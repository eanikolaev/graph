CREATE OR REPLACE FUNCTION is_tree (
    head_name varchar(50)
) RETURNS boolean AS $$
DECLARE
    res boolean;
BEGIN
    WITH RECURSIVE childs(id, visited, cycle) AS (
        SELECT employee.id, ARRAY[employee.id], false FROM employee WHERE employee.name=$1
    UNION ALL
        SELECT h.id, c.visited || h.id, h.id = ANY(c.visited) FROM hierarchy AS h, childs as c WHERE h.parent=c.id AND NOT c.cycle
    )
    SELECT bool_or(childs.cycle) INTO res FROM childs;
    RETURN res;
END;
$$ LANGUAGE plpgsql;

