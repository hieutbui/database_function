ALTER policy "Can only update own currency"
ON "public"."parking_owner"
to authenticated
USING (
  (( SELECT auth.uid() AS uid) = profile_id)
)
with check (
  (( SELECT auth.uid() AS uid) = profile_id)
)