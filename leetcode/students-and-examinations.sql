-- Source: https://leetcode.com/problems/students-and-examinations/description/

--Title: Students and Examinations

WITH source AS (
    SELECT
        *
    FROM Students
    CROSS JOIN Subjects
)
SELECT
    s.*,
    COALESCE(l.ct, 0) AS attended_exams
FROM source s
LEFT JOIN LATERAL (
    select
        count(*) as ct
    from Examinations e
    where e.student_id = s.student_id and e.subject_name = s.subject_name
    group by student_id, subject_name
) l ON 1=1
ORDER BY student_id, subject_name;