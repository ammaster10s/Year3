use tinycompany;

-- Find who is the youngest employee ?
-- Calcualate the age of the company employee 

Select year(curdate()) - year(bdate) from employee as Age; -- Derived attribute 

Select concat (fname," " , lname) , year(curdate()) - year(bdate) 
as Age from employee order by bdate desc limit 1;

-- cannot order by Age since Age is an information.

-- concat use for concatenate the value 

-- Bonus == Alias  ( Variable name )
select salary * 10 /100 as Bonus, salary 
from employee
where salary is not Null ; -- Case that salary is not null 

-- Calculate the wage for all employee who has "essn" starting with "10"

Select sum(salary)from employee where ssn Between 100000000 and 109999999;
-- => ssn >= 100000000 and ssn <=109999999
-- => ssn >   99999999 and ssn < 110000000 
Select sum(salary)from employee where ssn like "10%";


