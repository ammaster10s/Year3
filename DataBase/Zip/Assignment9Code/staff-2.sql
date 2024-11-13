-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 12, 2024 at 01:58 PM
-- Server version: 8.0.35
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `staff`
--

-- --------------------------------------------------------

--
-- Table structure for table `GENDER`
--

CREATE TABLE `GENDER` (
  `GENDER_ID` int NOT NULL,
  `GENDER_NAME` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `GENDER`
--

INSERT INTO `GENDER` (`GENDER_ID`, `GENDER_NAME`) VALUES
(1, 'Male'),
(2, 'Male'),
(3, 'Male'),
(4, 'Male'),
(5, 'Male'),
(6, 'Female'),
(7, 'Male'),
(8, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `TITLE`
--

CREATE TABLE `TITLE` (
  `TITLE_ID` int NOT NULL,
  `TITLE_NAME` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `TITLE`
--

INSERT INTO `TITLE` (`TITLE_ID`, `TITLE_NAME`) VALUES
(1, 'Mr'),
(2, 'Mr'),
(3, 'Mr'),
(4, 'Mr'),
(5, 'Mr'),
(6, 'Mrs'),
(7, 'Mr'),
(8, 'Mr');

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `USER_ID` int NOT NULL,
  `USER_TITLE` int DEFAULT NULL,
  `USER_FNAME` varchar(50) DEFAULT NULL,
  `USER_LNAME` varchar(50) DEFAULT NULL,
  `USER_GENDER` int DEFAULT NULL,
  `USER_EMAIL` varchar(50) DEFAULT NULL,
  `USER_NAME` varchar(25) DEFAULT NULL,
  `USER_PASSWD` varchar(25) DEFAULT NULL,
  `USER_GROUPID` int DEFAULT NULL,
  `DISABLE` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`USER_ID`, `USER_TITLE`, `USER_FNAME`, `USER_LNAME`, `USER_GENDER`, `USER_EMAIL`, `USER_NAME`, `USER_PASSWD`, `USER_GROUPID`, `DISABLE`) VALUES
(5, 6, 'Test', 'Test', 8, 'Test@gmail.com', 'Test', 'Test', 14, 0);

-- --------------------------------------------------------

--
-- Table structure for table `USER_GROUP`
--

CREATE TABLE `USER_GROUP` (
  `USERGROUP_ID` int NOT NULL,
  `USERGROUP_CODE` varchar(50) DEFAULT NULL,
  `USERGROUP_NAME` varchar(50) DEFAULT NULL,
  `USERGROUP_REMARK` varchar(255) DEFAULT NULL,
  `USERGROUP_URL` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `USER_GROUP`
--

INSERT INTO `USER_GROUP` (`USERGROUP_ID`, `USERGROUP_CODE`, `USERGROUP_NAME`, `USERGROUP_REMARK`, `USERGROUP_URL`) VALUES
(14, 'Test', 'Test', 'Test', '111222');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `GENDER`
--
ALTER TABLE `GENDER`
  ADD PRIMARY KEY (`GENDER_ID`);

--
-- Indexes for table `TITLE`
--
ALTER TABLE `TITLE`
  ADD PRIMARY KEY (`TITLE_ID`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`USER_ID`),
  ADD KEY `fk_user_gender` (`USER_GENDER`),
  ADD KEY `fk_user_title` (`USER_TITLE`),
  ADD KEY `fk_user_group` (`USER_GROUPID`);

--
-- Indexes for table `USER_GROUP`
--
ALTER TABLE `USER_GROUP`
  ADD PRIMARY KEY (`USERGROUP_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `GENDER`
--
ALTER TABLE `GENDER`
  MODIFY `GENDER_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `TITLE`
--
ALTER TABLE `TITLE`
  MODIFY `TITLE_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `USER`
--
ALTER TABLE `USER`
  MODIFY `USER_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `USER_GROUP`
--
ALTER TABLE `USER_GROUP`
  MODIFY `USERGROUP_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `USER`
--
ALTER TABLE `USER`
  ADD CONSTRAINT `fk_user_gender` FOREIGN KEY (`USER_GENDER`) REFERENCES `GENDER` (`GENDER_ID`),
  ADD CONSTRAINT `fk_user_group` FOREIGN KEY (`USER_GROUPID`) REFERENCES `USER_GROUP` (`USERGROUP_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_title` FOREIGN KEY (`USER_TITLE`) REFERENCES `TITLE` (`TITLE_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
