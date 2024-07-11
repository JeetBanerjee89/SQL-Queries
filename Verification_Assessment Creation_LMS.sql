SELECT DISTINCT assessments.id as "A. ID",
       (CASE WHEN assessments.parent_id IS NULL THEN assessments.id ELSE assessments.parent_id END) AS "Parent Id",
       (CASE WHEN assessments.parent_id IS NULL THEN 'Parent' ELSE 'Sectional' END) AS "Parent/Section",
       assessments.title as "A. Name",
       assessments.type as "A. Type",
       assessments.sub_type as "A. Subtype",
       assessments.is_published as "Is A. Published?",
       assessments.group_label as "A. Group Level",
       assessments.category_id as "A. Chapter Category ID",
       assessments.meta_data->'sync_details'->'Assessment Platform'->'last_sync_time' as "A. Syncing Details",
       categories.name as "A. Chapter Category Name",
       categories.type as "A. Chapter Category Type",
       school_root_table."School_Root_ID" as "School Root ID",
       school_root_table."School_Root_Cohort_Id" as "School Root Cohort Id",
       categories.grade as "A. Chapter Category Grade",
       categories.syllabus as "A. Chapter Category Syllameta_databus",
       categories.subject as "A. Chapter Category Subject",
       categories.description as "A. Chapter Category Description",
       categories.is_active as "A. Chapter Category Active?",
       categories.is_included_in_tnl_json as "A. Chapter Category TNL JSON Active?",
       categories.is_visible_to_user as "A. Chapter Category Visible to User?",
       assessments.created_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "A. Creation At",
       assessments.available_starting AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "A. Avl. Starting", 
       assessments.available_until AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "A. Avl. Until",
       assessments.send_results_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "A. Send Results At",
       assessments.updated_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "A. Updated At", 
       assessments.is_pausable,
       assessments.cutoff,
       assessments.allowed_attempts,
       assessments.is_timed,
       assessments.time_allowed,
       assessments.can_jump_sections,
       assessments.can_jump_questions,
       assessments.bloom_taxonomy_level,
       assessments.is_included_in_tnl_android_json,
       assessments.rank_mapping_id,
       assessments.questions_count,
       assessments.section_cutoff,
       assessments.is_paid,
       assessments.is_active,
       assessments.is_nav_visible,
       assessments.is_nav_enabled,
       assessments.assignments_count,
       assessments.questions_mandatory,
       assessments.has_negative_marking,
       assessments.can_show_answers,
       assessments.correct_score,
       assessments.partial_marking,
       resource_configurations.config_json -> 'assessment_mode' as "A. Mode",
       assessment_questions.question_id as "Q. ID",
       question_subtopic_table."Q._Subtopic_ID" as "Q. Subtopic ID",
       question_subtopic_table."Q._Subtopic_Name" as "Q. Subtopic Name",
       question_subtopic_table."Q._Subtopic_Grade" as "Q. Subtopic Grade",
       question_subtopic_table."Q._Subtopic_Syllabus" as "Q. Subtopic Syllabus",
       question_subtopic_table."Q._Subtopic_Subject" as "Q. Subtopic Subject",
       question_subtopic_table."Q._Is_Subtopic_Active?" as "Q. Subtopic Active?",
       question_subtopic_table."Q._Is_Subtopic_Included_in_TNL_JSON?" as "Q. Subtopic Included in TNL JSON?",
       question_subtopic_table."Q._Subtopic_Cohort" as "Q. Subtopic Cohort",
       --question_subtopic_table."Q._Chapter_Category" as "Q. Chapter Category", 
       question_chaptercategory_table."Q._Chapter_Category" as "Q. Chapter Category Id",
       question_chaptercategory_table."Q._Chapter_Category_Name" as "Q. Chapter Category Name",
       questions.raw_question_id as "Raw Q. ID",
       questions.created_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "Q. Created At",
       questions.updated_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta' as "Q. Updated At",
       questions.type as "Q. Type",
       questions.is_published as "Q. Published?",
       questions.points as "Q. Correct Point",
       questions.negative_points as "Q. Incorrect Point",
       questions.difficulty as "Q. Difficulty Level",
       questions.engagement as "Q. Engagement Level",
       questions.is_practice_eligible as "Q. Practice Eligible?",
       questions.is_quizup_eligible as "Q. Quizup Eligible?",
       questions.is_adaptive_eligible as "Q. Adaptive Eligible?",
       questions.is_test_eligible as "Q. Test Eligible?",
       questions.is_seo_enabled as "Q. Seo Enabled?",
       concepts.id as "C. ID",
       concepts.content_unique_id as "C. Unique ID",
       concepts.name as "C. Name",
       concepts.is_valid as "Is C. Valid?",
       concept_category_table."C._Category_ID" as "C. Category ID",
       concept_category_table."C._Category_Name" as "C. Category Name",
       concept_category_table."Is_C._Category_Active?" as "Is C. Category Active?",
       concept_category_table."C._Category_Cohort" as "C. Category Cohort",
       resource_concepts.is_active as "Is C. Active?",
       resource_concepts.is_primary as "Is C. Primary?",
       concepts_subtopic_table."C._Subtopic_ID" as "C. Subtopic ID",
       concepts_subtopic_table."C._Subtopic_Name" as "C. Subtopic Name",
       concepts_subtopic_table."C._Subtopic_Grade" as "C. Subtopic Grade",
       concepts_subtopic_table."C._Subtopic_Syllabus" as "C. Subtopic Syllabus",
       concepts_subtopic_table."C._Subtopic_Subject" as "C. Subtopic Subject",
       concepts_subtopic_table."C._Is_Subtopic_Active?" as "C. Subtopic Active?",
       concepts_subtopic_table."C._Is_Subtopic_Included_in_TNL_JSON?" as "C. Subtopic Included in TNL JSON?",
       concepts_subtopic_table."C._Subtopic_Cohort" as "C. Subtopic Cohort",
       
       (CASE 
       WHEN (school_root_table."School_Root_Cohort_Id" is not null and school_root_table."School_Root_Cohort_Id"= question_subtopic_table."Q._Subtopic_Cohort") THEN 'TRUE' 
       WHEN (school_root_table."School_Root_Cohort_Id" is not null and school_root_table."School_Root_Cohort_Id"!= question_subtopic_table."Q._Subtopic_Cohort") THEN 'FALSE'
       ELSE 'No School Root Present'
       END) as "School Root-Q.Subtopic Cohort Match",
       CONCAT(school_root_table."School_Root_Cohort_Id",'-',question_subtopic_table."Q._Subtopic_Cohort") as "School Root-Q.Subtopic Cohort Pair",
       
       (CASE 
       WHEN (concepts_subtopic_table."C._Subtopic_ID" is not null and question_subtopic_table."Q._Subtopic_ID"= concepts_subtopic_table."C._Subtopic_ID") THEN 'TRUE'
       WHEN (concepts_subtopic_table."C._Subtopic_ID" is not null and question_subtopic_table."Q._Subtopic_ID"!= concepts_subtopic_table."C._Subtopic_ID") THEN 'FALSE'
       ELSE 'No Concept Present' 
       END) as "Q. Subtopic-C.Subtopic ID Match",
       CONCAT(question_subtopic_table."Q._Subtopic_ID",'-',concepts_subtopic_table."C._Subtopic_ID") as "Q. Subtopic-C.Subtopic Pair",
       
       (CASE WHEN (concepts_subtopic_table."C._Subtopic_Cohort" is not null and concept_category_table."C._Category_Cohort"= concepts_subtopic_table."C._Subtopic_Cohort") THEN 'TRUE' 
       WHEN (concepts_subtopic_table."C._Subtopic_Cohort" is not null and concept_category_table."C._Category_Cohort"!= concepts_subtopic_table."C._Subtopic_Cohort") THEN 'FALSE'
       ELSE 'No Concept Present'
       END) as "C. Category-C.Subtopic Cohort Match",
       CONCAT(concept_category_table."C._Category_Cohort",'-',concepts_subtopic_table."C._Subtopic_Cohort") as "C. Category-C.Subtopic Cohort Pair"
       
