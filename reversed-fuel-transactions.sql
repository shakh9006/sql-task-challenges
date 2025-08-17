-- Source: https://www.codewars.com/kata/64db54b53b93ae00199bb904/train/sql

--Title: Identify and Exclude Reversed Fuel Transactions

WITH source AS (
  SELECT
    *,
    LEAD(is_reversal) OVER (PARTITION BY fuel_type, ABS(quantity) ORDER BY transaction_datetime) AS next_reversal
  from fuel_transactions
)
SELECT
  transaction_id,
  transaction_datetime,
  quantity,
  fuel_type,
  is_reversal
FROM source
WHERE is_reversal = 'N' AND COALESCE(next_reversal, 'N') = 'N'
ORDER BY transaction_datetime;
