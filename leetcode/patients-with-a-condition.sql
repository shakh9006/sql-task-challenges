-- Source: https://leetcode.com/problems/patients-with-a-condition/

--Title: Patients With a Condition

SELECT
    patient_id,
    patient_name,
    conditions
FROM Patients
WHERE conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%';