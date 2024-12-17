CREATE OR REPLACE FUNCTION public.add_favorite_parking(user_id uuid, parking_id uuid)
RETURNS json AS $$
DECLARE
    result json;
BEGIN
    UPDATE public.profile
    SET favorite_parking = 
        CASE 
            WHEN favorite_parking IS NULL THEN ARRAY[parking_id]
            ELSE array_append(favorite_parking, parking_id)
        END
    WHERE id = user_id;

    IF NOT FOUND THEN
        result := json_build_object('status', 'error', 'message', 'Failed: User not found.');
        RETURN result;
    END IF;

    result := json_build_object('status', 'success', 'message', 'Success: Parking added to favorites.');
    RETURN result;
END;
$$ LANGUAGE plpgsql;