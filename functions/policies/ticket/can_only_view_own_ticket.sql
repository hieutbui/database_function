ALTER policy "Can only view own ticket"
ON "public"."ticket"
to authenticated
USING (
  (( SELECT auth.uid() AS uid) = user_id)
)