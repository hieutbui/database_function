CREATE OR REPLACE FUNCTION public.get_yesterday_ticket_count(parkingId uuid)
RETURNS TABLE(value_x integer, name text, value_y bigint) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        EXTRACT(HOUR FROM t.start_time)::integer AS value_x,
        TO_CHAR(t.start_time, 'FMHH24') AS name,
        COUNT(t.id) AS value_y  -- Count the number of tickets
    FROM 
        public.ticket AS t
    WHERE 
        t.parking_id = parkingId
        AND t.start_time >= (CURRENT_DATE - INTERVAL '1 day')  -- Start of yesterday
        AND t.start_time < CURRENT_DATE  -- Start of today
    GROUP BY 
        value_x, name
    ORDER BY 
        value_x;
END;
$$ LANGUAGE plpgsql;