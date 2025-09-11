-- Source: https://leetcode.com/problems/rank-scores/description/

--Title: Rank Scores

SELECT
    score,
    DENSE_RANK() OVER(ORDER BY score DESC) AS rank
FROM Scores;