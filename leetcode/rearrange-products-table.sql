-- Source: https://leetcode.com/problems/rearrange-products-table/description/

--Title: Rearrange Products Table

WITH combined_stroes AS (
    SELECT product_id, 'store1' AS store, store1 AS price FROM Products
    UNION ALL
    SELECT product_id, 'store2' AS store, store2 AS price FROM Products
    UNION ALL
    SELECT product_id, 'store3' AS store, store3 AS price FROM Products
)
SELECT *
FROM combined_stroes
WHERE price IS NOT NULL;