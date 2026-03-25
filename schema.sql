-- Create Database
CREATE DATABASE sales_orders;
USE sales_orders;

-- Products Table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    price FLOAT,
    released_date DATE
);

INSERT INTO products (name, price, released_date) VALUES
('MacBook M4', 1000, '2024-10-26'),
('Apple Watch', 500, '2023-08-16'),
('iPhone 16', 800, '2022-10-15'),
('AirPods Pro 2', 250, '2023-09-22'),
('iPad Pro M3', 900, '2024-04-18');

-- Customers Table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(50)
);

INSERT INTO customers (name, email) VALUES
('Rahul Sharma','rahul@gmail.com'),
('Ananya Verma','ananya@gmail.com'),
('Vikram Singh','vikram@gmail.com'),
('Kartik Mehta','kartik@gmail.com');

-- Employees Table
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

INSERT INTO employees (name) VALUES
('Amit Kumar'),
('Priya Sharma'),
('Rohit Verma'),
('Neha Singh');

-- Sales Orders Table
CREATE TABLE sales_order (
    o_id INT PRIMARY KEY AUTO_INCREMENT,
    o_date DATE,
    quantity INT,
    product_id INT,
    status VARCHAR(50),
    customer_id INT,
    emp_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

INSERT INTO sales_order (o_date, quantity, product_id, status, customer_id, emp_id) VALUES
('2024-01-10', 2, 1, 'Delivered', 1, 1),
('2024-01-15', 1, 2, 'Pending', 2, 2),
('2024-02-05', 3, 3, 'Shipped', 3, 1),
('2024-02-20', 1, 4, 'Delivered', 4, 3),
('2024-03-01', 5, 5, 'Cancelled', 1, 2),
('2024-03-12', 2, 1, 'Delivered', 2, 4),
('2024-03-18', 4, 2, 'Shipped', 3, 3),
('2024-04-02', 1, 3, 'Pending', 4, 2),
('2024-04-10', 2, 4, 'Delivered', 1, 1),
('2024-04-18', 3, 5, 'Shipped', 2, 4),
('2024-05-01', 2, 1, 'Delivered', 3, 2),
('2024-05-09', 1, 2, 'Pending', 4, 3),
('2024-05-15', 6, 3, 'Delivered', 1, 1),
('2024-06-01', 2, 4, 'Shipped', 2, 2),
('2024-06-10', 1, 5, 'Delivered', 3, 4);
