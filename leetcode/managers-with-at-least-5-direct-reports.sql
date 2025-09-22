-- Source: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/

--Title: Managers with at Least 5 Direct Reports

WITH employee_ids AS (
    SELECT
        managerId AS id
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY 1
    HAVING COUNT(*) > 4
)
SELECT
    name
FROM Employee
WHERE id IN (select * from employee_ids);