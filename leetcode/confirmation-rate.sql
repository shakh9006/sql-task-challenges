-- Source: https://leetcode.com/problems/confirmation-rate/description/

--Title: Confirmation Rate

SELECT
    user_id,
    COALESCE(
        ROUND(COUNT(*) FILTER (WHERE action = 'confirmed') / (COUNT(*) * 1.00), 2),
        0.00
    ) AS confirmation_rate
FROM Signups
LEFT JOIN Confirmations USING(user_id)
GROUP BY user_id;