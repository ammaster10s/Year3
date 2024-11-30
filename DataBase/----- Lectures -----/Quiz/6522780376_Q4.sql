Use FinalQuiz_Data;

Select Brand as "Product Brand", max(Price) as "Max Price" From Product 
Where Month(Expiry_date) = 11 and Year(Expiry_date) = 2024
Group by brand 
Having Max(Price)> 20  
Order by Max(price);