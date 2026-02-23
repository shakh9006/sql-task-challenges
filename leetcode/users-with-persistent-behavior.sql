-- Source: https://leetcode.com/problems/find-users-with-persistent-behavior-patterns/description/

--Title: Find Users with Persistent Behavior Patterns

WITH action_filtered AS (
    SELECT
        *,
        COUNT(action) OVER (PARTITION BY user_id, action) AS ct,
        ROW_NUMBER() OVER(PARTITION BY user_id) AS rn
    FROM activity
),
streak_days AS (
    SELECT
        *,
        (action_date - INTERVAL '1 day' * (rn - 1))::DATE AS start_date
    FROM action_filtered
    WHERE ct >= 5
)
SELECT
    user_id,
    action,
    COUNT(*) AS streak_length,
    MIN(action_date) AS start_date,
    MAX(action_date) AS end_date
FROM streak_days
GROUP BY user_id, action
HAVING COUNT(*) >= 5
ORDER BY streak_length DESC, user_id;