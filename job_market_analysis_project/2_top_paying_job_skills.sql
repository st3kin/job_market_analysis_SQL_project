/* 
Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.

Filter for roles with specified salaries that are remote.

Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers 
understand which skills to develop that align with top salaries.

*/

WITH top_paying_jobs AS (
    SELECT
        j.job_id,
        j.job_title,
        c.name AS company_name,
        j.salary_year_avg
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
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    s2.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS s1
    ON top_paying_jobs.job_id = s1.job_id
INNER JOIN skills_dim AS s2
    ON s1.skill_id = s2.skill_id
ORDER BY salary_year_avg DESC;