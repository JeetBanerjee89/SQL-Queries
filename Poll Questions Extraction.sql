select distinct slides.uid as "Slide ID",
       slides.type as "Slide Type",
       slides.slide_order as "Slide Number",
       resource_details -> 0 -> 'image_url' as "Image URL",
       slides.presentation_id as "Presentation ID",
       content_bundles.id as "TMB ID",
       raw_topics.id as "RT ID",
       grades.name as "Grade",
       raw_topics.subject as "Subject"
from slides
left join resource_owners on resource_owners.resource_id=slides.presentation_id
left join content_bundles on content_bundles.resource_id=slides.presentation_id
left join raw_topics on raw_topics.content_bundle_id=content_bundles.id
left join grades on grades.id=raw_topics.grade_id
where resource_owners.owner_id= '456c36e8-39fb-435c-89a7-2118dca0e867' and
slides.type= 'poll_question'
       