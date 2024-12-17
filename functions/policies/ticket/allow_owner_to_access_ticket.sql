ALTER policy "Allow owner to access ticket"
ON "public"."ticket"
to authenticated
using (
  (( SELECT auth.uid() AS uid
  FROM parking_owner po
  WHERE ((po.profile_id = auth.uid()) AND (po.parking_id = po.parking_id))) IS NOT NULL)
)