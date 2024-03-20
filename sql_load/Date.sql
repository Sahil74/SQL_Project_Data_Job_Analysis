--converting whole zone to the only date(removing the timestramp)
select job_posted_date ::date FROM job_postings_fact limit 10
--some other data types examples
select 
    '2023-02-19'::date,
    '123'::integer,
    'true'::boolean,
    '3.14'::real;

-- on project
select job_title_short as title,
       job_location as location, 
       job_posted_date::date as date
from job_postings_fact
     



--- particular timezone 
/* in our data we dont have any timezone  (it usually look like at the end +00 somthing)
but we know that it is in UTC so we have to say first from utc to est(we want this timezone) */
--syntax = at time zone ''

select job_title_short as title,
       job_location as location, 
       job_posted_date at time zone 'UTC' at time zone 'EST' as date 
from job_postings_fact
limit 5


---extract something from datetime
--anything month, year, time, day
--syntax = extract(____ from column_name)

select job_title_short as title,
       job_location as location, 
       job_posted_date at time zone 'UTC' at time zone 'EST' as date, 
       extract(month from job_posted_date) as date_month,
       extract(year from job_posted_date) as date_month
from job_postings_fact
limit 5 

--we want to see how job posting increasing month to month
 








 -- Problem 1
 -- write a query to find the average salary both yearly and hourly
 -- for job posting that were posted after june 1 2023 group the resukts by job schedule type

select AVG(salary_year_avg) as yearly,
    AVG(salary_hour_avg) as hourly,
    job_schedule_type
    from job_postings_fact
    where job_posted_date > '2023-06-01'
    group by job_schedule_type


--problem 2
-- write a query to count the number of job posting for each month in 2023 adjusting the job_posted_date
-- to be in 'america/newyork' time zone before the month and group by and order by month

select 
extract(month from job_posted_date at time zone 'UTC' at time zone 'EDT') as month,
extract(year from job_posted_date at time zone 'UTC' at time zone 'EDT') as year,
count(job_id)
from job_postings_fact
where extract(year from job_posted_date at time zone 'UTC' at time zone 'EDT') = '2023'
group by month
order by month


--problem 3 
-- write a query to find companies (with name) that have posted jobs offering health insurance, where these posting were made
-- in the second quarter of 2023 use date extraction to find by quarter.

select company_dim.name,
job_postings_fact.job_id,
job_postings_fact.job_title_short,
job_postings_fact.job_health_insurance,
extract(quarter from job_postings_fact.job_posted_date) as quarter,
extract(month from job_postings_fact.job_posted_date) as month
from job_postings_fact left join company_dim on job_postings_fact.company_id = company_dim.company_id
where extract(quarter from job_posted_date) = 2 and job_postings_fact.job_health_insurance = True;


--Problem 4 create tables on each month from using all data

create table January_Jobs as
select * from job_postings_fact
where extract(year from job_posted_date) = 2023 and extract(month from job_posted_date) = 1;

create table February_Jobs as
select * from job_postings_fact
where extract(year from job_posted_date) = 2023 and extract(month from job_posted_date) = 2;

create table March_Jobs as
select * from job_postings_fact
where extract(year from job_posted_date) = 2023 and extract(month from job_posted_date) = 3;












