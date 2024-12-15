use Lab11;

-- Exercise 1.1
SELECT
    ABS(-25) AS Absolute_Value,
    PI() AS Pi_Value,
    POW(2, 5) AS Power_Calculation;

-- Exercise 1.2
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO
    products (
        product_id,
        product_name,
        price
    )
VALUES (1, 'Laptop', 800.00),
    (2, 'Mouse', 25.00),
    (3, 'Keyboard', 50.00),
    (4, 'Monitor', 200.00),
    (5, 'Printer', 120.00);

SELECT
    MIN(price) AS Minimum_Price,
    MAX(price) AS Maximum_Price,
    AVG(price) AS Average_Price
FROM products;

-- Exercise 1.3
SELECT
    LENGTH('DatabaseProgramming') AS String_Length,
    UPPER('DatabaseProgramming') AS Uppercase_String,
    REVERSE('DatabaseProgramming') AS Reversed_String;

-- Exercise 1.4

SELECT
    NOW() AS Current_DateTime,
    YEAR('2023-11-14') AS Year_Extracted,
    DATEDIFF('2024-01-01', '2023-11-14') AS Days_Between,
    DATEDIFF(now(), '2023-11-14') AS Days_from_now;

-- Exercise 1.5

SELECT
    VERSION() AS MySQL_Version,
    DATABASE() AS Current_Database,
    USER () AS CurrentUser;

-- Exercise 2.1 Square of X numbers

-- DELIMITER Change ";" to "//" Temporary
DELIMITER / /

CREATE FUNCTION square(num INT)
RETURNs INT
DETERMINISTIC
BEGIN
	RETURN num * num;
END //

DELIMITER;

SELECT square (5) as Square_of_5, square (10) AS square_of_10;
-- 25 and 100
-- Exercise 2.2 Calculate discount
DELIMITER / /

