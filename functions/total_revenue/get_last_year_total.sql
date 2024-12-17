CREATE OR REPLACE FUNCTION public.get_last_year_total(parkingId uuid)
RETURNS TABLE(value_x integer, name text, value_y double precision) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        EXTRACT(MONTH FROM t.start_time)::integer AS value_x,  -- Keep the month as is (1-12)
        TO_CHAR(date_trunc('month', t.start_time), 'Mon') AS name,
        SUM(t.total) AS value_y
    FROM 
        public.ticket AS t
    WHERE 
        t.parking_id = parkingId
        AND t.start_time >= (CURRENT_DATE - INTERVAL '1 year')
        AND t.start_time < CURRENT_DATE
    GROUP BY 
        value_x, name
    ORDER BY 
        value_x;
END;
$$ LANGUAGE plpgsql;