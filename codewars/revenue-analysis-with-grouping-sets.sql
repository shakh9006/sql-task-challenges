-- Source: https://www.codewars.com/kata/644e21831c0cb6566b89ad27/train/sql

--Title: Revenue Analysis with Grouping Sets

SELECT
  EXTRACT (YEAR FROM p.payment_date)::INT AS year,
  EXTRACT (MONTH FROM p.payment_date)::INT AS month,
  c.name AS category,
  FLOOR(SUM(p.amount))::INT AS revenue
FROM rental r
INNER JOIN inventory i USING(inventory_id)
INNER JOIN film_category fm USING(film_id)
INNER JOIN category c USING(category_id)
INNER JOIN payment p USING(rental_id)
WHERE EXTRACT (YEAR FROM p.payment_date) = 2007
GROUP BY
  GROUPING SETS (
    (1, 2),
    (1, 2, 3),
    (1)
  )
ORDER BY year, month, revenue DESC, category;