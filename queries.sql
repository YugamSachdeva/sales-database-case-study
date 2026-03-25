-- =========================
-- BASIC ANALYSIS
-- =========================

-- Total products sold
SELECT SUM(quantity) AS total_products_sold
FROM sales_order;

-- Orders not delivered
SELECT *
FROM sales_order
WHERE LOWER(status) <> 'delivered';

-- Orders count by status
SELECT status, COUNT(*) AS total_orders
FROM sales_order
GROUP BY status;

-- =========================
-- INTERMEDIATE QUERIES
-- =========================

-- Delivered orders with product & customer
SELECT so.o_id, so.o_date, p.name AS product_name, c.name AS customer_name
FROM sales_order so
JOIN products p ON p.id = so.product_id
JOIN customers c ON c.id = so.customer_id
WHERE so.status = 'Delivered'
ORDER BY so.o_date;

-- Customer-wise total products purchased
SELECT c.name, SUM(so.quantity) AS total_products
FROM sales_order so
JOIN customers c ON c.id = so.customer_id
GROUP BY c.name
ORDER BY total_products DESC;

-- Daily revenue
SELECT so.o_date,
       SUM(p.price * so.quantity) AS total_sales
FROM sales_order so
JOIN products p ON p.id = so.product_id
GROUP BY so.o_date;

-- =========================
-- ADVANCED ANALYTICS
-- =========================

-- Employee-wise total delivered sales
SELECT e.name,
       COALESCE(SUM(so.quantity * p.price), 0) AS total_sales
FROM employees e
LEFT JOIN sales_order so 
    ON e.id = so.emp_id AND LOWER(so.status) = 'delivered'
LEFT JOIN products p 
    ON p.id = so.product_id
GROUP BY e.name;

-- Customers with no orders
SELECT c.*
FROM customers c
LEFT JOIN sales_order so 
    ON c.id = so.customer_id
WHERE so.o_id IS NULL;

-- Orders above 2000 value
SELECT so.*, (so.quantity * p.price) AS total_cost
FROM sales_order so
JOIN products p ON p.id = so.product_id
WHERE (so.quantity * p.price) > 2000;

-- Top 3 customers by revenue
SELECT c.name,
       SUM(so.quantity * p.price) AS total_revenue
FROM sales_order so
JOIN customers c ON c.id = so.customer_id
JOIN products p ON p.id = so.product_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 3;

-- Monthly revenue trend
SELECT DATE_FORMAT(so.o_date, '%Y-%m') AS month,
       SUM(so.quantity * p.price) AS monthly_revenue
FROM sales_order so
JOIN products p ON p.id = so.product_id
GROUP BY month
ORDER BY month;

-- Most sold product
SELECT p.name,
       SUM(so.quantity) AS total_sold
FROM sales_order so
JOIN products p ON p.id = so.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

-- Customers with above average spending
SELECT c.name,
       AVG(so.quantity * p.price) AS avg_purchase
FROM sales_order so
JOIN customers c ON c.id = so.customer_id
JOIN products p ON p.id = so.product_id
GROUP BY c.name
HAVING avg_purchase > (
    SELECT AVG(quantity * price)
    FROM sales_order so
    JOIN products p ON p.id = so.product_id
);
