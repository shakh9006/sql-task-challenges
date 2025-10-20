-- Source: https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/

--Title: Percentage of Users Attended a Contest

SELECT
    contest_id,
    ROUND((COUNT(*) / ((select count(*) from Users) * 1.0)) * 100, 2) AS percentage
FROM Register
GROUP BY 1
ORDER BY percentage DESC, contest_id;