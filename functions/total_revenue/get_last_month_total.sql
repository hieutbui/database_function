CREATE OR REPLACE FUNCTION public.get_last_month_total(parkingId uuid)
RETURNS TABLE(value_x integer, name text, value_y double precision) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        EXTRACT(DAY FROM t.start_time)::integer AS value_x,
        TO_CHAR(t.start_time, 'FMDay') AS name,
        SUM(t.total) AS value_y
    FROM 
        public.ticket AS t
    WHERE 
        t.parking_id = parkingId
        AND t.start_time >= (CURRENT_DATE - INTERVAL '30 days')
    GROUP BY 
        value_x, name
    ORDER BY 
        value_x;
END;
$$ LANGUAGE plpgsql;