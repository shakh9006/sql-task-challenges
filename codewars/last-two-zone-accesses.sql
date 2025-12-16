-- Source: https://www.codewars.com/kata/692752ec3bfcc5bfac61abb9/train/sql

--Title: Security Breach: Last Two Zone Accesses

WITH source AS (
  SELECT
    employee_id,
    zone,
    access_time,
    DENSE_RANK() OVER(PARTITION BY employee_id ORDER BY access_time DESC) AS rank_id
  FROM access_logs
)
SELECT
  employee_id,
  EXTRACT (EPOCH FROM MAX(access_time) - MIN(access_time)) AS seconds_diff
FROM source
WHERE rank_id < 3
GROUP BY employee_id
HAVING COUNT(*) > 1
ORDER BY seconds_diff, employee_id;