-- Source: https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/

--Title: Customer Placing the Largest Number of Orders

SELECT
    customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1;