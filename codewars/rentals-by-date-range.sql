-- Source: https://www.codewars.com/kata/643972e66905c60034803a1f/train/sql

--Title: Rentals by Date Range

WITH default_dates AS (
  SELECT
    generate_series(
        '2005-05-24'::date,
        '2005-06-02'::date,
        interval '1 day'
    )::date AS rental_date,
    0 AS rentals
),
source AS (
  SELECT
    rental_date::DATE,
    COUNT(*) AS rentals
  FROM rental
  WHERE rental_date::DATE BETWEEN '2005-05-24' AND '2005-06-02'
  GROUP BY rental_date::DATE
)
SELECT
    rental_date::TEXT AS date,
    COALESCE(s.rentals, d.rentals) AS rentals
FROM default_dates d
LEFT JOIN source s USING(rental_date)
ORDER BY rental_date