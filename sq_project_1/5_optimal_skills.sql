/*
Identify skills in high demand and associated with 
high average salaries for Data Analyst roles

Concentrate on remote positions with specified salaries

Why? Targets skills that offer job security (high demand) 
and financial benefits (high salaries), offering strategic 
insights for career development in data analysis
*/

-- Demanded skills as a CTE

WITH demanded_skills AS (
    SELECT
        s2.skill_id,
        s2.skills,
        COUNT(s1.job_id) AS demand_count
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS s1
        ON j.job_id = s1.job_id
    INNER JOIN skills_dim AS s2
        ON s1.skill_id = s2.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY s2.skill_id
),

-- Average salary as a CTE

average_salary AS (
    SELECT
        s2.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS s1
        ON j.job_id = s1.job_id
    INNER JOIN skills_dim AS s2
        ON s1.skill_id = s2.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY s2.skill_id
)

SELECT
    demanded_skills.skill_id,
    demanded_skills.skills,
    demand_count,
    avg_salary
FROM demanded_skills
INNER JOIN average_salary
    ON demanded_skills.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 25;

/*

Rewriting the same query more concisely

SELECT
    s2.skill_id,
    s2.skills,
    COUNT(s1.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS s1
    ON j.job_id = s1.job_id
INNER JOIN skills_dim AS s2
    ON s1.skill_id = s2.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY s2.skill_id
HAVING COUNT(s1.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
*/