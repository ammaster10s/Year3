Create database Practice1;
use Practice1;

Create table Student
(
	id int not null unique,
    name varchar(100),
    constraint Student_Id_Pk primary key (id )
);

Create table Subject
(
	S_code int not null unique,
    S_name varchar(100),
    constraint Subject_Code_Pk primary key ( S_code )
);

Create table Email
(
	Student_Id int not null unique,
    email nvarchar(100),
    constraint Email_Pk primary key(Student_Id, email),
    constraint Student_Id_Fk foreign key(Student_Id)
    references Student (id)
);

Create table Enroll
(
	Student_Id int not null unique,
    Subject_Code int not null unique,
    e_date date ,
    status bit ,
    CONSTRAINT Enroll_Pk PRIMARY KEY (Student_Id, Subject_Code),
    constraint Enroll_Student_Id_Fk foreign key(Student_Id)
    references Student (id),
    
    constraint Enroll_Subject_Code_Fk foreign key(Subject_Code)
    references Subject (S_code)
);

Create index idk_CodeName 
on Subject (S_code, S_Name) ;

