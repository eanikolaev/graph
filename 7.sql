CREATE OR REPLACE FUNCTION is_ok (
) RETURNS boolean AS $$
BEGIN
    RETURN (SELECT id FROM hierarchy AS h WHERE h.id=h.parent and h.id<>1) is NULL;
END;
$$ LANGUAGE plpgsql;

