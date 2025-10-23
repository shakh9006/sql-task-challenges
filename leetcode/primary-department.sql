-- Source: https://leetcode.com/problems/primary-department-for-each-employee/description/

--Title: Primary Department for Each Employee

WITH EmployeeDetails AS (
    SELECT
        *,
        COUNT(*) OVER(PARTITION BY employee_id) AS ct
    FROM Employee
)
SELECT
    employee_id,
    department_id
FROM EmployeeDetails
WHERE (ct = 1 AND primary_flag = 'N') OR (ct > 1 AND primary_flag = 'Y');