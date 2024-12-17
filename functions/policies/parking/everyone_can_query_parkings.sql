ALTER policy "Everyone can query parkings"
ON "public"."parking"
to public
using (
  true
);