create table
  public.vehicle (
    id uuid not null default gen_random_uuid (),
    user_id uuid not null default gen_random_uuid (),
    vehicle_name text not null,
    license_plate text not null,
    created_at timestamp with time zone not null default now(),
    constraint vehicle_pkey primary key (id),
    constraint vehicle_user_id_fkey foreign key (user_id) references profile (id)
  ) tablespace pg_default;