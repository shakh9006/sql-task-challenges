-- Source: https://www.codewars.com/kata/64b16a9c67b45c1fb362cdf9/train/sql

--Title: Retained Users

SELECT
  TO_CHAR(date_trunc('month', l1.date), 'FMMonth, YYYY') AS month,
  COUNT(DISTINCT l1.user_id) AS retained_users
FROM logins l1
INNER JOIN logins l2
  ON l1.user_id = l2.user_id
  AND date_trunc('month', l1.date) = date_trunc('month', l2.date + INTERVAL '1 month')
GROUP BY date_trunc('month', l1.date)
ORDER BY date_trunc('month', l1.date);