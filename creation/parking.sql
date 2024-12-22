create table
  public.parking (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default now(),
    parking_name text not null,
    image text null,
    address text not null,
    phone text null,
    geolocation geography not null,
    total_slot bigint not null default '0'::bigint,
    available_slot bigint not null default '0'::bigint,
    price_per_day double precision null,
    price_per_month double precision null,
    price_per_year double precision null,
    constraint parking_pkey primary key (id)
  ) tablespace pg_default;