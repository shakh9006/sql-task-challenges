-- Source: https://leetcode.com/problems/sales-person/

--Title: Sales Person

SELECT
    name
FROM SalesPerson
WHERE sales_id NOT IN (
    select
        sales_id
    from Orders
    inner join Company using(com_id)
    where name = 'RED'
);

