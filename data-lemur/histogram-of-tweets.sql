-- Source: https://datalemur.com/questions/sql-histogram-tweets

--Title: Histogram of Tweets

WITH source AS (
  SELECT
    user_id,
    COUNT(*) AS ct
  FROM tweets
  WHERE EXTRACT (YEAR FROM tweet_date) = 2022
  GROUP BY user_id
)
SELECT
  ct As tweet_bucket,
  COUNT(*) AS users_num
FROM source
GROUP BY tweet_bucket;