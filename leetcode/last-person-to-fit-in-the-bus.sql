-- Source: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/

--Title: Last Person to Fit in the Bus

WITH source AS (
    SELECT
        *,
        SUM(weight) OVER(ORDER BY turn) AS total_weight
    FROM Queue
)
SELECT
    person_name
FROM source
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;