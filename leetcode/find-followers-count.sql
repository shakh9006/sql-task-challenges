-- Source: https://leetcode.com/problems/find-followers-count/

--Title: Find Followers Count

SELECT
    user_id,
    COUNT(DISTINCT follower_id) AS followers_count
FROM Followers
GROUP BY user_id;