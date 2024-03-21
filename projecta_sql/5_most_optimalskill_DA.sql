/*Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries 
Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis
*/

--4
--select Round(AVG(salary_year_avg),0) as salary,skills from job_postings_fact
with skills_demand as(
        select skills_dim.skill_id, count(job_postings_fact.job_id) as count_A, skills_dim.skills from job_postings_fact
        inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
        inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
        where job_title_short = 'Data Analyst' and
                job_work_from_home = True 
        Group by skills_dim.skill_id
),
average_salary as(
    --select Round(AVG(salary_year_avg),0) as salary,skills from job_postings_fact
        select skills_job_dim.skill_id, AVG(salary_year_avg)::int as salary from job_postings_fact
        inner join skills_job_dim on job_postings_fact.job_id  = skills_job_dim.job_id
        inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
        where job_title_short = 'Data Analyst' and salary_year_avg is not NULL and 
            job_work_from_home = True
            -- job_country = 'Australia'
        Group by skills_job_dim.skill_id
)
 
select skills_demand.skill_id,skills_demand.skills, count_A, salary from skills_demand inner join average_salary on average_salary.skill_id = skills_demand.skill_id    
order by count_A desc, average_salary desc