-- Source: https://leetcode.com/problems/duplicate-emails/description/

--Title: Duplicate Emails

SELECT
    email
FROM Person
GROUP BY 1
HAVING COUNT(*) > 1;