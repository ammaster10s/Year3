use Database_Project;

-- Basic Queries

-- Boom Section
-- 1
-- Count the number of products in each product category with average rating above 4.0:

SELECT
    Product_Category,
    COUNT(*) as Total_Products,
    AVG(Rating) as Avg_Rating
FROM Product
WHERE
    Rating > 4.0
GROUP BY
    Product_Category;

-- 2
-- List products with stock quantity less than 30 and price above 50000:
SELECT
    Product_Name,
    Stock_Quantity,
    Price
FROM Product
WHERE
    Stock_Quantity < 30
    AND Price > 50000
ORDER BY Price DESC;

-- 3
-- Calculate average product ratings and total stock by category
SELECT
    Product_Category,
    ROUND(AVG(Rating), 2) AS AVG_Rating,
    SUM(Stock_Quantity) AS Total_Stock,
    COUNT(*) AS Total_Products
FROM Product
GROUP BY
    Product_Category
HAVING
    AVG(Rating) >= 4.0
ORDER BY AVG_Rating DESC;


-- 4
-- Calculate average order total by customer gender:
SELECT A.Gender, AVG(R.Total_Price) as Avg_Order_Value
FROM
    Account as A
    JOIN User_Account as UA ON A.Account_Number = UA.Account_Number
    JOIN Receipt as R ON UA.User_ID = R.User_ID
GROUP BY
    A.Gender;

-- Don
-- 5
-- Identify Customers with Multiple Refund Requests
SELECT 
    User_ID, 
    COUNT(refund_id) AS Total_Refunds 
FROM 
    Refund_Request 
GROUP BY 
    User_ID 
HAVING 
	Total_Refunds > 2;

-- 6
-- List Frequent Buyers

SELECT 
    User_ID, 
    COUNT(Order_ID) AS Total_Orders 
FROM 
    Ordering 
GROUP BY 
    User_ID 
ORDER BY 
    Total_Orders DESC 
LIMIT 5;

-- 7
-- List Active Discounts
SELECT 
    Discount_code_id, 
    Discount_percentage, 
    Expiry_Date 
FROM 
    Discount 
WHERE 
    Expiry_Date > CURDATE();

-- 8
-- Products with Low Stock    
SELECT 
    Product_ID, 
    Product_Name, 
    Stock_Quantity 
FROM 
    Product 
WHERE 
    Stock_Quantity < 10 
ORDER BY 
    Product_ID ASC;

-- First
-- 9
-- list all user with memberstatus is gold
SELECT a.account_username, a.email, ua.MembershipStatus 
FROM account  a
INNER JOIN User_account ua
ON a.account_number = ua.account_number 
WHERE 
ua.MembershipStatus = 'Gold';

-- 10
-- Show Delivery Methods Used in January 2024
SELECT d.name AS Delivery_Type, COUNT(d.delivery_id) AS Usage_Count 
FROM delivery d
INNER JOIN ordering o
ON d.order_id = o.order_id 
WHERE o.purchase_date BETWEEN '2024-01-01' AND '2024-01-31' 
GROUP BY d.name;

-- 11
-- Show the most use delivery
SELECT d.name AS Delivery_Type, COUNT(d.delivery_id) AS Usage_Count 
FROM delivery d
GROUP BY d.name 
ORDER BY Usage_Count DESC 
LIMIT 1;

-- 12
-- Show most order product
SELECT Product_Name, Price 
FROM product 
ORDER BY Price DESC 
LIMIT 1;

-- JJ
-- 13 
-- Show the users who have used a discount on an order 
SELECT u.User_ID, u.Account_Number, d.Discount_code_id, d.Discount_percentage
FROM User_Account u
JOIN Discount d
ON u.User_ID = d.User_ID
WHERE d.Expiry_Date > CURDATE();



-- 14 
-- Show the Warannty_type that has duration more than 1 year.

Select Warranty_ID , Warranty_Type 
FROM  Warranty
where Duration >= 12;

-- 15
-- Show the product that get added into database before february
Select Product_Name , Date_Added 
FROM Product
WHERE Date_Added <= "2024-02-01"
ORDER BY Date_Added ASC;

-- 16
-- Show the card that expire after 2025
Select card_id , exp_date 
From Payment_info 
where year(exp_date) > 2025
ORDER BY year(exp_date) ASC ;

-- Jam
-- 17
-- product with low stock, less than 10 remaining. BASIC QUERY
SELECT Product_Name, Stock_Quantity
FROM Product
WHERE Stock_Quantity < 10;

