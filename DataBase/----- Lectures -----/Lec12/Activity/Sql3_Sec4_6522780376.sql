/* --------------------------------------------------------------
--   Please fill in your details in this comment block --  
--   Student ID: 6522780376	
--   Fullname: Pawaris Panyasombat
--   Section: 4
------------------------------------------------------------- */


use tinycollege;


-- Q1 List top 10 oldest preofessors (Fname and Lname ) and their current age.

Select concat (EMP_FNAME," " , EMP_LNAME) , year(curdate()) - year(EMP_DOB) as Age from Professor order by EMP_DOB asc limit 10;

-- Q2 Find the average GPA of "CIS" Student.

Select Round(AVG(STU_GPA),2) as "Average CIS GPA" from Student where DEPT_CODE = "CIS";

-- Q3 Find how many 3-credit coureses in total offered by "CIS", "MATH" , "BIOL" and "ENG".

SELECT  COUNT(*) AS "Total # of 3-Credit Courses" FROM Course WHERE DEPT_CODE IN ("CIS", "MATH", "BIOL", "ENG")  AND CRS_CREDIT = 3 ;

-- Q4 Find the total number of students in each department.


SELECT DEPT_CODE, COUNT(*) AS "Total # of Students" FROM Student WHERE DEPT_CODE IN ('CIS', 'MATH', 'BIOL', 'ENG') GROUP BY DEPT_CODE;

-- Q5 List all departments code with the avg GPA displayed in 2 decimal places.

Select DEPT_CODE, Round(AVG(STU_GPA),2) as "Average GPA" from Student group by DEPT_CODE order by AVG(STU_GPA) DESC ;

-- Q6 List all departments code that have average GPA of thiere students higher tham 3.00

Select DEPT_CODE, Round(AVG(STU_GPA),2) as "Average GPA" from Student  group by DEPT_CODE Having AVG(STU_GPA) > 3.00 order by AVG(STU_GPA) DESC ;

-- Q7 Find total number of studnets and the average GPA of students of each class.

Select STU_CLASS, count(*) as "Total Students" , AVG(STU_GPA) as "Average GPA" from Student Where STU_GPA is not null group by STU_CLASS  order by STU_CLASS;