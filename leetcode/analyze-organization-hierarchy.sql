-- Source: https://leetcode.com/problems/analyze-organization-hierarchy/description/

--Title: Analyze Organization Hierarchy

WITH RECURSIVE hierarchy AS (
  SELECT
    employee_id,
    employee_name,
    manager_id,
    salary,
    1 AS level
  FROM Employees
  WHERE manager_id IS NULL

  UNION ALL

  SELECT
    e.employee_id,
    e.employee_name,
    e.manager_id,
    e.salary,
    h.level + 1 AS level
  FROM Employees e
  JOIN hierarchy h ON e.manager_id = h.employee_id
),
subordinates AS (
  SELECT
    manager_id AS root_manager,
    employee_id AS subordinate
  FROM Employees
  WHERE manager_id IS NOT NULL

  UNION ALL

  SELECT
    s.root_manager,
    e.employee_id
  FROM subordinates s
  JOIN Employees e ON e.manager_id = s.subordinate
),
team_data AS (
  SELECT
    e.employee_id,
    COUNT(s.subordinate) AS team_size,
    COALESCE(SUM(e2.salary), 0) + e.salary AS budget
  FROM Employees e
  LEFT JOIN subordinates s ON s.root_manager = e.employee_id
  LEFT JOIN Employees e2 ON e2.employee_id = s.subordinate
  GROUP BY e.employee_id, e.salary
),
result AS (
  SELECT
    h.employee_id,
    h.employee_name,
    h.level,
    td.team_size,
    td.budget
  FROM hierarchy h
  JOIN team_data td ON h.employee_id = td.employee_id
)
SELECT *
FROM result
ORDER BY level ASC, budget DESC, employee_name ASC;