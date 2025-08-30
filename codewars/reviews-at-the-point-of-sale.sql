-- Source: https://www.codewars.com/kata/6617e45260963708e23558b8/train/sql

--Title: Timely Product Prices and Customer Reviews at the Point of Sale

SELECT
  sale_time::TEXT,
  s.product_id,
  p.price,
  review_rating
FROM sales s
INNER JOIN LATERAL (
  SELECT
    price
  FROM product_prices p
  WHERE s.product_id = p.product_id AND s.sale_time >= p.price_time
  ORDER BY p.price_time DESC
  LIMIT 1
) p ON TRUE
LEFT JOIN LATERAL(
  SELECT
    review_rating
  FROM customer_reviews c
  WHERE c.product_id = s.product_id AND s.sale_time >= c.review_time
  ORDER BY review_time DESC
  LIMIT 1
) c ON TRUE
ORDER BY s.sale_time DESC, s.id DESC