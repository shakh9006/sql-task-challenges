-- Source: https://www.codewars.com/kata/64775418ac16620042e2efce/train/sql

--Title: Users pets and JSON data: Part 1

WITH source AS (
  SELECT
    id,
    info->>'name' AS user_name,
    pet->>'name' AS pet_name
  FROM users, jsonb_array_elements(info->'pets') AS pet
)
SELECT
  id,
  user_name,
  STRING_AGG(pet_name, ', ') AS pet_names
FROM source
WHERE pet_name LIKE 'M%'
GROUP BY id, user_name
ORDER BY id;