-- Source: https://www.codewars.com/kata/642ed28eb8c5c206120581a9/train/sql

--Title: The Most Dedicated Customers - 2000s Nostalgia

WITH source AS (
  select
    r.customer_id,
    r.rental_date,
    r.return_date as org_return_date,
    r.rental_date + (CONCAT(f.rental_duration, ' ', 'day'))::interval as potentially_return_date,
    f.title as title,
    f.title || ': ' || r.rental_date::DATE as film,
    c.first_name,
    c.last_name
  from rental r
  inner join inventory i using(inventory_id)
  inner join film f using(film_id)
  inner join customer c USING(customer_id)
  where r.rental_date::date between '2005-04-01' and '2005-07-31'
),
invalid_customers AS (
  select
    customer_id
  from source
  where org_return_date is null and potentially_return_date < '2005-08-01'
)
SELECT
  customer_id,
  (first_name || ' ' || last_name) AS customer_name,
  COUNT(*) AS num_rentals,
  STRING_AGG(film, ' || ' ORDER BY rental_date::DATE DESC, title ASC) AS films_rented
FROM source s
WHERE NOT EXISTS (
  SELECT 1
  FROM invalid_customers i
  WHERE i.customer_id = s.customer_id
)
GROUP BY customer_id, first_name, last_name
HAVING COUNT(*) > 9
ORDER BY num_rentals DESC, last_name

