CREATE OR REPLACE FUNCTION get_way (
    start_name varchar(50),
    finish_name varchar(50)
) RETURNS TABLE (name varchar(50)) AS $$
DECLARE
    finish_id integer;
BEGIN
    IF start_name = finish_name THEN
        RETURN QUERY SELECT start_name;
    ELSE
        SELECT employee.id INTO finish_id FROM employee WHERE employee.name=$1;
        RETURN QUERY
        WITH RECURSIVE parents(id) AS (
            SELECT employee.id FROM employee WHERE employee.name=$2
        UNION ALL
            SELECT hierarchy.parent FROM hierarchy, parents
            WHERE ((hierarchy.id = parents.id) and (hierarchy.parent != finish_id))
        )
        SELECT employee.name FROM employee WHERE id in (SELECT parents.id FROM parents) or id=finish_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

