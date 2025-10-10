-- Source: https://leetcode.com/problems/queries-quality-and-percentage/description/

--Title: Queries Quality and Percentage

SELECT
    query_name,
    ROUND(AVG(rating / (position * 1.0)), 2) AS quality,
    ROUND((COUNT(*) FILTER (WHERE rating < 3) / (COUNT(*) * 1.0)) * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;