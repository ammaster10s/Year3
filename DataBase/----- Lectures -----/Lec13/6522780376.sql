Drop database if exists BoxOffice;

Create database if not exists BoxOffice;

Use BoxOffice;

Create table BoxOfficeMovies (
    MID int not null unique primary key,
    Title varchar(50) not null unique,
    Studio varchar(50) not null,
    Year int not null,
    Gross decimal(8, 2) not null
);

Create table Users (
    uID int not null unique primary key,
    userName varchar(50) not null unique
);

Create table Watch_Log (
    uID int not null,
    mID int not null,
    watch_datetime datetime not null,
    constraint PK_UM Primary key (uID, mID, watch_datetime),
    constraint FK_U Foreign key (uID) references Users (uID),
    constraint FK_M foreign key (mID) references BoxOfficeMovies (mID)
);

insert into
    BoxOfficeMovies
values
    (
        1,
        "Avengers: Endgame",
        "Marvel",
        2019,
        2794.7
    ),
    (
        2,
        "Avatar",
        "Fox",
        2009,
        2789.7
    ),
    (
        3,
        "Titanic",
        "Fox",
        1997,
        2187.5
    ),
    (
        4,
        "Star Wars: The Force Awakens",
        "Walt Disney",
        2015,
        2068.2
    ),
    (
        5,
        "Frozen II",
        "Walt Disney",
        2020,
        2934.25
    ),
    (
        6,
        "Star Wars: The Rise of Skywalker",
        "Walt Disney",
        2019,
        3564.75
    );

insert into
    usersda
values
    (1, "captan_Marvel"),
    (2, "oldmcdonald123");

insert into
    Watch_Log
values
    (1, 1, "2022-10-10 09:30:15"),
    (2, 2, "2022-10-10 11:01:56"),
    (2, 2, "2022-10-13 14:26:03"),
    (1, 1, "2022-10-13 17:30:15"),
    (1, 5, "2022-10-13 19:55:21"),
    (2, 4, "2022-10-13 20:49:34"),
    (2, 6, "2022-10-13 23:10:32");

# List all users (usernames) , their watched moveis and year and the name of month of their watched time.
SELECT
    users.userName,
    movie.Title,
    YEAR(logs.watch_datetime),
    MONTHNAME(logs.watch_datetime) as Month
FROM
    Users as users
    INNER JOIN Watch_Log as logs ON users.uID = logs.uID
    INNER JOIN BoxOfficeMovies as movie ON logs.mID = movie.MID;

# List all movies in the BoxOfficeMovies table and find how many times they have been watched and results display descendingly
SELECT
    movie.Title,
    COUNT(logs.mID) as freq
FROM
    BoxOfficeMovies as movie
    LEFT JOIN Watch_Log as logs ON movie.MID = logs.mID
GROUP BY
    movie.Title
ORDER BY
    freq DESC;

SELECT
    *
FROM
    watch_log;

CREATE view vw_cntMovie as (
    SELECT
        COUNT(*) as cntMovie,
        mID,
        uID
    from
        watch_log
    group by
        MID,
        uID
);

drop view vw_cntMovie;

select
    *
from
    vw_cntMovie;

# List all movies that have never been watched
SELECT
    DISTINCT movie.mID,
    movie.Title
FROM
    BoxOfficeMovies as movie
where
    mID not in(
        Select
            mID
        from
            Watch_Log
        GROUP BY
            mID
    );

# List all movies that earned more than minimum gross of the year 2019
SELECT
    mID,
    Title
FROM
    BoxOfficeMovies
where
    Gross > (
        SELECT
            MIN(Gross)
        FROM
            BoxOfficeMovies
        WHERE
            Year = 2019
    );

# Create a view name "vw_cntMovie" for counting all movies of each studio that had been watched for each daym each month mand each year.
DROP VIEW if exists vw_cntMovie;

DROP VIEW if exists vw_cntMovie2;

CREATE view vw_cntMovie as
SELECT
    DAY(Logs.watch_datetime) as dd,
    MONTH(Logs.watch_datetime) as mm,
    YEAR(Logs.watch_datetime) as yy,
    movie.Studio,
    COUNT(movie.mID) as cntMovie
FROM
    watch_log as Logs
    LEFT JOIN BoxOfficeMovies as movie ON Logs.mID = movie.MID
GROUP BY
    dd,
    mm,
    movie.Studio,
    yy;

--  ONLY_FULL_GROUP_BY  YOU need to group all!
Select
    *
from
    vw_cntMovie;

# Using subquery
CREATE view vw_cntMovie2 as
SELECT
    DAY(watch_datetime) as dd,
    MONTH(watch_datetime) as mm,
    YEAR(watch_datetime) as yy,
    Studio,
    COUNT(mID) as cntMovie
FROM
    (
        SELECT
            watch_datetime,
            mID,
            (
                SELECT
                    Studio
                FROM
                    BoxOfficeMovies
                WHERE
                    BoxOfficeMovies.MID = Watch_Log.mID
            ) as Studio
        FROM
            Watch_Log
    ) as subquery
GROUP BY
    Studio,
    dd,
    mm,
    yy;

Select
    *
from
    vw_cntMovie2;