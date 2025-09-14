-- Source: https://leetcode.com/problems/employees-earning-more-than-their-managers/description/

--Title: Employees Earning More Than Their Managers

SELECT
    e.name AS "Employee"
FROM Employee e
INNER JOIN Employee m
    ON e.managerId = m.id AND e.salary > m.salary;