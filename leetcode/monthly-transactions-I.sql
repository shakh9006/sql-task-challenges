-- Source: https://leetcode.com/problems/monthly-transactions-i/description/

--Title: Monthly Transactions I

SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(*) AS trans_count,
    COUNT(*) FILTER (WHERE state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(amount) FILTER (WHERE state = 'approved') AS approved_total_amount
FROM Transactions
GROUP BY 1, 2;