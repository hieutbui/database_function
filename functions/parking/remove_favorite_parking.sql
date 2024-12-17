CREATE OR REPLACE FUNCTION public.remove_favorite_parking(user_id uuid, parking_id uuid)
RETURNS json AS $$
DECLARE
    result json;
BEGIN
    UPDATE public.profile
    SET favorite_parking = array_remove(favorite_parking, parking_id)
    WHERE id = user_id;

    IF NOT FOUND THEN
        result := json_build_object('status', 'error', 'message', 'Failed: User not found or parking not found in favorites.');
        RETURN result;
    END IF;

    result := json_build_object('status', 'success', 'message', 'Success: Parking removed from favorites.');
    RETURN result;
END;
$$ LANGUAGE plpgsql;