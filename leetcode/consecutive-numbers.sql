-- Source: https://leetcode.com/problems/consecutive-numbers/description/

--Title: Consecutive Numbers

WITH source AS (
    SELECT
        num,
        LEAD(num) OVER(ORDER BY id) AS next_num,
        LAG(num) OVER(ORDER BY id) AS prev_num
    FROM Logs
)
SELECT
    DISTINCT num AS ConsecutiveNums
FROM source
WHERE num = next_num AND num = prev_num;