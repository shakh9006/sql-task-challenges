-- Source: https://leetcode.com/problems/second-highest-salary/description/

--Title:  Second Highest Salary

WITH highest_salary AS (
    SELECT
        MAX(salary) AS max_salary
    FROM Employee
)
SELECT COALESCE(
    (select
        salary
    from Employee
    where salary != (select max_salary from highest_salary)
    order by salary desc
    limit 1),
    NULL
) AS "SecondHighestSalary";