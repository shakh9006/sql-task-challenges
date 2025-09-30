-- Source: https://leetcode.com/problems/human-traffic-of-stadium/description/

--Title: Human Traffic of Stadium

WITH source AS (
    SELECT
        *,
        ROW_NUMBER() OVER() AS rn
    FROM Stadium
    WHERE people >= 100
),
grouped AS (
    SELECT
        *,
        id - rn AS group_num
    FROM source
)
SELECT
    id,
    visit_date,
    people
FROM grouped
WHERE group_num IN (
    select
        group_num
    from grouped
    group by group_num
    having count(*) > 2
)
ORDER BY visit_date;