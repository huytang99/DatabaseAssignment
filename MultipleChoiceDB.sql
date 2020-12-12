-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2020 at 04:08 PM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_student` (IN `namee` VARCHAR(50))  SELECT Username,FullName,Email FROM student WHERE Username=namee$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `match_answer_list` (IN `itakeid` VARCHAR(50))  SELECT selectanswer.TakeID, Score, Question.QuestionID,SelectAnswerIndex,CorrectAnswerIndex
FROM question,selectanswer,take
Where Take.TakeID=itakeid AND Take.TakeID=selectanswer.TakeID AND selectanswer.QuestionID=question.QuestionID AND selectanswer.SelectAnswerIndex=question.CorrectAnswerIndex$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `student_total_score` (IN `itakeid` VARCHAR(50))  NO SQL
SELECT selectanswer.TakeID, SUM(Score)
FROM question,selectanswer,take
Where Take.TakeID=itakeid AND Take.TakeID=selectanswer.TakeID AND selectanswer.QuestionID=question.QuestionID AND selectanswer.SelectAnswerIndex=question.CorrectAnswerIndex$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `createtest`
--

CREATE TABLE `createtest` (
  `TeacherUsername` varchar(50) NOT NULL,
  `TestID` varchar(50) NOT NULL,
  `DateCreate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `createtest`
--

INSERT INTO `createtest` (`TeacherUsername`, `TestID`, `DateCreate`) VALUES
('amanda', '1', '2020-12-10 16:45:40'),
('david', '2', '2020-12-12 16:46:11'),
('king', '3', '2020-12-12 16:46:36'),
('lee', '4', '2020-12-13 16:46:53'),
('lena', '5', '2020-12-14 16:47:08'),
('lucy', '6', '2020-12-15 16:47:28'),
('paul', '7', '2020-12-16 16:47:52'),
('Tom', '8', '2020-12-18 16:48:05');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `TestID` varchar(50) NOT NULL,
  `StudentUserName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`TestID`, `StudentUserName`) VALUES
('1', 'aeronn'),
('2', 'graham'),
('3', 'jack'),
('4', 'jane'),
('5', 'johnsmithh'),
('6', 'kkakie'),
('7', 'june'),
('8', 'kylie');

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `TestID` varchar(50) NOT NULL,
  `QuestionID` varchar(50) NOT NULL,
  `QuestionTitle` varchar(50) NOT NULL,
  `Answer1` varchar(50) NOT NULL,
  `Answer2` varchar(50) NOT NULL,
  `Answer3` varchar(50) NOT NULL,
  `Answer4` varchar(50) NOT NULL,
  `CorrectAnswerIndex` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`TestID`, `QuestionID`, `QuestionTitle`, `Answer1`, `Answer2`, `Answer3`, `Answer4`, `CorrectAnswerIndex`) VALUES
('1', '1', 'ques1', 'ans11', 'ans22', 'ans33', 'ans44', 2),
('5', '10', 'ques10', 'ans101', 'ans102', 'ans103', 'ans104', 2),
('5', '11', 'ques11', 'ans111', 'ans112', 'ans113', 'ans114', 1),
('6', '12', 'ques12', 'ans121', 'ans122', 'ans123', 'ans124', 4),
('7', '13', 'ques13', 'ans131', 'ans132', 'ans133', 'ans134', 2),
('8', '17', 'ques17', 'ans171', 'ans172', 'ans173', 'ans174', 1),
('1', '2', 'ques2', 'ans21', 'ans22', 'ans23', 'ans24', 1),
('2', '3', 'ques3', 'ans31', 'ans32', 'ans33', 'ans34', 3),
('2', '4', 'ques4', 'ans41', 'ans42', 'ans43', 'ans44', 1),
('3', '5', 'ques5', 'ans51', 'ans52', 'ans53', 'ans54', 4),
('3', '6', 'ques6', 'ans61', 'ans62', 'ans63', 'ans64', 3),
('4', '7', 'ques7', 'ans71', 'ans72', 'ans73', 'ans74', 1),
('4', '8', 'ques8', 'ans81', 'ans82', 'ans83', 'ans84', 4),
('5', '9', 'ques9', 'ans91', 'ans92', 'ans93', 'ans94', 3);

-- --------------------------------------------------------

--
-- Table structure for table `selectanswer`
--

CREATE TABLE `selectanswer` (
  `QuestionID` varchar(50) NOT NULL,
  `TakeID` varchar(50) NOT NULL,
  `SelectAnswerIndex` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `selectanswer`
--

INSERT INTO `selectanswer` (`QuestionID`, `TakeID`, `SelectAnswerIndex`) VALUES
('1', '1', 3),
('10', '7', 2),
('12', '5', 4),
('13', '5', 2),
('17', '5', 1),
('2', '1', 4),
('5', '3', 2),
('5', '6', 4),
('8', '7', 4),
('9', '3', 2);

--
-- Triggers `selectanswer`
--
DELIMITER $$
CREATE TRIGGER `after_newSelectedAnswer` AFTER INSERT ON `selectanswer` FOR EACH ROW BEGIN
INSERT INTO selectanswer_backup VALUES (NEW.QuestionID,NEW.TakeID,NEW.SelectAnswerIndex);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_updateSelectedAnswer` AFTER UPDATE ON `selectanswer` FOR EACH ROW BEGIN
UPDATE selectanswer_backup SET
selectanswer_backup.SelectAnswerIndex=NEW.SelectAnswerIndex
WHERE selectanswer_backup.TakeID=NEW.TakeID AND selectanswer_backup.QuestionID=NEW.QuestionID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `selectanswer_backup`
--

