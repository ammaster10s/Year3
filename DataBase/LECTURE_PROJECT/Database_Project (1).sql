Drop database if exists Database_Project;
Create database if not exists Database_Project;
use Database_Project;

CREATE TABLE Product (
    Product_ID INT NOT NULL PRIMARY KEY,
    Warranty_Type VARCHAR(20),
    Product_Category VARCHAR(20),
    Description TEXT,
    Stock_Quantity INT NOT NULL,
    Product_Name VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Rating DECIMAL(1,1),
    Date_Added DATE NOT NULL,
    Refund_ID INT NOT NULL,
    Warranty_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    CONSTRAINT Rating CHECK (Rating BETWEEN 0 AND 5),
    UNIQUE (Product_ID)
);


CREATE TABLE Product_Software (
    Software_Category_ID INT NOT NULL,
    License_key VARCHAR(20) NOT NULL,
    Product_ID INT NOT NULL,
    PRIMARY KEY (Product_ID)
);


CREATE TABLE Product_Hardware (
    Hardware_Type VARCHAR(20),
    Product_ID INT NOT NULL,
    PRIMARY KEY (Product_ID)
);


CREATE TABLE Warranty (
    Warranty_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Warranty_Type VARCHAR(20),
    Duration INT,
    PRIMARY KEY (Warranty_ID, Product_ID),
    UNIQUE (Warranty_ID)
);


CREATE TABLE Delivery (
    Delivery_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    Name VARCHAR(20),  
    CONSTRAINT pk_Delivery PRIMARY KEY (Delivery_ID, Order_ID),
    UNIQUE (Delivery_ID)
);


CREATE TABLE Service_Type (
    Delivery_ID INT NOT NULL,
    User_ID INT NOT NULL,
    Service_Name VARCHAR(20),  
    PRIMARY KEY (Delivery_ID)    
);


CREATE TABLE Ordering (
    Order_ID INT NOT NULL PRIMARY KEY,
    Purchase_Date DATE NOT NULL,
    User_ID INT NOT NULL,
    Tracking_ID INT,
    UNIQUE (Order_ID)
);


CREATE TABLE Refund_Request (
    Refund_ID INT NOT NULL,
    Employee_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Name VARCHAR(50),
    User_ID INT NOT NULL,
    CONSTRAINT pk_Refund PRIMARY KEY (Refund_ID, Employee_ID, Product_ID, User_ID),
    UNIQUE (Refund_ID)
);


CREATE TABLE Employee_account (
    Employee_ID INT NOT NULL,
    Account_Number VARCHAR(20) NOT NULL,
    Position VARCHAR(50),
    Department VARCHAR(50),
    CONSTRAINT pk_Employee PRIMARY KEY (Employee_ID, Account_Number),
     UNIQUE (Employee_ID)
);


CREATE TABLE User_Account (
    User_ID INT NOT NULL,
    Account_Number VARCHAR(20) NOT NULL,
    MembershipStatus VARCHAR(20),
    CONSTRAINT pk_User PRIMARY KEY (User_ID, Account_Number),
    UNIQUE (User_ID)
);

CREATE TABLE Referral_Code (
    Refund_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    User_ID INT NOT NULL,
    CONSTRAINT pk_Referral PRIMARY KEY (Refund_ID, Order_ID, User_ID)
);


CREATE TABLE Account (
    Account_Number VARCHAR(20) NOT NULL PRIMARY KEY,
    Phone_Number VARCHAR(10),
    Account_Password VARCHAR(50) NOT NULL,
    Account_Username VARCHAR(50) NOT NULL,
    Citizen_ID VARCHAR(13) NOT NULL,
    Gender VARCHAR(1),
    Join_Date DATE NOT NULL,
    Date_of_birth DATE NOT NULL,
    Home_address VARCHAR(100) NOT NULL,
    CONSTRAINT Gender CHECK (Gender IN ('M', 'F')),
    UNIQUE (Account_Number)
);


CREATE TABLE Address (
    Account_Number VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    CONSTRAINT pk_Account PRIMARY KEY (Account_Number, Address)
);


CREATE TABLE Application (
    Discount_code_id VARCHAR(20) NOT NULL,
    Order_ID INT NOT NULL,
    CONSTRAINT pk_Application PRIMARY KEY (Discount_code_id, Order_ID)
);


CREATE TABLE Receipt (
    Invoice INT NOT NULL,
    Payment_ID INT NOT NULL,
    User_ID INT NOT NULL,
    Discount_Customer_Type VARCHAR(20),
    Shipping_Price DECIMAL(10,2),
    Tax_Amount DECIMAL(10,2),
    Date_and_Time DATETIME NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    PricePerUnit DECIMAL(10,2) NOT NULL,
    Total_Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_Receipt PRIMARY KEY (Invoice)
);



CREATE TABLE Discount (
    Discount_code_id VARCHAR(20) NOT NULL,
    Order_ID INT NOT NULL,
    User_ID INT NOT NULL,
    Discount_percentage DECIMAL(5,2),
    Expiry_Date DATE NOT NULL,
    Usage_limit INT,
    Discount_code VARCHAR(20),
    Description TEXT,
    Minimum_Purchase_Amount DECIMAL(10,2),
    Discount_Amount DECIMAL(10,2),
    CONSTRAINT pk_Discount PRIMARY KEY (Discount_code_id),
    UNIQUE (Discount_code_id)
);



