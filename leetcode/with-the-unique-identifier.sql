-- Source: https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/

--Title: Replace Employee ID With The Unique Identifier

SELECT
    unique_id,
    name
FROM Employees
LEFT JOIN EmployeeUNI USING(id);