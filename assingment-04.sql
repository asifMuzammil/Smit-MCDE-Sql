
-- 4.1. Write a query that returns the total number of customers 

SELECT 
    COUNT(*)     AS total_customers,
    COUNT(phone) AS customers_with_phone
FROM sales.customers;

-- 4.2. Group production.products by brand_id and return the product 

SELECT 
    brand_id,
    COUNT(*)        AS product_count,
    AVG(list_price) AS avg_price
FROM production.products
GROUP BY brand_id
ORDER BY avg_price DESC;

-- 4.3. Using HAVING, find every brand with an average list_price above $1000.

SELECT 
    brand_id,
    AVG(list_price) AS avg_price
FROM production.products
GROUP BY brand_id
HAVING AVG(list_price) > 1000
ORDER BY avg_price DESC;



-- 4.4. The following query does not run. Explain the error and fix it:
-- SELECT customer_id, SUM(list_price) AS total
-- FROM sales.order_items
-- WHERE SUM(list_price) > 5000
-- GROUP BY customer_id;
--
-- Explanation of Errors:
-- 1. SUM() is an aggregate function and cannot be used in a WHERE clause 
--    because filtering in WHERE occurs before grouping. It must be in HAVING.
-- 2. The sales.order_items table does not have a customer_id column; 
--    customer_id belongs to sales.orders, so a JOIN is required.
-- --------------------------------------------------------------------
SELECT 
    o.customer_id, 
    SUM(oi.list_price * oi.quantity) AS total_spent
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi 
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
HAVING SUM(oi.list_price * oi.quantity) > 5000
ORDER BY total_spent DESC;


-- 4.5. 
SELECT TOP 10
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi 
    ON o.order_id = oi.order_id
INNER JOIN production.products AS p 
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;


-- 4.6. Think About It: A colleague joins orders to order_items and reports 
-- "we received 4,658 orders last year." Explain why this count is likely 
-- wrong and write the corrected version.
--
-- Explanation:
-- Joining orders to order_items inflates row counts due to the 1-to-many 
-- relationship (an order with multiple items produces multiple rows). 
-- The colleague counted total order line items rather than unique orders.
-- --------------------------------------------------------------------
-- Correct version using the existing join:
SELECT COUNT(DISTINCT o.order_id) AS true_order_count
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi 
    ON o.order_id = oi.order_id;

-- Best practice without joining:
SELECT COUNT(*) AS true_order_count
FROM sales.orders;

