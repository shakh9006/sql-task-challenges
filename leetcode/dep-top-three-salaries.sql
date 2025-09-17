-- Source: https://leetcode.com/problems/department-top-three-salaries/description/

--Title: Department Top Three Salaries

WITH source AS (
    SELECT
        d.name AS dep_name,
        e.name,
        e.salary,
        DENSE_RANK() OVER(PARTITION BY d.id ORDER BY salary DESC) AS rn
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentId = d.id
)
SELECT
   dep_name AS "Department",
   name AS "Employee",
   salary AS "Salary"
FROM source
WHERE rn <= 3;