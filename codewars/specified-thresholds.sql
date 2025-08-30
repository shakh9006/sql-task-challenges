--Source: https://www.codewars.com/kata/64eddd65592aaa0058f5da7c/train/sql

--Title: Next Greater Or Equal Ordered Quantities for Specified Thresholds

SELECT
  i.order_id,
  i.threshold_quantity,
  p.quantity AS next_ge_quantity,
  p.product_name
FROM inventory_thresholds i
LEFT JOIN LATERAL (
  SELECT
    p.quantity,
    p.product_name
  FROM product_orders p
  WHERE p.order_id = i.order_id AND i.threshold_quantity <= p.quantity
  LIMIT 1
) p ON true
ORDER BY 1, 2, 3;