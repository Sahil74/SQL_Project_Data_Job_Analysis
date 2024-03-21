--select Round(AVG(salary_year_avg),0) as salary,skills from job_postings_fact
select AVG(salary_year_avg)::int as salary,skills from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and salary_year_avg is not NULL and job_country = 'Australia'
       -- job_work_from_home = True
Group by skills
order by  salary desc
limit 25