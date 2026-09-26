/*
SQL PROJECT: ONLINE BOOK STORE ANALYSIS
Database: PostgreSQL | Tool: pgAdmin

This project covers database creation, relationships, data import,
basic analysis, advanced business questions, JOINs, aggregations,
HAVING, COALESCE and subqueries.
*/

-- =====================================================
-- 1. CREATE TABLES
-- =====================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    published_year INT,
    price NUMERIC(10,2),
    stock INT
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    book_id INT REFERENCES books(book_id),
    order_date DATE,
    quantity INT,
    total_amount NUMERIC(10,2)
);


-- =====================================================
-- 2. DATA IMPORT
-- =====================================================
-- Import Books.csv, Customers.csv and Orders.csv using
-- pgAdmin Import/Export, or update the COPY paths below.
--
-- Example:
-- COPY books(book_id,title,author,genre,published_year,price,stock)
-- FROM 'C:/Users/YourName/Downloads/Books.csv'
-- CSV HEADER;


-- =====================================================
-- 3. VERIFY DATA
-- =====================================================

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;


-- =====================================================
-- 4. BASIC BUSINESS ANALYSIS
-- =====================================================

-- 1) Retrieve all books in the Fiction genre
SELECT *
FROM books
WHERE genre = 'Fiction';

-- 2) Find books published after 1950
SELECT *
FROM books
WHERE published_year > 1950;

-- 3) List all customers from Canada
SELECT *
FROM customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Calculate total stock of all books
SELECT SUM(stock) AS total_stock
FROM books;

-- 6) Find the most expensive book
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;

-- 7) Show orders where more than 1 book was ordered
SELECT *
FROM orders
WHERE quantity > 1;

-- 8) Retrieve orders where total amount exceeds 20
SELECT *
FROM orders
WHERE total_amount > 20;

-- 9) List all unique book genres
SELECT DISTINCT genre
FROM books;

-- 10) Find the book(s) with the lowest stock
SELECT *
FROM books
WHERE stock = (SELECT MIN(stock) FROM books);

-- 11) Calculate total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;


-- =====================================================
-- 5. ADVANCED BUSINESS ANALYSIS
-- =====================================================

-- 1) Total number of books sold for each genre
SELECT
    b.genre,
    SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b
    ON b.book_id = o.book_id
GROUP BY b.genre
ORDER BY total_books_sold DESC;

-- 2) Average price of books in the Fantasy genre
SELECT
    ROUND(AVG(price), 2) AS average_price
FROM books
WHERE genre = 'Fantasy';

-- 3) Customers who have placed at least 2 orders
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2
ORDER BY order_count DESC;

-- 4) Most frequently ordered book
SELECT
    b.book_id,
    b.title,
    SUM(o.quantity) AS total_quantity_ordered
FROM orders o
JOIN books b
    ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY total_quantity_ordered DESC
LIMIT 1;

-- 5) Top 3 most expensive Fantasy books
SELECT
    book_id,
    title,
    price
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Total quantity of books sold by each author
SELECT
    b.author,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
JOIN books b
    ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY total_quantity_sold DESC;

-- 7) Cities where customers spent more than 30
SELECT
    c.city,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 30
ORDER BY total_spent DESC;

-- 8) Customer who spent the most
SELECT
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- 9) Remaining stock after fulfilling all orders
SELECT
    b.book_id,
    b.title,
    b.stock,
    COALESCE(SUM(o.quantity), 0) AS ordered_quantity,
    b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_quantity
FROM books b
LEFT JOIN orders o
    ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;


-- =====================================================
-- 6. ADDITIONAL REAL-WORLD ANALYSIS
-- =====================================================

-- 10) Total revenue by genre
SELECT
    b.genre,
    SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN books b
    ON b.book_id = o.book_id
GROUP BY b.genre
ORDER BY total_revenue DESC;

-- 11) Customers whose total spending is above 50
SELECT
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) > 50
ORDER BY total_spent DESC;

-- 12) Books that have never been ordered
SELECT
    b.book_id,
    b.title,
    b.stock
FROM books b
LEFT JOIN orders o
    ON b.book_id = o.book_id
WHERE o.book_id IS NULL;

-- 13) Total number of orders and total revenue
SELECT
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders;


-- =====================================================
-- PROJECT SKILLS DEMONSTRATED
-- =====================================================
-- CREATE TABLE | PRIMARY KEY | FOREIGN KEY
-- CSV DATA IMPORT | SELECT | WHERE | BETWEEN | DISTINCT
-- ORDER BY | LIMIT | SUM | AVG | COUNT | MIN | MAX
-- GROUP BY | HAVING | INNER JOIN | LEFT JOIN
-- COALESCE | SUBQUERY | BUSINESS ANALYSIS

-- END OF PROJECT
