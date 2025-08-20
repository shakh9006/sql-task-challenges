-- Source: https://www.codewars.com/kata/667d1db038cc5c1262d78dcd/train/sql

--Title: Identifying Peak Hours for Angry Customer Calls

WITH source AS (
  SELECT
    EXTRACT (HOUR FROM c.timestamp) AS call_hour,
    content
  FROM calls c
  LEFT JOIN LATERAL (
    SELECT
      content
    FROM transcriptions t
    WHERE t.call_id = c.call_id
    LIMIT 1
  ) t ON true
  WHERE c.status = 'transferred_to_rep'
),
source_with_word_length AS (
  SELECT
   call_hour,
   content,
   (LENGTH(LOWER(content)) - LENGTH(REPLACE(LOWER(content), 'f-word', '')))
      / LENGTH('f-word') AS occurrences
  FROM source
)
SELECT
  call_hour,
  COUNT(*) FILTER (WHERE occurrences > 2) AS angry_call_count
FROM source_with_word_length
GROUP BY 1
HAVING COUNT(*) FILTER (WHERE occurrences > 2) > 0
ORDER BY angry_call_count DESC, call_hour;