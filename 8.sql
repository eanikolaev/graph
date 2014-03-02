CREATE OR REPLACE FUNCTION get_count_of_vertical (
    head_name varchar(50)
) RETURNS integer AS $$
BEGIN
    RETURN ( SELECT count(*) FROM get_vertical($1) );
END;
$$ LANGUAGE plpgsql;

