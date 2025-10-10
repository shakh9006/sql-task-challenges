-- Source: https://leetcode.com/problems/average-selling-price/description/?source=submission-noac

--Title: Average Selling Price

SELECT
    p.product_id AS product_id,
    COALESCE(ROUND(SUM(units * price) / (SUM(units) * 1.0), 2), 0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;