CREATE OR REPLACE FUNCTION dfs (
    head_name varchar(50)
) RETURNS TABLE(name varchar(50)) AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE childs(id, name, path) AS (
        SELECT employee.id, employee.name, ARRAY[employee.id] FROM employee WHERE employee.name=$1
    UNION ALL
        SELECT hierarchy.id, employee.name, path || hierarchy.id 
        FROM hierarchy, childs, employee 
        WHERE hierarchy.parent=childs.id AND employee.id=hierarchy.id
    )
    SELECT childs.name FROM childs ORDER BY childs.path;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION print_department (
    head_name varchar(50)
) RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec in SELECT name, get_count_of_vertical(name) AS shift FROM dfs($1) LOOP
        RAISE NOTICE USING MESSAGE = repeat('--', rec.shift) || rec.name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

