-- Source: https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/description/

--Title: Actors and Directors Who Cooperated At Least Three Times

SELECT
    actor_id,
    director_id
FROM ActorDirector
GROUP BY 1, 2
HAVING COUNT(*) > 2;