create table
  public.parking_specific_address (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default now(),
    ward text not null,
    district text not null,
    city text not null,
    country text not null,
    constraint parking_specific_address_pkey primary key (id),
    constraint parking_specific_address_id_fkey foreign key (id) references parking (id)
  ) tablespace pg_default;