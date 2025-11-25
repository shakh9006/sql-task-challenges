-- Source: https://leetcode.com/problems/find-stores-with-inventory-imbalance/description/

--Title: Find Stores with Inventory Imbalance

WITH source AS (
    SELECT
        *,
        RANK() OVER(PARTITION BY store_id ORDER BY price DESC) highest_price_rank,
        RANK() OVER(PARTITION BY store_id ORDER BY price) lowest_price_rank
    FROM inventory
)
SELECT
    s.store_id,
    s2.store_name,
    s2.location,
    ih.product_name AS most_exp_product,
    il.product_name AS cheapest_product,
    ROUND(MAX(il.quantity) / (MAX(ih.quantity) * 1.0), 2) AS imbalance_ratio
FROM source s
INNER JOIN source ih
    ON s.store_id = ih.store_id AND ih.highest_price_rank = 1
INNER JOIN source il
    ON s.store_id = il.store_id AND il.lowest_price_rank = 1
INNER JOIN stores s2
    ON s.store_id = s2.store_id
WHERE ih.quantity < il.quantity
GROUP BY 1, 2, 3, 4, 5
HAVING COUNT(*) > 2
ORDER BY imbalance_ratio DESC, s2.store_name;