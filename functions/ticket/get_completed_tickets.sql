BEGIN
    RETURN QUERY
    SELECT 
        t.id,
        p.parking_name,
        p.image AS parking_image,
        p.address AS parking_address,
        p.phone AS parking_phone,
        v.vehicle_name,
        v.license_plate,
        t.start_time,
        t.end_time,
        t.status::TEXT AS status,
        t.days,
        t.hours,
        t.total
    FROM 
        public.ticket t
    JOIN 
        public.parking p ON t.parking_id = p.id
    JOIN 
        public.vehicle v ON t.vehicle_id = v.id
    WHERE 
        t.status = 'cancelled';
END;