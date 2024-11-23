DROP DATABASE IF EXISTS TransactionDemo;

CREATE DATABASE TransactionDemo;
USE TransactionDemo;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(50),
    balance DECIMAL(10, 2)
);
SELECT * FROM ACCOUNTS;
INSERT INTO accounts (account_name, balance) VALUES
('Alice', 1000.00),
('Bob', 1500.00),
('Charlie', 2000.00);


/*
 * COMMIT TRANSACTION
 *
 */
 
START TRANSACTION; -- Start Transanction

-- Atom 1
UPDATE accounts SET balance = balance - 100  
WHERE account_name = 'Alice';

-- Atom 2
UPDATE accounts SET balance = balance + 100 
WHERE account_name = 'Bob';

-- Check intermediate state
SELECT * FROM accounts;

-- COMMIT the transaction
COMMIT;

-- Check after the transaction
SELECT * FROM accounts;

/*
 * ROLLBACK TRANSACTION
 *
 */

START TRANSACTION;
UPDATE accounts SET balance = balance - 50 
WHERE account_name = 'Alice';

UPDATE accounts SET balance = balance + 50 
WHERE account_name = 'Bob';

-- Check intermediate state
SELECT * FROM accounts;

-- ROLLBACK the transaction
ROLLBACK;

-- Check after the transaction
SELECT * FROM accounts;



SHOW VARIABLES WHERE Variable_name='autocommit';  -- ON

SET AUTOCOMMIT = 1;

SHOW VARIABLES WHERE Variable_name='autocommit';  -- OFF

SELECT @@SESSION.transaction_isolation;		-- REPEATABLE-READ      Return varibale from server
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT @@SESSION.transaction_isolation;
