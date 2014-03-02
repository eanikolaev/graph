CREATE OR REPLACE FUNCTION get_count_of_department (
    head_name varchar(50)
) RETURNS integer AS $$
BEGIN
    RETURN (SELECT count(*) FROM get_department($1));
END;
$$ LANGUAGE plpgsql;

