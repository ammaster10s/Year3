CREATE Database if exist

CREATE TABLE Users (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Product VARCHAR(100),
    Amount DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- Show product brand and name that its name covers the word "te" or "le" in any part of the name.

Select brand as ProductBrand , name as ProductName 
From product WHERE
(name like "%te%" or name like "%le%");

-- Show the month name of paid date and total amount for all payment transaction paid in 2021.

Select monthname(paid_date) as MonthName , sum(amount) as TotalAmount

From payment Where year(Paid_date) =2021
Group by monthname(paid_date);

-- Show the product brand and the maximum price of the product that will expire in 2023, maximum price is greater than 20


Select P.brand as "product brand", max(P.price) From Product as P 
Where year(P.expiry_date) =2023 Having P.Price >20 Group by P.brand;


-- Show the customers's Full name , product name, and total amount for all payment transaction paid by "Mario Maurer" between 1 November to 31 December 2021

Select concat(C.Firstname, " ", C.lastname) as Fullname, Pr.name as ProductName, sum(P.amount) as TotalAmount
From payment as P join Customer C on P.customer_id = C.customer_id
join Product as Pr on Pr.product_id = p.product_id
Where concat(C.Firstname, " ", C.lastname) = "Mario Maurer" and P.paid_date between "2021-11-01" and "2021-12-31"
Group by concat(C.firstname," ", C.lastname), P.

-- Show the product brand and the total paid price of each brand which is greater than 1,180

Select P.brand as "product brand" , Sum(P.amount * Pr.price) as "Total paid price"
from payment p join Product Pr on  Pr.product_id = P.product_id
Group by P.brand
Having Sum(P.amount * Pr.price) >1180;