CREATE TABLE Tracking_Service (
    Tracking_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    User_ID INT NOT NULL,
    CONSTRAINT pk_Tracking PRIMARY KEY (Tracking_ID, Order_ID, User_ID),
    UNIQUE (Tracking_ID)
);


CREATE TABLE Payment (
    Payment_ID INT NOT NULL PRIMARY KEY,
    Card_ID INT NOT NULL,
    User_ID INT NOT NULL,
    UNIQUE (Payment_ID)
);


CREATE TABLE Payment_Info (
    Card_ID INT NOT NULL PRIMARY KEY,
    CVC INT NOT NULL,
    Exp_Date DATE NOT NULL,
    User_ID INT NOT NULL,
    UNIQUE (Card_ID)
);


CREATE TABLE Installment (
    Card_ID INT NOT NULL,
    Interest_Rate DECIMAL(5,2),
    CONSTRAINT pk_Installment PRIMARY KEY (Card_ID)
);


CREATE TABLE Transfer (
    Card_ID INT NOT NULL,
    Transfer_No INT NOT NULL,
    CONSTRAINT pk_Transfer PRIMARY KEY (Card_ID)
);

ALTER TABLE Product
ADD CONSTRAINT fk_Product_Refund
FOREIGN KEY (Refund_ID) REFERENCES Refund_Request(Refund_ID),
ADD CONSTRAINT fk_Product_Warranty
FOREIGN KEY (Warranty_ID) REFERENCES Warranty(Warranty_ID),
ADD CONSTRAINT fk_Product_Order
FOREIGN KEY (Order_ID) REFERENCES Ordering(Order_ID);


ALTER TABLE Product_Software
ADD CONSTRAINT fk_Product_Software_Product
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID);

ALTER TABLE Product_Hardware
ADD CONSTRAINT fk_Product_Hardware_Product
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID);

ALTER TABLE Warranty
ADD CONSTRAINT fk_Warranty_Product
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID);

ALTER TABLE Delivery
ADD CONSTRAINT fk_Delivery_Order
FOREIGN KEY (Order_ID) REFERENCES Ordering(Order_ID);

ALTER TABLE Service_Type
ADD CONSTRAINT fk_Service_Type_Delivery
FOREIGN KEY (Delivery_ID) REFERENCES Delivery(Delivery_ID),
ADD CONSTRAINT fk_Service_Type_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Ordering
ADD CONSTRAINT fk_Ordering_User
FOREIGN KEY (User_ID) REFERENCES User_account(User_ID),
ADD CONSTRAINT fk_Ordering_Tracking
FOREIGN KEY (Tracking_ID) REFERENCES Tracking_Service(Tracking_ID);

ALTER TABLE Refund_Request
ADD CONSTRAINT fk_Refund_Request_Employee
FOREIGN KEY (Employee_ID) REFERENCES Employee_account(Employee_ID),
ADD CONSTRAINT fk_Refund_Request_Product
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
ADD CONSTRAINT fk_Refund_Request_User
FOREIGN KEY (User_ID) REFERENCES User_account(User_ID);

ALTER TABLE Employee_account
  ADD CONSTRAINT fk_Employee_account_Account FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number);
  
ALTER TABLE User_account
  ADD CONSTRAINT fk_User_account_Account FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number);

ALTER TABLE Referral_Code
ADD CONSTRAINT fk_Referral_Code_Order
FOREIGN KEY (Order_ID) REFERENCES Ordering(Order_ID),
ADD CONSTRAINT fk_Referral_Code_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Address
ADD CONSTRAINT fk_Address_Account
FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number);

ALTER TABLE Application
ADD CONSTRAINT fk_Application_Discount
FOREIGN KEY (Discount_code_id) REFERENCES Discount(Discount_code_id),
ADD CONSTRAINT fk_Application_Order
FOREIGN KEY (Order_ID) REFERENCES Ordering(Order_ID);

ALTER TABLE Receipt
ADD CONSTRAINT fk_Receipt_Payment
FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
ADD CONSTRAINT fk_Receipt_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Discount
ADD CONSTRAINT fk_Discount_Order
FOREIGN KEY (Order_ID) REFERENCES Ordering(Order_ID),
ADD CONSTRAINT fk_Discount_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Tracking_Service
ADD CONSTRAINT fk_Tracking_Service_Order
FOREIGN KEY (Order_ID) REFERENCES Ordering(Order_ID),
ADD CONSTRAINT fk_Tracking_Service_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Payment
ADD CONSTRAINT fk_Payment_Card
FOREIGN KEY (Card_ID) REFERENCES Payment_Info(Card_ID),
ADD CONSTRAINT fk_Payment_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Payment_Info
ADD CONSTRAINT fk_Payment_Info_User
FOREIGN KEY (User_ID) REFERENCES User_Account(User_ID);

ALTER TABLE Installment
ADD CONSTRAINT fk_Installment_Card
FOREIGN KEY (Card_ID) REFERENCES Payment_Info(Card_ID);

ALTER TABLE Transfer
ADD CONSTRAINT fk_Transfer_Card
FOREIGN KEY (Card_ID) REFERENCES Payment_Info(Card_ID);

