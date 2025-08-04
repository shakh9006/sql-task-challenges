-- Source: https://www.codewars.com/kata/65cde30b29ece3000fcf5429/train/sql

--Title: Deduplicated Aggregation of Data from Multiple Tables in Banking Operations

SELECT
  COALESCE(a.event_id, c.event_id, i.event_id) event_id,
  UNNEST(ARRAY_AGG(DISTINCT assistant_name ORDER BY assistant_name)) assistant_name,
  UNNEST(ARRAY_AGG(DISTINCT consultation_date ORDER BY consultation_date)) consultation_date,
  UNNEST(ARRAY_AGG(DISTINCT issuance_date ORDER BY issuance_date)) issuance_date
FROM bank_assistants a
FULL JOIN consultations c USING(event_id)
FULL JOIN card_issuances i USING(event_id)
GROUP BY 1
ORDER BY 1