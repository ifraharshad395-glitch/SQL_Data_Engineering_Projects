select sd.skills, round(median(salary_year_avg),0) as median_salary,
 --count(jpf.*) as demand_count,
 round(ln(count(jpf.*)), 1) as ln_demand_count,
 round((round(median(salary_year_avg),0) * ln(count(jpf.*)))/1_000_000, 2) as optimal_score
from job_postings_fact as jpf 
inner join skills_job_dim as sjd 
on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id = sd.skill_id
where jpf.job_title_short = 'Data Engineer'
and jpf.job_work_from_home = true
and jpf.salary_year_avg is not null
group by sd.skills
having count(jpf.*) > 100
order by optimal_score desc
limit 25;