-- Q1
CREATE DATABASE siit;
USE siit;
SOURCE /Users/ammaster10/Downloads/siit.sql;
SHOW TABLES;


INSERT INTO department VALUES ('CS', 'Computer Science'), ('IT', 'Information Technology'),
('EE', 'Electrical Engineering'), ('ME', 'Mechanical Engineering'), ('CE', 'Civil Engineering');


INSERT INTO instructor VALUES (1, 'John', 'Doe', 'CS'), (2, 'Jane', 'Smith', 'IT'),
(3, 'Michael', 'Johnson', 'EE'), (4, 'Emily', 'Davis', 'ME'), (5, 'David', 'Brown', 'CE');


INSERT INTO salary VALUES (1, 50000.00), (2, 55000.00), (3, 60000.00), (4, 45000.00), (5, 48000.00);


INSERT INTO student VALUES (101, 'Alice', 'Williams', 'CS'), (102, 'Bob', 'Taylor', 'IT'),
(103, 'Charlie', 'Anderson', 'EE'), (104, 'Diana', 'Moore', 'ME'), (105, 'Eve', 'Thomas', 'CE');


INSERT INTO course VALUES ('CS101', 'Intro to Computer Science', 3, 'CS'), 
('IT201', 'Network Security', 4, 'IT'), ('EE301', 'Circuits', 4, 'EE'),
('ME401', 'Thermodynamics', 3, 'ME'), ('CE501', 'Structural Analysis', 3, 'CE');


INSERT INTO teaches VALUES (1, 'CS101', 1, 'Fall', 2024), (2, 'IT201', 1, 'Spring', 2024),
(3, 'EE301', 1, 'Summer', 2024), (4, 'ME401', 1, 'Fall', 2024), (5, 'CE501', 1, 'Spring', 2024);



ALTER TABLE instructor
ADD CONSTRAINT fk_department_instructor
FOREIGN KEY (dept_code)
REFERENCES department(dept_code)
ON DELETE RESTRICT;

ALTER TABLE course
ADD CONSTRAINT fk_department_course
FOREIGN KEY (dept_code)
REFERENCES department(dept_code)
ON DELETE RESTRICT;

ALTER TABLE salary
ADD CONSTRAINT fk_department_salary
FOREIGN KEY (dept_code)
REFERENCES department(dept_code)
ON DELETE RESTRICT;

ALTER TABLE student
ADD CONSTRAINT fk_department_student
FOREIGN KEY (dept_code)
REFERENCES department(dept_code)
ON DELETE RESTRICT;


-- Q2

CREATE DATABASE Library;
USE Library;
SOURCE /Users/ammaster10/Downloads/Library.sql;
SHOW TABLES;

-- List All Books by Alice Johnson
SELECT B.title, CONCAT(A.first_name, ' ', A.last_name) AS Author_Name
FROM Books B
JOIN Authors A ON B.author_id = A.author_id
JOIN Transactions T ON B.book_id = T.book_id
JOIN Borrowers BR ON T.borrower_id = BR.borrower_id
WHERE BR.first_name = 'Alice' AND BR.last_name = 'Johnson';


-- List overdue Books
SELECT B.title, CONCAT(BR.first_name, ' ', BR.last_name) AS Borrower_Name, T.return_date
FROM Books B
JOIN Transactions T ON B.book_id = T.book_id
JOIN Borrowers BR ON T.borrower_id = BR.borrower_id
WHERE T.return_date < CURDATE();


-- List all authors who have books checked out and the number of books checked out by each.

SELECT CONCAT(A.first_name, ' ', A.last_name) AS Author_Name, COUNT(T.transaction_id) AS books_checked_out
FROM Authors A
JOIN Books B ON A.author_id = B.author_id
JOIN Transactions T ON B.book_id = T.book_id
GROUP BY A.author_id;

-- Find the top-spending customers as the below image.

SELECT CONCAT(BR.first_name, ' ', BR.last_name) AS Borrower_Name, COUNT(T.transaction_id) AS books_checked_out
FROM Borrowers BR
JOIN Transactions T ON BR.borrower_id = T.borrower_id
GROUP BY BR.borrower_id
ORDER BY books_checked_out DESC
LIMIT 1;

-- Q3 

CREATE DATABASE Coffeshop;
USE Coffeshop;
SOURCE /Users/ammaster10/Downloads/Coffeshop.sql;
SHOW TABLES;

-- List all orders along with the customer's name and order total as
-- below. (0.4 points)

SELECT 
    O.order_id,
    CONCAT(C.first_name, ' ', C.last_name) AS customer_name,
    SUM(P.price * OI.quantity) AS order_total
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY O.order_id;

-- Calculate the total revenue for the coffee shop as below image. (0.4
-- points)

SELECT 
    SUM(P.price * OI.quantity) AS total_revenue
FROM Order_Items OI
JOIN Products P ON OI.product_id = P.product_id;


-- Create a view to see the most popular products and list them.
CREATE VIEW MostPopularProducts AS
SELECT 
    P.name,
    SUM(OI.quantity) AS total_quantity_sold
FROM Products P
JOIN Order_Items OI ON P.product_id = OI.product_id
GROUP BY P.product_id
ORDER BY total_quantity_sold DESC;

SELECT * FROM MostPopularProducts;



-- Find the top-spending customers.

SELECT 
    CONCAT(C.first_name, ' ', C.last_name) AS customer_name,
    SUM(P.price * OI.quantity) AS total_spent
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY C.customer_id
ORDER BY total_spent DESC;

-- Q4

CREATE DATABASE Bank;

USE Bank;

SOURCE /Users/ammaster10/Downloads/Bank.sql;

-- List all customers and their account types along with 
-- the total balance for each customer.
SELECT 
    CONCAT(C.first_name, ' ', C.last_name) AS customer_name,
    GROUP_CONCAT(A.account_type SEPARATOR ', ') AS account_types,
    SUM(A.balance) AS total_balance
FROM Customers C
JOIN Accounts A ON C.customer_id = A.customer_id
GROUP BY C.customer_id;

-- Find the top 3 customers with the highest total balance across all accounts.
SELECT 
    CONCAT(C.first_name, ' ', C.last_name) AS customer_name,
    SUM(A.balance) AS total_balance
FROM Customers C
JOIN Accounts A ON C.customer_id = A.customer_id
GROUP BY C.customer_id
ORDER BY total_balance DESC
LIMIT 3;

-- Q5

CREATE DATABASE SearchEngine;
use SearchEngine;
SOURCE /Users/ammaster10/Downloads/SearchEngine.sql;

-- Update the content of a web page based on its URL.

UPDATE Web_pages
SET content = 'This is the updated content of page 1.'
WHERE url = 'http://www.example.com/page1';


-- List the web pages ranked by their appearance 
-- in search results for a specific query.
SELECT 
    Q.query_text,
    P.title,
    P.url,
    R.rank
FROM Search_results R
JOIN Web_pages P ON R.page_id = P.page_id
JOIN Search_queries Q ON R.query_id = Q.query_id
WHERE Q.query_text = 'Search engine'
ORDER BY R.rank;

