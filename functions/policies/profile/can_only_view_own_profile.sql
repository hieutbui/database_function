ALTER policy "Can only view own profile"
ON "public"."profile"
to authenticated
USING (
  (( SELECT auth.uid() AS uid) = id)
)