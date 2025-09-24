-- Source: https://leetcode.com/problems/investments-in-2016/description/

--Title: Investments in 2016

WITH source AS (
    SELECT
        tiv_2016,
        COUNT(*) OVER(PARTITION BY lat, lon) AS ct,
        COUNT(*) OVER(PARTITION BY tiv_2015) AS tiv_2015_ct
    FROM Insurance
)
SELECT
    ROUND(SUM(tiv_2016)::NUMERIC, 2) AS tiv_2016
FROM source
WHERE ct = 1 AND tiv_2015_ct > 1;