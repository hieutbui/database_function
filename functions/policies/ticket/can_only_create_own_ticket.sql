ALTER policy  "Can only create own ticket"
ON "public"."ticket"
to authenticated
USING (
  (( SELECT auth.uid() AS uid) = user_id)
)