-- 18
-- calculate potential saving from a still active discount BASIC QUERY
SELECT Discount_code, Description, Discount_percentage, Minimum_Purchase_Amount, 
       ROUND((Minimum_Purchase_Amount * (Discount_percentage / 100)), 2) AS Potential_Savings
FROM Discount 
WHERE Expiry_Date > CURDATE();

-- 19
--  the top-rated and lowest-rated products BASIC QUERY
SELECT Product_Name, Rating
FROM Product
WHERE Rating = (SELECT MAX(Rating) FROM Product)
   OR Rating = (SELECT MIN(Rating) FROM Product);

-- 20
-- Products imported within the past 9 months
SELECT Product_Name, Date_Added, Stock_Quantity FROM Product 
WHERE Date_Added >= DATE_SUB(CURDATE(), INTERVAL 9 MONTH) ORDER BY Date_Added DESC;

-- Noel
-- 21
-- Display Account_Number that has Male gender and last digit is 1
SELECT account_number, gender FROM Account WHERE Gender = 'M' and account_number LIKE "%1";

-- 22
-- List Employee Account that has IT as a department
SELECT Employee_ID, Account_Number, Department FROM Employee_Account WHERE Department = "IT";

-- 23
-- List License Key that last digit is 4
SELECT Product_ID, License_Key FROM Product_Software WHERE License_Key LIKE "%4";

-- 24
-- List discount that description ends with "offer" and "Sale"
SELECT discount_code_id, description FROM discount WHERE description LIKE "% offer" OR description LIKE "% sale";






-- Advanced Queries
-- 1
-- Find all products and their warranties/refunds status
SELECT 
    P.Product_Name,
    'Has Warranty' AS Status
FROM Product AS P
JOIN Warranty AS W ON P.Product_ID = W.Product_ID
UNION
SELECT 
    P.Product_Name,
    'Has Refund' AS Status
FROM Product AS P
JOIN Refund_Request AS R ON P.Product_ID = R.Product_ID;

-- 2
-- Account and Product Purchases
SELECT 
    A.Account_Username,
    UA.MembershipStatus,
    COUNT(DISTINCT O.Order_ID) AS Total_Orders,
    GROUP_CONCAT(DISTINCT P.Product_Category) AS Categories_Bought,
    ROUND(SUM(R.Total_Price), 2) AS Total_Spent
FROM Account AS A
JOIN User_Account AS UA ON A.Account_Number = UA.Account_Number
JOIN Ordering AS O ON UA.User_ID = O.User_ID
JOIN Product AS P ON O.Order_ID = P.Order_ID
JOIN Receipt AS R ON O.Order_ID = R.Payment_ID
GROUP BY A.Account_Username, UA.MembershipStatus
HAVING Total_Orders > 0
ORDER BY Total_Spent DESC;

-- 3
-- Return the product performance with refund statistics:
SELECT 
    P.Product_Category,
    P.Product_Name,
    P.Rating,
    COUNT(DISTINCT RR.Refund_ID) AS Refund_Count
FROM Product AS P
LEFT JOIN Warranty AS W ON P.Product_ID = W.Product_ID
LEFT JOIN Refund_Request AS RR ON P.Product_ID = RR.Product_ID
GROUP BY P.Product_Category, P.Product_Name, P.Rating
HAVING Refund_Count > 0;

-- 4
-- Compare delivery services by order count and average shipping cost
SELECT 
    ST.Service_Name,
    COUNT(O.Order_ID) AS Total_Orders,
    AVG(R.Shipping_Price) AS Avg_Shipping_Cost
FROM Service_Type AS ST
JOIN Delivery AS D ON ST.Delivery_ID = D.Delivery_ID
JOIN Ordering AS O ON D.Order_ID = O.Order_ID
JOIN Receipt AS R ON O.Order_ID = R.Payment_ID
GROUP BY ST.Service_Name;

-- 5
-- Temporary place for the procedures

DELIMITER //
DROP PROCEDURE IF EXISTS get_employee_info;
CREATE PROCEDURE get_employee_info( emp_id INT )
BEGIN
    SELECT * FROM Employee_account WHERE Employee_ID = emp_id;
END //
DELIMITER ;

CALL get_employee_info(1);

-- Don
-- 6
-- Evaluate Popular Product Categories
SELECT 
    P.Product_Category, 
    COUNT(O.Order_ID) AS Total_Orders 
