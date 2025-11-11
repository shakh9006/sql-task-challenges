-- Source: https://leetcode.com/problems/employees-with-missing-information/description/

--Title: Employees With Missing Information

WITH unique_ids AS (
    SELECT employee_id
    FROM Employees
    UNION
    SELECT employee_id
    FROM Salaries
)
SELECT
    employee_id
FROM unique_ids
LEFT JOIN Employees e USING(employee_id)
LEFT JOIN Salaries s USING(employee_id)
WHERE e.name IS NULL OR s.salary IS NULL;