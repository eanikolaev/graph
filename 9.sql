CREATE OR REPLACE FUNCTION print_department (
    head_name varchar(50)
) RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec in SELECT name, get_count_of_vertical(name) AS shift FROM get_department($1) ORDER BY shift LOOP
        RAISE NOTICE USING MESSAGE = repeat('--', rec.shift) || rec.name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

