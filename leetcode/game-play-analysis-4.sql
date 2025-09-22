-- Source: https://leetcode.com/problems/game-play-analysis-iv/description/

--Title: Game Play Analysis IV

WITH source AS (
    SELECT
        player_id,
        event_date,
        (MIN(event_date) OVER(PARTITION BY player_id) + INTERVAL '1 day')::DATE AS next_date
    FROM Activity
)
SELECT
    ROUND(
        COUNT(DISTINCT player_id) FILTER (WHERE event_date = next_date) / (COUNT(DISTINCT player_id) * 1.0),
        2
    ) AS fraction
FROM source