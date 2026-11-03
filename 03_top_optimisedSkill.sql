/*
goal: what are the top optimised skills for data engineers
-optimised skills are those that have a high demand and a high median salary
*/

select sd.skills,
cast (round(MEDIAN(jpf.salary_year_avg), 2) as INT64) as median_salary,
count (jpf.salary_year_avg) as demand_count,
round(ln(count (jpf.*))) as log_demand_count,
round(round(MEDIAN(jpf.salary_year_avg)  * ln(count (jpf.*)))/1000000, 2) as optimised_score
from job_postings_fact as jpf
inner join skills_job_dim as sjd
on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id = sd.skill_id
where jpf.job_title_short = 'Data Engineer' and jpf.salary_year_avg is not null
group by sd.skills
having count (jpf.salary_year_avg) > 100
order by optimised_score desc
limit 20;

/*
┌────────────┬───────────────┬──────────────┬──────────────────┬─────────────────┐
│   skills   │ median_salary │ demand_count │ log_demand_count │ optimised_score │
│  varchar   │     int64     │    int64     │      double      │     double      │
├────────────┼───────────────┼──────────────┼──────────────────┼─────────────────┤
│ python     │        133000 │         7004 │              9.0 │            1.18 │
│ spark      │        140000 │         3521 │              8.0 │            1.14 │
│ aws        │        135000 │         4406 │              8.0 │            1.13 │
│ kafka      │        147500 │         1991 │              8.0 │            1.12 │
│ sql        │        126010 │         7155 │              9.0 │            1.12 │
│ mongo      │        201000 │          243 │              5.0 │             1.1 │
│ java       │        137500 │         2469 │              8.0 │            1.07 │
│ airflow    │        145000 │         1618 │              7.0 │            1.07 │
│ hadoop     │        140000 │         1951 │              8.0 │            1.06 │
│ scala      │        140000 │         1966 │              8.0 │            1.06 │
│ snowflake  │        135000 │         2473 │              8.0 │            1.05 │
│ azure      │        126500 │         3613 │              8.0 │            1.04 │
│ redshift   │        137500 │         1723 │              7.0 │            1.02 │
│ nosql      │        135000 │         1641 │              7.0 │             1.0 │
│ kubernetes │        145500 │          929 │              7.0 │            0.99 │
│ databricks │        130000 │         1783 │              7.0 │            0.97 │
│ gcp        │        135000 │         1180 │              7.0 │            0.95 │
│ docker     │        139000 │          921 │              7.0 │            0.95 │
│ terraform  │        145000 │          688 │              7.0 │            0.95 │
│ cassandra  │        147500 │          531 │              6.0 │            0.93 │
└────────────┴───────────────┴──────────────┴──────────────────┴─────────────────┘
*/
