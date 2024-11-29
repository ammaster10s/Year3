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
    Rating DECIMAL(2,1),
    Date_Added DATE NOT NULL,
    Refund_ID INT NOT NULL REFERENCES Refund(Refund_ID),
    Warranty_ID INT NOT NULL REFERENCES Warranty(Warranty_ID),
    Order_ID INT NOT NULL REFERENCES Ordering(Order_ID),
    CONSTRAINT Rating CHECK (Rating BETWEEN 0 AND 5)
);

CREATE TABLE Product_Software (
    Software_Category_ID INT NOT NULL,
    License_key VARCHAR(20) NOT NULL,
    Product_ID INT NOT NULL PRIMARY KEY REFERENCES Product(Product_ID)
);

CREATE TABLE Product_Hardware (
    Hardware_Type VARCHAR(50),
    Product_ID INT NOT NULL PRIMARY KEY REFERENCES Product(Product_ID)
);

CREATE TABLE Warranty (
    Warranty_ID INT NOT NULL,
    Product_ID INT NOT NULL REFERENCES Product(Product_ID),
    Warranty_Type VARCHAR(20),
    Duration INT,
    CONSTRAINT pk_Warranty PRIMARY KEY (Warranty_ID, Product_ID)
);

CREATE TABLE Delivery (
    Delivery_ID INT NOT NULL,
    Order_ID INT NOT NULL REFERENCES Ordering(Order_ID),
    Name VARCHAR(20),
    CONSTRAINT pk_Delivery PRIMARY KEY (Delivery_ID, Order_ID)
);

CREATE TABLE Service_Type (
    Delivery_ID INT NOT NULL PRIMARY KEY REFERENCES Delivery(Delivery_ID),
    User_ID INT NOT NULL REFERENCES User_Account(User_ID),
    Service_Name VARCHAR(20)
);

CREATE TABLE Ordering (
    Order_ID INT NOT NULL PRIMARY KEY,
    Purchase_Date DATE NOT NULL,
    User_ID INT NOT NULL REFERENCES User_account(User_ID),
    Tracking_ID INT REFERENCES Tracking_Service(Tracking_ID)
);

CREATE TABLE Refund_Request (
    Refund_ID INT NOT NULL,
    Employee_ID INT NOT NULL REFERENCES Employee_account(Employee_ID),
    Product_ID INT NOT NULL REFERENCES Product(Product_ID),
    Name VARCHAR(50),
    User_ID INT NOT NULL REFERENCES User_account(User_ID),
    CONSTRAINT pk_Refund PRIMARY KEY (Refund_ID, Employee_ID, Product_ID, User_ID)
);

CREATE TABLE Employee_account (
    Employee_ID INT NOT NULL,
    Account_Number VARCHAR(20) NOT NULL REFERENCES Account(Account_Number),
    Position VARCHAR(50),
    Department VARCHAR(50),
    CONSTRAINT pk_Employee PRIMARY KEY (Employee_ID, Account_Number)
);

CREATE TABLE User_Account (
    User_ID INT NOT NULL,
    Account_Number VARCHAR(20) NOT NULL REFERENCES Account(Account_Number),
    MembershipStatus VARCHAR(20),
    CONSTRAINT pk_User PRIMARY KEY (User_ID, Account_Number)
);

CREATE TABLE Referral_Code(
	Refund_ID INT NOT NULL,
    Order_ID INT NOT NULL REFERENCES Ordering(Order_ID),
    User_ID INT NOT NULL REFERENCES User_Account(User_ID),
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
    Email VARCHAR(50),
    CONSTRAINT Gender CHECK (Gender IN ("M", "F"))
);

CREATE TABLE Address(
	Account_Number VARCHAR(20) NOT NULL REFERENCES Account(Account_Number),
    Address VARCHAR(100) NOT NULL,
    CONSTRAINT pk_Account PRIMARY KEY (Account_Number, Address)
);

CREATE TABLE Application(
	Discount_code_id VARCHAR(20) NOT NULL REFERENCES Discount(Discount_code_id),
    Order_ID INT NOT NULL REFERENCES Ordering(Order_ID),
    CONSTRAINT pk_Application PRIMARY KEY (Discount_code_id, Order_ID)
);

CREATE TABLE Receipt(
	Invoice INT NOT NULL,
    Payment_ID INT NOT NULL REFERENCES Payment(Payment_ID),
    User_ID INT NOT NULL REFERENCES User_Account(User_ID),
    Discount_Customer_Type VARCHAR(20),
    Shipping_Price VARCHAR(20),
    Tax_Amount VARCHAR(20),
    Date_and_Time DATETIME NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    PricePerUnit DECIMAL(10,2) NOT NULL,
    Total_Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_Receipt PRIMARY KEY (Invoice, Payment_ID, User_ID)
);

CREATE TABLE Discount(
	Discount_code_id VARCHAR(20) NOT NULL,
    Order_ID INT NOT NULL REFERENCES Ordering(Order_ID),
    User_ID INT NOT NULL REFERENCES User_Account(User_ID),
    Discount_percentage DECIMAL(5,2),
    Expiry_Date DATE NOT NULL,
    Usage_limit INT,
    Discount_code VARCHAR(20),
    Description TEXT,
    Minimum_Purchase_Amount DECIMAL(10,2),
	Discount_Amount DECIMAL(10,2),
    CONSTRAINT pk_Discount PRIMARY KEY (Discount_code_id, Order_ID, User_ID)
);

CREATE TABLE Tracking_Service(
	Tracking_ID INT NOT NULL,
    Order_ID INT NOT NULL REFERENCES Ordering(Order_ID),
    User_ID INT NOT NULL REFERENCES User_Account(User_ID),
    CONSTRAINT pk_Tracking PRIMARY KEY (Tracking_ID, Order_ID, User_ID)
);

CREATE TABLE Payment(
	Payment_ID INT NOT NULL PRIMARY KEY,
    Card_ID INT NOT NULL REFERENCES Payment_Info(Card_ID),
    User_ID INT NOT NULL REFERENCES User_Account(User_ID)
);

CREATE TABLE Payment_Info(
	Card_ID INT NOT NULL PRIMARY KEY,
    CVC INT NOT NULL,
    Exp_Date DATE NOT NULL,
    User_ID INT NOT NULL REFERENCES User_Account(User_ID)
);

CREATE TABLE Installment(
	Card_ID INT NOT NULL PRIMARY KEY REFERENCES Payment_Info(Card_ID),
    Interest_Rate DECIMAL(5,2)
);

CREATE TABLE Transfer(
	Card_ID INT NOT NULL PRIMARY KEY REFERENCES Payment_Info(Card_ID),
    Transfer_No INT NOT NULL
);