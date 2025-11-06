-- Source: https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/

--Title: Number of Unique Subjects Taught by Each Teacher

SELECT
    t1.teacher_id,
    COUNT(DISTINCT t1.subject_id) AS cnt
FROM Teacher t1
LEFT JOIN Teacher t2
    ON t1.teacher_id != t2.teacher_id
        AND t1.subject_id = t2.subject_id AND t1.dept_id = t2.dept_id
WHERE t2.teacher_id IS NULL
GROUP BY t1.teacher_id;