DROP DATABASE IF EXISTS Practice;
CREATE DATABASE IF NOT EXISTS practice;

use practice;

CREATE TABLE Users(
    USER_ID INT PRIMARY KEY AUTO_INCREMENT,
    Username Varchar(50),
    Email Varchar(100)
);

CREATE TABLE Orders (
    Orders_Id INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT,
    Product VARCHAR(100),
    Amount DECIMAL(10,2),
    Status VARCHAR(20),
    Foreign Key (USER_ID) REFERENCES Users(USER_ID)
);

CREATE TABLE Products (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

DESCRIBE Users;

-- Insert users
INSERT INTO Users (Username, Email)
VALUES 
    ('Alice', 'alice@example.com'),
    ('Bob', 'bob@example.com'),
    ('Charlie', 'charlie@example.com');

-- Insert orders
INSERT INTO Orders (User_ID, Product, Amount, Status)
VALUES
    (1, 'Laptop', 1200.50, 'Completed'),
    (1, 'Mouse', 25.99, 'Pending'),
    (2, 'Keyboard', 45.00, 'Completed'),
    (3, 'Monitor', 200.75, 'Pending'),
    (3, 'Desk', 150.00, 'Completed');


INSERT INTO Products (ProductName, Price)
VALUES 
    ('Laptop', 1200.50),
    ('Mouse', 25.99),
    ('Keyboard', 45.00),
    ('Monitor', 200.75),
    ('Desk', 150.00);

SELECT 
    Users.Username, 
    Orders.Product, 
    Orders.Amount, 
    Orders.Status
FROM Users
RIGHT JOIN Orders ON Users.User_ID = Orders.User_ID;

SELECT 
    Users.Username, 
    SUM(Orders.Amount) AS Total_Spent
FROM Users
JOIN Orders ON Users.User_ID = Orders.User_ID
GROUP BY Users.Username;


SELECT Users.username, Orders.Orders_Id, Orders.Amount
FROM Users
JOIN Orders ON Users.User_ID = Orders.User_ID;


-- : Write a query to group all orders by Status and count the number of orders in each status.

SELECT Status , Count(Product) as 'total' 
FROM Orders
GROUP BY status;

-- Write a query to find all Status groups where the total order amount exceeds $500.

SELECT Status , COUNT(Product) , SUM(Amount) FROM Orders
GROUP BY Status
HAVING SUM(amount) > 500;

SELECT DISTINCT p.product 
FROM Product as p


SELECT Product FROM Orders
UNION
SELECT ProductName FROM Products;

SELECT Users.Username, Products.ProductName
FROM Users
CROSS JOIN Products;
