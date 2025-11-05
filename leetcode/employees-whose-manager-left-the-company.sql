-- Source: https://leetcode.com/problems/employees-whose-manager-left-the-company/description/

--Title: Employees Whose Manager Left the Company

WITH EmployeeIds AS (
    SELECT DISTINCT employee_id
    FROM Employees
)
SELECT
    employee_id
FROM Employees
WHERE manager_id IS NOT NULL
    AND manager_id NOT IN (select * from EmployeeIds)
    AND salary < 30000
ORDER BY employee_id;