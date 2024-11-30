               
DROP TABLE IF EXISTS Payment;

Create table Payment
(
	Customer_Id Char(3) not null,
    Product_Id Char(4) not null,
    Paid_date date ,
    Amount int not null,
    Primary key (Customer_ID , Product_Id),
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

Select * from payment;
               