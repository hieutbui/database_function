ALTER policy "Allow owner to update employee working time"
ON "public"."parking_employee"
to authenticated
with check (
  (( SELECT auth.uid() AS uid
  FROM parking_owner po
  WHERE ((po.profile_id = auth.uid()) AND (po.parking_id = po.parking_id))) IS NOT NULL)
)
