-- Source: https://leetcode.com/problems/average-time-of-process-per-machine/description/

--Title: Average Time of Process per Machine

WITH source AS (
    SELECT
        machine_id,
        process_id,
        SUM(timestamp) FILTER (WHERE activity_type = 'end') -  SUM(timestamp) FILTER (WHERE activity_type = 'start') AS summary
    FROM Activity
    GROUP BY 1, 2
)
SELECT
    machine_id,
    ROUND(AVG(summary)::NUMERIC, 3) AS processing_time
FROM source
GROUP BY 1;