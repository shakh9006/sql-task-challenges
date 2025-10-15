-- Source: Group Sold Products By The Date

--Title: https://leetcode.com/problems/group-sold-products-by-the-date/description/

SELECT
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STRING_AGG(DISTINCT product, ',' ORDER BY product) AS products
FROM Activities
GROUP BY sell_date;