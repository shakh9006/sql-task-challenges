-- Source: https://leetcode.com/problems/combine-two-tables/description/

--Title: Combine Two Tables

SELECT
    firstName,
    lastName,
    city,
    state
FROM Person
LEFT JOIN Address USING(personId);