-- Source: https://leetcode.com/problems/find-books-with-polarized-opinions/

--Title: Find Books with Polarized Opinions

SELECT
    book_id,
    title,
    author,
    genre,
    pages,
    MAX(session_rating) - MIN(session_rating) AS rating_spread,
    ROUND(COUNT(*) FILTER(WHERE session_rating != 3) / (COUNT(*) * 1.0), 2) AS polarization_score
FROM reading_sessions
INNER JOIN books USING(book_id)
GROUP BY 1, 2, 3, 4, 5
HAVING COUNT(DISTINCT session_id) > 4
    AND COUNT(session_rating) FILTER (WHERE session_rating <= 2) > 0
    AND COUNT(session_rating) FILTER (WHERE session_rating >= 4) > 0
    AND (COUNT(*) FILTER(WHERE session_rating != 3) / (COUNT(*) * 1.0)) >= 0.6
ORDER BY polarization_score DESC, title DESC;