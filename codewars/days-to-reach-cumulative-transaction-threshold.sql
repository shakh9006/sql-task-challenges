-- Source: https://www.codewars.com/kata/64b7ef13e0abed003e6cb0b4/train/sql

--Title: Days to Reach a Cumulative Transaction Threshold


WITH source AS (
  SELECT
    *,
    SUM(amount) OVER(ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_amount
  FROM transactions
)
SELECT
  id,
  date,
  amount,
  CASE
    WHEN MAX(date) OVER() = date THEN MAX(date) OVER() - MIN(date) OVER()
    ELSE NULL
  END AS days_to_reach_threshold
FROM source
WHERE total_amount - amount < 15