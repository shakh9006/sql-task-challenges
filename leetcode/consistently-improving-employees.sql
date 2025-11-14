-- Source: https://leetcode.com/problems/find-consistently-improving-employees/

--Title: Find Consistently Improving Employees

WITH ranked_performance_reviews AS (
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM performance_reviews
)
SELECT
    pr1.employee_id,
    e.name,
    pr1.rating - pr3.rating AS improvement_score
FROM ranked_performance_reviews pr1
INNER JOIN ranked_performance_reviews pr2
    ON pr1.employee_id = pr2.employee_id AND pr2.rn = 2
INNER JOIN ranked_performance_reviews pr3
    ON pr1.employee_id = pr3.employee_id AND pr3.rn = 3
INNER JOIN employees e
    ON pr1.employee_id = e.employee_id
WHERE pr1.rn = 1 AND pr3.rating < pr2.rating AND pr2.rating < pr1.rating
ORDER BY improvement_score DESC, name;