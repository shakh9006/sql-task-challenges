-- Source: https://leetcode.com/problems/delete-duplicate-emails/description/

--Title: Delete Duplicate Emails

WITH source AS (
    SELECT
        id,
        ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) AS rn
    FROM Person
)
DELETE FROM Person
WHERE id IN (select id from source where rn != 1);