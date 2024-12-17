create or replace function public.cancel_ticket(ticket_id uuid)
returns text as $$
declare
    updated_count int;
begin
    update public.tickets
    set status = 'cancelled'
    where id = ticket_id;

    -- Get the number of rows updated
    updated_count := found;

    if updated_count > 0 then
        return 'ok';  -- Return 'ok' if the update was successful
    else
        return 'failed';  -- Return 'failed' if no rows were updated
    end if;
end;
$$ language plpgsql;