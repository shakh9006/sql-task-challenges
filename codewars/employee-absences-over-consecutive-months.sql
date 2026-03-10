-- Source: https://www.codewars.com/kata/6613fda5fe0da4bdcfb4be00/train/sql

--Title: Identification of Prolonged Employee Absences Over Consecutive Months

WITH source AS (
  SELECT
    *,
    EXTRACT (month from absent_date) AS month,
    EXTRACT (year from absent_date) AS year
  FROM attendance
),
temp AS (
  SELECT
    emp_no,
    absent_date,
    month,
    DENSE_RANK() OVER(PARTITION BY emp_no, year, month) AS rn,
    ROW_NUMBER() OVER(PARTITION BY emp_no, year, month) AS month_rn
  FROM source
),
grouped_attendance AS (
  SELECT
    emp_no,
    absent_date,
    month_rn,
    month - rn AS diff
  FROM temp
),
count_attendance AS (
  SELECT
    emp_no,
    absent_date,
    SUM(
      CASE
        WHEN month_rn = 1 THEN 1
        ELSE 0
      END
    ) OVER(PARTITION BY emp_no, diff) AS ct
  FROM grouped_attendance
)
SELECT
  emp_no,
  absent_date
FROM count_attendance
WHERE ct >= 3
ORDER BY emp_no DESC, absent_date ASC;
