-- Source: https://leetcode.com/problems/find-category-recommendation-pairs/description/

--Title: Find Category Recommendation Pairs

WITH RankedCategories AS (
    SELECT
        product_id,
        category,
        RANK() OVER(ORDER BY category ASC) category_id
    FROM ProductInfo
),
CategorizedProductPurchases AS (
    SELECT
        pp.user_id,
        rc.*,
        DENSE_RANK() OVER(PARTITION BY user_id, category ORDER BY product_id) AS rn
    FROM ProductPurchases pp
    INNER JOIN RankedCategories rc USING(product_id)
),
CleanedPurchases AS (
    SELECT
        *
    FROM CategorizedProductPurchases
    WHERE rn = 1
)
SELECT
    p1.category AS category1,
    p2.category AS category2,
    COUNT(DISTINCT p1.user_id) AS customer_count
FROM CleanedPurchases p1
INNER JOIN CleanedPurchases p2
    ON p1.user_id = p2.user_id AND p1.category_id < p2.category_id
GROUP BY p1.category, p2.category
HAVING COUNT(DISTINCT p1.user_id) > 2
ORDER BY customer_count DESC, category1, category2;