USE tinyCompany;
Insert into department 
	values 	(1, "Accounting", "2A101 Fl.1"),
			(2, "Human Resource", "2A104 Fl.1"),
			(3, "Research and Development", "2B401 Fl.4");
Insert into Project 
	values 	(1, "APTX4869", 3),
			(2, "APTX4742", 2);
Insert into Employee
	values	("Peter", "Parker", "110033445", "1985-05-04", "M", NULL, NULL),
			("MaryJane", "Watson", "103849237", "1983-08-19", "F", 3400.4, 1),
			("Miles", "Morales", "230563445", "1990-08-31", "M", NULL, NULL);
Insert into Assignment
	values	("110033445",1,20,50.5),
			("103849237", 1, 10, 55),
			("103849237", 2, 10, 58);
            