-- Creating the database
CREATE DATABASE IF NOT EXISTS MovieRentalSystem;
USE MovieRentalSystem;

-- Creating the User table
CREATE TABLE User (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,     -- PK for User
    Username VARCHAR(50) UNIQUE NOT NULL,   
    F_Name VARCHAR(50) NOT NULL,
    L_Name VARCHAR(50) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email_Address VARCHAR(100) UNIQUE NOT NULL,
    Phone_number INT(10)
);

-- Creating the Movie table

CREATE TABLE Movie (
    Movie_ID INT PRIMARY KEY AUTO_INCREMENT,    -- PK for Movie
    Price DECIMAL(10, 2) NOT NULL,
    Main_Actor VARCHAR(100),
    Released_date DATE,
    Description TEXT,
    Length INT, -- Length in minutes
    Movie_Name VARCHAR(255) NOT NULL,
);


-- Creating the Payment table first to resolve FK dependencies
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    CreditCard_Number VARCHAR(20) NOT NULL,
    CVC CHAR(3) NOT NULL,
    Expiration_Date DATE NOT NULL,
    User_ID INT NOT NULL,
    House_Address VARCHAR(255),
    Zipcode VARCHAR(10),
    Country VARCHAR(50),
    Card_Holder_FName VARCHAR(50),
    Card_Holder_LName VARCHAR(50),
    Payment_Date DATE NOT NULL,  
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);


-- Creating the Order table
CREATE TABLE Order (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Payment_ID INT,
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID)
);

-- Creating the Place_Order table (junction table for Order and User)
CREATE TABLE Place_Order (
    Order_ID INT NOT NULL,
    User_ID INT NOT NULL,
    PRIMARY KEY (Order_ID, User_ID),
    FOREIGN KEY (Order_ID) REFERENCES Order(Order_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

CREATE TABLE Borrow_History (
    Borrow_ID INT PRIMARY KEY AUTO_INCREMENT,
    Payment_ID INT,
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID)
);


-- Creating the Order_Contain table (junction table for Order and Movie)
CREATE TABLE Order_Contain (
    Order_ID INT,
    Movie_ID INT,
    PRIMARY KEY (Order_ID, Movie_ID),
    FOREIGN KEY (Order_ID) REFERENCES Order(Order_ID),
    FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID)
);



-- Creating the Wishlist table
CREATE TABLE Wishlist (
    WishlistID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Movie_ID INT NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Movie_ID) REFERENCES Movie(Movie_ID)
);




-- Linking User with Borrow_History for access rights (many-to-many relationship)
CREATE TABLE User_Access_BorrowHistory (
    Borrow_ID INT NOT NULL,
    User_ID INT NOT NULL,
    PRIMARY KEY (Borrow_ID, User_ID),
    FOREIGN KEY (Borrow_ID) REFERENCES Borrow_History(Borrow_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
