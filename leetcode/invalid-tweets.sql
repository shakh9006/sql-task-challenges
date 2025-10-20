-- Source: https://leetcode.com/problems/invalid-tweets/description/

--Title: Invalid Tweets

SELECT
    tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;