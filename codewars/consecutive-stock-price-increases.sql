-- Source: https://www.codewars.com/kata/661537f087f83d460a095961/train/sql

--Title: Analysis of Consecutive Stock Price Increases

WITH stocks_meta AS (
  SELECT
    *,
    COALESCE(price - LAG(price) OVER(ORDER BY trade_date), 1) AS price_diff
  FROM stocks
  WHERE EXTRACT (YEAR FROM trade_date) = 2023
),
source AS (
  SELECT
    *
  FROM stocks_meta s1
  LEFT JOIN LATERAL (
    select
      s2.trade_date AS end_trade_date
    from stocks_meta s2
    where s1.trade_date < s2.trade_date AND s2.price_diff <= 0.0
    order by s2.trade_date asc
    limit 1
  ) s2 ON 1=1
  WHERE s1.price_diff > 0
)
SELECT
  COUNT(trade_date) AS trading_days_length,
  MIN(trade_date) AS start_date,
  MAX(trade_date) AS end_date,
  MIN(price) AS start_price,
  MAX(price) AS end_price
FROM source
GROUP BY end_trade_date
HAVING COUNT(*) > 1
ORDER BY trading_days_length DESC, start_date DESC;