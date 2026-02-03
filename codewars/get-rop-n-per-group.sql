-- Source: https://www.codewars.com/kata/582001237a3a630ce8000a41/train/sql

--Title: Using Window Functions To Get Top N per Group

WITH source AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY views DESC, id) AS rn
  FROM posts
)
SELECT
  c.id AS category_id,
  c.category,
  s.title,
  s.views,
  s.id AS post_id
FROM categories c
LEFT JOIN source s
  ON c.id = s.category_id AND s.rn < 3
ORDER BY category, views DESC, post_id;