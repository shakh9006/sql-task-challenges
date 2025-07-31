--Source: https://www.codewars.com/kata/6115701cc3626a0032453126/train/sql

--Title: Competition results (code golf)

SELECT
  *,
  ROW_NUMBER() OVER(PARTITION BY competition_id ORDER BY points DESC) AS rank,
  COALESCE(points - LAG(points) OVER(PARTITION BY competition_id), 0) * -1 AS next_behind,
  MAX(points) OVER(PARTITION BY competition_id) - points AS total_behind,
  points - AVG(points) OVER(PARTITION BY competition_id) AS diff_from_avg
FROM results;