-- partition by finding hourly salary

select job_id, job_title_short, company_id, salary_hour_avg,
avg(salary_hour_avg) over(
    partition by job_title_short, company_id
)
from job_postings_fact
where salary_hour_avg is not null
order by random()
limit 10;


--ranking salary hour avg

select job_id, job_title_short, salary_hour_avg,
rank() over(
    order by salary_hour_avg desc
) as rank_hourly_salary
from job_postings_fact
where salary_hour_avg is not null
---order by salary_hour_avg desc
limit 10;


---partition by and order by -- running salary hour avg

select job_posted_date, job_title_short, salary_hour_avg,
avg(salary_hour_avg) over(
    partition by job_title_short
    order by job_posted_date
) as running_avg_hourly_by_title
from job_postings_fact
where salary_hour_avg is not null
order by job_title_short,
job_posted_date
limit 10;

select job_posted_date, job_title_short, salary_hour_avg,
avg(salary_hour_avg) over(
    partition by job_title_short
    order by job_posted_date
) as running_avg_hourly_by_title
from job_postings_fact
where salary_hour_avg is not null
and job_title_short = 'Data Engineer'
order by job_title_short,
job_posted_date
limit 10;


--lag()--time based comparison of company yearly salary

select 
job_id,
company_id,
job_title,
job_title_short,
job_posted_date,
salary_year_avg,
lag(salary_year_avg) over(
    partition by company_id
    order by job_posted_date
) as previous_posted_salary
from job_postings_fact
where salary_year_avg is not null
order by company_id, job_posted_date
limit 60;

select 
job_id,
company_id,
job_title,
job_title_short,
job_posted_date,
salary_year_avg,
lead(salary_year_avg) over(
    partition by company_id
    order by job_posted_date
) as previous_posted_salary
from job_postings_fact
where salary_year_avg is not null
order by company_id, job_posted_date
limit 60; 