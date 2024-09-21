CREATE TABLE `Course` (
  `Course_ID` int NOT NULL,
  `Course_Name` varchar(100) NOT NULL,
  `Department` varchar(50) NOT NULL
)

CREATE TABLE `Register` (
  `Register_ID` int NOT NULL,
  `Student_ID` int NOT NULL,
  `Section_ID` int NOT NULL,
  `Registration_date` date NOT NULL,
  `Grade` char(2) NOT NULL
)

CREATE TABLE `Section` (
  `Section_ID` int NOT NULL,
  `Course_ID` int NOT NULL,
  `Semester` varchar(20) NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Year` int NOT NULL,
  `Instructor` varchar(100) NOT NULL
)

CREATE TABLE `Student` (
  `Student_ID` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` varchar(1) NOT NULL
)

INSERT INTO `Course` (`Course_ID`, `Course_Name`, `Department`) VALUES
(101, 'Introduction to Computer Science', 'Computer Science'),
(102, 'Calculus I', 'Mathematics'),
(103, 'Physics I', 'Physics'),
(104, 'Introduction to Psychology', 'Psychology'),
(105, 'English Literature', 'English'),
(106, 'Data Structures', 'Computer Science'),
(107, 'Linear Algebra', 'Mathematics'),
(108, 'Organic Chemistry', 'Chemistry'),
(109, 'Macroeconomics', 'Economics'),
(110, 'World History', 'History');


INSERT INTO `Register` (`Register_ID`, `Student_ID`, `Section_ID`, `Registration_date`, `Grade`) VALUES
(1, 1, 1, '2023-09-01', 'A'),
(2, 2, 2, '2023-09-02', 'B+'),
(3, 3, 3, '2023-09-03', 'A-'),
(4, 4, 4, '2023-09-04', 'B'),
(5, 5, 5, '2023-09-05', 'C+'),
(6, 6, 6, '2023-09-06', 'A'),
(7, 7, 7, '2023-09-07', 'B-'),
(8, 8, 8, '2023-09-08', 'C'),
(9, 9, 9, '2023-09-09', 'A'),
(10, 10, 10, '2023-09-10', 'B+');

INSERT INTO `Section` (`Section_ID`, `Course_ID`, `Semester`, `email`, `Year`, `Instructor`) VALUES
(1, 101, 'Fall', NULL, 2023, 'Dr.Smith'),
(2, 102, 'Spring', NULL, 2024, 'Prof. Johnson'),
(3, 103, 'Fall', NULL, 2023, 'Dr.Lee'),
(4, 101, 'Spring', NULL, 2024, 'Prof. Brown'),
(5, 105, 'Fall', NULL, 2023, 'Dr.Green'),
(6, 106, 'Spring', NULL, 2024, 'Prof. White'),
(7, 107, 'Fall', NULL, 2023, 'Dr.Black'),
(8, 108, 'Spring', NULL, 2024, 'Prof. Adam'),
(9, 101, 'Fall', NULL, 2023, 'Dr.Clark'),
(10, 110, 'Spring', NULL, 2024, 'Prof. Harris');

INSERT INTO `Student` (`Student_ID`, `FirstName`, `LastName`, `email`, `DOB`, `Gender`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2000-01-15', 'M'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2001-02-20', 'F'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '1999-03-25', 'F'),
(4, 'Bob', 'Williams', 'bob.williams@example.com', '2002-04-30', 'M'),
(5, 'Charlie', 'Brown', 'charlie.brown@example.com', '2000-05-05', 'M'),
(6, 'Emily', 'Davis', 'emily.davis@example.com', '2001-06-10', 'F'),
(7, 'Frank', 'Miller', 'frank.miller@example.com', '1998-07-15', 'M'),
(8, 'Grace', 'Wilson', 'grace.wilson@example.com', '1999-08-20', 'F'),
(9, 'Henry', 'Moore', 'henry.moore@example.com', '2000-09-25', 'M'),
(10, 'Ivy', 'Taylor', 'lvy.taylor@example.com', '2001-10-30', 'F');

ALTER TABLE `Course`
  ADD PRIMARY KEY (`Course_ID`);


ALTER TABLE `Register`
  ADD PRIMARY KEY (`Register_ID`),
  ADD KEY `Student_ID` (`Student_ID`),
  ADD KEY `Section_ID` (`Section_ID`);


ALTER TABLE `Section`
  ADD PRIMARY KEY (`Section_ID`),
  ADD KEY `Course_ID` (`Course_ID`);


ALTER TABLE `Student`
  ADD PRIMARY KEY (`Student_ID`);

ALTER TABLE `Register`
  ADD CONSTRAINT `register_ibfk_2` FOREIGN KEY (`Section_ID`) REFERENCES `Section` (`Section_ID`),
  ADD CONSTRAINT `register_ibfk_3` FOREIGN KEY (`Student_ID`) REFERENCES `Student` (`Student_ID`) ON DELETE CASCADE;

ALTER TABLE `Section`
  ADD CONSTRAINT `section_ibfk_1` FOREIGN KEY (`Course_ID`) REFERENCES `Course` (`Course_ID`);
COMMIT;


-Write a query to show a list of Male students and order by their first name. (output as below)

SELECT * FROM `Student` WHERE Gender = 'M' ORDER BY FirstName;

-Write a query to show a list of students who study "Introduction to
Computer Science". (output as below with student ID, first name, last
name and grade)

SELECT 
    Student.Student_ID, 
    Student.FirstName, 
    Student.LastName, 
    Register.Grade
FROM 
    Student
JOIN 
    Register ON Student.Student_ID = Register.Student_ID
JOIN 
    Section ON Register.Section_ID = Section.Section_ID
JOIN 
    Course ON Section.Course_ID = Course.Course_ID
WHERE 
    Course.Course_Name = 'Introduction to Computer Science';


-Write a query to show the age of each student (output as below with first
name, last name and age)

SELECT FirstName, LastName, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), DOB)), '%Y') + 0 AS age
FROM Student;

https://www.scaler.com/topics/how-to-calculate-age-from-date-of-birth-in-sql/


Write a query to find the students who have Grade ’A’ and order by their
first name (include the student ID and first name and Grade in the result).

SELECT 
    Student.Student_ID, 
    Student.FirstName, 
    Register.Grade
    
FROM 
    Student
JOIN 
    Register ON Student.Student_ID = Register.Student_ID
JOIN 
    Section ON Register.Section_ID = Section.Section_ID
JOIN 
    Course ON Section.Course_ID = Course.Course_ID
WHERE 
	Register.Grade = "A"
ORDER BY
    'FirstName';
    

Write a query to update all the students who learn "Introduction to
Computer Science" grade to B+.

UPDATE Register
JOIN Section ON Register.Section_ID = Section.Section_ID
JOIN Course ON Section.Course_ID = Course.Course_ID
SET Register.Grade = 'B+'
WHERE Course.Course_Name = 'Introduction to Computer Science';

SELECT 
    Student.Student_ID, 
    Student.FirstName, 
    Register.Grade
FROM 
    Student
JOIN 
    Register ON Student.Student_ID = Register.Student_ID
JOIN 
    Section ON Register.Section_ID = Section.Section_ID
JOIN 
    Course ON Section.Course_ID = Course.Course_ID
WHERE 
    Register.Grade = 'B+' 
    AND Course.Course_Name = 'Introduction to Computer Science'
ORDER BY 
    Student.FirstName;
