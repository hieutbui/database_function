ALTER policy "Can view own info"
ON "public"."parking_owner"
to authenticated
USING (
  (( SELECT auth.uid() AS uid) = profile_id)
)