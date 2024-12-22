create table
  public.parking_employee (
    id uuid not null default gen_random_uuid (),
    profile_id uuid not null default gen_random_uuid (),
    working_start_time time with time zone null,
    working_end_time time with time zone null,
    created_at timestamp with time zone not null default now(),
    parking_id uuid not null default gen_random_uuid (),
    currency_locale text null default 'vi_VN'::text,
    constraint parking_employee_pkey primary key (id),
    constraint parking_employee_parking_id_fkey foreign key (parking_id) references parking (id),
    constraint parking_employee_profile_id_fkey foreign key (profile_id) references profile (id)
  ) tablespace pg_default;