DROP DATABASE IF EXISTS lab12;
CREATE DATABASE If not EXISTs lab12;
USE lab12;
-- Create table and insert data
CREATE TABLE Users ( UserId INT, UserName VARCHAR(50), Password VARCHAR(50) );

INSERT INTO Users VALUES (1, 'John', 'password123'), (2, 'Jane', 'secure456');

SELECT * FROM Users WHERE UserId = 105 OR 1=1;


CREATE TABLE Products ( ProductID INT, ProductName VARCHAR(100));
INSERT INTO Products VALUES (1, 'Laptop'), (2, 'Smartphone');

-- Create user and grant privileges
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON lab12.* TO 'readonly_user'@'localhost';

-- List users on server
SELECT user FROM mysql.user;

-- Display privileges of an user
SHOW GRANTS FOR 'readonly_user'@'localhost';

GRANT SELECT,INSERT ON lab12.* TO 'readonly_user'@'localhost';
-- Display privileges of an user
SHOW GRANTS FOR 'readonly_user'@'localhost';


REVOKE SELECT, INSERT ON lab12.* FROM 'readonly_user'@'localhost';

DROP USER 'readonly_user'@'localhost';

-- User hashing

-- MD5 Hash
SELECT MD5('password123');

-- SHA1 Hash
SELECT SHA1('password123');

-- AES encryption
SELECT AES_ENCRYPT('password123', 'secret');

-- AES decryption
SELECT AES_DECRYPT(AES_ENCRYPT('1231313', 'SecretKey'), 'SecretKey');

-- View Concept

-- Create table and insert data
CREATE TABLE Employees (
EmployeeID INT,
Name VARCHAR(50),
Salary DECIMAL(10, 2)
);
INSERT INTO Employees VALUES (1, 'Alice', 5000), (2, 'Bob', 4000);

-- Create a view
CREATE VIEW SecureView AS
SELECT EmployeeID, Name FROM Employees
WHERE Salary > 4500 ;
-- Query the view
SELECT * FROM SecureView;



-- Practice
DROP TABLE Customers;
CREATE TABLE Customers (
    ID INT,
    Name VARCHAR(50),
    AGE INT,
    Address VARCHAR(100),
    Salary VARBINARY(100)
);
INSERT INTO Customers VALUES 
    (1,'John',36,'Austrailia', AES_ENCRYPT(3000, SHA1('1123'))),
    (2,'Kane',25,'Africa', AES_ENCRYPT(1500, SHA1('1123'))),
    (3,'Neil',23,'Korea', AES_ENCRYPT(2000, SHA1('1123'))),
    (4,'Rohit',30,'India', AES_ENCRYPT(2500, SHA1('1123'))),
    (5,'Rahul',28,'India', AES_ENCRYPT(3500, SHA1('1123'))),
    (6,'Raj',40,'India', AES_ENCRYPT(2000, SHA1('1123'))),
    (7,'Ravi',35,'India', AES_ENCRYPT(3000, SHA1('1123')));

DROP VIEW Secure_salary;
CREATE VIEW Secure_salary as SELECT ID, Name, AES_DECRYPT(Salary, SHA1('1123')) FROM Customers WHERE AES_DECRYPT(Salary, SHA1('1123')) > 1500;

SELECT * FROM Customers;
SELECT * FROM Secure_salary;