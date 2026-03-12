-- Source: https://www.codewars.com/kata/655c71144a5af0c736140407/train/sql

--Title: Customer Support System: Users with Multiple Distinct Usernames

WITH transform_users AS (
  SELECT
    user_id,
    user_name,
    LOWER(user_name) AS user_name_lower,
    ROW_NUMBER() OVER(PARTITION BY user_id, LOWER(user_name) ORDER BY user_name) AS rn
  FROM tickets
),
valid_users AS (
  SELECT
    user_id
  FROM transform_users
  GROUP BY user_id
  HAVING COUNT(DISTINCT user_name_lower) > 1
)
SELECT
  user_id,
  user_name
FROM transform_users
WHERE user_id IN (select * from valid_users) AND rn = 1
ORDER BY user_id, LOWER(user_name);
