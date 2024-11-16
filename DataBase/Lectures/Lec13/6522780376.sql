Drop database if exists BoxOffice;
Create database if not exists BoxOffice;
Use BoxOffice;
Create table BoxOfficeMovies (
	MID 	int 			not null	unique	primary key,
    Title	varchar(50) 	not null	unique,
    Studio	varchar(50)		not null,
    Year	int				not null,
    Gross	decimal (8,2)	not null
);
Create table Users (
	uID		int				not null 	unique	primary key,
	userName	varchar(50)	not null 	unique
);

Create table Watch_Log (
	uID		int			not null,
    mID		int			not null,
    watch_datetime	datetime not null,
    constraint	PK_UM	Primary key (uID, mID, watch_datetime),
    constraint	FK_U	Foreign key (uID) references Users (uID),
    constraint	FK_M	foreign key (mID) references BoxOfficeMovies (mID)
);

insert into BoxOfficeMovies values
	(1, "Avengers: Endgame", "Marvel", 2019, 2794.7),
    (2, "Avatar", "Fox", 2009, 2789.7),
    (3, "Titanic", "Fox", 1997, 2187.5),
    (4, "Star Wars: The Force Awakens", "Walt Disney", 2015, 2068.2),
    (5, "Frozen II", "Walt Disney", 2020, 2934.25),
    (6, "Star Wars: The Rise of Skywalker", "Walt Disney", 2019, 3564.75);
    
insert into users values 
	(1, "captan_Marvel"), (2, "oldmcdonald123");
    
insert into Watch_Log values
	(1, 1, "2022-10-10 09:30:15"),
    (2, 2, "2022-10-10 11:01:56"),
    (2, 2, "2022-10-13 14:26:03"),
    (1, 1, "2022-10-13 17:30:15"),
    (1, 5, "2022-10-13 19:55:21"),
    (2, 4, "2022-10-13 20:49:34"),
    (2, 6, "2022-10-13 23:10:32");
     


# List all users (usernames) , their watched moveis and year and the name of month of their watched time.

SELECT users.userName, movie.Title, YEAR(logs.watch_datetime), MONTHNAME(logs.watch_datetime) as Month 
FROM Users as users
INNER JOIN Watch_Log as logs ON users.uID = logs.uID
INNER JOIN BoxOfficeMovies as movie ON logs.mID = movie.MID;

# List all movies in the BoxOfficeMovies table and find how many times they have been watched and results display descendingly

SELECT DISTINCT movie.Title, COUNT(logs.mID) as freq
FROM  BoxOfficeMovies as movie
LEFT JOIN Watch_Log as logs ON movie.MID = logs.mID
GROUP BY movie.Title
ORDER BY freq DESC;


