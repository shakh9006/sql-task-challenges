-- Source: https://www.codewars.com/kata/6496dbe08673b33ddae5c733/train/sql

--Title: Developer of the Day


WITH backend_team AS (
  SELECT
    ROW_NUMBER() OVER(ORDER BY birth_date DESC) rn,
    *
  FROM employees
  WHERE team = 'backend'
),
days AS (
  SELECT
    ((ROW_NUMBER() OVER (ORDER BY d::DATE) - 1) % (select count(*) from backend_team)) + 1 AS rn,
    d::DATE AS date,
    TO_CHAR(d, 'Day') AS day_of_week
  FROM generate_series(
    '2023-07-01'::DATE,
    '2023-09-30'::DATE,
    INTERVAL '1 day'
  ) AS d
  WHERE EXTRACT(ISODOW FROM d) < 6
)
SELECT
  d.date,
  d.day_of_week,
  b.employee_id,
  b.full_name
FROM days d
INNER JOIN backend_team b USING(rn)
ORDER BY d.date;

