/*
Look at the average salary associated with each skill for Data Analyst positions.

Focus on roles with specified salaries, regardless of location.

Why? It reveals how different skills impact salary levels for Data Analysts and helps 
identify the most financially rewarding skills to acquire or improve.

*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS s1
    ON j.job_id = s1.job_id
INNER JOIN skills_dim AS s2
    ON s1.skill_id = s2.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;