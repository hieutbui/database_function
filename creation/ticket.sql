create table
  public.ticket (
    id uuid not null default gen_random_uuid (),
    start_time timestamp with time zone not null,
    end_time timestamp with time zone not null,
    days bigint not null,
    hours bigint not null,
    total double precision not null,
    status public.ticket_status not null,
    created_at timestamp with time zone not null default now(),
    user_id uuid not null default gen_random_uuid (),
    parking_id uuid not null default gen_random_uuid (),
    vehicle_id uuid not null default gen_random_uuid (),
    payment_intent_id text null,
    entry_time timestamp with time zone null,
    exit_time timestamp with time zone null,
    constraint ticket_pkey primary key (id),
    constraint ticket_parking_id_fkey foreign key (parking_id) references parking (id),
    constraint ticket_user_id_fkey foreign key (user_id) references profile (id),
    constraint ticket_vehicle_id_fkey foreign key (vehicle_id) references vehicle (id)
  ) tablespace pg_default;