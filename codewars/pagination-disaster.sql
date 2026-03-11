-- Source: https://www.codewars.com/kata/6613d333fe0da4edf9b4accb/train/sql

--Title: Refactoring SQL Queries: part 2 (Pagination Disaster)

WITH source AS (
  SELECT
    d.deal_id,
    d.deal_name,
    t.currency,
    SUM(t.amount) AS amount
  FROM deals d
  LEFT JOIN tranches t USING(deal_id)
  GROUP BY d.deal_id, t.currency
)
SELECT
  deal_id,
  deal_name,
  JSON_AGG(
    JSON_BUILD_OBJECT(
      'currency', currency,
      'total_amount', amount
    ) ORDER BY currency
  ) AS currency_details
FROM source
GROUP BY deal_id, deal_name
ORDER BY deal_id DESC;

