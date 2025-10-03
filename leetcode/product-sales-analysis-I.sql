-- Source: https://leetcode.com/problems/product-sales-analysis-i/description/

--Title: Product Sales Analysis I

SELECT
    product_name,
    year,
    price
FROM Sales
LEFT JOIN Product USING(product_id);