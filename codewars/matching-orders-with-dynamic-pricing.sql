-- Source: https://www.codewars.com/kata/65a16ae06b146a1134225b33/train/sql

--Title: Matching Orders with Dynamic Pricing

SELECT
  o.order_id,
  o.item_id,
  o.order_timestamp::TEXT,
  p.new_price
FROM orders o
LEFT JOIN LATERAL (
  select
    new_price
  from price_changes p
  where p.item_id = o.item_id and o.order_timestamp >= p.change_timestamp
  order by p.change_timestamp desc
  limit 1
) p ON 1=1
ORDER BY order_id;