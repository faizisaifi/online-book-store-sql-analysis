# Online Book Store SQL Analysis

## 📌 Project Overview

This project analyzes an Online Book Store database using PostgreSQL.

The database contains three main tables:

- **Books** – stores book details such as title, author, genre, price and stock.
- **Customers** – stores customer information such as name, email, city and country.
- **Orders** – stores order details including customer, book, quantity, order date and total amount.

## 🗂️ Database Structure

### Books
- book_id
- title
- author
- genre
- published_year
- price
- stock

### Customers
- customer_id
- name
- email
- phone
- city
- country

### Orders
- order_id
- customer_id
- book_id
- order_date
- quantity
- total_amount

## 🔍 Analysis Performed

The project answers business questions such as:

- Which books belong to the Fiction genre?
- Which books were published after 1950?
- What is the total stock available?
- Which book is the most expensive?
- What is the total revenue generated?
- Which genre has the highest number of books sold?
- Which customers have placed at least two orders?
- Which book is ordered most frequently?
- Which customer has spent the most?
- How much stock remains after fulfilling orders?
- Which books have never been ordered?

## 🛠️ SQL Skills Used

- SELECT
- WHERE
- BETWEEN
- DISTINCT
- ORDER BY
- LIMIT
- SUM
- AVG
- COUNT
- MIN / MAX
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- COALESCE
- Subqueries
- Primary Keys
- Foreign Keys

## 💻 Tools

- PostgreSQL
- pgAdmin
- SQL

## 📁 Project File

The complete SQL analysis is available in:

`Online_Book_Store_SQL_Project_Professional.sql`

## 🎯 Objective

The objective of this project is to demonstrate practical SQL and PostgreSQL skills by solving real-world business questions using relational data.
