--Source: https://www.codewars.com/kata/64b92cbc34d6f90e60fbc6b5/train/sql

--Title: Days to Reach a Cumulative Transaction Threshold: part 2

WITH transactions_amount_computed AS (
  SELECT
    *,
    SUM(amount) OVER(PARTITION BY user_id ORDER BY id) AS amount_sum
  FROM transactions
),
filtered_transactions AS (
  SELECT
    t1.*
  FROM transactions_amount_computed t1
  LEFT JOIN LATERAL (
    select
      t2.date
    from transactions_amount_computed t2
    where t2.amount_sum >= 15 and t1.user_id = t2.user_id
    order by t2.amount_sum
    limit 1
  ) t2 ON 1=1
  WHERE t1.date <= t2.date
),
threshold_transactions AS (
  SELECT
    id,
    CASE
      WHEN amount_sum >= 15 THEN user_id
      ELSE NULL
    END AS user_id,
    CASE
      WHEN amount_sum >= 15 THEN country
      ELSE NULL
    END AS country,
    date,
    amount,
    CASE
      WHEN amount_sum >= 15
        THEN MAX(date) OVER(PARTITION BY user_id) - MIN(date) OVER(PARTITION BY user_id)
      ELSE NULL
    END AS days_to_reach_threshold
  FROM filtered_transactions
),
country_threshold_transactions AS (
  SELECT
    country,
    ROUND(AVG(days_to_reach_threshold)::FLOAT) AS avg_country_days_to_reach_threshold
  FROM threshold_transactions
  GROUP BY country
)
SELECT
  t1.*,
  t2.avg_country_days_to_reach_threshold
FROM threshold_transactions t1
LEFT JOIN country_threshold_transactions t2 USING(country);