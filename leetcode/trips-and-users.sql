-- Source: https://leetcode.com/problems/trips-and-users/

--Title: Trips and Users

WITH banned_user_ids AS (
    SELECT
        users_id
    FROM Users
    WHERE banned = 'Yes'
)
SELECT
    request_at AS "Day",
    ROUND(COUNT(*) FILTER (WHERE status != 'completed') / (COUNT(*) * 1.0), 2) AS "Cancellation Rate"
FROM Trips
WHERE client_id NOT IN (select * from banned_user_ids)
    AND driver_id NOT IN (select * from banned_user_ids)
    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 1
ORDER BY 1;