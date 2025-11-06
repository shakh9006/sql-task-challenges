-- Source: https://leetcode.com/problems/odd-and-even-transactions/description/

--Title: Odd and Even Transactions

SELECT
    transaction_date,
    COALESCE(SUM(amount) FILTER (WHERE amount % 2 = 1), 0) AS odd_sum,
    COALESCE(SUM(amount) FILTER (WHERE amount % 2 = 0), 0) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY 1;