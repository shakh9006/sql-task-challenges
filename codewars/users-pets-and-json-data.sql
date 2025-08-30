-- Source: https://www.codewars.com/kata/6479b3a881616a003732a726/train/sql

--Title: Users' pets and JSON data: Part 2

WITH source AS (
  SELECT
    LEFT(pet->>'name', 1) as first_letter,
    COUNT(*) as pet_count
  FROM users, jsonb_array_elements(info->'pets') as pet
  GROUP BY LEFT(pet->>'name', 1)
)
SELECT
  first_letter,
  pet_count,
  string_agg(info->>'name', ', ' order by id) as user_names
FROM source
JOIN users ON EXISTS (select pet->>'name' from jsonb_array_elements(info->'pets') as pet where LEFT(pet->>'name', 1) = first_letter)
GROUP BY first_letter, pet_count
ORDER BY pet_count desc, first_letter;