FROM assessments
    LEFT JOIN categories ON categories.id=assessments.category_id
    LEFT JOIN cohort_categories ON cohort_categories.category_id::int=split_part(categories.ancestry,'/', 1)::int
    
    LEFT JOIN (SELECT cohort_categories.category_id as "School_Root_ID",
          cohort_categories.tnl_cohort_id as "School_Root_Cohort_Id"
   FROM cohort_categories
   LEFT JOIN categories ON categories.id=cohort_categories.category_id
   WHERE cohort_categories.tnl_cohort_id IN (53, 209, 211, 206, 208, 213, 207, 210, 212, 252, 232, 231)) as school_root_table ON school_root_table."School_Root_ID"=split_part(categories.ancestry,'/', 1)::Int
   
    LEFT JOIN assessment_questions ON assessment_questions.assessment_id=assessments.id
    LEFT JOIN questions ON questions.id=assessment_questions.question_id
    
    LEFT JOIN (SELECT categories.id as "Q._Subtopic_ID",
                      categories.name as "Q._Subtopic_Name",
                      categories.grade as "Q._Subtopic_Grade",
                      categories.syllabus as "Q._Subtopic_Syllabus",
                      categories.subject as "Q._Subtopic_Subject",
                      categories.is_active as "Q._Is_Subtopic_Active?",
                      categories.is_included_in_tnl_json as "Q._Is_Subtopic_Included_in_TNL_JSON?",
                      cohort_categories.tnl_cohort_id as "Q._Subtopic_Cohort",
                      split_part(categories.ancestry,'/', 2)::Int as "Q._Chapter_Category"
                FROM categories
                      LEFT JOIN cohort_categories ON cohort_categories.category_id=split_part(categories.ancestry,'/',1)::int
                WHERE categories.type= 'QuestionTypeCategory' AND cohort_categories.tnl_cohort_id IN (53, 209, 211, 206, 208, 213, 207, 210, 212, 252, 232, 231)) as question_subtopic_table ON question_subtopic_table."Q._Subtopic_ID"=questions.category_id
    
    LEFT JOIN (SELECT categories.id as "Q._Chapter_Category",
                      categories.name as "Q._Chapter_Category_Name"
                FROM categories
                WHERE categories.type= 'ChapterCategory') as question_chaptercategory_table ON question_chaptercategory_table."Q._Chapter_Category"=question_subtopic_table."Q._Chapter_Category"
                
    LEFT JOIN resource_concepts ON resource_concepts.resource_id=assessment_questions.question_id
    LEFT JOIN concepts ON concepts.id=resource_concepts.concept_id
    
    LEFT JOIN(SELECT categories.id as "C._Category_ID",
                     categories.name as "C._Category_Name",
                     categories.is_active as "Is_C._Category_Active?",
                     cohort_categories.tnl_cohort_id as "C._Category_Cohort"
    FROM categories
        LEFT JOIN cohort_categories ON cohort_categories.category_id=split_part(categories.ancestry,'/',1)::int
        WHERE cohort_categories.tnl_cohort_id IN (53,209,211,206,208,213,207,210,212,252,232,231)) as concept_category_table ON concept_category_table."C._Category_ID"=concepts.category_id
    
    LEFT JOIN (SELECT categories.id as "C._Subtopic_ID",
                      categories.name as "C._Subtopic_Name",
                      categories.grade as "C._Subtopic_Grade",
                      categories.syllabus as "C._Subtopic_Syllabus",
                      categories.subject as "C._Subtopic_Subject",
                      categories.is_active as "C._Is_Subtopic_Active?",
                      categories.is_included_in_tnl_json as "C._Is_Subtopic_Included_in_TNL_JSON?",
                      cohort_categories.tnl_cohort_id as "C._Subtopic_Cohort"
                FROM categories
                      LEFT JOIN cohort_categories ON cohort_categories.category_id=split_part(categories.ancestry,'/',1)::int
                WHERE categories.type= 'QuestionTypeCategory' AND cohort_categories.tnl_cohort_id IN (53, 209, 211, 206, 208, 213, 207, 210, 212, 252, 232, 231)) as concepts_subtopic_table ON concepts_subtopic_table."C._Subtopic_ID"=concepts.sub_topic_id
                
    inner join resource_configurations on assessments.id=resource_configurations.resource_id
WHERE assessments.id IN ({{Enter Assessment ID(s):}}) or assessments.parent_id IN ({{Enter Assessment ID(s):}})
AND questions.is_deleted = false
AND resource_configurations.resource_type = 'Assessment'
AND resource_concepts.is_primary = true
ORDER BY assessments.id asc