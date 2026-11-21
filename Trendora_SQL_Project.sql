create database trendora_db;
use trendora_db;

SHOW TABLES;

--  Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);
INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Fashion'),
('Home Appliances'),
('Beauty'),
('Sports');
SELECT * FROM categories;

--  Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    phone VARCHAR(15),
    registration_date DATE
);
INSERT INTO customers
(customer_name, email, city, phone, registration_date)
VALUES
('Arun Kumar', 'arun@example.com', 'Coimbatore', '9876501234', '2026-01-15'),
('Priya Sharma', 'priya@example.com', 'Chennai', '9876501235', '2026-02-10'),
('Rahul Dev', 'rahul@example.com', 'Tiruppur', '9876501236', '2026-03-05'),
('Sneha Raj', 'sneha@example.com', 'Madurai', '9876501237', '2026-04-20'),
('Karthik S', 'karthik@example.com', 'Salem', '9876501238', '2026-05-12');
SELECT * FROM customers;
-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);
INSERT INTO products
(product_name, category_id, price, stock_quantity)
VALUES
('Wireless Headphones', 1, 2499.00, 20),
('Cotton Kurti', 2, 899.00, 30),
('Mixer Grinder', 3, 2799.00, 10),
('Face Wash', 4, 299.00, 25),
('Yoga Mat', 5, 699.00, 15);

SELECT * FROM products;

-- Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    city VARCHAR(50),
    contact_number VARCHAR(15)
);

INSERT INTO suppliers
(supplier_name, city, contact_number)
VALUES
('ABC Traders', 'Coimbatore', '9876501111'),
('Fashion Hub', 'Tiruppur', '9876502222'),
('Prime Suppliers', 'Chennai', '9876503333');

SELECT * FROM suppliers;

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
INSERT INTO orders
(customer_id, order_date, order_status)
VALUES
(1, '2026-06-10', 'Delivered'),
(2, '2026-06-12', 'Shipped'),
(3, '2026-06-15', 'Pending');
SELECT * FROM orders;

--  Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);
INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 2499.00),
(2, 2, 2, 899.00),
(3, 3, 1, 2799.00);
SELECT * FROM order_items;

--  Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);
INSERT INTO payments
(order_id, payment_date, payment_method, payment_amount, payment_status)
VALUES
(1, '2026-06-10', 'UPI', 2499.00, 'Completed'),
(2, '2026-06-12', 'Credit Card', 1798.00, 'Completed'),
(3, '2026-06-15', 'Cash', 2799.00, 'Pending');
SELECT * FROM payments;

--  Inventory Table
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    supplier_id INT,
    available_quantity INT,
    last_updated DATE,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    FOREIGN KEY (supplier_id)
        REFERENCES suppliers (supplier_id)
); 
INSERT INTO inventory
(product_id, supplier_id, available_quantity, last_updated)
VALUES
(1, 1, 20, '2026-06-20'),
(2, 2, 30, '2026-06-20'),
(3, 3, 10, '2026-06-20'),
(4, 1, 25, '2026-06-20'),
(5, 2, 15, '2026-06-20');
SELECT * FROM inventory;

-- Business Analysis Queries

-- Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT COUNT(*) AS total_products
FROM products;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT SUM(payment_amount) AS total_sales
FROM payments
WHERE payment_status = 'Completed';SELECT AVG(price) AS average_price
FROM products;
SELECT MAX(price) AS highest_price
FROM products;
SELECT MIN(price) AS lowest_price
FROM products;
SELECT SUM(stock_quantity) AS total_stock
FROM products;

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;