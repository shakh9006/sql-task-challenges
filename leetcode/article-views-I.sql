-- Source: https://leetcode.com/problems/article-views-i/description/

--Title: Article Views I

SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;