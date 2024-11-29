-- Insert into Product
INSERT INTO Product (Product_ID, Warranty_Type, Product_Category, Description, Stock_Quantity, Product_Name, Price, Rating, Date_Added, Refund_ID, Warranty_ID, Order_ID) VALUES
(1, 'Standard', 'Electronics', 'Smartphone with 128GB storage', 100, 'Phone Model A', 599.99, 4.5, '2024-01-01', 1, 1, 1),
(2, 'Extended', 'Electronics', 'High-performance laptop', 50, 'Laptop Model B', 999.99, 4.7, '2024-02-01', 2, 2, 2),
(3, 'Standard', 'Home Appliances', 'Automatic coffee machine', 20, 'Coffee Machine Model C', 199.99, 4.3, '2024-03-05', 3, 3, 3),
(4, 'Premium', 'Electronics', 'Wireless noise-canceling headphones', 30, 'Headphones Model D', 299.99, 4.8, '2024-04-10', 4, 4, 4),
(5, 'Standard', 'Furniture', 'Ergonomic office chair', 15, 'Chair Model E', 149.99, 4.6, '2024-05-15', 5, 5, 5),
(6, 'Extended', 'Electronics', '4K Smart TV 55 inch', 25, 'TV Model F', 899.99, 4.7, '2024-06-20', 6, 6, 6),
(7, 'Standard', 'Home Appliances', 'Smart vacuum cleaner', 40, 'Vacuum Model G', 299.99, 4.4, '2024-07-25', 7, 7, 7),
(8, 'Premium', 'Fitness', 'Treadmill with incline', 10, 'Treadmill Model H', 1199.99, 4.9, '2024-08-30', 8, 8, 8),
(9, 'Standard', 'Electronics', 'Tablet 64GB', 60, 'Tablet Model I', 399.99, 4.2, '2024-09-05', 9, 9, 9),
(10, 'Extended', 'Garden', 'Robotic lawn mower', 5, 'Lawn Mower Model J', 799.99, 4.3, '2024-10-10', 10, 10, 10);

-- Insert into Product_Software
INSERT INTO Product_Software (Software_Category_ID, License_key, Product_ID) VALUES
(1, 'ABC123XYZ', 1),
(2, 'DEF456UVW', 2),
(3, 'GHI789JKL', 3),
(4, 'MNO012PQR', 4),
(5, 'STU345VWX', 5),
(6, 'YZA678BCD', 6),
(7, 'EFG901HIJ', 7),
(8, 'KLM234NOP', 8),
(9, 'QRS567TUV', 9),
(10, 'WXY890ZAB', 10);

-- Insert into Product_Hardware
INSERT INTO Product_Hardware (Hardware_Type, Product_ID) VALUES
('Smartphone', 1),
('Laptop', 2),
('Coffee Machine', 3),
('Headphones', 4),
('Office Chair', 5),
('TV', 6),
('Vacuum Cleaner', 7),
('Treadmill', 8),
('Tablet', 9),
('Lawn Mower', 10);

-- Insert into Warranty
INSERT INTO Warranty (Warranty_ID, Product_ID, Warranty_Type, Duration) VALUES
(1, 1, 'Standard', 24),
(2, 2, 'Extended', 36),
(3, 3, 'Standard', 12),
(4, 4, 'Premium', 48),
(5, 5, 'Standard', 24),
(6, 6, 'Extended', 36),
(7, 7, 'Standard', 24),
(8, 8, 'Premium', 60),
(9, 9, 'Standard', 12),
(10, 10, 'Extended', 36);

-- Insert into Account
INSERT INTO Account (Account_Number, Phone_Number, Account_Password, Account_Username, Citizen_ID, Gender, Join_Date, Date_of_birth, Home_address) VALUES
('ACC001', '1234567890', 'pass123', 'user1', '1234567890123', 'M', '2023-01-01', '1990-01-01', '123 Main St'),
('ACC002', '0987654321', 'pass456', 'user2', '9876543210987', 'F', '2023-02-01', '1992-02-02', '456 Elm St'),
('ACC003', '2345678901', 'pass789', 'user3', '2345678901234', 'M', '2023-03-01', '1985-03-03', '789 Oak St'),
('ACC004', '3456789012', 'pass101', 'user4', '3456789012345', 'F', '2023-04-01', '1989-04-04', '101 Pine St'),
('ACC005', '4567890123', 'pass111', 'user5', '4567890123456', 'M', '2023-05-01', '1987-05-05', '111 Maple St'),
('ACC006', '5678901234', 'pass121', 'user6', '5678901234567', 'F', '2023-06-01', '1993-06-06', '121 Birch St'),
('ACC007', '6789012345', 'pass131', 'user7', '6789012345678', 'M', '2023-07-01', '1986-07-07', '131 Cedar St'),
('ACC008', '7890123456', 'pass141', 'user8', '7890123456789', 'F', '2023-08-01', '1991-08-08', '141 Spruce St'),
('ACC009', '8901234567', 'pass151', 'user9', '8901234567890', 'M', '2023-09-01', '1994-09-09', '151 Willow St'),
('ACC010', '9012345678', 'pass161', 'user10', '9012345678901', 'F', '2023-10-01', '1990-10-10', '161 Chestnut St');
