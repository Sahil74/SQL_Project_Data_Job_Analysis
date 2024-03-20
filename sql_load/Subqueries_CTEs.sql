--subqueries

--basic
select * 
from (select * from job_postings_fact 
        where extract(month from job_posted_date) = 1
        ) as January_jobs;

 --problem - get a list companies' name that are offering jobs that do not have any requirements for degree
select company_id, name from company_dim where company_id in (select company_id
from job_postings_fact
where job_no_degree_mention = True);
   

-- cte
with January_jobs as (
    select * from job_postings_fact where extract(month from job_posted_date) = 1
)

select * from January_jobs


--problem 
-- find the companies that have the most job openings.
--get the total numeber of jobposting per company id
-- return the total number of jobs with the company_name



with company_job_counts as (
    select company_id,
            count(*) as total_jobs
    from 
            job_postings_fact
    GROUP BY
            company_id

)
select company_dim.name as company_name, company_job_counts.total_jobs from company_dim left join company_job_counts on company_job_counts.company_id = company_dim.company_id
order by total_jobs desc


---Problem 4
/* Find the count of the numebr of remote jobs posting per skill GROUP BY
- Display the top 5 skills by their demand in remote jobs
- include skills id, name, and count of posting reqioring the skill*/

--solution
with remote_jobs as(
select count(*) as count, skills_to_job.skill_id
from skills_job_dim as skills_to_job inner join job_postings_fact as job_postings
on job_postings.job_id = skills_to_job.job_id
where job_postings.job_work_from_home = True and
job_postings.job_title_short = 'Data Analyst'
group BY skill_id
)
select skills.skill_id,skills, count from remote_jobs inner join skills_dim as skills on skills.skill_id = remote_jobs.skill_id
order by count desc


 
--my solution
select count(skills_job_dim.job_id), skills_dim.skills 
from skills_dim left join skills_job_dim on skills_job_dim.skill_id = skills_dim.skill_id
where skills_job_dim.job_id in (select job_id from job_postings_fact where job_work_from_home = True)
group by skills_dim.skills  