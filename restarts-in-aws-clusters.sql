-- Source: https://www.codewars.com/kata/652eac1a3a9be51b35dbfbbb/train/sql

--Title: Analyzing Backup Intervals and Restarts in AWS Clusters

SELECT
  MIN(event_datetime)::TEXT start_time,
  MAX(event_datetime)::TEXT end_time,
  aws_cluster_id,
  MAX(event_datetime) - MIN(event_datetime) total_backup_duration,
  COUNT(*)-2 number_of_restarts
FROM (
  SELECT
    *,
    SUM((backup_status='End')::INT) OVER (PARTITION BY aws_cluster_id ORDER BY event_datetime) - (backup_status='End')::INT backup_id
  FROM backup_events
) events
GROUP BY aws_cluster_id, backup_id
ORDER BY start_time, aws_cluster_id;