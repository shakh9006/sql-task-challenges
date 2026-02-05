-- Source: https://www.codewars.com/kata/6495acce1e2c9a001ad35e5d/train/sql

--Title: Top Performing Students

WITH courses_with_avg AS (
  SELECT
    *,
    AVG(score) OVER(PARTITION BY course_name) AS avg_score
  FROM courses
),
out_performance as (
  SELECT
    student_id,
    course_name,
    ROUND(((score - avg_score) / avg_score * 100), 2)::FLOAT AS avg_score
  FROM courses_with_avg
  WHERE ROUND(((score - avg_score) / avg_score * 100), 2)::FLOAT > 0
)
SELECT
  o.student_id,
  s.name,
  STRING_AGG(o.course_name || ' (' ||to_char(o.avg_score, 'FM999999990.00') || '%)', ', ' ORDER BY o.course_name, o.avg_score DESC) AS outperformance
FROM out_performance o
INNER JOIN students s
  ON o.student_id = s.id
GROUP BY o.student_id, s.name
HAVING COUNT(course_name) > 2;