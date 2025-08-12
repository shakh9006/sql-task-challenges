-- Source: https://www.codewars.com/kata/64366d8cb6eeb20017fa2534/train/sql

--Title: Unlocking the Popularity Secrets of Children's Films: Analyzing Rentals



WITH children_film_ids AS (
  SELECT
    film_id
  FROM film_category
  INNER JOIN category USING(category_id)
  WHERE name = 'Children'
)
SELECT
  i.film_id,
  CASE
    WHEN COUNT(DISTINCT r.customer_id) <= 5 THEN f.title || ' is not popular'
    WHEN COUNT(DISTINCT r.customer_id) > 5 AND COUNT(DISTINCT r.customer_id) <= 15 THEN f.title || ' is slightly popular'
    WHEN COUNT(DISTINCT r.customer_id) > 15 AND COUNT(DISTINCT r.customer_id) <= 30 THEN f.title || ' is moderately popular'
    ELSE f.title || ' is very popular'
  END AS popularity,
  COUNT(DISTINCT r.customer_id) AS rental_count
FROM rental r
INNER JOIN inventory i USING(inventory_id)
INNER JOIN film f
  ON f.film_id = i.film_id AND f.film_id IN (
    select film_id from children_film_ids
  )
GROUP BY i.film_id, f.title
ORDER BY rental_count DESC, f.title;