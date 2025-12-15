
CREATE TABLE books(
BOOK_ID SERIAL PRIMARY KEY,
Title VARCHAR (100),
Author VARCHAR (100),
Genre VARCHAR (50),
Published_Year INT,
Price NUMERIC (10, 2),
Stock INT
);

CREATE TABLE CUSTOMERS(
CUSTOMER_ID SERIAL PRIMARY KEY,
NAME VARCHAR (100),
EMAIL VARCHAR (100),
PHONE VARCHAR (15),
CITY VARCHAR (50),
COUNTRY VARCHAR (150)
);

CREATE TABLE orders(
Order_id SERIAL PRIMARY KEY,
CUSTOMER_ID INT REFERENCES CUSTOMERS(CUSTOMER_ID),
BOOK_ID INT REFERENCES BOOKS(BOOK_ID),
ORDER_DATE DATE,
QUANTITY INT,
TOTAL_AMOUNT NUMERIC (10, 2)
);

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

--Retrieve all books in the "Fiction" genre:
SELECT * FROM books
WHERE Genre = 'Fiction';

--Find books published after the year 1950:
SELECT * FROM books
WHERE published_year > 1950;

--List all the customers from the Canada:
SELECT * FROM customers
where country = 'Canada';

--Show orders placed in November 2023:
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--Retreive the total stock of books available:
SELECT SUM(stock) AS total_stock
FROM books;

--Find the details of the most expensive book:
SELECT * FROM books
ORDER BY PRICE desc
LIMIT 1;

--Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity > 1;

--Retreive all orders where the total amount exceeds $20:
SELECT * FROM orders
WHERE total_amount > 20;

--List all genres available in the Books Table:
SELECT DISTINCT genre FROM books;

--Find the book with the lowest stock:
SELECT * FROM books
ORDER BY STOCK
LIMIT 1;

--Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS total_revenue 
FROM orders;

--Retreive the total number of books sold for each genre:
SELECT b.genre,SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id 
GROUP BY b.genre;

--Find the average price of books in the "Fantasy genre":
SELECT AVG(price)
FROM books
WHERE genre = 'Fantasy';

--List customers who have placed at least 2 orders:
SELECT customer_id,COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >=2;

--Find the most frequently ordered book:
SELECT o.book_id,b.title,count(o.order_id) AS order_count
FROM orders o
JOIN books b
ON o.book_id = b.book_id
GROUP BY o.book_id , b.title
ORDER BY order_count desc LIMIT 1;

--Show the top 3 most expensive books of 'Fantasy' Genre:
SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price desc LIMIT 3;

--Retreive the total quantity of books sold by each author:
SELECT b.author,SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN BOOKS b ON o.book_id = b.book_id
GROUP BY b.author;

--List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city,o.total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE total_amount >=30;

--Find the customers who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_id ,c.name
ORDER BY total_spent desc LIMIT 1;

--Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id,b.title, b.stock,COALESCE(SUM(o.quantity),0) AS order_quantity,
b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;

















