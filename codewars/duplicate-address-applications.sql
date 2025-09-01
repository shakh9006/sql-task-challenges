-- Source: https://www.codewars.com/kata/686cf5d8ebcff30d8b051b06/train/sql

--Title: One House, Many Claims: Detect Duplicate Address Applications

SELECT
  COUNT(*) || ' applications (applicant_ids: ' || STRING_AGG(applicant_id::TEXT, ', ' ORDER BY applicant_id) || ') already filed at ' || house_no || ' ' || street_name AS audit_note
FROM energy_rebate_applications
GROUP BY house_no, street_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, street_name, house_no;