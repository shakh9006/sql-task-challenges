-- Source: https://leetcode.com/problems/rising-temperature/description/

--Title: Rising Temperature

WITH source AS (
    SELECT
        *,
        LAG(temperature) OVER(ORDER BY recordDate) AS prevDateTemperature,
        COALESCE(LAG(recordDate) OVER(ORDER BY recordDate), recordDate) AS prevDate
    FROM Weather
)
SELECT
    id
FROM source
WHERE temperature > prevDateTemperature AND (recordDate - prevDate) = 1;