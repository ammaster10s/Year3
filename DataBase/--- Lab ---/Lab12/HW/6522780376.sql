use DB_LAB12;
---Bullet Point 1---
DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'staff'@'localhost';
DROP USER IF EXISTS 'customer'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin-user';
GRANT ALL PRIVILEGES ON DB_LAB12.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'staff'@'localhost' IDENTIFIED BY 'staff-user';
GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LAB12.* TO 'staff'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'customer'@'localhost' IDENTIFIED BY 'customer-user';
GRANT SELECT ON DB_LAB12.* TO 'customer'@'localhost';
FLUSH PRIVILEGES;

---Bullet Point 2---
ALTER TABLE account MODIFY `No.` VARBINARY(80);
ALTER TABLE account MODIFY `Name` VARBINARY(80);

UPDATE account
SET `No.` = AES_ENCRYPT(`No.`, 'number'),
    `Name` = AES_ENCRYPT(`Name`, 'name');

DELIMITER $$
CREATE TRIGGER encrypt_before_insertion
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
    SET NEW.`No.` = AES_ENCRYPT(NEW.`No.`, 'number');
    SET NEW.`Name` = AES_ENCRYPT(NEW.`Name`, 'name');
END$$
DELIMITER ;

INSERT INTO `account` (`ID`, `No.`, `Name`, `CreditLimit`, `bal`) VALUES
(101, '123456789', 'TestTest', 1000000, 1000000);

---Bullet Point 3---
CREATE VIEW account_view AS
SELECT `No.` AS `Account No.`, `Name`, `bal` AS `Balance` FROM `account`;

--Bullet Point 4 In LoginForm.php & DisplayPage.php---

