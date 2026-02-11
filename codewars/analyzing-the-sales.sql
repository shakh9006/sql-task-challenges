-- Source: https://www.codewars.com/kata/5dac87a0abe9f1001f39e36d/train/sql

--Title: Analyzing the sales by product and date

WITH source AS (
  SELECT
    EXTRACT ('year' FROM s.date) AS year,
    EXTRACT ('month' FROM s.date) AS month,
    EXTRACT ('day' FROM s.date) AS day,
    p.name AS product_name,
    sd.count * p.price AS total
  FROM sales s
  INNER JOIN sales_details sd
    ON s.id = sd.sale_id
  INNER JOIN products p
    ON sd.product_id = p.id
)
SELECT
  product_name,
  year,
  month,
  day,
  SUM(total) AS total
FROM source
GROUP BY product_name, ROLLUP (year, month, day)
ORDER BY product_name, year, month, day;