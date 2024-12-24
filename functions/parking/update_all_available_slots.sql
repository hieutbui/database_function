CREATE OR REPLACE FUNCTION public.update_all_available_slots()
RETURNS void AS $$
BEGIN
    -- Update available_slot for all parkings based on total_slot and count of active tickets
    UPDATE public.parking p
    SET available_slot = p.total_slot - (
        SELECT COUNT(*)
        FROM public.ticket t
        WHERE t.parking_id = p.id AND t.status IN ('active', 'paid')
    );
END;
$$ LANGUAGE plpgsql;