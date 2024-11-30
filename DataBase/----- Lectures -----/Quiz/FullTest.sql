Drop database if exists FinalQuiz_Data;
Create database if not exists FinalQuiz_Data;
Use FinalQuiz_Data;
Create table Customer
(
	Customer_ID 	char(3) not null unique,
    FName			varchar(20) not null,
    LName			varchar(20) not null,
    Gender			char(1) not null,
    Constraint 		Primary Key (Customer_ID)
);
Create table Product
(
	Product_ID		char(4) not null unique,
    Brand			varchar(20) not null,
    PName			varchar(50) not null,
    Expiry_date		date,
    Price			int2,
    Constraint  	Primary Key (Product_ID) 
);
Insert into Customer values ("c01", "Mario", "Maurer", "M"),
					("c02", "Nadech", "Kugimiya", "M"),
					("c03", "Ranee", "Campen", "F"),
                    ("c04", "Darika", "hoorne", "F");
                    
insert into Product values ("M001", "Meiji Milk", "Meiji High Protein Milk", "2024-10-25", 15),
					("M002", "Meiji Milk", "Meiji Yoghurt Milk", "2024-11-28", 30),
                    ("B001", "Farmhouse", "Whole Wheat Bread", "2024-11-21", 35),
                    ("B002", "Farmhouse", "Mini Bun Bread", "2024-11-23", 28);
                    
               
DROP TABLE IF EXISTS Payment;

Create table Payment
(
	Customer_Id Char(3) not null,
    Product_Id Char(4) not null,
    Paid_date date ,
    Amount int not null,
    CONSTRAINT Pk Primary key (Customer_ID , Product_Id),
    CONSTRAINT Customer_ID_FK foreign key (Customer_Id) References Customer(Customer_Id),
    CONSTRAINT Product_ID_FK foreign key (Product_Id) References Product(Product_Id) 

);

Describe Payment;


Insert into Payment (Customer_Id, Product_Id ,Paid_date, Amount ) Values 

("c01", "M001", "2024-11-01",22),
("c02", "B001", "2024-09-12",30),
("c02", "M002", "2024-09-12",12),
("c01", "B002", "2024-11-01", 5),
("c02", "M001", "2024-11-15",10),
("c03", "M002", "2024-11-16",11)
;

Select * from Product;

Select Brand as ProductBrand, PName as ProductName From product where PName like "%re%" or "%le%";

Select monthname(paid_date) as MonthName , SUM(amount) as "Total Amount" FROM Payment  Where YEAR(paid_date) = 2024 GROUP by monthname(paid_date);

Select Brand as "Product Brand", max(Price) as "Max Price" From Product Where Month(Expiry_date) = 11 Group by brand Having Max(Price)> 20  Order by Max(price);


Select concat(C.Fname , " " , C.Lname ) as "Full Name", P.PName as "Product Name" , Sum(Pay.amount) as "Total Amount" 
FROM Customer as C
JOIN Payment as Pay ON C.Customer_Id =Pay.Customer_Id 
JOIN Product as P   ON   Pay.Product_ID = P.Product_ID 
Where concat(C.Fname , " " , C.Lname ) = "Mario Maurer" and Paid_date between "2024-11-1" and "2024-12-31"
Group by concat(C.Fname ," " , C.Lname ), P.PName
;





               