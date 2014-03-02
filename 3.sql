CREATE OR REPLACE FUNCTION get_department (
    head_name varchar(50)
) RETURNS TABLE (name varchar(50)) AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE childs(id) AS (
        SELECT employee.id FROM employee WHERE employee.name=$1
    UNION ALL
        SELECT hierarchy.id FROM hierarchy, childs WHERE hierarchy.parent=childs.id
    )
    SELECT employee.name FROM employee WHERE id in (SELECT * FROM childs);
END;
$$ LANGUAGE plpgsql;

