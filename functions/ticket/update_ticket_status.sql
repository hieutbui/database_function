create or replace function public.update_ticket_status()
returns void as $$
BEGIN
    UPDATE public.ticket
    SET status = 'completed'
    WHERE end_time < now() 
      AND status <> 'cancelled' 
      AND status <> 'completed';
END;
$$ language plpgsql;