-- Source: https://leetcode.com/problems/most-common-course-pairs/description/

--Title: Most Common Course Pairs

WITH source AS (
    SELECT
        course_name AS first_course,
        LEAD(course_name) OVER(PARTITION BY user_id) AS second_course,
        AVG(course_rating) OVER(PARTITION BY user_id) AS avg_rating,
        COUNT(course_id) OVER(PARTITION BY user_id) course_count
    FROM course_completions
)
SELECT
    first_course,
    second_course,
    COUNT(*) AS transition_count
FROM source
WHERE 1=1
    AND avg_rating >= 4
    AND course_count >= 5
    AND first_course IS NOT NULL
    AND second_course IS NOT NULL
GROUP BY first_course, second_course
ORDER BY transition_count DESC, LOWER(first_course), LOWER(second_course);