CREATE OR REPLACE FUNCTION set_parent (
-- change parent is equal to change department
    name varchar(50),
    parent_id integer DEFAULT -1
) RETURNS integer AS $$
DECLARE
    employee_id integer;
BEGIN
    employee_id = (SELECT id FROM employee WHERE employee.name=$1);
    IF (SELECT id FROM hierarchy WHERE id=employee_id)::bool THEN
        IF $2 != -1 THEN
            UPDATE hierarchy SET parent=$2 WHERE id=employee_id;
        ELSE
            DELETE FROM hierarchy WHERE id=employee_id;
        END IF;
    ELSE
        IF $2 != -1 THEN
            INSERT INTO hierarchy (id, parent) VALUES (employee_id, $2);
        END IF;
    END IF;
    RETURN employee_id;
END;
$$ LANGUAGE plpgsql;

