-- Source: https://www.codewars.com/kata/657d994ffbfb3ac8fdb093d6/train/sql

--Title: Exact Call Center Traffic: Identifying Peak Hours and User Workload

WITH time_series AS (
   SELECT
    t AS org_hour,
    CASE
      WHEN EXTRACT (HOUR FROM t) < 12
        THEN EXTRACT (HOUR FROM t) || ' AM'
      WHEN EXTRACT (HOUR FROM t) = 12
        THEN EXTRACT (HOUR FROM t) || ' PM'
      ELSE EXTRACT (HOUR FROM t) - 12 || ' PM'
    END AS hour
    FROM generate_series(
      current_date + time '09:00',
      current_date + time '18:00',
      interval '1 hour'
  ) AS T
),
source AS (
  SELECT
    *,
    username as usr,
    EXTRACT(HOUR FROM called_time) AS org_hour,
    CASE
      WHEN EXTRACT(HOUR FROM called_time) < 12
        THEN EXTRACT(HOUR FROM called_time) || ' AM'
      WHEN EXTRACT (HOUR FROM called_time) = 12
        THEN EXTRACT (HOUR FROM called_time) || ' PM'
      ELSE
        EXTRACT(HOUR FROM called_time) - 12 || ' PM'
    END AS hour
  FROM calls
  WHERE 1=1
      AND called_time::DATE = '2023-12-14'
      AND EXTRACT(HOUR FROM called_time) BETWEEN 9 AND 18
),
split_into_user_group AS (
  SELECT
    hour,
    org_hour,
    usr,
    COUNT(*) AS exact_user_call_ct
  FROM source
  GROUP BY org_hour, hour, usr
),
final_grouping AS (
  SELECT
    hour,
    org_hour,
    SUM(exact_user_call_ct)::INT AS call_count,
    MAX(exact_user_call_ct)::INT AS max_calls_by_single_user
  FROM split_into_user_group
  GROUP BY org_hour, hour
),
combined_with_inactive_data AS (
  SELECT
    t.*,
    ROW_NUMBER() OVER(ORDER BY call_count DESC, org_hour ASC) as rn
  FROM (
    SELECT
      t.hour,
      t.org_hour,
      COALESCE(f.call_count, 0) AS call_count,
      COALESCE(f.max_calls_by_single_user, 0) AS max_calls_by_single_user
    FROM time_series t
    LEFT JOIN final_grouping f USING(hour)
  ) t
)
SELECT
  hour,
  call_count,
  max_calls_by_single_user,
  CASE
    WHEN rn = 1
      THEN 'Peak Hour'
    WHEN rn BETWEEN 2 AND 4
      THEN 'Off-Peak Hour'
    ELSE 'Quiet Hour'
  END AS call_volume_category
FROM combined_with_inactive_data;
