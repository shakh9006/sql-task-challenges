-- Source: https://leetcode.com/problems/find-emotionally-consistent-users/description/

--Title: Find Emotionally Consistent Users

WITH source AS (
    SELECT
        *,
        COUNT(reaction) OVER(PARTITION BY user_id, reaction) AS reaction_ct
    FROM reactions
),
dominant_reactions as (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY reaction_ct DESC) AS rn
    FROM source
),
valid_users AS (
    SELECT
        user_id,
        COUNT(DISTINCT content_id) AS content_count
    FROM source
    GROUP BY user_id
    HAVING COUNT(DISTINCT content_id) >= 5
)
SELECT
    u.user_id,
    r.reaction AS dominant_reaction,
    ROUND(r.reaction_ct * 1.0 / u.content_count, 2) AS reaction_ratio
FROM valid_users u
LEFT JOIN dominant_reactions r
    ON u.user_id = r.user_id AND r.rn = 1
WHERE ROUND(r.reaction_ct * 1.0 / u.content_count, 2) >= 0.6
ORDER BY reaction_ratio DESC, user_id;