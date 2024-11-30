Create database myExam;
use myExam;

-- drop database myExam;
Create table Student
(
    ID int not null unique primary key, -- First Method
    Fname varchar(100) not null ,
    Lname varchar(100) not null,
    DOB date
    
);

Create table Examination
(
    Semester int not null ,
    Exam_Number int not null ,
    Question varchar(100) ,
    constraint Exam_Semester primary key (Semester, Exam_Number)
);

Create table take
(
    examDate date,
    Student_ID int not null,
    examNumber int not null,
    Semester int not null,
    constraint take_PK primary key (Student_ID , examNumber , Semester) ,
    constraint take__student_fk foreign key (Student_ID) references Student(ID),
    constraint take__examination_fk foreign key (Semester) references Examination(Semester)
);


Alter table student 
add Gender char(1); 

Alter table Student 
modify Gender char(5);

Alter table student 
rename column DoB to DateOfBirth;

-- Alter table Student
-- DROP primary key ;

-- Alter table Student
-- add constraint Student_Id_Pk primary key (ID);

--  Example 

Alter table Student
ADD constraint CHK_Gender Check 
(Gender in ('M', 'F'));


--  check (Gender = "F" or Gender = "M") Alternatively 

-- Drop the existing constraint
ALTER TABLE Student
DROP CONSTRAINT CHK_Gender;

-- Add the updated constraint
ALTER TABLE Student
ADD CONSTRAINT CHK_Gender CHECK (Gender IN ('M', 'F', 'O'));

--  DML to add record 
insert into Student (ID, Fname, Lname, Gender)
values (101, "Somsak", "Saetung", "M");

Alter table Student 
 alter column Gender set default 'F';


 