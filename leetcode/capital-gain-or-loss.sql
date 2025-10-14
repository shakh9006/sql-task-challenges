-- Source: https://leetcode.com/problems/capital-gainloss/

--Title: Capital Gain/Loss

WITH source AS (
    SELECT
        stock_name,
        CASE
            WHEN operation = 'Buy' THEN price * -1
            ELSE price
        END AS price
    FROM Stocks
)
SELECT
    stock_name,
    SUM(price) AS capital_gain_loss
FROM source
GROUP BY 1;