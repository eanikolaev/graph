CREATE OR REPLACE FUNCTION add_employee (
    name varchar(50),
    parent integer DEFAULT -1
) RETURNS integer AS $$
DECLARE
    employee_id integer;
BEGIN
    INSERT INTO employee (name ) VALUES ($1 ) RETURNING id INTO employee_id;
    IF $2 != -1 THEN
        INSERT INTO hierarchy (id, parent) VALUES (employee_id, $2);
    END IF;
    RETURN employee_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION remove_employee (
-- help function
    name varchar(50)
) RETURNS integer AS $$
DECLARE
    employee_id integer;
BEGIN
    DELETE FROM employee WHERE employee.name=$1 RETURNING id INTO employee_id;
    RETURN employee_id;
END;
$$ LANGUAGE plpgsql;
