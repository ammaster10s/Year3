Use FinalQuiz_Data;

Select monthname(paid_date) as MonthName , SUM(amount) as "Total Amount" FROM Payment  Where YEAR(paid_date) = 2024 GROUP by monthname(paid_date);