FROM 
    Product P
    JOIN Ordering O ON P.Order_ID = O.Order_ID 
GROUP BY 
    P.Product_Category 
ORDER BY 
    Total_Orders DESC;

-- 7
-- Track High-Spending Customers
SELECT 
    U.User_ID, 
    SUM(R.Total_Price) AS Total_Spent 
FROM 
    User_Account U 
    JOIN Receipt R ON U.User_ID = R.User_ID 
GROUP BY 
    U.User_ID 
HAVING 
    SUM(R.Total_Price) > 1000 
ORDER BY 
    Total_Spent DESC;
    
-- 8
-- Revenue Generated by Product 
SELECT 
    P.Product_ID, 
    P.Product_Name, 
    SUM(R.Quantity * R.PricePerUnit) AS Total_Revenue 
FROM 
    Receipt R 
    JOIN Product P ON R.Name = P.Product_Name 
GROUP BY 
    P.Product_ID, P.Product_Name 
ORDER BY 
    Total_Revenue DESC;

-- 9
-- Find Users Who Ordered or Requested Refunds
SELECT 
    User_ID, 
    'Order Made' AS Activity
FROM 
    Ordering
UNION
SELECT 
    User_ID, 
    'Refund Requested' AS Activity
FROM 
    Refund_Request;

-- First
-- 10
-- List all employee and count their refund process
SELECT EA.Employee_ID, EA.Position, EA.Department, COUNT(RR.Refund_ID) AS Refunds_Processed
FROM Employee_Account EA
LEFT JOIN Refund_Request AS RR ON EA.Employee_ID = RR.Employee_ID
GROUP BY EA.Employee_ID, EA.Position, EA.Department
HAVING Refunds_Processed > 0
ORDER BY Refunds_Processed DESC;

-- 11
-- List sales conversion by discount
SELECT D.Discount_Code_ID, COUNT(A.Discount_Code_ID) AS Usage_Count,ROUND(SUM(R.Total_Price), 2) AS Revenue_Generated
FROM Discount AS D
LEFT JOIN Application AS A 
ON D.Discount_Code_ID = A.Discount_Code_ID
JOIN Receipt AS R 
ON A.Order_ID = R.Payment_ID
GROUP BY D.Discount_Code_ID
ORDER BY Revenue_Generated DESC;

-- 12
-- list customer base on lifetime value
SELECT 
    A.Account_Username,
    ROUND(SUM(R.Total_Price), 2) AS Lifetime_Value
FROM 
    Account AS A
JOIN 
    User_Account AS UA ON A.Account_Number = UA.Account_Number
JOIN 
    Receipt AS R ON UA.User_ID = R.User_ID
GROUP BY 
    A.Account_Username
ORDER BY 
    Lifetime_Value DESC;

use temp;
-- 13
-- list average revenue by Membership Status
SELECT UA.MembershipStatus,ROUND(SUM(R.Total_Price) / COUNT(O.Order_ID), 2) AS Avg_Revenue_Per_Order
FROM User_Account AS UA
INNER JOIN Ordering AS O ON UA.User_ID = O.User_ID
INNER JOIN Receipt AS R ON O.Order_ID = R.Payment_ID
GROUP BY UA.MembershipStatus
ORDER BY Avg_Revenue_Per_Order DESC;

-- JJ
-- 14 
-- Select the Account_Number that handle the refund for Samsung Product

SELECT em.Account_Number, rq.name 
FROM Employee_account em 
RIGHT JOIN Refund_Request rq 
ON rq.Employee_ID = em.Employee_ID 
WHERE rq.name 
LIKE "%Samsung%";

-- 15
-- Show the account that the owner age more than 20 and live in silom

SELECT ac.account_number, ad.account_number, YEAR(CURDATE()) - YEAR(ac.date_of_birth) AS Age, ad.address
FROM address ad
LEFT JOIN account ac
ON ad.account_number = ac.account_number
WHERE YEAR(CURDATE()) - YEAR(ac.date_of_birth) >= 20
AND ad.address LIKE "%Silom%";

-- 16 
-- Show the card has higher than the average interest rate 
SELECT p.card_id, i.interest_rate
FROM installment i
LEFT JOIN payment_info p
ON p.card_id = i.card_id
WHERE i.interest_rate >= (SELECT AVG(interest_rate) FROM installment);


-- 17 
-- Show user that has membership status is Gold along with order_ID and Tracking_ID

