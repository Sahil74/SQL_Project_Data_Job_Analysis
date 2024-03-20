--Union - expect duplicates
select job_title_short,
    company_id,
    job_location
    from january_jobs

UNION

select job_title_short,
    company_id,
    job_location
    from february_jobs

--UnionALL - including d uplicates

select job_title_short,
    company_id,
    job_location
    from january_jobs

UNION ALL

select job_title_short,
    company_id,
    job_location
    from february_jobs


--Problem 
/* Find job postings from the first quarter that have a salary greater than
Combine job posting tables from the first quarter of 2023 (Jan-Mar)
Gets job postings with an average yearly salary > $70,000*/


select 
quarter_1.job_title_short,
quarter_1.job_location,
quarter_1.job_via,
quarter_1.job_posted_date::date 
from(
        select * from january_jobs
        Union ALL
        select * from february_jobs
        Union ALL
        select * from march_jobs
        ) as quarter_1
where quarter_1.salary_year_avg >70000 and quarter_1.job_title_short = 'Data Analyst'
order by quarter_1.salary_year_avg desc


select