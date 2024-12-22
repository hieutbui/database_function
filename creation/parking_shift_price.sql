create table
  public.parking_shift_price (
    id uuid not null default gen_random_uuid (),
    parking_id uuid not null default gen_random_uuid (),
    price double precision not null,
    start_time time without time zone not null,
    end_time time without time zone not null,
    created_at timestamp with time zone not null default now(),
    shift_type public.shift_type not null,
    constraint parking_shift_price_pkey primary key (id),
    constraint parking_shift_price_parking_id_fkey foreign key (parking_id) references parking (id)
  ) tablespace pg_default;