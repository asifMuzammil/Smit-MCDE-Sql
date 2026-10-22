--1.1
SELECT 
product_name, 
list_price / 1000 as price_in_thousands
FROM production.products;

--1.2
SELECT DISTINCT
state
FROM  sales.stores;

--1.3
SELECT TOP 5 
    product_name, 
    list_price
FROM production.products
ORDER BY list_price ASC ;

--1.4
SELECT 
    product_name, 
    list_price,
    category_id
FROM production.products
WHERE list_price BETWEEN 200 AND 600
AND category_id IN (1,6);

--1.5
SELECT product_name, category_id, list_price
FROM production.products
WHERE (category_id = 1 OR  category_id = 6) AND list_price < 1000
order by list_price ASC ;

--1.5 
SELECT product_name, category_id, list_price
FROM production.products
WHERE category_id IN (1 ,6)
AND list_price <1001
order by list_price DESC ; 

--1.6
SELECT
customer_id,
last_name,
email
FROM sales.customers
WHERE email  LIKE '%.com' and last_name LIKE 'M%';

--1.7
  SELECT product_name, category_id, list_price
    FROM production.products
    WHERE (category_id = 1 OR category_id = 6) 
      AND list_price < 1000
      ORDER BY list_price ASC  ;


--1.8
SELECT *
    FROM sales.order_items
    WHERE discount IS NOT NULL;

