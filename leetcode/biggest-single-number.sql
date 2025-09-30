-- Source: https://leetcode.com/problems/biggest-single-number/description/

--Title: Biggest Single Number

SELECT COALESCE(
    (
        select
            num
        from MyNumbers
        group by num
        having count(*) = 1
        order by num desc
        limit 1
    ),
    NULL
) AS num;