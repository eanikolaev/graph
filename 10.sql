CREATE OR REPLACE FUNCTION unnest_rownum(integer ARRAY)
RETURNS TABLE (id integer, element integer) AS $$
BEGIN
    id := 1;
    FOREACH element IN array $1
      LOOP
        RETURN NEXT;
        id := id + 1;
      END LOOP;
    RETURN;    
END
$$ LANGUAGE plpgsql; 


CREATE OR REPLACE FUNCTION get_way_up (
    start_name varchar(50),
    start_depth integer
) RETURNS TABLE (id integer, depth integer) AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE parents(id, depth) AS (
        SELECT employee.id, $2 FROM employee WHERE employee.name=$1
    UNION ALL
        SELECT hierarchy.parent, parents.depth+1 FROM hierarchy, parents WHERE hierarchy.id = parents.id AND hierarchy.id <> 1
    )
    (SELECT parents.id, parents.depth FROM parents);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_way (
    start_name varchar(50),
    finish_name varchar(50)
) RETURNS TABLE (name varchar(50)) AS $$
DECLARE
    max integer;
    start_id integer;
    finish_id integer;
BEGIN        
    SELECT count(*) INTO max FROM employee;
    RETURN QUERY
    SELECT employee.name
    FROM employee
    WHERE employee.id in
    (SELECT id
    FROM
      (
        (SELECT get_way_up($1,1))
         UNION
        (SELECT get_way_up($2,max))
      ) as way
    );
/*    RETURN QUERY
    SELECT name FROM (SELECT id FROM way1 UNION SELECT id FROM way2 ORDER BY 2) as way left join employee ON employee.id=way.id;   

    i := 0;
    LOOP
        i = i + 1;
        EXIT WHEN w1[i] = w2[0];
    END LOOP;
    
    w = w1[1:i] || w2;
*/
/*    RETURN QUERY
    SELECT employee.name FROM employee;*/
  /*  SELECT employee.name FROM employee, unnest_rownum(w) as t(id,el) WHERE t.el=employee.id ORDER BY t.id;*/
END
$$ LANGUAGE plpgsql;


/*
CREATE OR REPLACE FUNCTION get_way_new (
    start_name varchar(50),
    finish_name varchar(50)
) RETURNS TABLE (name varchar(50)) AS $$
DECLARE
    start_id integer;
    finish_id integer;
    path integer ARRAY;
BEGIN
    SELECT employee.id INTO start_id FROM employee WHERE employee.name=$1;
    SELECT employee.id INTO finish_id FROM employee WHERE employee.name=$2;
 
    CREATE OR REPLACE VIEW graph
    AS (SELECT hierarchy.parent, hierarchy.id FROM hierarchy)
        UNION
       (SELECT hierarchy.id, hierarchy.parent FROM hierarchy);    

    WITH RECURSIVE paths (id, parent, sid, visited) 
    AS ( 
        SELECT graph.id, graph.parent, graph.id, ARRAY[graph.id] as sid
        FROM graph
        WHERE graph.id = start_id
    UNION ALL
        SELECT nxt.id, nxt.parent, prv.sid, prv.visited || nxt.id
        FROM graph  nxt
        JOIN paths prv ON nxt.id = prv.parent
        WHERE NOT (ARRAY[nxt.id] <@ prv.visited)
    )
    
    SELECT paths.visited INTO path
    FROM paths
    WHERE paths.visited[1]=start_id AND paths.visited[array_length(paths.visited, 1)]=finish_id
    LIMIT 1;

    RETURN QUERY
    SELECT employee.name FROM employee, unnest_rownum(path) as t(id,el) WHERE t.el=employee.id ORDER BY t.id;
END;
$$ LANGUAGE plpgsql;
*/

