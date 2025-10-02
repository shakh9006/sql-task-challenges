-- Source: https://leetcode.com/problems/customers-who-bought-all-products/

--Title: Customers Who Bought All Products

SELECT
    customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (select count(*) as product_count from Product)