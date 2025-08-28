-- Source: https://www.codewars.com/kata/64c57002edf1bc9f208283bc/solutions/sql

--Title: Advanced Pivoting Data

DO $block$
BEGIN
  EXECUTE ($$
   DROP VIEW IF EXISTS sales_analytics;
   CREATE VIEW sales_analytics AS
     select category_id "Cat. ID", categories.name "Category",
     $$||(
       select
         string_agg(format('coalesce(sum(amount) filter (where department_id = %s), 0::money) %I', id, name||' ('||id||')'), ', ' order by id)
       from departments
       where id in (select distinct department_id from sales)
     )||$$, sum(amount) "Totals"
     from categories
     join products on category_id = categories.id
     join sales on product_id = products.id
     join departments on departments.id = department_id
     group by ROLLUP ((1,2))
     order by 1
   $$);
END; $block$;

SELECT * FROM sales_analytics;