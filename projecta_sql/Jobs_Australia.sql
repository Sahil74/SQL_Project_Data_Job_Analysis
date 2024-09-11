-- How Many jobs has been posted in the last year in australia and also find how many data jobs?
select count(job_id) as number_of_jobs, EXTRACT(YEAR from job_posted_date) as month
from job_postings_fact
where job_location = 'Australia'
group by month
order by count(job_id) DESC;

select count(job_id) as number_of_jobs, EXTRACT(YEAR from job_posted_date) as month
from job_postings_fact
where job_location = 'Australia' and job_title Like '% Data %'
group by month
order by count(job_id) DESC;

-- Top 10 Data jobs in australia
select count(job_id) as number_of_jobs, job_title
from job_postings_fact
where job_location = 'Australia' and job_title Like '% Data %'
group by job_title
order by count(job_id) DESC
limit 10;



-- Identify the five leading job platforms in Australia along with the number of job listings available on each.

select count(job_id) as number_of_jobs, job_via as platform
from job_postings_fact
where job_location = 'Australia' and job_title like '% Data %'
group by platform
order by count(job_id) DESC
LIMIT 5;




-- Top 10 Companies hiring data specialist in australia.
select count(j.job_id), c.name from job_postings_fact as j JOIN company_dim as c on j.company_id = c.company_id
where j.job_location = 'Australia' and j.job_title like '% Data %'
group by c.name
order by count(j.job_id) DESC
Limit 10;

