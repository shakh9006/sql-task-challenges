-- Source: https://leetcode.com/problems/find-golden-hour-customers/description/

--Title: Find Golden Hour Customers

WITH source AS (
    SELECT
        customer_id,
        COUNT(*) AS all_orders_count,
        COUNT(*) FILTER (
            WHERE EXTRACT(HOUR FROM order_timestamp) BETWEEN 11 AND 13
            OR EXTRACT(HOUR FROM order_timestamp) BETWEEN 18 AND 20
        ) AS peek_hours_count,
        COUNT(order_rating) AS rating_count,
        ROUND(AVG(order_rating), 2) AS avg_rating
    FROM restaurant_orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    all_orders_count AS total_orders,
    ROUND(peek_hours_count / (all_orders_count * 1.0) * 100) AS peak_hour_percentage,
    avg_rating AS average_rating
FROM source
WHERE all_orders_count > 2
    AND peek_hours_count / (all_orders_count * 1.0) >= 0.6
    AND avg_rating >= 4
    AND rating_count / (all_orders_count * 1.0) >= 0.5
ORDER BY avg_rating DESC, customer_id DESC;