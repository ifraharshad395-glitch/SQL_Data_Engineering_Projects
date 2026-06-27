--clean up this using text functions

with title_lower as (
    select job_title,
    lower(trim(job_title)) as clean_job_title
    from job_postings_fact
)

select job_title,
case 
    when clean_job_title like '%data%' and clean_job_title like '%analyst%' then 'Data Analyst'
    when clean_job_title like '%data%' and clean_job_title like '%engineer%' then 'Data Engineer'
    when clean_job_title like '%data%' and clean_job_title like '%scientist%' then 'Data Scientist'
    else 'other'
end as job_title_category
from title_lower
order by random()
limit 30;