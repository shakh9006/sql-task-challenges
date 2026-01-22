-- Source: https://www.codewars.com/kata/589cf45835f99b2909000115/train/sql

--Title: Calculating Running Total

WITH source AS (
  SELECT
    created_at::DATE AS date,
    COUNT(*) AS count
  FROM posts
  GROUP BY 1
  ORDER BY 1
)
SELECT
  *,
  SUM(count) OVER(ORDER BY date)::INT AS total
FROM source;