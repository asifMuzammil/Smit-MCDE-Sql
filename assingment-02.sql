use bikestores;
SELECT * 
FROM sales.customers;
--2.1
SELECT 
p.product_id,
p.product_name,
b.brand_name,
p.list_price 
FROM production.products AS p
inner JOIN production.brands b 

--2.2
 SELECT 
 s.store_id, 
 s.store_name,
 s.city 
 FROM sales.stores AS s
 LEFT JOIN sales.staffs AS st 
      ON s.store_id = st.store_id
 WHERE st.staff_id IS NULL;
   
--2.3
SELECT p.product_name, s.quantity
FROM production.products AS p
LEFT JOIN production.stocks AS s
    ON p.product_id = s.product_id AND s.quantity < 5 AND s.store_id = 1;   

--In a LEFT JOIN, conditions in the ON clause only determine matching for the right table without filtering rows from the preserved left table, returning NULL for unmatched products instead of excluding them

SELECT p.product_name, s.quantity
FROM production.products AS p
inner JOIN  production.stocks AS s
ON p.product_id = s.product_id 
WHERE s.store_id = 1
AND  s.quantity < 5
order BY s.quantity ASC  ;

--2.4

SELECT 
m.first_name + ' ' + m.last_name as manager_name,
e.first_name + ' ' + e.last_name as employee_name,
1 AS employee_count
FROM sales.staffs as m
inner JOIN sales.staffs as e 
on m.staff_id = e.manager_id 
order by manager_name ;

--2.5

SELECT 
o.order_id,
p.product_name,
oi.quantity,
oi.list_price
FROM sales.orders AS o
inner JOIN sales.order_items AS oi 
	ON o.order_id = oi.order_id
inner JOIN production.products AS p 
        ON oi.product_id = p.product_id
WHERE o.order_id = 1
order by list_price ;
--2.6

SELECT COUNT(DISTINCT o.order_id) AS true_order_count
    FROM sales.orders ASne o
    inner JOIN sales.order_items AS oi 
        ON o.order_id = oi.order_id;

--2.7

-----Not----