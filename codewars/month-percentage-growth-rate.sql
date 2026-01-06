-- Source: https://www.codewars.com/kata/589e0837e10c4a1018000028/train/sql

--Title: Calculating Month-Over-Month Percentage Growth Rate

WITH source AS (
  SELECT
    DATE_TRUNC('month', created_at)::DATE AS date,
    COUNT(*) AS count
  FROM posts
  GROUP BY DATE_TRUNC('month', created_at)::DATE
)
SELECT
  date,
  count,
  TO_CHAR(
    ROUND((count / (LAG(count) OVER(ORDER BY date))::numeric * 100) - 100, 1),
    'FM999999990.0'
  ) || '%' AS percent_growth
FROM source;