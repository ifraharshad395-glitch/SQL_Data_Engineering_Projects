select * from information_schema.columns;

select table_name, column_name, data_type
 from information_schema.columns 
where table_name = 'job_postings_fact';

describe job_postings_fact;

describe
select job_title_short, salary_year_avg
from job_postings_fact;

select job_id, job_work_from_home, job_posted_date, salary_year_avg
from job_postings_fact 
limit 10;

select job_id, job_work_from_home, job_posted_date, salary_year_avg
from job_postings_fact 
where salary_year_avg is not null
limit 10;

select job_id, 
cast(job_work_from_home as int) as job_work_from_home,
cast(job_posted_date as date) as job_posted_date,
cast(salary_year_avg as decimal(10,0)) as salary_year_avg
from job_postings_fact 
where salary_year_avg is not null
limit 10;

select job_id, company_id,
cast(job_work_from_home as int) as job_work_from_home,
cast(job_posted_date as date) as job_posted_date,
cast(salary_year_avg as decimal(10,0)) as salary_year_avg
from job_postings_fact 
where salary_year_avg is not null
limit 10;

select cast(job_id as varchar) as job_id, 
cast(company_id as varchar) as company_id,
cast(job_work_from_home as int) as job_work_from_home,
cast(job_posted_date as date) as job_posted_date,
cast(salary_year_avg as decimal(10,0)) as salary_year_avg
from job_postings_fact 
where salary_year_avg is not null
limit 10;

select (cast(job_id as varchar) || '-' || cast(company_id as varchar)) as job_id_unique_identifier ,
cast(job_work_from_home as int) as job_work_from_home,
cast(job_posted_date as date) as job_posted_date,
cast(salary_year_avg as decimal(10,0)) as salary_year_avg
from job_postings_fact 
where salary_year_avg is not null
limit 10;

select job_posted_date
from job_postings_fact;