CREATE TABLE `selectanswer_backup` (
  `QuestionID` varchar(50) NOT NULL,
  `TakeID` varchar(50) NOT NULL,
  `SelectAnswerIndex` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `selectanswer_backup`
--

INSERT INTO `selectanswer_backup` (`QuestionID`, `TakeID`, `SelectAnswerIndex`) VALUES
('1', '1', 3),
('10', '7', 2),
('12', '5', 4),
('13', '5', 2),
('17', '5', 1),
('2', '1', 4),
('5', '3', 2),
('5', '6', 4),
('8', '7', 4),
('9', '3', 2);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FullName` varchar(50) NOT NULL,
  `School` varchar(50) NOT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Username`, `Password`, `FullName`, `School`, `Email`) VALUES
('aeronn', '786655', 'Aeronn Smithh', 'BK', 'Aeronsmithh@gmail.com'),
('graham', '786255', 'Gramham Maggot', 'BK', 'grahh@gmail.com'),
('jack', '786955', 'Jack Lonmithh', 'BK', 'jackk@gmail.com'),
('jane', '786455', 'Jane Temple', 'BK', 'janeithh@gmail.com'),
('johnsmithh', '786455', 'John Smithh', 'BK', 'johnsmithh@gmail.com'),
('june', '786855', 'Joune Smikle', 'BK', 'joune@gmail.com'),
('kkakie', '786455', 'Kakie Johns', 'BK', 'johnh@gmail.com'),
('kylie', '786555', 'Kylie Grant', 'BK', 'kylie@gmail.com');

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

--
-- Dumping data for table `take`
--

