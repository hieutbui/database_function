create table
  public.parking_owner (
    id uuid not null default gen_random_uuid (),
    parking_id uuid not null default gen_random_uuid (),
    profile_id uuid not null default gen_random_uuid (),
    currency_locale text not null default 'vi_VN'::text,
    created_at timestamp with time zone not null default now(),
    constraint parking_owner_pkey primary key (id),
    constraint parking_owner_parking_id_fkey foreign key (parking_id) references parking (id),
    constraint parking_owner_profile_id_fkey foreign key (profile_id) references profile (id)
  ) tablespace pg_default;