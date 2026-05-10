select 
 jpf.job_id, jpf.job_title_short, cd.company_id, 
 cd.name as company_name, jpf.job_location
 from 
 job_postings_fact as jpf left join company_dim as cd 
 on jpf.company_id = cd.company_id
 limit 10;

 select jpf.job_id, jpf.job_title_short, sdj.skill_id, sd.skills
 from job_postings_fact as jpf
 left join skills_job_dim as sdj on jpf.job_id = sdj.job_id
 left join skills_dim as sd on sdj.skill_id = sd.skill_id
 limit 10;
