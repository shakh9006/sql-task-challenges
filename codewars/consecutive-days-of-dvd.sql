-- Source: https://www.codewars.com/kata/6475a060e81712003cc2eb44/train/sql

--Title: Analyzing Consecutive Days of DVD Rentals for a Customer

WITH source AS (
  SELECT
    customer_id,
    rental_date::DATE AS rental_date,
    rental_date::DATE - ROW_NUMBER() OVER(ORDER BY rental_date::DATE)::INT AS group_date
  FROM rental
  WHERE customer_id = 1
  GROUP BY customer_id, rental_date::DATE
  ORDER BY rental_date
)
SELECT
  first_name || ' ' || last_name AS name,
  rental_date AS date_rental_occurred,
  COUNT(*) OVER(PARTITION BY group_date) AS consecutive_days
FROM source
INNER JOIN customer USING(customer_id)
ORDER BY date_rental_occurred;