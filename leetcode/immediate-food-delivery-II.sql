-- Source: https://leetcode.com/problems/immediate-food-delivery-ii/

--Title: Immediate Food Delivery II

WITH source AS (
    SELECT
        customer_id,
        MIN(order_date) AS order_date,
        MIN(customer_pref_delivery_date) AS delivery_date
    FROM Delivery
    GROUP BY customer_id
)
SELECT
   ROUND(
    COUNT(*) FILTER (WHERE order_date = delivery_date) / (COUNT(*) * 1.00) * 100,
    2
   ) AS immediate_percentage
FROM source;