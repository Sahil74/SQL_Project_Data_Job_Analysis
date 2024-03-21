/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.*/


select company_dim.name, job_title_short, job_via, job_location, salary_year_avg, salary_hour_avg, skills 
from job_postings_fact 
INNER JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Machine Learning Engineer' and job_country = 'Australia'


select count(job_postings_fact.job_id) as count, company_dim.name, job_via
from job_postings_fact 
INNER JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and job_country = 'Australia'
group by company_dim.name, job_via
order by count desc

select count(job_postings_fact.job_id) as count,skills from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and
        job_work_from_home = True
Group by skills
order by count desc
limit 5 

select count(job_postings_fact.job_id) as count,skills from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and
        job_work_from_home = True
Group by skills
order by count desc
limit 5 