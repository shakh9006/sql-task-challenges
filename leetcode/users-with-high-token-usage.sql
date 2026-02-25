-- Source: https://leetcode.com/problems/find-users-with-high-token-usage/

--Title: Find Users with High Token Usage

SELECT
    user_id,
    COUNT(prompt) AS prompt_count,
    ROUND(AVG(tokens), 2) AS avg_tokens
FROM prompts
GROUP BY user_id
HAVING 1=1
    AND MAX(tokens) > AVG(tokens)
    AND COUNT(prompt) > 2
ORDER BY avg_tokens DESC, user_id;