CREATE OR REPLACE FUNCTION public.search_parking (
  search_query TEXT,
  user_location geography,
  max_distance DOUBLE PRECISION DEFAULT NULL, -- Maximum distance parameter in meters
  sort_by public.sort_by DEFAULT 'distance', -- Default sort by distance
  sort_order public.sort_order DEFAULT 'asc' -- Default sort order
) RETURNS TABLE (
  id UUID,
  created_at TIMESTAMP WITH TIME ZONE,
  parking_name TEXT,
  image TEXT,
  address TEXT,
  phone TEXT,
  geolocation geography,
  total_slot BIGINT,
  available_slot BIGINT,
  price_per_hour jsonb[],
  price_per_day DOUBLE PRECISION,
  price_per_month DOUBLE PRECISION,
  price_per_year DOUBLE PRECISION,
  distance DOUBLE PRECISION
) AS $$
BEGIN
    RETURN QUERY
    EXECUTE format(
        $query$
        SELECT 
            p.id,
            p.created_at,
            p.parking_name,
            p.image,
            p.address,
            p.phone,
            p.geolocation,
            p.total_slot,
            p.available_slot,
            ARRAY(
                SELECT jsonb_build_object(
                    'id', s.id,
                    'price', s.price,
                    'start_time', s.start_time,
                    'end_time', s.end_time,
                    'shift_type', s.shift_type
                )
                FROM public.parking_shift_price s
                WHERE s.parking_id = p.id
            ) AS price_per_hour,
            p.price_per_day,
            p.price_per_month,
            p.price_per_year,
            ST_Distance(p.geolocation, $2) AS distance
        FROM 
            public.parking p
        LEFT JOIN 
            public.parking_specific_address psa ON psa.id = p.id
        WHERE 
            (p.parking_name ILIKE '%%' || $1 || '%%'
            OR psa.ward ILIKE '%%' || $1 || '%%'
            OR psa.district ILIKE '%%' || $1 || '%%'
            OR psa.city ILIKE '%%' || $1 || '%%'
            OR psa.country ILIKE '%%' || $1 || '%%')
            AND ($3 IS NULL OR ST_Distance(p.geolocation, $2) <= $3)
        ORDER BY 
            CASE 
                WHEN $4 = 'price' THEN p.price_per_day
                ELSE ST_Distance(p.geolocation, $2)
            END %s NULLS LAST
        $query$
        , CASE WHEN sort_order = 'desc' THEN 'DESC' ELSE 'ASC' END
    )
    USING search_query, user_location, max_distance, sort_by;
END;
$$ LANGUAGE plpgsql;