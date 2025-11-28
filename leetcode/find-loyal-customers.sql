-- Source: https://leetcode.com/problems/find-loyal-customers/description/

--Title: Find Loyal Customers

SELECT
    customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING COUNT(*) FILTER (WHERE transaction_type = 'purchase') > 2
    AND COUNT(*) FILTER (WHERE transaction_type = 'refund') / (COUNT(*) * 0.1) < 2
    AND MAX(transaction_date) - MIN(transaction_date) >= 30
ORDER BY customer_id;