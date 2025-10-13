-- Source: https://leetcode.com/problems/movie-rating/description/

--Title: Movie Rating

WITH greatest_user_rank AS (
    SELECT
        name AS results
    FROM MovieRating
    INNER JOIN Users USING(user_id)
    GROUP BY name
    ORDER BY COUNT(*) DESC, name
    LIMIT 1
),
highest_movie_rank AS (
    SELECT
        title AS results
    FROM MovieRating
    INNER JOIN Movies USING(movie_id)
    WHERE EXTRACT (year from created_at) = 2020 AND EXTRACT(month from created_at) = 2
    GROUP BY title
    ORDER BY AVG(rating) DESC, title
    LIMIT 1
)
SELECT results
FROM greatest_user_rank
UNION ALL
SELECT results
FROM highest_movie_rank;