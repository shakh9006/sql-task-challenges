-- Source: https://leetcode.com/problems/count-salary-categories/description/

--Title: Count Salary Categories

WITH CategorizedAccounts AS (
    SELECT
        account_id,
        CASE
            WHEN SUM(income) < 20000 THEN 'Low Salary'
            WHEN SUM(income) BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category
    FROM Accounts
    GROUP BY account_id
),
SalaryCategories AS (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary' AS category
    UNION ALL
    SELECT 'High Salary' AS category
)
SELECT
    category,
    COALESCE(COUNT(account_id), 0) AS accounts_count
FROM SalaryCategories
LEFT JOIN CategorizedAccounts USING(category)
GROUP BY category;