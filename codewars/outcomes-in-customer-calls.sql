-- Source: https://www.codewars.com/kata/64d499812df37400210180e4/train/sql

--Title: Six Consecutive 'No' Outcomes in Customer Calls

WITH source AS (
  SELECT
    *,
    LAG(date_of_call) OVER(PARTITION BY user_id ORDER BY call_id) AS prev_date_of_call
  FROM calls
),
grouped_calls AS (
  SELECT
    s1.call_id,
    s1.user_id,
    s1.outcome,
    s1.date_of_call,
    s2.prev_date_of_call AS group_date,
    ROW_NUMBER() OVER(PARTITION BY s2.prev_date_of_call ORDER BY s1.call_id) AS rn
  FROM source s1
  LEFT JOIN LATERAL (
    select
      s2.prev_date_of_call
    from source s2
    where s1.user_id = s2.user_id
      and s1.date_of_call < s2.date_of_call
      and s2.outcome = 'Yes'
    limit 1
  ) s2 ON 1=1
  WHERE s1.outcome = 'No'
)
SELECT * FROM grouped_calls;

WITH source AS (
  SELECT
    *,
    LAG(date_of_call) OVER(PARTITION BY user_id ORDER BY call_id) AS prev_date_of_call
  FROM calls
),
grouped_calls AS (
  SELECT
    s1.call_id,
    s1.user_id,
    s1.outcome,
    s1.date_of_call,
    s2.prev_date_of_call AS group_date,
    ROW_NUMBER() OVER(PARTITION BY s2.prev_date_of_call ORDER BY s1.call_id) AS rn
  FROM source s1
  LEFT JOIN LATERAL (
    select
      s2.prev_date_of_call
    from source s2
    where s1.user_id = s2.user_id
      and s1.date_of_call < s2.date_of_call
      and s2.outcome = 'Yes'
    limit 1
  ) s2 ON 1=1
  WHERE s1.outcome = 'No'
)
SELECT
  user_id,
  to_char(date_of_call, 'YYYY-MM-DD HH24:MI:SS') AS date_of_call
FROM grouped_calls
WHERE rn = 6
ORDER BY user_id, date_of_call;