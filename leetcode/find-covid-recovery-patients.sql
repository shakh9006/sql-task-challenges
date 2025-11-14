-- Source: https://leetcode.com/problems/find-covid-recovery-patients/

--Title: Find COVID Recovery Patients

WITH source AS (
    SELECT
        ct.patient_id,
        MIN(ct.test_date) AS positive_date,
        MIN(p.test_date) AS negative_date
    FROM covid_tests ct
    LEFT JOIN covid_tests p ON p.patient_id = ct.patient_id AND ct.test_date < p.test_date AND p.result = 'Negative'
    WHERE ct.result = 'Positive' AND p.test_date > ct.test_date
    GROUP BY ct.patient_id
)
SELECT
    patient_id,
    patient_name,
    age,
    negative_date - positive_date AS recovery_time
FROM source
INNER JOIN patients USING(patient_id)
ORDER BY recovery_time, patient_name;