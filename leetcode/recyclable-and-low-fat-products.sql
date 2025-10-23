-- Source: https://leetcode.com/problems/recyclable-and-low-fat-products/

--Title: Recyclable and Low Fat Products

SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';