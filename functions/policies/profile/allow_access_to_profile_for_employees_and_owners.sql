ALTER policy "Allow access to profile for employees and owners"
ON "public"."profile"
to public
using (
  ((id = auth.uid()) OR (EXISTS ( SELECT 1
  FROM (parking_owner po
  JOIN parking_employee pe ON ((po.parking_id = pe.parking_id)))
  WHERE ((po.profile_id = auth.uid()) AND (pe.profile_id = profile.id)))))
);
