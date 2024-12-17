create
or replace function public.find_nearby_parkings (
  user_location geography,
  search_distance double precision
) returns table (
  id uuid,
  created_at timestamp with time zone,
  parking_name text,
  image text,
  address text,
  phone text,
  geolocation geography,
  total_slot bigint,
  available_slot bigint,
  price_per_hour double precision,
  price_per_day double precision,
  price_per_month double precision,
  price_per_year double precision,
  distance double precision
) as $$
BEGIN
    RETURN QUERY
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
        ARRAY(SELECT jsonb_build_object(
            'id', s.id,
            'price', s.price,
            'start_time', s.start_time,
            'end_time', s.end_time,
            'shift_type', s.shift_type
        ) FROM public.parking_shift_price s WHERE s.parking_id = p.id) AS price_per_hour,
        p.price_per_day,
        p.price_per_month,
        p.price_per_year,
        ST_Distance(p.geolocation, user_location) AS distance
    FROM 
        public.parking p
    WHERE 
        ST_DWithin(p.geolocation, user_location, search_distance)
    ORDER BY 
        distance;
END;
$$ language plpgsql;