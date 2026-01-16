-- Source: https://www.codewars.com/kata/58167fa1f544130dcf000317/train/sql

--Title: SQL Statistics: MIN, MEDIAN, MAX

WITH median_t AS (
  SELECT
    AVG(CAST(score AS DECIMAL(10, 4)))::FLOAT AS median
  FROM
      (SELECT
          score,
          ROW_NUMBER() OVER (ORDER BY score) AS row_asc,
          COUNT(*) OVER () AS total_rows
      FROM
          result) AS numbered_data
  WHERE
      row_asc IN ((total_rows + 1) / 2, (total_rows + 2) / 2)
),
min_max AS (
  SELECT
    MIN(score) AS min,
    MAX(score) AS max
  FROM result
)
SELECT *
FROM median_t, min_max;