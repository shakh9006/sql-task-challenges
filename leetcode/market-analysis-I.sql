-- Source: https://leetcode.com/problems/market-analysis-i/description/

--Title: Market Analysis I

SELECT
    user_id AS buyer_id,
    MIN(join_date) AS join_date,
    COUNT(*) FILTER (WHERE EXTRACT (year from order_date) = 2019) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
GROUP BY user_id
ORDER BY user_id;