CREATE FUNCTION calculate_discount(price DECIMAL(10,2), discount DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN price - (price * discount / 100);
END //

DELIMITER;
-- Test the function
SELECT
    calculate_discount (250, 10) AS Price_after_10_percent_discount,
    calculate_discount (250, 15) AS Price_after_15_percent_discount;

-- Exercise 2.3 Check if a Number is Even or Odd

DELIMITER / /

CREATE FUNCTION is_even(num INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
RETURN num % 2 = 0;
END //

DELIMITER;
-- Test the function
SELECT is_even (4) AS Is_4_Even, is_even (7) AS Is_7_Even;

-- Exercise 2.4 Determine Customer Category Based on Purchase Amount

DELIMITER / /

CREATE FUNCTION customer_category(purchase_amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE category VARCHAR(20);
	IF purchase_amount >= 500 THEN
		SET category = 'Premium';
	ELSEIF purchase_amount BETWEEN 100 AND 499 THEN
		SET category = 'Standard';
	ELSE
		SET category = 'Basic';
	END IF;
	RETURN category;
END //

DELIMITER;

-- Test the function
SELECT
    customer_category (600) AS Category_600,
    customer_category (300) AS Category_300,
    customer_category (50) AS Category_50;

-- Exercise 3.1 Simple stored proceduce

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO
    employees (name, position, salary)
VALUES (
        'Alice',
        'Developer',
        55000.00
    ),
    ('Bob', 'Manager', 75000.00),
    (
        'Charlie',
        'Analyst',
        60000.00
    ),
    (
        'David',
        'Developer',
        67000.00
    ),
    ('Eve', 'Manager', 80000.00);

DELIMITER / /

CREATE PROCEDURE get_all_employees()
BEGIN
SELECT * FROM employees;
END;

/ /

DELIMITER;

CALL get_all_employees ();

-- Exercise 3.2

DROP PROCEDURE if EXISTS get_employee_by_position;

DELIMITER / /

CREATE PROCEDURE get_employee_by_position(IN emp_position VARCHAR(50))
BEGIN 
	SELECT * FROM employees WHERE position = emp_position;
END;

/ /

DELIMITER;

CALL get_employee_by_position ('Developer');

-- Exercise 3.3 Stored Procedure with Output Parameters

DELIMITER / /

CREATE PROCEDURE get_total_salary(OUT total_salary DECIMAL(10, 2))
BEGIN
    SELECT SUM(salary) INTO total_salary FROM employees;
END //

DELIMITER;

CALL get_total_salary (@total_salary);

SELECT @total_salary AS Total_Salary;

-- Exercsie 3.4 Store procedure with Input and output parameters

DELIMITER / /

CREATE PROCEDURE get_highest_paid_employee( IN emp_position VARCHAR(50), OUT emp_name VARCHAR(50), OUT emp_salary DECIMAL(10, 2))
BEGIN
    SELECT name, salary INTO emp_name, emp_salary FROM employees WHERE position = emp_position ORDER BY salary DESC LIMIT 1;
END //

DELIMITER;

CALL get_highest_paid_employee ( 'Developer', @emp_name, @emp_salary );

SELECT @emp_name AS Highest_Paid_Employee, @emp_salary AS Salary;

-- Exercise 3.5 Stored procedure with Conditional Logic

DELIMITER / /

CREATE PROCEDURE check_salary_threshold(IN emp_id INT, IN threshold DECIMAL(10, 2))
BEGIN 
    DECLARE emp_salary DECIMAL(10, 2);
    SELECT salary INTO emp_salary FROM employees WHERE id = emp_id;

    IF emp_salary > threshold THEN
        SELECT CONCAT('Employee with ID ', emp_id, ' has a salary above the threshold') AS Message;
    ELSE
        SELECT CONCAT('Employee with ID ', emp_id, ' has a salary below the threshold') AS Message;
    END IF;
END //

DELIMITER;

CALL check_salary_threshold (1, 3000);

-- Triggers

-- Exercise 4.1 Update a column before new row is inserted

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    position VARCHAR(50),
    created_at TIMESTAMP
);

DROP TRIGGER IF EXISTS set_created_at_2;

DELIMITER //

CREATE TRIGGER set_created_at_2 
BEFORE INSERT ON employees
FOR EACH ROW 
BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END //

DELIMITER ;

INSERT INTO employees (name, position) VALUES ('Alice', 'Developer');

SELECT * FROM employees;


-- Exercise 4.2 Add a log entry after insert data into the table

Create table orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    amount DECIMAL(10, 2)
);

Create table order_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    message Varchar(100)
    
);

DELIMITER //

CREATE TRIGGER log_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_logs (order_id, message ) 
    VALUES (NEW.order_id, CONCAT('Order for ', NEW.product_name, ' was placed'));
END //

DELIMITER ;

INSERT INTO orders (product_name, amount) VALUES ('Laptop', 999.99);
SELECT * from order_logs;


-- Exercse 4.3 Keep track of any changes in a column by updating another column

DROP table if exists products;
CREATE table products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2),
    last_updated TIMESTAMP
);

DELIMITER //
CREATE TRIGGER update_last_modified 
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN 
    IF NEW.price != Old.price THEN
        SET NEW.last_updated = CURRENT_TIMESTAMP;
    END IF;

END //
DELIMITER ;

INSERT INTO products (product_name, price) VALUES ('Phone', 299.99);

UPDATE products SET price = 349.99 WHERE product_id = 1;
SELECT * from Products;


-- Exercise 4.4 Log a message whenever a row is deleted.

DROP table if exists customers;
CREATE table customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50)
);

CREATE table deletion_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    message VARCHAR(100)
);

DROP Trigger if EXISTS log_deletion;
DELIMITER //
Create Trigger log_deletion
after DELETE ON customers
for each ROW
begin INSERT into deletion_logs(message) values (CONCAT('Customer '
, OLD.customer_name, ' was deleted'));
end //
DELIMITER ;

INSERT INTO customers (customer_name) VALUES ('John Doe');
DELETE FROM customers WHERE customer_name = "John Doe";
SELECT * from deletion_logs;

