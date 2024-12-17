CREATE OR REPLACE FUNCTION create_payment_intent(
    amount text,
    currency text,
    description text,
    parking_name text,
    parking_address text,
    vehicle text,
    start_date_time text,
    end_date_time text,
    hours text,
    days text
) RETURNS jsonb AS $$
DECLARE
    secret_key text;
    response jsonb;
BEGIN
    -- Retrieve the secret key from the vault
    SELECT decrypted_secret INTO secret_key
    FROM vault.decrypted_secrets
    WHERE name = 'ecoparking_stripe_api_key_id';

    SELECT content INTO response
    FROM http(( 
        'POST',
        'https://api.stripe.com/v1/payment_intents',
        ARRAY[http_header('authorization','Bearer ' || secret_key)],
        'application/x-www-form-urlencoded',
        'amount=' || amount || 
        '&currency=' || currency || 
        '&description=' || description || 
        '&metadata[parking_name]=' || parking_name || 
        '&metadata[parking_address]=' || parking_address || 
        '&metadata[vehicle]=' || vehicle || 
        '&metadata[start_date_time]=' || start_date_time || 
        '&metadata[end_date_time]=' || end_date_time || 
        '&metadata[hours]=' || hours || 
        '&metadata[days]=' || days
    )::http_request);

    RETURN response;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;