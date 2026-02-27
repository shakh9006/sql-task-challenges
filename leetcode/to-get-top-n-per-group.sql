-- Source: https://www.codewars.com/kata/5820176255c3d23f360000a9/train/sql

--Title: Using LATERAL JOIN To Get Top N per Group

SELECT
  c.id AS category_id,
  c.category,
  p.title,
  p.views,
  p.id AS post_id
FROM categories c
LEFT JOIN LATERAL (
  select
    p.id,
    p.title,
    p.views
  from posts p
  where p.category_id = c.id
  order by views desc
  limit 2
) p ON 1=1
ORDER BY c.category, p.views DESC, p.id