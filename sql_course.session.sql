select job_title_short,job_location,job_via, salary_year_avg, job_posted_date from job_postings_fact
where job_location like '%Australia%' and job_title_short like '%Data Analyst%'
order by salary_year_avg asc

select count(job_id) as count, Job_via from job_postings_fact
where job_location like '%Australia%' and job_title_short like '%Data Analyst%'
GROUP by job_via
order by count desc
