-- Source: https://www.codewars.com/kata/5daf515c3affec002b2fb921/train/sql

--Title: Present JSON data the SQL way

SELECT
  data->>'first_name' AS first_name,
  data->>'last_name' AS last_name,
  data->>'date_of_birth' AS age,
  EXTRACT(YEAR FROM age(current_date, (data->>'date_of_birth')::date)) AS age,
  CASE
    WHEN (data->>'private')::BOOLEAN = true THEN 'Hidden'
    WHEN (data->'email_addresses')::JSON->>0 IS NULL THEN 'None'
    ELSE (data->'email_addresses')::JSON->>0
  END AS email_address
FROM users
ORDER BY first_name, last_name;