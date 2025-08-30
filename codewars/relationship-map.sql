-- Source: https://www.codewars.com/kata/64edadd1dea72f005e62aa69/train/sql

--Title: Constructing a Student-Course Relationship Map

SELECT
  name || ' (' || student_id || ')' AS student,
  course_name || ' (' || course_id || ')' AS course,
  COALESCE(s2.is_exists, 0) AS is_exists
FROM students s
LEFT JOIN courses c
  ON c.course_id IN (select course_id from enrollments)
LEFT JOIN LATERAL (
  SELECT
    CASE
      WHEN e.course_id = c.course_id AND e.student_id = s.student_id THEN 1
      ELSE 0
    END AS is_exists
  FROM enrollments e
  WHERE e.course_id = c.course_id AND e.student_id = s.student_id
) s2 ON true
WHERE student_id IN (select student_id from enrollments)
ORDER BY student_id, course_id;