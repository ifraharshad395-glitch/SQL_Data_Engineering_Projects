
---subquery

select *
 from 
 ( select * from job_postings_fact
 where salary_year_avg is not null or 
 salary_hour_avg is not null); 

 --cte 

 with valid_salaries as (
   select * from job_postings_fact
 where salary_year_avg is not null or 
 salary_hour_avg is not null)

 select * from valid_salaries;


--subquery examples

 --subquery in select (show each jobs' salary next to the overall market median salray)

 select job_title_short, salary_year_avg,
 (select 
    median(salary_year_avg)
    from job_postings_fact) as overall_market_median
from job_postings_fact
where salary_year_avg is not null;
 
--subquery in from (stage only jobs that are remote before aggregating to determine the remote median salary per job)

select job_title_short, median(salary_year_avg) as median_salary,
(select median(salary_year_avg)
from job_postings_fact 
where job_work_from_home = true) as market_remote_median_salary
from (
    select job_title_short, salary_year_avg 
    from job_postings_fact
    where job_work_from_home = true
) as remote_jobs
group by job_title_short;

--subquery in having (keep onloy job titles whose median salary is above the overall median)

select job_title_short, median(salary_year_avg) as median_salary,
(select median(salary_year_avg)
from job_postings_fact 
where job_work_from_home = true) as market_remote_median_salary
from (
    select job_title_short, salary_year_avg 
    from job_postings_fact
    where job_work_from_home = true
) as remote_jobs
group by job_title_short
having median(salary_year_avg) > (
    select median(salary_year_avg)
from job_postings_fact 
where job_work_from_home = true
);





---cte examples
 ---compare how much mor (or less) remote roles pay compared to onsite roles for each job title
 --use a cte to calculate the median salary by title and work arrangement, then compare these

 with title_median as (
 select job_title_short, job_work_from_home, 
 cast(median(salary_year_avg) as int) as median_salary
 from job_postings_fact
 where job_country = 'United States'
 group by job_title_short, job_work_from_home
 )

 select r.job_title_short, 
 r.median_salary as remote_median_salary,
 o.median_salary as onsite_median_salary,
 (r.median_salary - o.median_salary) as remote_premium
 from title_median as r inner join title_median as o 
 on r.job_title_short = o.job_title_short
 where r.job_work_from_home = true
 and o.job_work_from_home = false
 order by remote_premium desc;



--source src and target tgt tables

--identify job postings that have no associated skills before loading them into a data mart

select * from job_postings_fact 
limit 10;

select * from skills_job_dim
limit 40;

select * 
from job_postings_fact as tgt 
where not exists (
    select 1 
    from skills_job_dim as src
    where tgt.job_id = src.job_id
) 
order by job_id; 