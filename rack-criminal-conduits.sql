-- Source: https://www.codewars.com/kata/667b1516a9b024779627367a/train/sql

--Title: Examining Traffic Data to Track Criminal Conduits

WITH source AS (
  SELECT
    type,
    (COALESCE(LAG(type) OVER(ORDER BY datetime),'') ='black bmw')::INT + (COALESCE(LEAD(type) OVER(ORDER BY datetime),'') = 'black bmw')::INT n
  FROM traffic_observations
  WHERE traffic_light_id = 1
)
SELECT
  type AS type_neighbour,
  SUM(n) AS count
FROM source
GROUP BY type
HAVING SUM(n) > 0
ORDER BY count DESC, type_neighbour;