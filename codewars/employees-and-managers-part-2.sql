-- Source: Employees and managers: part 2

--Title: Employees and managers: part 2

WITH RECURSIVE source AS(
  SELECT
    id,
    name,
    '' AS management_chain
  FROM employees
  WHERE manager_id IS NULL
  UNION ALL
  SELECT
    e.id,
    e.name,
    CASE
      WHEN s.management_chain = '' THEN s.name || ' (' || s.id || ')'
      ELSE s.management_chain || ' -> ' || s.name || ' (' || s.id || ')'
    END AS management_chain
  FROM employees e
  INNER JOIN source s
    ON e.manager_id = s.id
  WHERE manager_id IS NOT NULL
)
SELECT *
FROM source
ORDER BY id;