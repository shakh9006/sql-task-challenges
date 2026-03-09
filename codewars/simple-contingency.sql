-- Source: https://www.codewars.com/kata/65a1199e066be50650d761e1/train/sql

--Title: Creating a Simple Contingency Table in SQL

SELECT
  COALESCE(sex, 'Total') AS "Sex/Handedness",
  COUNT(*) FILTER (WHERE handedness = 'Right-handed') AS "Right-handed",
  COUNT(*) FILTER (WHERE handedness = 'Left-handed') AS "Left-handed",
  COUNT(*) AS "Total"
FROM survey_data
GROUP BY GROUPING SETS (
  (sex),
  ()
)
ORDER BY sex DESC NULLS LAST;