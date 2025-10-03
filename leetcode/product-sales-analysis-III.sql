-- Source: https://leetcode.com/problems/product-sales-analysis-iii/description/

--Title: Product Sales Analysis III

WITH source AS (
    SELECT
        *,
        RANK() OVER(PARTITION BY product_id ORDER BY year) AS rn
    FROM Sales
)
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM source
WHERE rn = 1;