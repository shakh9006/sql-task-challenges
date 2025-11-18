-- Source: https://leetcode.com/problems/find-overbooked-employees/description/

--Title: Find Overbooked Employees

WITH source AS (
    SELECT
        *,
        EXTRACT (WEEK FROM meeting_date) AS week
    FROM meetings
),
weekly_hours AS (
    SELECT
        employee_id,
        SUM(duration_hours) AS meeting_hours
    FROM source
    GROUP BY employee_id, week
    HAVING SUM(duration_hours) > 20
)
SELECT
    employee_id,
    employee_name,
    department,
    COUNT(*) AS meeting_heavy_weeks
FROM weekly_hours
INNER JOIN employees USING(employee_id)
GROUP BY employee_id, employee_name, department
HAVING COUNT(*) > 1
ORDER BY meeting_heavy_weeks DESC, employee_name;