DECLARE
    secret_key text;
BEGIN
    SELECT decrypted_secret INTO secret_key
    FROM vault.decrypted_secrets
    WHERE name = 'google_signin_web_client_id';

    RETURN secret_key;
END;
