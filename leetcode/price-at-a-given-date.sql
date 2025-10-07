-- Source: https://leetcode.com/problems/product-price-at-a-given-date/

--Title: Product Price at a Given Date

WITH source AS (
    SELECT
        DISTINCT product_id
    FROM Products
)
SELECT
    product_id,
    COALESCE(p.new_price, 10) AS price
FROM source s
LEFT JOIN LATERAL(
    SELECT new_price
    FROM Products p
    WHERE p.product_id = s.product_id AND change_date <= '2019-08-16'
    ORDER BY change_date DESC
    LIMIT 1
) p ON 1=1;