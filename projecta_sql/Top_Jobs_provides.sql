select count(job_id) as number_of_jobs, job_via
from job_postings_fact
where job_title_short = 'Data Analyst'
group by job_via
order by count(job_id) DESC;

select count(job_id) as number_of_jobs, EXTRACT(YEAR from job_posted_date) as month
from job_postings_fact
group by month
order by count(job_id) DESC;