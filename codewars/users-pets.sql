-- Source: https://www.codewars.com/kata/647ede2fe4d998004ad24995/train/sql

--Title: Users' pets and JSON data: Part 3

WITH grouped_users AS (
  SELECT
    info->>'name' AS user_name,
    jsonb_array_length(info->'pets') AS pet_count,
    CASE
      WHEN (info->>'age')::INT BETWEEN 18 AND 30 THEN '18-30'
      WHEN (info->>'age')::INT BETWEEN 31 AND 45 THEN '31-45'
      WHEN (info->>'age')::INT BETWEEN 46 AND 60 THEN '46-60'
      ELSE '61 and above'
    END AS age_group,
    CASE
        WHEN (info->>'age')::INT BETWEEN 18 AND 30 THEN 18
        WHEN (info->>'age')::INT BETWEEN 31 AND 45 THEN 31
        WHEN (info->>'age')::INT BETWEEN 46 AND 60 THEN 60
        ELSE 61
      END AS age_start
  FROM users
)
SELECT
  age_group,
  ROUND(AVG(pet_count), 1) AS avg_pet_count,
  MIN(g2.max_pet_owner) AS max_pet_owner,
  MAX(g2.max_pet_count) AS max_pet_count
FROM grouped_users g1
LEFT JOIN LATERAL (
  select
    user_name as max_pet_owner,
    pet_count as max_pet_count
  from grouped_users g2
  where g2.age_group = g1.age_group
  order by g2.pet_count desc
  limit 1
) g2 ON 1=1
GROUP BY age_group, age_start
ORDER BY max_pet_count DESC, age_start