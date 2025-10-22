-- Source: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/

--Title: The Number of Employees Which Report to Each Employee

WITH report_ids AS (
    SELECT
        reports_to AS employee_id,
        COUNT(*) AS reports_count,
        ROUND(AVG(age)) AS average_age
    FROM Employees
    WHERE reports_to IS NOT NULL
    GROUP BY reports_to
)
SELECT
    employee_id,
    name,
    reports_count,
    average_age
FROM Employees
INNER JOIN report_ids USING(employee_id)
ORDER BY employee_id;