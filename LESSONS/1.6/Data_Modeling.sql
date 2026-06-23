select job_id, job_title_short, salary_year_avg, company_id
from job_postings_fact
limit 10;

select company_id, name
from company_dim
limit 10;

select *
from company_dim
limit 10;

select *
from company_dim
where name in ('Meta', 'Facebook')
limit 10;


select * 
from information_schema.tables;

select * 
from information_schema.tables
where table_catalog = 'data_jobs';

select * 
from information_schema.columns
where table_catalog = 'data_jobs';

PRAGMA show_tables;
PRAGMA show_tables_expanded;

describe job_postings_fact;
