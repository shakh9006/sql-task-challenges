-- Source: https://www.codewars.com/kata/66b09bedf5ca866d7ffafc8f/train/sql

--Title: Daily Hospital Admissions and Discharges Report

WITH available_days AS (
  SELECT
    join_date::DATE AS date
  FROM admissions
  UNION
  SELECT
    exit_date::DATE AS date
  FROM exits
),
joins_report AS (
  SELECT
    join_date::DATE AS join_date,
    COUNT(*) AS joins
  FROM admissions
  GROUP BY join_date::DATE
),
exits_report AS (
   SELECT
    exit_date::DATE AS exit_date,
    COUNT(*) AS exits
  FROM exits
  GROUP BY exit_date::DATE
),
report AS (
  SELECT
    date::TEXT,
    COALESCE(joins, 0) AS joins,
    COALESCE(exits, 0) AS exits,
    COALESCE(joins, 0) - COALESCE(exits, 0) AS net
  FROM available_days
  LEFT JOIN joins_report
      ON date = join_date
  LEFT JOIN exits_report
      ON date = exit_date
)
SELECT
  *,
  SUM(net::INT) OVER(ORDER BY date ASC) AS cumulative_net
FROM report;