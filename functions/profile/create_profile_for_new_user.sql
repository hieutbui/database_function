CREATE OR REPLACE FUNCTION public.create_profile_for_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
  user_type_value public.user_type; -- Declare as public.user_type to hold the enum value
BEGIN
  -- Extract the type from raw_user_meta_data
  user_type_value := NEW.raw_user_meta_data ->> 'type';

  -- Check if the extracted type is valid and assign the corresponding enum value
  IF user_type_value = 'user' THEN
    user_type_value := 'user'::public.user_type;
  ELSIF user_type_value = 'employee' THEN
    user_type_value := 'employee'::public.user_type;
  ELSIF user_type_value = 'parkingOwner' THEN
    user_type_value := 'parkingOwner'::public.user_type;
  ELSE
    user_type_value := 'user'::public.user_type; -- Default value
  END IF;

  INSERT INTO public.profile (id, email, type, full_name)
  VALUES (NEW.id, NEW.email, user_type_value, NEW.raw_user_meta_data ->> 'full_name');
  
  RETURN NEW;
END;
$function$;