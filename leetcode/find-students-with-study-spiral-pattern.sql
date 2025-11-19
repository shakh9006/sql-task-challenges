-- Source: https://leetcode.com/problems/find-students-with-study-spiral-pattern/

--Title: Find Students with Study Spiral Pattern

WITH source AS (
    SELECT
        *,
        COALESCE(session_date - LAG(session_date) OVER(PARTITION BY student_id ORDER BY session_date), 0) AS day_diff,
        RANK() OVER(PARTITION BY student_id, subject ORDER BY session_date) AS rn
    FROM study_sessions
),
cycle_sessions AS (
    SELECT
        student_id,
        SUM(hours_studied) AS hours_studied,
        COUNT(subject) AS cycles
    FROM source
    WHERE day_diff < 3
    GROUP BY student_id, rn
    HAVING COUNT(subject) > 2
    ORDER BY 1
)
SELECT
    student_id,
    student_name,
    major,
    MAX(cycles) AS cycle_length,
    SUM(hours_studied) AS total_study_hours
FROM cycle_sessions
INNER JOIN students USING(student_id)
GROUP BY student_id, student_name, major
HAVING COUNT(cycles) > 1 AND  MAX(cycles) = MIN(cycles)
ORDER BY cycle_length DESC, total_study_hours DESC;