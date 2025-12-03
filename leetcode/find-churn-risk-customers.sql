-- Source: https://leetcode.com/problems/find-churn-risk-customers/description/

--Title: Find Churn Risk Customers

WITH source AS (
    SELECT
        user_id,
        MIN(event_date) FILTER (WHERE event_type = 'start') AS start_date,
        MAX(event_date) AS last_event_date,
        MAX(monthly_amount) AS max_historical_amount,
        COUNT(*) FILTER (WHERE event_type = 'downgrade') AS downgrade_count
    FROM subscription_events
    GROUP BY user_id
)
SELECT
    user_id,
    current_plan,
    current_monthly_amount,
    max_historical_amount,
    last_event_date - start_date AS days_as_subscriber
FROM source s1
LEFT JOIN LATERAL (
    select
        event_type AS current_event_type,
        plan_name AS current_plan,
        monthly_amount AS current_monthly_amount
    from subscription_events s2
    where s1.user_id = s2.user_id
    order by s2.event_date desc
    limit 1
) s2 ON 1=1
WHERE current_event_type != 'cancel'
    AND downgrade_count != 0
    AND (max_historical_amount / 2) > current_monthly_amount
    AND last_event_date - start_date >= 60
ORDER BY days_as_subscriber DESC, user_id;