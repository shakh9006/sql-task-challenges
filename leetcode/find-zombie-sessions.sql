-- Source: https://leetcode.com/problems/find-zombie-sessions/description/

--Title: Find Zombie Sessions

WITH source AS (
    SELECT
        session_id,
        user_id,
        EXTRACT(EPOCH FROM (MAX(event_timestamp) - MIN(event_timestamp))) / 60 AS session_duration_minutes,
        COUNT(event_type) FILTER (WHERE event_type = 'scroll') AS scroll_count,
        COUNT(event_type) FILTER (WHERE event_type = 'click') AS click_count,
        COALESCE(COUNT(event_type) FILTER (WHERE event_type = 'purchase'), 0) AS purchase_count
    FROM app_events
    GROUP BY session_id, user_id
)
SELECT
    session_id,
    user_id,
    session_duration_minutes,
    scroll_count
FROM source
WHERE session_duration_minutes > 30
    AND scroll_count >= 5
    AND click_count / (scroll_count * 1.0) < 0.2
    AND purchase_count = 0
ORDER BY scroll_count DESC, session_id;