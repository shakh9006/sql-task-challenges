-- Source: https://www.codewars.com/kata/6574382cfbfb3a42cdb095e5/train/sql

--Title: The Road to Hell

WITH hell_journey AS (
  select journey_id
  from journey_stop j
  where exists (
    select
      1
    from stations s
    where s.station_name = 'Hell' and s.id = j.station_id
  )
)
SELECT
  CASE
    WHEN sequence_number = 1 THEN journey_name
    ELSE NULL
  END AS journey,
  s.station_name || ' (' || js.sequence_number || ')' AS station_name
FROM journey_stop js
INNER JOIN stations s ON js.station_id = s.id
INNER JOIN journey j ON js.journey_id = j.id
WHERE js.journey_id IN (select journey_id from hell_journey)
ORDER BY j.id, js.sequence_number;