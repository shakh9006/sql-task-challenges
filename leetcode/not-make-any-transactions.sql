-- Source: https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/

--Title: Customer Who Visited but Did Not Make Any Transactions

SELECT
    customer_id,
    COUNT(*) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (select visit_id from Transactions)
GROUP BY customer_id;