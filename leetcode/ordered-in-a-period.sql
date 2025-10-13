-- Source: https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/

--Title: List the Products Ordered in a Period

SELECT
    product_name,
    SUM(unit) AS unit
FROM Orders
INNER JOIN Products USING(product_id)
WHERE EXTRACT (year from order_date) = 2020 AND EXTRACT(month from order_date) = 2
GROUP BY product_name
HAVING SUM(unit) >= 100;