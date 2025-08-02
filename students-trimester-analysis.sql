--Source: https://www.codewars.com/kata/649db77b6f8b2b00474fce2b/train/sql

--Title: Students Who Consistently Improve: A Trimester Analysis in UK University

WITH source AS (
  SELECT
    c.student_id,
    s.name,
    c.course_name,
    c.score,
    CASE
      WHEN EXTRACT (month FROM course_date) IN (10, 11, 12) THEN 'Michaelmas'
      WHEN EXTRACT (month FROM course_date) IN (1, 2, 3) THEN 'Lent'
      ELSE 'Summer'
    END AS trimesters,
    CASE
      WHEN EXTRACT (month FROM course_date) IN (10, 11, 12) THEN 1
      WHEN EXTRACT (month FROM course_date) IN (1, 2, 3) THEN 2
      ELSE 3
    END AS trimesters_order
  FROM courses c
  INNER JOIN students s ON c.student_id = s.id
),
grouped_info AS (
  SELECT
    student_id,
    name,
    trimesters,
    trimesters_order,
    ROUND(AVG(score), 2)::NUMERIC AS trimesters_avg
  FROM source
  GROUP BY 1, 2, 3, 4
  ORDER BY student_id DESC
),
final_grouping AS (
  SELECT
    student_id,
    name,
    STRING_AGG( trimesters || ' (' || trimesters_avg || ')', ', ' ORDER BY trimesters_order ) AS trimesters_avg_scores
  FROM grouped_info
  GROUP BY 1, 2
  ORDER BY student_id DESC
)
SELECT
  fg.*,
  CASE
    WHEN gi2.trimesters_avg > gi1.trimesters_avg AND gi3.trimesters_avg > gi2.trimesters_avg THEN TRUE
    ELSE FALSE
  END AS consistent_improvement
FROM final_grouping fg
INNER JOIN grouped_info gi1
  ON fg.student_id = gi1.student_id AND gi1.trimesters = 'Michaelmas'
INNER JOIN grouped_info gi2
  ON fg.student_id = gi2.student_id AND gi2.trimesters = 'Lent'
INNER JOIN grouped_info gi3
  ON fg.student_id = gi3.student_id AND gi3.trimesters = 'Summer'
