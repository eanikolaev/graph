CREATE OR REPLACE FUNCTION set_parent (
-- change parent is equal to change department
    name varchar(50),
    parent_id integer
) RETURNS integer AS $$
DECLARE
    employee_id integer;
BEGIN
    employee_id = (SELECT id FROM employee WHERE employee.name=$1);
    IF (SELECT id FROM hierarchy WHERE id=employee_id)::bool THEN
        DELETE FROM hierarchy WHERE id=employee_id;
    END IF;
    INSERT INTO hierarchy (id, parent) VALUES (employee_id, $2);
    RETURN employee_id;
END;
$$ LANGUAGE plpgsql;

