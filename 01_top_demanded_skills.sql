/*
Goal: Find out the Most in-demand skills for Data Engineers
-Identiy the top 10 most in-demand skills for Data Engineers based on job postings and industry trends.
-focus on remote job postings
*/

select sd.skills,
count(jpf.job_id) as demand_count
from job_postings_fact as jpf
inner join skills_job_dim as sjd
on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id = sd.skill_id

where jpf.job_title_short = 'Data Engineer'
group by sd.skills
order by demand_count desc
limit 10
;

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │       233132 │
│ python     │       224102 │
│ aws        │       130205 │
│ azure      │       128822 │
│ spark      │       106904 │
│ java       │        69657 │
│ databricks │        63012 │
│ snowflake  │        60379 │
│ scala      │        57079 │
│ kafka      │        56410 │
└────────────┴──────────────┘

*/