CREATE OR REPLACE FUNCTION public.get_yesterday_total(parkingId uuid)
RETURNS TABLE(value_x integer, name text, value_y double precision) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        EXTRACT(HOUR FROM t.start_time)::integer AS value_x,
        TO_CHAR(t.start_time, 'FMHH24') AS name,
        SUM(t.total) AS value_y
    FROM 
        public.ticket AS t
    WHERE 
        t.parking_id = parkingId
        AND t.start_time >= (CURRENT_DATE - INTERVAL '1 day') 
        AND t.start_time < CURRENT_DATE
    GROUP BY 
        value_x, name
    ORDER BY 
        value_x;
END;
$$ LANGUAGE plpgsql;