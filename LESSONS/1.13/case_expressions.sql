-- bucket salaries
-- < 25 = 'Low'
-- 25 - 50 = 'Medium'
-- > 50 = 'High'

select job_title_short, salary_hour_avg,
(case 
    when salary_hour_avg < 25 then 'Low'
    when salary_hour_avg < 50 then 'Medium'
    else 'High'
end) as salary_buckets
from job_postings_fact
where salary_hour_avg is not null
limit 10;

--handling missing data 
--filter null values

select job_title_short, salary_hour_avg,
(case 
    when salary_hour_avg is null then 'Missing'
    when salary_hour_avg < 25 then 'Low'
    when salary_hour_avg < 50 then 'Medium'
    else 'High'
end) as salary_buckets
from job_postings_fact
limit 10;


-- Catgorizing categorical values
-- classify the job_title column values as
-- data analyst
-- data engineer
-- data scientist

select job_title,
case 
    when job_title like '%Data%' and job_title like '%Analyst%' then 'Data Analyst'
    when job_title like '%Data%' and job_title like '%Engineer%' then 'Data Engineer'
    when job_title like '%Data%' and job_title like '%Scientist%' then 'Data Scientist'
    else 'other' 
end as job_category,
 job_title_short
from job_postings_fact
order by random()
limit 20;



-- conditional aggregation
-- calculate median salaries for different buckets 
-- < 100k
-- >= 100k

select job_title_short,
count(*) as job_postings, 
median(
    case when salary_year_avg < 100_000 then salary_year_avg
    end 
) as median_low_salary,
median(
    case when salary_year_avg >= 100_000 then salary_year_avg
    end
) as median_high_salary
from job_postings_fact
where salary_year_avg is not null
group by job_title_short;


-- Final example: conditional calculations
-- compute a standardized_salary usimgyearly salary and adjusted hourly salary (e.g 2000 hours/years)
-- categorize salaries into tiers of 
-- < 75k 'low'
-- 75k - 150k 'medium'
-- >= 150k 'high'

with salaries as (
    select job_title_short,
    salary_year_avg, salary_hour_avg,
    case 
        when salary_year_avg is not null then salary_year_avg
        when salary_hour_avg is not null then salary_hour_avg * 2080
    end  as standardized_salary
    from job_postings_fact
)
select *,
case 
    when standardized_salary is null then 'Missing'
    when standardized_salary < 75_000 then 'Low'
    when standardized_salary < 150_000 then 'Medium'
    else 'High'
end as salary_bucket
from salaries 
order by standardized_salary desc
limit 10; 