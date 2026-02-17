-- Source: https://www.codewars.com/kata/6929d3813b04b7fd78f21c5b/train/sql

--Title: 🌍 Earth-Like Exoplanet Detection

WITH danger_objects AS (
  SELECT
     object_id
  FROM spectral_logs
  GROUP BY object_id
  HAVING 1=1
    AND COUNT(signature) FILTER (WHERE signature = 'CO2_SUPERDENSE') > 0
    AND COUNT(signature) FILTER (WHERE signature = 'SO2_ACIDITY') > 0
    AND COUNT(signature) FILTER (WHERE signature = 'SULFURIC_CLOUDS') > 0
),
eath_like_objects AS (
  SELECT
    object_id
  FROM spectral_logs
  GROUP BY object_id
  HAVING 1=1
    AND COUNT(signature) FILTER (WHERE signature = 'O2_ABS') > 1
    AND COUNT(signature) FILTER (WHERE signature = 'H2O_VAPOR') > 1
    AND COUNT(signature) FILTER (WHERE signature = 'CH4_TRACE') > 1
    AND COUNT(signature) FILTER (WHERE signature = 'O3_UV_SHIELD') > 1
    AND COUNT(signature) FILTER (WHERE signature = 'CO2_BASELINE') > 1
)
SELECT
  object_id
FROM eath_like_objects
WHERE object_id NOT IN (select * from danger_objects)
ORDER BY object_id;