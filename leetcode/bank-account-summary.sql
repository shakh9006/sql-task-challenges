-- Source: https://leetcode.com/problems/bank-account-summary-ii/description/

--Title: Bank Account Summary

SELECT
    name,
    SUM(amount) AS balance
FROM Users
LEFT JOIN Transactions USING(account)
GROUP BY 1
HAVING SUM(amount) > 10000;