ALTER policy "Can only update own profile"
ON "public"."profile"
to authenticated
USING (
  (( SELECT auth.uid() AS uid) = id)
)
with check (
  (( SELECT auth.uid() AS uid) = id)
)