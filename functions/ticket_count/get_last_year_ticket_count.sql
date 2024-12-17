CREATE OR REPLACE FUNCTION public.get_last_year_ticket_count(parkingId uuid)
RETURNS TABLE(value_x integer, name text, value_y bigint) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        EXTRACT(MONTH FROM date_trunc('month', t.start_time))::integer AS value_x,
        TO_CHAR(date_trunc('month', t.start_time), 'Mon') AS name,
        COUNT(t.id) AS value_y  -- Count the number of tickets
    FROM 
        public.ticket AS t
    WHERE 
        t.parking_id = parkingId
        AND t.start_time >= date_trunc('year', CURRENT_DATE) - INTERVAL '1 year'  -- Start of last year
        AND t.start_time < date_trunc('year', CURRENT_DATE)  -- Start of this year
    GROUP BY 
        value_x, name
    ORDER BY 
        value_x;
END;
$$ LANGUAGE plpgsql;