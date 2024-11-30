/* --------------------------------------------------------------
 --   SQL 1: SOLUTION
 ------------------------------------------------------------- */
DROP DATABASE IF EXISTS tinycompany;

CREATE DATABASE IF NOT EXISTS tinycompany;

USE tinycompany;

-- Department Table 
CREATE TABLE department(
	dnumber INT PRIMARY KEY,
	-- dnumber is a primary key
	dname VARCHAR(100) NOT NULL,
	location VARCHAR(100),
	-- location is nullable 
	CONSTRAINT chk_dnumber CHECK (
		dnumber >= 1
		AND dnumber <= 20
	) -- dnumber range from 1 to 20
);

-- Project Table 
CREATE TABLE project(
	pnumber INT PRIMARY KEY,
	-- dnumber is a primary keyemployeeproject
	pname VARCHAR(50) NOT NULL,
	dept_no INT NOT NULL,
	CONSTRAINT FK_DeptProj FOREIGN KEY (dept_no) REFERENCES department(dnumber)
);

-- Write your DDL for employee and assignment here 
-- Hint: Review the CREATE sequence, i.e., which tables should be created first
-- Employee Table
CREATE TABLE employee(
	fname VARCHAR(20) NOT NULL,
	lname VARCHAR(20) NOT NULL,
	ssn VARCHAR(9) PRIMARY KEY,
	bdate DATE NOT NULL,
	sex VARCHAR(1) NOT NULL,
	salary DECIMAL(12, 2),
	-- salary is nullable 
	dept_no INT,
	-- dept_no is nullable 
	CONSTRAINT FK_EmpDept FOREIGN KEY (dept_no) REFERENCES department(dnumber)
);

-- Add a CHECK constraint for sex: only value 'M' or 'F' allowed
ALTER TABLE
	employee
ADD
	CONSTRAINT CHK_Gender CHECK (sex in ('M', 'F'));

-- Assignment Table
CREATE TABLE assignment(
	essn VARCHAR(9) NOT NULL,
	projno INT NOT NULL,
	hours DECIMAL(9, 2),
	-- hours is nullable 
	hourlyrate DECIMAL(9, 2),
	-- hourlyrate is nullable 
	CONSTRAINT FK_AsmEmp FOREIGN KEY (essn) REFERENCES employee(ssn),
	CONSTRAINT FK_AsmPrj FOREIGN KEY (projno) REFERENCES project(pnumber),
	PRIMARY KEY (essn, projno)
);