INSERT INTO `take` (`TakeID`, `DateTake`, `Score`, `Duration`, `TestID`, `StudentUsername`) VALUES
('1', '2020-12-12 16:35:38', 1, 60, '1', 'aeronn'),
('2', '2020-12-13 16:39:41', 1, 15, '2', 'graham'),
('3', '2020-12-13 16:40:47', 1, 90, '3', 'jack'),
('4', '2020-12-14 16:41:43', 1, 120, '4', 'jane'),
('5', '2020-12-16 16:42:38', 1, 50, '5', 'johnsmithh'),
('6', '2020-12-17 16:43:07', 1, 50, '6', 'kkakie'),
('7', '2020-12-18 16:43:33', 1, 90, '7', 'june'),
('8', '2020-12-20 16:44:32', 1, 90, '8', 'kylie');

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

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`Username`, `Password`, `FullName`, `PhoneNumber`, `Email`, `IdentityNumber`) VALUES
('amanda', '987301', 'Amanda Person', '903208402', 'amanda@gmail.com', 2131231212),
('david', '786450', 'David Wood', '903201202', 'daviddd@gmail.com', 2100001212),
('king', '078645', 'King Lee', '923458401', 'kingg@gmal.com', 2131238731),
('lee', '098345', 'Lee Jonns', '905408401', 'leea@gmal.com', 2109321211),
('lena', '098645', 'Lena Johns', '903208401', 'lena@gmal.com', 2131231211),
('lucy', '090045', 'Lucy Whits', '903200001', 'lucyy@gmal.com', 2131000011),
('nicole', '098641', 'Nicole Johns', '903208101', 'nicolee@gmal.com', 2931231211),
('paul', '098045', 'Paul Joe', '903202741', 'lpaul@gmal.com', 2131471211),
('Tom', '093864', 'TOm Hart', '903200401', 'toma@gmal.com', 2231231211);

--
-- Triggers `teacher`
--
DELIMITER $$
CREATE TRIGGER `after_teacher_insert` AFTER INSERT ON `teacher` FOR EACH ROW BEGIN
INSERT INTO teacher_backup VALUES (NEW.Username,NEW.Password,NEW.Fullname,NEW.PhoneNumber,NEW.Email,NEW.IdentityNumber);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_backup`
--

CREATE TABLE `teacher_backup` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FullName` varchar(50) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `IdentityNumber` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teacher_backup`
--

INSERT INTO `teacher_backup` (`Username`, `Password`, `FullName`, `PhoneNumber`, `Email`, `IdentityNumber`) VALUES
('amanda', '987301', 'Amanda Person', '903208402', 'amanda@gmail.com', 2131231212),
('david', '786450', 'David Wood', '903201202', 'daviddd@gmail.com', 2100001212),
('king', '078645', 'King Lee', '923458401', 'kingg@gmal.com', 2131238731),
('lee', '098345', 'Lee Jonns', '905408401', 'leea@gmal.com', 2109321211),
('lena', '098645', 'Lena Johns', '903208401', 'lena@gmal.com', 2131231211),
('lucy', '090045', 'Lucy Whits', '903200001', 'lucyy@gmal.com', 2131000011),
('nicole', '098641', 'Nicole Johns', '903208101', 'nicolee@gmal.com', 2931231211),
('paul', '098045', 'Paul Joe', '903202741', 'lpaul@gmal.com', 2131471211),
('Tom', '093864', 'TOm Hart', '903200401', 'toma@gmal.com', 2231231211);

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
-- Dumping data for table `test`
--

INSERT INTO `test` (`TestID`, `TestName`, `Subject`, `Duration`, `Deadline`) VALUES
('1', 'first chapter', 'Math', 60, 'no'),
('2', 'Quiz', 'Math', 15, 'No'),
('3', 'second_chapter', 'Math', 90, 'No'),
('4', 'Final', 'Math', 120, 'No'),
('5', 'First_half', 'English', 50, 'No'),
('6', 'Secon_half', 'English', 50, 'No'),
('7', 'Midterm', 'Physics', 90, 'No'),
('8', 'Final', 'History', 90, 'No');

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
-- Indexes for table `selectanswer_backup`
--
ALTER TABLE `selectanswer_backup`
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
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `tc` (`FullName`);

--
-- Indexes for table `teacher_backup`
--
ALTER TABLE `teacher_backup`
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
