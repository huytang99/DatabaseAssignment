-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2020 at 02:39 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assignment2`
--

-- --------------------------------------------------------

--
-- Table structure for table `createtest`
--

CREATE TABLE `createtest` (
  `TeacherUsername` varchar(50) NOT NULL,
  `TestID` varchar(50) NOT NULL,
  `DateCreate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `TestID` varchar(50) NOT NULL,
  `StudentUserName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `TestID` varchar(50) NOT NULL,
  `QuestionID` varchar(50) NOT NULL,
  `Answer1` varchar(50) NOT NULL,
  `Answer2` varchar(50) NOT NULL,
  `Answer3` varchar(50) NOT NULL,
  `Answer4` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `selectanswer`
--

CREATE TABLE `selectanswer` (
  `QuestionID` varchar(50) NOT NULL,
  `TakeID` varchar(50) NOT NULL,
  `SelectAnswerIndex` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FullName` varchar(50) NOT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `take`
--

CREATE TABLE `take` (
  `TakeID` varchar(50) NOT NULL,
  `DateTake` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Score` int(10) UNSIGNED DEFAULT NULL,
  `Duration` int(10) UNSIGNED DEFAULT NULL,
  `TestID` varchar(50) DEFAULT NULL,
  `StudentUsername` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FullName` varchar(50) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `IdentityNumber` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `TestID` varchar(50) NOT NULL,
  `TestName` varchar(50) NOT NULL,
  `Subject` varchar(50) NOT NULL,
  `Duration` int(10) UNSIGNED DEFAULT NULL,
  `Deadline` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `createtest`
--
ALTER TABLE `createtest`
  ADD PRIMARY KEY (`TeacherUsername`,`TestID`),
  ADD KEY `TestID` (`TestID`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`TestID`,`StudentUserName`),
  ADD KEY `StudentUserName` (`StudentUserName`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`QuestionID`,`TestID`),
  ADD KEY `TestID` (`TestID`);

--
-- Indexes for table `selectanswer`
--
ALTER TABLE `selectanswer`
  ADD PRIMARY KEY (`QuestionID`,`TakeID`),
  ADD KEY `TakeID` (`TakeID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`Username`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `take`
--
ALTER TABLE `take`
  ADD PRIMARY KEY (`TakeID`),
  ADD KEY `StudentUsername` (`StudentUsername`),
  ADD KEY `TestID` (`TestID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`Username`),
  ADD UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  ADD UNIQUE KEY `IdentityNumber` (`IdentityNumber`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`TestID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `createtest`
--
ALTER TABLE `createtest`
  ADD CONSTRAINT `createtest_ibfk_1` FOREIGN KEY (`TeacherUsername`) REFERENCES `teacher` (`Username`),
  ADD CONSTRAINT `createtest_ibfk_2` FOREIGN KEY (`TestID`) REFERENCES `test` (`TestID`);

--
-- Constraints for table `permission`
--
ALTER TABLE `permission`
  ADD CONSTRAINT `permission_ibfk_1` FOREIGN KEY (`StudentUserName`) REFERENCES `student` (`Username`),
  ADD CONSTRAINT `permission_ibfk_2` FOREIGN KEY (`TestID`) REFERENCES `test` (`TestID`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`TestID`) REFERENCES `test` (`TestID`);

--
-- Constraints for table `selectanswer`
--
ALTER TABLE `selectanswer`
  ADD CONSTRAINT `selectanswer_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`),
  ADD CONSTRAINT `selectanswer_ibfk_2` FOREIGN KEY (`TakeID`) REFERENCES `take` (`TakeID`);

--
-- Constraints for table `take`
--
ALTER TABLE `take`
  ADD CONSTRAINT `take_ibfk_1` FOREIGN KEY (`StudentUsername`) REFERENCES `student` (`Username`),
  ADD CONSTRAINT `take_ibfk_2` FOREIGN KEY (`TestID`) REFERENCES `test` (`TestID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
