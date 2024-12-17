ALTER policy "Can only create own vehicle"
ON "public"."vehicle"
to authenticated
with check (
  (( SELECT auth.uid() AS uid) = user_id)
)