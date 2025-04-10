/* Identify the top 10 highest-paying Data Analyst roles that are available remotely. */

/* Focuses on job postings with specified salaries. (remove nulls) */

/*Why? Highlight the top-paying opportunities for Data Analysts, offering insights 
into employment options and location flexibility. */

SELECT
    j.job_id,
    j.job_title,
    c.name AS company_name,
    j.job_location,
    j.job_schedule_type,
    j.salary_year_avg,
    j.job_posted_date
FROM
    job_postings_fact AS j
LEFT JOIN company_dim AS c
    ON j.company_id = c.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
