-- Source: https://www.codewars.com/kata/64b58b2b59329500245ffc22/train/sql

--Title: Backend Team's Tradition: An Age-Alternating Introduction

WITH source AS (
  SELECT
    *,
    ROW_NUMBER() OVER(ORDER BY birth_date DESC) AS rn_desc,
    ROW_NUMBER() OVER(ORDER BY birth_date ASC) AS rn_asc
  FROM employees
  WHERE team = 'backend'
),
custom_order AS (
  SELECT
    *,
    CASE
         WHEN rn_desc <= rn_asc THEN rn_desc * 2 - 1
         ELSE rn_asc * 2
     END AS zigzag_order
  FROM source
)
SELECT
  employee_id,
  full_name,
  team,
  birth_date
FROM custom_order
ORDER BY zigzag_order