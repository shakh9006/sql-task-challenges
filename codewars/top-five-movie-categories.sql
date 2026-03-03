-- Source: https://www.codewars.com/kata/642d3e2c6555a30d83798f54/train/sql

--Title: Top Five Movie Categories Rented At Each Store

WITH source AS (
  SELECT
    i.store_id,
    c.name AS category,
    COUNT(*) AS num_rentals,
    ROW_NUMBER() OVER(PARTITION BY i.store_id ORDER BY COUNT(*) DESC, c.name) AS rn
  FROM rental r
  LEFT JOIN inventory i USING(inventory_id)
  INNER JOIN film_category f
    ON i.film_id = f.film_id
  INNER JOIN category c
    ON c.category_id = f.category_id
  GROUP BY i.store_id, c.name
)
SELECT
  store_id,
  category,
  num_rentals
FROM source
WHERE rn < 6
ORDER BY store_id, rn;