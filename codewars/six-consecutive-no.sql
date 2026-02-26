-- Source: https://www.codewars.com/kata/64d499812df37400210180e4/train/sql

--Title: Six Consecutive 'No' Outcomes in Customer Calls

WITH source AS (
  SELECT
    user_id,
    date_of_call,
    COALESCE(LAG(outcome, 6) OVER(PARTITION BY user_id ORDER BY date_of_call), 'Yes') AS prev,
    COUNT(NULLIF(outcome, 'Yes')) OVER(PARTITION BY user_id ORDER BY date_of_call ROWS 5 PRECEDING) AS ct
  FROM calls
  ORDER BY date_of_call
)
SELECT
  user_id,
  date_of_call::TEXT
FROM source
WHERE prev = 'Yes' AND ct = 6
ORDER BY user_id, date_of_call;