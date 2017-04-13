-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2017 at 07:53 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iot_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `board_info`
--

CREATE TABLE `board_info` (
  `board_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `board_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `board_detail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lab_name` varchar(5) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store information of board';

--
-- Dumping data for table `board_info`
--

INSERT INTO `board_info` (`board_id`, `board_name`, `board_detail`, `lab_name`) VALUES
('A1', 'Arduino Uno', 'Arduino Uno', '701H6'),
('A2', 'Arduino Mega', 'Arduino Mega', '702H6');

-- --------------------------------------------------------

--
-- Table structure for table `board_log`
--

CREATE TABLE `board_log` (
  `board_log` int(11) NOT NULL,
  `board_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `borrow_time` datetime NOT NULL,
  `return_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store log of board' ROW_FORMAT=COMPACT;

--
-- Dumping data for table `board_log`
--

INSERT INTO `board_log` (`board_log`, `board_id`, `user_id`, `borrow_time`, `return_time`) VALUES
(1, 'A1', '51303576', '2017-03-10 05:00:00', '2017-03-10 10:00:00'),
(5, 'A2', '51303576', '2017-03-10 13:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book_log`
--

CREATE TABLE `book_log` (
  `book_id` int(11) NOT NULL,
  `user_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `lab_name` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `purpose` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store log of booking' ROW_FORMAT=COMPACT;

--
-- Dumping data for table `book_log`
--

INSERT INTO `book_log` (`book_id`, `user_id`, `lab_name`, `start_time`, `end_time`, `purpose`) VALUES
(1, '51303576', '701H6', '2017-03-11 06:06:01', '2017-03-11 07:10:22', 'Seminar'),
(2, '51300665', '702H6', '2017-03-11 10:00:00', '2017-03-11 13:00:00', 'Classes'),
(3, '51303576', '701H6', '2017-03-10 11:00:00', '2017-03-10 10:00:00', 'Seminar'),
(4, '51300665', '702H6', '2017-03-28 00:00:00', '2017-03-29 00:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `card_info`
--

CREATE TABLE `card_info` (
  `card_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To map card_id to user_id';

--
-- Dumping data for table `card_info`
--

INSERT INTO `card_info` (`card_id`, `user_id`) VALUES
('0000002', '51300665'),
('0000001', '51303576');

-- --------------------------------------------------------

--
-- Table structure for table `lab_info`
--

CREATE TABLE `lab_info` (
  `lab_name` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `capacity` int(2) NOT NULL,
  `number_of_pc` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store information of lab';

--
-- Dumping data for table `lab_info`
--

INSERT INTO `lab_info` (`lab_name`, `capacity`, `number_of_pc`) VALUES
('701H6', 50, 50),
('702H6', 50, 50);

-- --------------------------------------------------------

--
-- Table structure for table `lab_log`
--

CREATE TABLE `lab_log` (
  `lab_name` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `available` tinyint(1) NOT NULL,
  `number_student` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store log of lab';

--
-- Dumping data for table `lab_log`
--

INSERT INTO `lab_log` (`lab_name`, `available`, `number_student`) VALUES
('701H6', 0, 20),
('702H6', 1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `pc_info`
--

CREATE TABLE `pc_info` (
  `pc_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `pc_os` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'operate system',
  `pc_detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lab_name` varchar(5) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store information of pc';

--
-- Dumping data for table `pc_info`
--

INSERT INTO `pc_info` (`pc_id`, `pc_os`, `pc_detail`, `lab_name`) VALUES
('PC01', 'Window 10', 'Dell vostro', '701H6'),
('PC02', 'Window 10', 'Dell vostro', '702H6');

-- --------------------------------------------------------

--
-- Table structure for table `pc_log`
--

CREATE TABLE `pc_log` (
  `pc_log` int(11) NOT NULL,
  `pc_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `borrow_time` datetime NOT NULL,
  `return_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store log of pc';

--
-- Dumping data for table `pc_log`
--

INSERT INTO `pc_log` (`pc_log`, `pc_id`, `user_id`, `borrow_time`, `return_time`) VALUES
(1, 'PC01', '51303576', '2017-03-10 13:16:07', NULL),
(2, 'PC02', '51300665', '2017-03-10 08:11:17', '2017-03-10 12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `user_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL COMMENT 'mssv/msgv',
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `firstname` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'student/teacher',
  `gender` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'male/female/other',
  `birthday` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store information of user' ROW_FORMAT=COMPACT;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`user_id`, `password`, `firstname`, `lastname`, `role`, `gender`, `birthday`) VALUES
('51300665', 'abcdef', 'Dung', 'Nguyen Dinh', 'Student', 'Male', '1995-08-08'),
('51303576', 'fedcba', 'Tan', 'Le Huu', 'Student', 'Male', '1995-08-25');

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE `user_log` (
  `user_log` int(11) NOT NULL,
  `user_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `in_time` datetime NOT NULL,
  `out_time` datetime DEFAULT NULL,
  `lab_name` varchar(5) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store log of user';

--
-- Dumping data for table `user_log`
--

INSERT INTO `user_log` (`user_log`, `user_id`, `in_time`, `out_time`, `lab_name`) VALUES
(1, '51303576', '2017-03-10 10:02:13', '2017-03-10 09:15:16', '701H6'),
(2, '51300665', '2017-03-10 08:00:00', NULL, '702H6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `board_info`
--
ALTER TABLE `board_info`
  ADD PRIMARY KEY (`board_id`),
  ADD KEY `board_lab` (`lab_name`);

--
-- Indexes for table `board_log`
--
ALTER TABLE `board_log`
  ADD PRIMARY KEY (`board_log`),
  ADD KEY `board_log_board_info` (`board_id`),
  ADD KEY `board_log_user_info` (`user_id`);

--
-- Indexes for table `book_log`
--
ALTER TABLE `book_log`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `book_user` (`user_id`),
  ADD KEY `book_lab` (`lab_name`);

--
-- Indexes for table `card_info`
--
ALTER TABLE `card_info`
  ADD PRIMARY KEY (`card_id`),
  ADD KEY `card_to_user` (`user_id`);

--
-- Indexes for table `lab_info`
--
ALTER TABLE `lab_info`
  ADD PRIMARY KEY (`lab_name`);

--
-- Indexes for table `lab_log`
--
ALTER TABLE `lab_log`
  ADD PRIMARY KEY (`lab_name`);

--
-- Indexes for table `pc_info`
--
ALTER TABLE `pc_info`
  ADD PRIMARY KEY (`pc_id`),
  ADD KEY `pc_lab` (`lab_name`);

--
-- Indexes for table `pc_log`
--
ALTER TABLE `pc_log`
  ADD PRIMARY KEY (`pc_log`),
  ADD KEY `pc_log_pc_info` (`pc_id`),
  ADD KEY `pc_log_user_info` (`user_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`user_log`),
  ADD KEY `user_log_user_info` (`user_id`),
  ADD KEY `user_log_lab_info` (`lab_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `board_log`
--
ALTER TABLE `board_log`
  MODIFY `board_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `book_log`
--
ALTER TABLE `book_log`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `pc_log`
--
ALTER TABLE `pc_log`
  MODIFY `pc_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user_log`
--
ALTER TABLE `user_log`
  MODIFY `user_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `board_info`
--
ALTER TABLE `board_info`
  ADD CONSTRAINT `board_lab` FOREIGN KEY (`lab_name`) REFERENCES `lab_info` (`lab_name`);

--
-- Constraints for table `board_log`
--
ALTER TABLE `board_log`
  ADD CONSTRAINT `board_log_board_info` FOREIGN KEY (`board_id`) REFERENCES `board_info` (`board_id`),
  ADD CONSTRAINT `board_log_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `book_log`
--
ALTER TABLE `book_log`
  ADD CONSTRAINT `book_lab` FOREIGN KEY (`lab_name`) REFERENCES `lab_info` (`lab_name`),
  ADD CONSTRAINT `book_user` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `card_info`
--
ALTER TABLE `card_info`
  ADD CONSTRAINT `card_to_user` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `pc_info`
--
ALTER TABLE `pc_info`
  ADD CONSTRAINT `pc_lab` FOREIGN KEY (`lab_name`) REFERENCES `lab_info` (`lab_name`);

--
-- Constraints for table `pc_log`
--
ALTER TABLE `pc_log`
  ADD CONSTRAINT `pc_log_pc_info` FOREIGN KEY (`pc_id`) REFERENCES `pc_info` (`pc_id`),
  ADD CONSTRAINT `pc_log_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

--
-- Constraints for table `user_log`
--
ALTER TABLE `user_log`
  ADD CONSTRAINT `user_log_lab_info` FOREIGN KEY (`lab_name`) REFERENCES `lab_info` (`lab_name`),
  ADD CONSTRAINT `user_log_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
