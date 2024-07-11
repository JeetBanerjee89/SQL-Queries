SELECT batch_schedules.batch_id as "Batch ID",
      batches.name as "Batch Name",
      batches.course_id as "Course ID",
      courses.name as "Course Name",
      courses.cohort_id as "Cohort ID",
      courses.medium_of_instruction as "Language",
      batches.start_at as "Batch Start Date",
      courses.pricing_strategy as "Paid/Free",
      batch_schedules.session_starts_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "Session Start",
      batch_schedules.raw_topic_id as "Raw Topic ID",
      raw_topics.name as "Raw Topic Backend Name",
      raw_topics.display_name as "Raw Topic Display Name",
      grades.name as "Grade",
      raw_topics.subject as "Subject",
      raw_topics.chapter as "Chapter",
      raw_topics.content_bundle_id as "TMB ID",
      content_bundles.name as "TMB Name",
      content_bundles.published as "Is TMB Published?",
      presentations.id as "Neo Slide ID",
      presentations.title as "Neo Slide Name",
      content_bundle_requisites.requisite_group_id as "Requisite Group ID",
      one_to_many_requisite_groups.name as "Requisite Group Name",
      one_to_many_requisite_groups.published as "Is RG Published?",
      one_to_many_requisites.meta_info -> 'assessment_id' as "Assessment ID",
      one_to_many_requisites.display_name as "Asset Display Name",
      one_to_many_requisites.meta_info -> 'class_note_id' as "Chapter Note ID",
      one_to_many_class_notes.name as "Chapter Note Name",
      one_to_many_requisites.meta_info -> 'journey_id' as "Journey ID",
      one_to_many_requisites.assets_type as "Asset Type",
      one_to_many_requisite_groups.tnl_cohort_id as "RG Cohort ID",
      (Case when (one_to_many_requisites.assets_type='Assessment' and one_to_many_requisites.display_name='Daily Practice Problems') THEN TRUE
      ELSE FALSE END) as "DPP Tagged?",
      (Case when (one_to_many_requisites.assets_type='Assessment' and one_to_many_requisites.display_name='Cumulative Worksheet') THEN TRUE
      ELSE FALSE END) as "WS Tagged?",
      (Case when one_to_many_requisites.assets_type='ClassNote' THEN TRUE ELSE FALSE END) as "Notes Tagged?",
      (Case when one_to_many_requisites.assets_type='Journey' THEN TRUE ELSE FALSE END) as "Journey Tagged?"
      
FROM batch_schedules
    LEFT JOIN batches ON batches.id=batch_schedules.batch_id
    LEFT JOIN courses ON courses.id=batches.course_id
    LEFT JOIN raw_topics ON raw_topics.id=batch_schedules.raw_topic_id
    LEFT JOIN grades ON grades.id=raw_topics.grade_id
    LEFT JOIN content_bundles ON content_bundles.id=raw_topics.content_bundle_id
    LEFT JOIN presentations ON presentations.id=content_bundles.resource_id
    LEFT JOIN content_bundle_requisites ON content_bundle_requisites.content_bundle_id=content_bundles.id
    LEFT JOIN one_to_many_requisite_groups ON one_to_many_requisite_groups.id=content_bundle_requisites.requisite_group_id
    LEFT JOIN one_to_many_requisites ON one_to_many_requisites.requisite_group_id=content_bundle_requisites.requisite_group_id
    LEFT JOIN one_to_many_class_notes on one_to_many_class_notes.id = (meta_info->'class_note_id')::bigint
WHERE batch_id IN ({{Enter Batch ID(s):}})
    AND session_starts_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta'>=('{{ Date Range Start }}')
    AND session_starts_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta'<=('{{ Date Range End }}')
    AND courses.cohort_id IN (53, 209, 211, 206, 208, 213, 210, 212, 252, 232, 231)
    AND courses.pricing_strategy='paid'
    AND one_to_many_requisites.deleted_at isnull
    ORDER BY session_starts_at ASC,
             batch_id ASC
             
             