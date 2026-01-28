-- Source: https://www.codewars.com/kata/686f7daab952c6058e61d70c/train/sql

--Title: SQL for Marketing – Episode 2: Cohort-Based Funnel Drop-Off

WITH base AS (
  SELECT 'received' AS stage
  UNION
  SELECT 'opened' AS stage
  UNION
  SELECT 'clicked' AS stage
  UNION
  SELECT 'converted' AS stage
),
base_campaign_send AS (
  SELECT
    user_id,
    campaign_id,
    MIN(sent_at) AS sent_at
  FROM campaign_sends
  WHERE campaign_id = 'SUMMER2025'
  GROUP BY user_id, campaign_id
),
deduplicated_events AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_time DESC) AS rn
  FROM engagement_events
  WHERE campaign_id = 'SUMMER2025'
),
filtered_events AS (
  SELECT
    user_id,
    event_time,
    campaign_id,
    CASE
      WHEN event_type IN ('open', 'click') THEN event_type || 'ed'
      WHEN event_type = 'converted' THEN event_type
      ELSE 'received'
    END AS event_type
  FROM deduplicated_events
  WHERE rn = 1
  ORDER BY user_id, event_time
),
source AS (
  SELECT
    b.user_id,
    COALESCE(f.event_type, 'received') AS event_type
  FROM base_campaign_send b
  LEFT JOIN filtered_events f
    ON b.user_id = f.user_id AND b.sent_at < f.event_time
)
SELECT
  b.stage,
  COALESCE(s.users, 0) AS users
FROM base b
LEFT JOIN (
  SELECT
    event_type AS stage,
    COUNT(*) users
  FROM source
  GROUP BY event_type
) s ON b.stage = s.stage;