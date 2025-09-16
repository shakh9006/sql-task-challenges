-- Source: https://leetcode.com/problems/customers-who-never-order/

--Title: Customers Who Never Order

WITH OrdersCustomerIds AS (
    SELECT
        customerId
    FROM Orders
)
SELECT
   name AS "Customers"
FROM Customers
WHERE id NOT IN (select * from OrdersCustomerIds);