-- Source: https://www.codewars.com/kata/64ae84cc9957c3003159fbe1/train/sql

--Title: Calculating Daily Registrations and 8-Day Running Averages

WITH dates AS (
  SELECT generate_series(
    (select min(registered_at) from users)::DATE,
    (select max(registered_at) from users)::DATE,
    interval '1 day'
  ) AS daily_date
),
daily_sign_ups AS (
  SELECT
    registered_at::DATE AS date,
    COUNT(*) AS sign_ups
  FROM users
  GROUP BY registered_at::DATE
),
source AS (
  SELECT
    d1.daily_date::DATE AS date,
    COALESCE(d2.sign_ups, 0) AS sign_ups
  FROM dates d1
  LEFT JOIN daily_sign_ups d2
    ON d1.daily_date = d2.date
)
SELECT
  *,
  ROUND(AVG(sign_ups) OVER(ORDER BY date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW), 2) AS avg_signups
FROM source
ORDER BY date;