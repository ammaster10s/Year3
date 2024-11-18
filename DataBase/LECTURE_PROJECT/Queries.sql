use Database_Project;

-- Basic Queries

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

-- Calculate average order total by customer gender:
SELECT A.Gender, AVG(R.Total_Price) as Avg_Order_Value
FROM
    Account as A
    JOIN User_Account as UA ON A.Account_Number = UA.Account_Number
    JOIN Receipt as R ON UA.User_ID = R.User_ID
GROUP BY
    A.Gender;

-- Advanced Queries

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


-- Temporary place for the procedures

DELIMITER //
DROP PROCEDURE IF EXISTS get_employee_info;
CREATE PROCEDURE get_employee_info( emp_id INT )
BEGIN
    SELECT * FROM Employee_account WHERE Employee_ID = emp_id;
END //
DELIMITER ;

CALL get_employee_info(1);