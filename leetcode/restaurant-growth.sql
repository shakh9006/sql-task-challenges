-- Source: https://leetcode.com/problems/restaurant-growth/description/

--Title: Restaurant Growth

WITH grouped_by_date AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY 1
),
source AS (
    SELECT
        visited_on,
        SUM(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
        COUNT(*) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ct
    FROM grouped_by_date c
)
SELECT
    visited_on,
    amount,
    average_amount
FROM source
WHERE ct = 7
ORDER BY visited_on;