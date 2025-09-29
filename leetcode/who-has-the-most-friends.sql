-- Source: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/

--Title: Friend Requests II: Who Has the Most Friends

WITH all_friends AS (
    SELECT
        accepter_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT
        requester_id AS id
    FROM RequestAccepted
)
SELECT
    id,
    COUNT(*) AS num
FROM all_friends
GROUP BY 1
ORDER BY num DESC
LIMIT 1;