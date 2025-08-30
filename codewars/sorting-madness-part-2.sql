--Source: https://www.codewars.com/kata/64c226795743820031f48401/train/sql

--Title: Sorting Madness: part 2

SELECT
  *
FROM orders
ORDER BY
  COUNT(product_id) OVER(PARTITION BY product_id) = 1,
  MIN(order_id) OVER(PARTITION BY product_id),
  order_id;
