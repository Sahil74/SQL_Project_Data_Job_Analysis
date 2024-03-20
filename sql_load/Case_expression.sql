select count(job_id) as number_of_jobs,
CASE
    when job_location = 'Anywhere' then 'Remote'
    when job_location ='New York' then 'Local'
    else 'Onsite'
END as location_category
from job_postings_fact
where job_title_short = 'Data Analyst'
group by location_category;

--problem

select 
    CASE
    whem

select Max(salary_year_avg),job_title_short
from job_postings_fact
group by job_title_short