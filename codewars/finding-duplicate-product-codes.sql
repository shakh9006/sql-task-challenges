--Source: https://www.codewars.com/kata/653a1edb38656500434d80ba/train/sql

--Title: Finding Duplicate Product Codes Across Different Groups

WITH source AS (
  SELECT
    group_id,
    product_code
  FROM products p1
  WHERE EXISTS (
    select 1
    from products p2
    where p1.product_id != p2.product_id
      and p1.group_id != p2.group_id
      and p1.product_code = p2.product_code
  )
  GROUP BY 1, 2
)
SELECT
  p.product_id,
  s.*
FROM source s
LEFT JOIN LATERAL (
  select
    p.product_id
  from products p
  where p.group_id = s.group_id
    and p.product_code = s.product_code
  order by product_id desc
  limit 1
) p on 1=1
ORDER BY s.product_code, s.group_id DESC
