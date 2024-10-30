/* --------------------------------------------------------------
--   Please fill in your details in this comment block --  
--   Student ID: 6522780376	
--   Fullname: Pawaris Panyasombat
--   Section: 4
------------------------------------------------------------- */

DROP DATABASE IF EXISTS tinycompany; 
CREATE DATABASE IF NOT EXISTS tinycompany;
USE tinycompany;
-- Department Table 

CREATE TABLE department(
	dnumber		INT 		 PRIMARY KEY,  -- dnumber is a primary key
	dname		VARCHAR(20)  NOT NULL,
	location	VARCHAR(100), -- location is nullable 
	CONSTRAINT chk_dnumber CHECK (dnumber >= 1 AND dnumber <=20 ) -- dnumber range from 1 to 20
);

-- Project Table 
CREATE TABLE project(
	pnumber		INT 		 PRIMARY KEY,  -- dnumber is a primary key
	pnane		VARCHAR(50)  NOT NULL,
	dept_no	 	INT 		 NOT NULL,
	CONSTRAINT FK_DeptProj FOREIGN KEY (dept_no) REFERENCES department(dnumber)
);

-- Write your DDL for employee and assignment here 

CREATE TABLE employee(
	FName 		VARCHAR(20)  NOT NULL,
	Lname		VARCHAR(20)  NOT NULL,
	Ssn			CHAR(9) 	 PRIMARY KEY,
	Bdate		DATE 		 NOT NULL,
	sex			CHAR(1) 	 NOT NULL,
	salary		DECIMAL(12,2) ,
	dept_no		INT 		,

	Constraint chk_sex Check (sex in ('M', 'F')),
	Constraint employee_fk_deptno foreign key (dept_no) references department(dnumber)

);


CREATE TABLE Assignment (
	essn		CHAR(9) 	NOT NULL,
	proj_no		INT 		NOT NULL,
	hours		DECIMAL(9,2),
	hourly_rate DECIMAL(9,2),
    
	CONSTRAINT Assignment_pk PRIMARY KEY (essn, proj_no),
	Constraint Assignment_fk_essn foreign key (essn) references employee(Ssn),
	Constraint Assignment_fk_projno foreign key (proj_no) references project(pnumber)
);


	

-- Hint: Review