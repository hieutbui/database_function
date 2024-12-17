ALTER policy "Can only create own vehicle"
ON "public"."vehicle"
to authenticated
using (
  (( SELECT auth.uid() AS uid) = user_id)
)
with check (
  (( SELECT auth.uid() AS uid) = user_id)
)