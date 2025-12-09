-- Source: https://www.codewars.com/kata/648d872a20f2410065b26ebf/train/sql

--Title: Employees and managers

WITH RECURSIVE subs AS (
    SELECT *
    FROM employees

    UNION ALL

    SELECT
      e.id,
      e.name,
      s.manager_id,
      e.experience
    FROM subs s
    INNER JOIN employees e
      ON e.manager_id = s.id
)
SELECT
  manager_id,
  COUNT(*) AS total_subordinates,
  ROUND(AVG(experience), 1) AS average_experience,
  STRING_AGG(name, ', ' ORDER BY id) AS employee_names
FROM subs
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY 2 DESC, 1
LIMIT 5;