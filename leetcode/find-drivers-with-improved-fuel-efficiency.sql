-- Source: https://leetcode.com/problems/find-drivers-with-improved-fuel-efficiency/description/

--Title: Find Drivers with Improved Fuel Efficiency

WITH first_half_of_year AS (
    SELECT
        driver_id,
        AVG(distance_km / fuel_consumed) AS avg_fuel_eff
    FROM trips
    WHERE EXTRACT (MONTH FROM trip_date) >= 1 AND EXTRACT (MONTH FROM trip_date) < 7
    GROUP BY driver_id
),
second_half_of_year AS (
    SELECT
        driver_id,
        AVG(distance_km / fuel_consumed) AS avg_fuel_eff
    FROM trips
    WHERE EXTRACT (MONTH FROM trip_date) >= 7
    GROUP BY driver_id
)
SELECT
    driver_id,
    driver_name,
    ROUND(fh.avg_fuel_eff, 2) AS first_half_avg,
    ROUND(sh.avg_fuel_eff, 2) AS second_half_avg,
    ROUND(sh.avg_fuel_eff - fh.avg_fuel_eff, 2) AS efficiency_improvement
FROM drivers
INNER JOIN first_half_of_year fh USING(driver_id)
INNER JOIN second_half_of_year sh USING(driver_id)
WHERE sh.avg_fuel_eff > fh.avg_fuel_eff
ORDER BY efficiency_improvement DESC, driver_name;