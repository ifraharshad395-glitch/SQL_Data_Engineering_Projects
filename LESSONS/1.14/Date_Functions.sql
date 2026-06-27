select job_posted_date,
job_posted_date::date as date ,
job_posted_date::time as time,
job_posted_date::timestamp as timestamp ,
job_posted_date::timestamptz as timestamptz
from job_postings_fact
limit 10;

select job_posted_date,
extract(year from job_posted_date) as year,
extract(month from job_posted_date) as month,
extract(day from job_posted_date) as day
from job_postings_fact
limit 10;


select 
extract(year from job_posted_date) as job_posted_year,
extract(month from job_posted_date) as job_posted_month,
count(*) as job_count
from job_postings_fact
where job_title_short = 'Data Engineer'
group by 
extract(year from job_posted_date),
extract(month from job_posted_date) 
order by 
job_posted_year, 
job_posted_month;



select job_posted_date,
date_trunc('year', job_posted_date) as truncated_year,
date_trunc('quarter', job_posted_date) as truncated_quarter,
date_trunc('month', job_posted_date) as truncated_month,
date_trunc('week', job_posted_date) as truncated_week,
date_trunc('day', job_posted_date) as truncated_day,
date_trunc('hour', job_posted_date) as truncated_hour
from job_postings_fact
order by random()
limit 10;


select 
date_trunc('month', job_posted_date) as job_posted_month,
count(job_id) as job_count
from job_postings_fact
where job_title_short = 'Data Engineer'
group by date_trunc('month', job_posted_date)
order by job_posted_month;

select 
date_trunc('month', job_posted_date) as job_posted_month,
count(job_id) as job_count
from job_postings_fact
where job_title_short = 'Data Engineer' 
and extract(year from job_posted_date) = 2024
group by date_trunc('month', job_posted_date)
order by job_posted_month;

 