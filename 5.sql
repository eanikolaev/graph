CREATE OR REPLACE FUNCTION get_vertical (
    head_name varchar(50)
) RETURNS TABLE (name varchar(50)) AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE parents(id) AS (
        SELECT employee.id FROM employee WHERE employee.name=$1
    UNION ALL
        SELECT hierarchy.parent FROM hierarchy, parents WHERE hierarchy.id = parents.id
    )
    SELECT employee.name FROM employee WHERE id in (SELECT parents.id FROM parents);
END;
$$ LANGUAGE plpgsql;

