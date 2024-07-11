select distinct users.premium_account_id as "PID",
       users.full_name as "Name",
       batch_schedules.batch_id as "Batch ID",
       
       count(one_to_many_classroom_schedules.attended) as "Overall Sessions",
       count(Case when one_to_many_classroom_schedules.attended='TRUE' THEN 1 END) as "Overall Attended",
       cast(count(Case when one_to_many_classroom_schedules.attended='TRUE' THEN 1 END) as float) / 
       nullif(count(one_to_many_classroom_schedules.attended),0)*100 as "Overall Attend. %age",
       
       
       (count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Physics' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Physics' THEN 1 END)) as "Total Physics",
       count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Physics' THEN 1 END) as "Attended Physics",
       cast(count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Physics' THEN 1 END) as float) / 
       nullif((count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Physics' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Physics' THEN 1 END)),0)* 100 as "Physics Attend. %age",
       
       (count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Chemistry' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Chemistry' THEN 1 END)) as "Total Chemistry",
       count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Chemistry' THEN 1 END) as "Attended Chemistry",
       cast(count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Chemistry' THEN 1 END) as float) /
       nullif((count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Chemistry' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Chemistry' THEN 1 END)),0)*100 as "Chemistry Attend. %age",
       
       (count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Mathematics' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Mathematics' THEN 1 END)) as "Total Maths",
       count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Mathematics' THEN 1 END) as "Attended Maths",
       cast(count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Mathematics' THEN 1 END) as float) / 
       nullif((count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Mathematics' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Mathematics' THEN 1 END)),0)*100 as "Maths Attend. %age",
       
       
       (count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Biology' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Biology' THEN 1 END)) as "Total Biology",
       count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Biology' THEN 1 END) as "Attended Biology",
       cast(count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Biology' THEN 1 END) as float) / 
       nullif((count(Case when one_to_many_classroom_schedules.attended='TRUE' and raw_topics.subject= 'Biology' THEN 1 END)+
       count(Case when one_to_many_classroom_schedules.attended='FALSE' and raw_topics.subject= 'Biology' THEN 1 END)),0)*100 as "Biology Attend. %age"
       
       
from one_to_many_classroom_schedules
join users on users.id=one_to_many_classroom_schedules.user_id
join batch_schedules on batch_schedules.id=one_to_many_classroom_schedules.batch_schedule_id
join raw_topics on raw_topics.id=batch_schedules.raw_topic_id
where batch_schedules.batch_id in ({{Enter BIDs}})
and batch_schedules.session_starts_at AT TIME ZONE 'utc' AT TIME ZONE 'Asia/Calcutta'<= current_date
group by users.premium_account_id, users.full_name, batch_schedules.batch_id