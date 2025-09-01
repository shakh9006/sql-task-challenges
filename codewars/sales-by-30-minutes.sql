-- Source: https://www.codewars.com/kata/64ad157a0c6952004b172c5f/train/sql

--Title: Panda's leaked report with daily stats: Sales by 30 Minutes

WITH intervals AS (
  SELECT
    generate_series(
      TIMESTAMP '2023-05-08 10:00:00',
      TIMESTAMP '2023-05-08 22:00:00',
      INTERVAL '30 minutes'
    ) AS start_interval,
    generate_series(
      TIMESTAMP '2023-05-08 10:30:00',
      TIMESTAMP '2023-05-08 22:30:00',
      INTERVAL '30 minutes'
    ) AS end_interval
),
source AS (
  SELECT
    i.start_interval,
    i.end_interval,
    amount,
    SUM(amount) OVER() AS total_amount_per_day
  FROM intervals i
  LEFT JOIN sales s
    ON s.timestamp >= i.start_interval AND s.timestamp < i.end_interval
)
SELECT
  TO_CHAR(start_interval, 'HH12:MI AM') || '-' || TO_CHAR(end_interval, 'HH12:MI AM') AS "Time",
  COUNT(*) FILTER (WHERE amount > 0) AS "Cnt",
  (COALESCE(SUM(amount)::NUMERIC, 0.0))::MONEY AS "Sales",
  COALESCE(ROUND((SUM(amount)::NUMERIC / total_amount_per_day) * 100, 2), 0.0) AS "%Sales"
FROM source
GROUP BY start_interval, end_interval, total_amount_per_day
ORDER BY start_interval;