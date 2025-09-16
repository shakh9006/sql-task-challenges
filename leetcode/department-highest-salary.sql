-- Source: https://leetcode.com/problems/department-highest-salary/description/

--Title: Department Highest Salary

WITH RankedEmployee AS (
    SELECT
        d.name AS dep_name,
        e.name,
        e.salary,
        DENSE_RANK() OVER(PARTITION BY e.departmentId ORDER BY salary DESC) AS rn
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentId = d.id
)
SELECT
    dep_name AS "Department",
    name AS "Employee",
    salary AS "Salary"
FROM RankedEmployee
WHERE rn = 1;