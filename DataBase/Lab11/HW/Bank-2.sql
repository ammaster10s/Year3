-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2020 at 05:36 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

START TRANSACTION;

SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;

--
-- Database: `cust`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--
DROP DATABASE IF EXISTS `cust`;

CREATE DATABASE IF NOT EXISTS `cust`;

USE `cust`;

CREATE TABLE `account` (
    `ID` int(11) NOT NULL,
    `No.` varchar(20) DEFAULT NULL,
    `Name` varchar(200) DEFAULT NULL,
    `CreditLimit` double DEFAULT NULL,
    `bal` float DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO
    `account` (
        `ID`,
        `No.`,
        `Name`,
        `CreditLimit`,
        `bal`
    )
VALUES (
        105,
        'N01',
        'John Morris',
        20000,
        13000
    );

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
    `id` int(11) NOT NULL,
    `type` char(1) CHARACTER SET utf8mb4 DEFAULT NULL,
    `amount` float DEFAULT NULL,
    `date` datetime DEFAULT NULL,
    `accid` int(11) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account` ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction` ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 16;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;

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
          -- Update balance
          UPDATE `account` 
          SET bal = bal - amount 
          WHERE ID = accid;

          -- Log the transaction
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

        
        -- Update balance
          UPDATE `account` 
          SET bal = bal + amount 
          WHERE ID = accid;

          -- Log the transaction
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
DELIMITER ;

--Write a Trigger to check balance of money before insert.
-- If balance of money is not enough to Withdraw, please alert message “Not
-- enough money” (Hint: Assign to a variable), however, if the balance is sufficient,
-- insert the record and update new balance to “bal” column.

DELIMITER //
CREATE TRIGGER check_balance
BEFORE INSERT ON Transaction
FOR EACH ROW
BEGIN
    DECLARE existing_bal FLOAT;
    SELECT bal INTO existing_bal FROM `account` WHERE ID = NEW.accid;
    
    IF NEW.type = 'W' AND existing_bal < NEW.amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough money';
    ELSE
        UPDATE `account`
        SET bal = bal - NEW.amount
        WHERE ID = NEW.accid;
    END IF;
END;//

DELIMITER ;