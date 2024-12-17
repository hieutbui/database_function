CREATE OR REPLACE FUNCTION public.get_last_month_ticket_count(parkingId uuid)
RETURNS TABLE(value_x integer, name text, value_y bigint) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        EXTRACT(DAY FROM t.start_time)::integer AS value_x,
        TO_CHAR(t.start_time, 'FMDay') AS name,
        COUNT(t.id) AS value_y  -- Count the number of tickets
    FROM 
        public.ticket AS t
    WHERE 
        t.parking_id = parkingId
        AND t.start_time >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'  -- Start of last month
        AND t.start_time < date_trunc('month', CURRENT_DATE)  -- Start of this month
    GROUP BY 
        value_x, name
    ORDER BY 
        value_x;
END;
$$ LANGUAGE plpgsql;