-- Source: https://leetcode.com/problems/sales-analysis-iii/description/

--Title: Sales Analysis III

SELECT
    p.product_id,
    p.product_name
FROM Sales s
INNER JOIN Product p USING(product_id)
GROUP BY  1, 2
HAVING MIN(sale_date) BETWEEN '2019-01-01' AND '2019-03-31'
    AND MAX(sale_date) BETWEEN '2019-01-01' AND '2019-03-31';