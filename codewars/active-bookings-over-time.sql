-- Source: https://www.codewars.com/kata/6776bee98d5e887886da23e9/train/sql

--Title: Tracking Active Bookings Over Time

WITH unique_dates AS (
  SELECT
    DISTINCT booking_date
  FROM course_bookings
  ORDER BY booking_date
)
SELECT
  u.booking_date,
  COUNT(*) AS active_bookings
FROM unique_dates u
LEFT JOIN course_bookings c
  ON (u.booking_date >= c.booking_date AND u.booking_date <= c.course_start_date)
    OR (u.booking_date = c.booking_date AND c.booking_date = c.course_start_date)
GROUP BY 1
ORDER BY 1;