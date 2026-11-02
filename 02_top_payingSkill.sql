/*
goal: find the top paying skills
-calculate the median salary for each skill required
*/

select sd.skills,
cast (round(MEDIAN(jpf.salary_year_avg), 2) as INT64) as median_salary,
count(jpf.*) as demand_count
from job_postings_fact as jpf
inner join skills_job_dim as sjd
on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id = sd.skill_id

where jpf.job_title_short = 'Data Engineer'
group by sd.skills
having demand_count > 100
order by median_salary desc
limit 20
;


/*
┌───────────────┬───────────────┬──────────────┐
│    skills     │ median_salary │ demand_count │
│    varchar    │     int64     │    int64     │
├───────────────┼───────────────┼──────────────┤
│ mongo         │        201000 │         3795 │
│ solidity      │        192500 │          174 │
│ rust          │        169688 │         1317 │
│ arch          │        157642 │          151 │
│ puppet        │        157500 │         1066 │
│ groovy        │        157500 │          813 │
│ vue           │        156500 │         1107 │
│ codecommit    │        155000 │          292 │
│ zoom          │        155000 │          669 │
│ golang        │        155000 │         2805 │
│ typescript    │        150000 │         2616 │
│ ansible       │        150000 │         6122 │
│ ruby on rails │        150000 │          319 │
│ node          │        150000 │         1084 │
│ pytorch       │        147500 │         4400 │
│ cassandra     │        147500 │        12206 │
│ redis         │        147500 │         4215 │
│ graphql       │        147500 │         2215 │
│ kafka         │        147500 │        56410 │
│ macos         │        146200 │          245 │
└───────────────┴───────────────┴──────────────┘