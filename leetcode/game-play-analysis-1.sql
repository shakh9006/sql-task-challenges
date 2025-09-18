-- Source: https://leetcode.com/problems/game-play-analysis-i/description/

--Title: Game Play Analysis I

SELECT
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY 1;