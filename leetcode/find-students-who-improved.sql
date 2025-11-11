-- Source: https://leetcode.com/problems/find-students-who-improved/

--Title: Find Students Who Improved

SELECT
    student_id,
    subject,
    f.score AS first_score,
    l.score AS latest_score
FROM Scores s
LEFT JOIN LATERAL (
    select
        score
    from Scores f
    where f.student_id = s.student_id AND f.subject = s.subject
    order by f.exam_date
    limit 1
) f ON 1=1
LEFT JOIN LATERAL (
    select
        score
    from Scores l
    where l.student_id = s.student_id AND l.subject = s.subject
    order by l.exam_date DESC
    limit 1
) l ON 1=1
WHERE f.score < l.score
GROUP BY student_id, subject, f.score, l.score
ORDER BY student_id, subject;