Use FinalQuiz_Data;


Select P.Brand as "Product Brand" , Sum(Pay.amount * P.Price) as "Total Paid price" From Product as P
JOIN Payment as Pay on P.Product_Id = Pay.Product_Id
GROUP by P.Brand
Having Sum(Pay.amount * P.Price) > 1180;