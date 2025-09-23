-- Source: https://leetcode.com/problems/employee-bonus/description/

--Title: Employee Bonus

SELECT name, bonus
FROM Employee
LEFT JOIN Bonus USING(empId)
WHERE bonus < 1000 OR bonus IS NULL;