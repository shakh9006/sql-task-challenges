-- Source: https://www.codewars.com/kata/5816a3ecf54413a113000074/train/sql

--Title: Conditional Count

SELECT
  EXTRACT (month from payment_date) AS month,
  COUNT(rental_id) AS total_count,
  SUM(amount) AS total_amount,
  COUNT(rental_id) FILTER(WHERE staff_id = 1) AS mike_count,
  SUM(amount) FILTER(WHERE staff_id = 1) AS mike_amount,
  COUNT(rental_id) FILTER(WHERE staff_id = 2) AS jon_count,
  SUM(amount) FILTER(WHERE staff_id = 2) AS jon_amount
FROM payment
WHERE staff_id = 1 OR staff_id = 2
GROUP BY EXTRACT (month from payment_date)
ORDER BY 1;