SELECT u.User_ID, o.Order_ID, o.Tracking_ID, u.Account_Number, u.MembershipStatus 
FROM User_Account u
LEFT JOIN Ordering o
ON u.User_ID = o.User_ID
WHERE MembershipStatus = "GOLD";

-- JAM
-- 18
-- Find users with their account details
SELECT UA.User_ID, A.Account_Username, A.Email, A.Phone_Number
FROM User_Account UA
JOIN Account A ON UA.Account_Number = A.Account_Number;

-- 19
-- Estimate delivery time by It is assumed that all items will take 3 days to be delivered.
SELECT Delivery_ID, Ordering.Order_ID, Purchase_Date, 
DATE_ADD(Purchase_Date, INTERVAL 3 DAY) AS Expected_Delivery_Date
FROM Delivery 
JOIN Ordering  ON Delivery.Order_ID = Ordering.Order_ID
WHERE CURDATE() > DATE_ADD(Purchase_Date, INTERVAL 3 DAY);

-- 20
-- customer that order the most
SELECT UA.User_ID, A.Account_Username, COUNT(O.Order_ID) AS Total_Orders
FROM User_Account UA
JOIN Account A ON UA.Account_Number = A.Account_Number
JOIN Ordering O ON UA.User_ID = O.User_ID
GROUP BY UA.User_ID, A.Account_Username
ORDER BY Total_Orders DESC
LIMIT 5;

-- 21
-- Top spender
SELECT ua.User_ID, a.Account_Username, SUM(p.Price) AS Total_Spending
FROM User_Account ua
JOIN Account a ON ua.Account_Number = a.Account_Number
JOIN Ordering o ON ua.User_ID = o.User_ID
JOIN Product p ON p.Order_ID = o.Order_ID
GROUP BY ua.User_ID, a.Account_Username
ORDER BY Total_Spending DESC;


 -- 22
 -- Number of sales for each catagory
SELECT  p.Product_Category, COUNT(p.Order_ID) AS Number_of_Sales
FROM Product p
JOIN Ordering o ON p.Order_ID = o.Order_ID
GROUP BY p.Product_Category
ORDER BY Number_of_Sales DESC;

-- 23
-- overdue payment
SELECT p.Payment_ID, pi.Card_ID, pi.Exp_Date, DATEDIFF(CURDATE(), pi.Exp_Date) AS Days_Overdue
FROM Payment p
JOIN Payment_Info pi ON p.Card_ID = pi.Card_ID
WHERE pi.Exp_Date < CURDATE();

-- Noel
-- 24
-- List Customers with Orders last digit is 9 but Have Platinum Membership
SELECT 
    UA.User_ID, 
    A.Account_Username, 
    UA.MembershipStatus
FROM 
    User_Account UA
JOIN 
    Account A ON UA.Account_Number = A.Account_Number
LEFT JOIN 
    Ordering O ON UA.User_ID = O.User_ID
WHERE 
	O.order_id LIKE "%9" AND
	UA.MembershipStatus LIKE "Platinum";

-- 25
-- Identify Underperforming Products
SELECT 
    P.Product_ID, 
    P.Product_Name, 
    P.Rating, 
    P.Stock_Quantity
FROM 
    Product P
WHERE 
    P.Rating < (SELECT AVG(Rating) FROM Product)
    AND P.Stock_Quantity < 20
ORDER BY 
    P.Rating ASC;
    
-- 26
-- Discount code effectiveness on sales
SELECT 
    d.discount_code_id,
    d.Description,
    COUNT(a.Order_ID) AS Orders_Using_Code,
    ROUND(SUM(r.Total_Price), 2) AS Total_Sales_With_Code
FROM 
    discount d
JOIN 
    Application a ON d.order_id = a.order_id
JOIN 
    Ordering o ON a.Order_ID = o.Order_ID
JOIN 
    Receipt r ON o.Order_ID = r.Payment_ID
GROUP BY 
   d.discount_code_id, d.Description
ORDER BY 
    Total_Sales_With_Code DESC;

-- 27
-- List of Membership Status that has total orders
SELECT 
    ua.MembershipStatus,
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    User_account ua
JOIN 
    Ordering o ON ua.User_ID = o.User_ID
JOIN 
    Receipt r ON o.Order_ID = r.Payment_ID
GROUP BY 
    ua.MembershipStatus
ORDER BY
	Total_Orders DESC;
