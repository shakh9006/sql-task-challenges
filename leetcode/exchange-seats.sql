-- Source: https://leetcode.com/problems/exchange-seats/description/

--Title: Exchange Seats

WITH source AS (
    SELECT
        *,
        COUNT(*) OVER() AS row_count
    FROM Seat
)
SELECT
    CASE
        WHEN id % 2 = 0 THEN id - 1
        WHEN id % 2 = 1 AND id != row_count THEN id + 1
        ELSE id
    END AS id,
    student
FROM source
ORDER BY id;