create table
  public.profile (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default now(),
    email text not null,
    phone text null,
    full_name text null,
    display_name text null,
    avatar text null,
    type public.user_type not null default 'user'::user_type,
    dob date null,
    gender public.gender null,
    favorite_parking uuid[] null,
    constraint profile_pkey primary key (id),
    constraint profile_id_fkey foreign key (id) references auth.users (id)
  ) tablespace pg_default;