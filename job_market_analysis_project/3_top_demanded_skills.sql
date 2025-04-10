/*
Identify the top 5 in-demand skills for a data analyst.

Focus on all job postings.

Why? Retrieves the top 5 skills with the highest demand in 
the job market, providing insights into the most valuable skills 
for job seekers. 

*/

SELECT
    skills,
    COUNT(s1.job_id) AS demand_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS s1
    ON j.job_id = s1.job_id
INNER JOIN skills_dim AS s2
    ON s1.skill_id = s2.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;