use `cust`;

show DATABASES;

show TABLES;

DESCRIBE account;

DESCRIBE transaction;

-- Store procedures to deposit and withdraw money from an account

DELIMITER //

DROP PROCEDURE IF EXISTS WidthdrawMoney;

CREATE Procedure WidthdrawMoney (accid INT, amount FLOAT)
BEGIN
    DECLARE existing_bal FLOAT;
    SELECT bal into existing_bal from `account` where ID = accid ;
    
   IF existing_bal IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Account not found';
    ELSEIF amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid amount';
    ELSE

        IF existing_bal < amount THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient balance';
        ELSE

          UPDATE `account` 
          SET bal = bal - amount 
          WHERE ID = accid;

          INSERT INTO `transaction` (type, amount, date, accid) 
          VALUES ('W', amount, NOW(), accid);
        END IF;
    END IF;
END //

DELIMITER;

DELIMITER //

DROP PROCEDURE IF EXISTS DepositMoney;

CREATE PROCEDURE DepositMoney (accid INT, amount FLOAT)
BEGIN
    DECLARE existing_bal FLOAT;

    -- Check if account exists and get the current balance
    SELECT bal INTO existing_bal 
    FROM `account` 
    WHERE ID = accid;

    IF existing_bal IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Account not found';
    ELSEIF amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid amount';
    ELSE

          UPDATE `account` 
          SET bal = bal + amount 
          WHERE ID = accid;

          INSERT INTO `transaction` (type, amount, date, accid) 
          VALUES ('D', amount, NOW(), accid);
          
    END IF;
END //

DELIMITER;

-- Test the procedures
CALL DepositMoney (105, 5000);

CALL WidthdrawMoney (105, 10000);

Select * from transaction;

Select * from account;

DELETE FROM transaction;

Select a.*, t.* FROM account a JOIN transaction t ON a.ID = t.accid;

-- Trigger to prevent updating transactions
DELIMITER //

CREATE TRIGGER prevent_transaction_update
BEFORE UPDATE ON Transaction
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Updates to existing transactions are not allowed';
END;//

-- Trigger to prevent deleting transactions
CREATE TRIGGER prevent_transaction_delete
BEFORE DELETE ON Transaction
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Deletion of transactions is not allowed';
END;//

DELIMITER;

--Write a Trigger to check balance of money before insert.
-- If balance of money is not enough to Withdraw, please alert message “Not
-- enough money” (Hint: Assign to a variable), however, if the balance is sufficient,
-- insert the record and update new balance to “bal” column.

DELIMITER //

CREATE TRIGGER check_balance
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN
    DECLARE existing_bal FLOAT;
    SELECT bal INTO existing_bal FROM `account` WHERE ID = NEW.accid;

    IF NEW.type = 'W' THEN
        IF existing_bal < NEW.amount THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Not enough money';
        ELSE
          
            UPDATE `account`
            SET bal = bal - NEW.amount
            WHERE ID = NEW.accid;
        END IF;
    ELSEIF NEW.type = 'D' THEN
       
        UPDATE `account`
        SET bal = bal + NEW.amount
        WHERE ID = NEW.accid;
    END IF;
END//

DELIMITER;