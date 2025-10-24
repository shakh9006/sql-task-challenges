-- Source: https://leetcode.com/problems/calculate-special-bonus/

--Title: Calculate Special Bonus

SELECT
    e1.employee_id,
    COALESCE(e2.salary, 0) AS bonus
FROM Employees e1
LEFT JOIN Employees e2
    ON e1.employee_id = e2.employee_id AND e2.employee_id % 2 != 0 AND e2.name NOT LIKE 'M%'
ORDER BY e1.employee_id;