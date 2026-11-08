USE BikeStores;
GO

-- Q1
SELECT 
    first_name, 
    last_name, 
    city
FROM sales.customers
WHERE state IN ('NY', 'CA')
  AND email LIKE '%.com'
  AND last_name LIKE 'M%'
ORDER BY city ASC, last_name ASC;


-- Q2
SELECT 
    product_name,
    list_price,
    ROUND(list_price * 0.90, 2) AS discounted_price
FROM production.products
WHERE list_price > 500
ORDER BY list_price DESC
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;


-- Q3
SELECT 
    order_id, 
    order_date, 
    required_date, 
    order_status
FROM sales.orders
WHERE (order_status = 1 OR order_status = 2)
  AND shipped_date IS NULL
  AND order_date BETWEEN '2018-01-01' AND '2018-06-30';


-- Q4
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_date,
    s.store_name,
    p.product_name,
    oi.quantity
FROM sales.orders o
INNER JOIN sales.customers c ON o.customer_id = c.customer_id
INNER JOIN sales.stores s ON o.store_id = s.store_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
INNER JOIN production.products p ON oi.product_id = p.product_id
WHERE o.order_status = 4
  AND o.order_date BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY o.order_date DESC;


-- Q5
SELECT 
    p.product_name,
    c.category_name,
    b.brand_name
FROM production.products p
INNER JOIN production.categories c ON p.category_id = c.category_id
INNER JOIN production.brands b ON p.brand_id = b.brand_id
LEFT JOIN sales.order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- Q6
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    st.store_name
FROM sales.staffs s
LEFT JOIN sales.staffs m ON s.manager_id = m.staff_id
INNER JOIN sales.stores st ON s.store_id = st.store_id;


-- Q7 (a)


-- Q7 (b)


-- Q8
SELECT TOP 5
    c.category_name,
    b.brand_name,
    COUNT(DISTINCT oi.order_id) AS distinct_orders,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM production.categories c
INNER JOIN production.products p ON c.category_id = p.category_id
INNER JOIN production.brands b ON p.brand_id = b.brand_id
INNER JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name, b.brand_name
HAVING COUNT(DISTINCT oi.order_id) >= 20
ORDER BY total_revenue DESC;


-- Q9
SELECT 
    s.store_name,
    YEAR(o.order_date) AS order_year,
    COUNT(DISTINCT o.order_id) AS distinct_orders,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM sales.stores s
INNER JOIN sales.orders o ON s.store_id = o.store_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_name, YEAR(o.order_date)
ORDER BY s.store_name ASC, order_year ASC;


-- Q10


-- Q11
SELECT 
    customer_id, 
    first_name, 
    last_name
FROM sales.customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM sales.orders
    WHERE customer_id IS NOT NULL
);


-- Q12
