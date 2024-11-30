Use FinalQuiz_Data;


Select concat(C.Fname , " " , C.Lname ) as "Full Name", P.PName as "Product Name" , Sum(Pay.amount) as "Total Amount" 
FROM Customer as C
JOIN Payment as Pay ON C.Customer_Id =Pay.Customer_Id 
JOIN Product as P   ON   Pay.Product_ID = P.Product_ID 
Where FName ="Mario" and LName = "Maurer" and Paid_date between "2024-11-1" and "2024-12-31"
Group by concat(C.Fname + " " + C.Lname ), P.PName
;

