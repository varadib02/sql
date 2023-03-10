-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 10, 2023 at 12:31 PM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dualis_webshop`
--
CREATE DATABASE IF NOT EXISTS `dualis_webshop` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dualis_webshop`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `addShippingAddress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addShippingAddress` (IN `countryIN` VARCHAR(100) CHARSET utf8, IN `countyIN` VARCHAR(100) CHARSET utf8, IN `cityIN` VARCHAR(100) CHARSET utf8, IN `zipcodeIN` INT(10), IN `streetIN` VARCHAR(100) CHARSET utf8, IN `houseIN` VARCHAR(20) CHARSET utf8, IN `doorIN` VARCHAR(20) CHARSET utf8)   INSERT INTO `shipping_address`(
    `shipping_address`.`country`,
    `shipping_address`.`county`,
    `shipping_address`.`city`,
    `shipping_address`.`zipcode`,
    `shipping_address`.`street`,
    `shipping_address`.`house`,
    `shipping_address`.`door`
)
VALUES(
    countryIN,
    countyIN,
    cityIN,
    zipcodeIN,
    streetIN,
    houseIN,
    doorIN
)$$

DROP PROCEDURE IF EXISTS `countUserWithOut`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `countUserWithOut` (OUT `result` INT(20))   SELECT COUNT(*) INTO result
FROM `user`$$

DROP PROCEDURE IF EXISTS `emailById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `emailById` (IN `emailIN` VARCHAR(100))   UPDATE user
SET user.status_id=1
WHERE user.email=emailIN$$

DROP PROCEDURE IF EXISTS `getAllUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUser` ()   SELECT * FROM `user`$$

DROP PROCEDURE IF EXISTS `getUserByEmail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByEmail` (IN `emailIN` VARCHAR(100) CHARSET utf8)   SELECT * 
FROM `user`
WHERE `user`.`email` = emailIN$$

DROP PROCEDURE IF EXISTS `getUserById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById` (IN `idIN` BIGINT(11))   SELECT * 
FROM `user` 
WHERE `user`.`id` = idIN$$

DROP PROCEDURE IF EXISTS `getUserLikeEmail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserLikeEmail` (IN `emailIN` VARCHAR(100))   SELECT *
FROM `user`
WHERE `user`.`email` LIKE CONCAT("%", emailIN, "%")
ORDER BY `user`.`id` ASC$$

DROP PROCEDURE IF EXISTS `insertUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUser` ()   INSERT INTO `user`(
    `user`.`email`, 
    `user`.`password`,
    `user`.`title`, 
    `user`.`first_name`, 
    `user`.`last_name`, 
    `user`.`user_name`, 
    `user`.`phone`, 
    `user`.`status_id`,
    `user`.`guid`,
    `user`.`role_id`
)
VALUES(
	"unga.bunga@gmail.com",
    "asd123",
    "Dr.",
    "Béla",
    "Király",
    "krumplisteszta",
    "+36123456789",
    0,
    uuid(),
    1
)$$

DROP PROCEDURE IF EXISTS `insertUserAnother`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUserAnother` (IN `emailIN` VARCHAR(100) CHARSET utf8, IN `passwordIN` TEXT CHARSET utf8, IN `titleIN` VARCHAR(25) CHARSET utf8, IN `firstNameIN` VARCHAR(25) CHARSET utf8, IN `lastNameIN` VARCHAR(25) CHARSET utf8, IN `userNameIN` VARCHAR(50) CHARSET utf8, IN `phoneIN` VARCHAR(12) CHARSET utf8, IN `roleIdIN` BIGINT(11))   INSERT INTO `user`(
    `user`.`email`, 
    `user`.`password`,
    `user`.`title`, 
    `user`.`first_name`, 
    `user`.`last_name`, 
    `user`.`user_name`, 
    `user`.`phone`, 
    `user`.`status_id`,
    `user`.`guid`,
    `user`.`role_id`
)
VALUES(
	emailIN,
    SHA2(passwordIN, 256),
    titleIN,
    firstNameIN,
    lastNameIN,
    userNameIN,
    phoneIN,
    0,
    uuid(),
    roleIdIN
)$$

DROP PROCEDURE IF EXISTS `logicalDeleteuser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `logicalDeleteuser` (IN `idIn` BIGINT(11))   UPDATE user
SET 	
	user.status_id = 2,
	user.deleted_at=NOW(),
    user.updated_at=NOW()
WHERE user.id=idIN$$

DROP PROCEDURE IF EXISTS `nullaStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nullaStatus` (OUT `result` INT(11))   SELECT COUNT(*) INTO result
FROM `user`
WHERE `user`.`status_id` = 0$$

DROP PROCEDURE IF EXISTS `updateUserNameById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserNameById` (IN `idIN` INT(11), IN `userNameIN` VARCHAR(50) CHARSET utf8)   BEGIN

UPDATE user
Set user.user_name=userNameIN,
user.updated_at=NOW()
WHERE user.id=idIN;

SELECT * 
FROM user
WHERE user.id=idIN;

END$$

DROP PROCEDURE IF EXISTS `userCount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `userCount` ()   SELECT COUNT(`user`.`id`)
FROM `user`$$

DROP PROCEDURE IF EXISTS `userRole`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `userRole` (IN `userNameIN` VARCHAR(100) CHARSET utf8)   SELECT `user`.`role_id`
FROM `user`
WHERE `user`.`user_name` = userNameIN$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `value`) VALUES
(1, 'Elektronikai cikk'),
(2, 'Bútor'),
(3, 'Sporteszköz');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) NOT NULL,
  `shipping_address_id` bigint(11) NOT NULL,
  `amount` int(20) NOT NULL,
  `status_id` bigint(11) NOT NULL DEFAULT '1' COMMENT 'A 1-s status id azt jelenti hogy feldolgozás alatt',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Ez a mező fogja tárolni hogy mikor történt a rendelés',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_x_product`
--

DROP TABLE IF EXISTS `order_x_product`;
CREATE TABLE IF NOT EXISTS `order_x_product` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(11) NOT NULL,
  `product_id` bigint(11) NOT NULL,
  `product_amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `price` int(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `img` text NOT NULL COMMENT 'A termék kép szerver elérési útja',
  `description` text,
  `status_id` bigint(11) NOT NULL DEFAULT '5' COMMENT 'Az 5-ös status id azt jelenti hogy a termék elérhetősége aktív',
  `guid` text NOT NULL,
  `category_id` bigint(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `value`) VALUES
(1, 'superadmin'),
(2, 'admin'),
(3, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_address`
--

DROP TABLE IF EXISTS `shipping_address`;
CREATE TABLE IF NOT EXISTS `shipping_address` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(100) NOT NULL,
  `county` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `zipcode` int(10) NOT NULL,
  `street` varchar(100) NOT NULL,
  `house` varchar(20) NOT NULL,
  `door` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shipping_address`
--

INSERT INTO `shipping_address` (`id`, `country`, `county`, `city`, `zipcode`, `street`, `house`, `door`) VALUES
(1, 'Iran', 'Georgia', 'Mortonburgh', 6333, 'Értelmesebb utca', '5', '7'),
(2, 'Reunion', 'Maine', 'Zulaufbury', 30082, 'Schultz Drives', '1', '2'),
(3, 'Guadeloupe', 'Georgia', 'North Jamal', 97741, 'Ursula Lakes', '1', '5'),
(4, 'Philippines', 'Iowa', 'West Makennamouth', 21744, 'Turner Lights', '8', '1'),
(5, 'Cyprus', 'Georgia', 'Wisokyborough', 52557, 'Goyette Street', '2', '9'),
(6, 'Tuvalu', 'Nevada', 'East Elmira', 45769, 'Mertz Estate', '3', ''),
(7, 'British Virgin Islands', 'Georgia', 'Port Edenfurt', 43542, 'Kennedi Extensions', '', '6'),
(8, 'Chad', 'Massachusetts', 'Kubtown', 93275, 'Zetta Shore', '3', '8'),
(9, 'Gambia', 'SouthCarolina', 'Lake Christafurt', 72090, 'Moen Drives', '4', '1'),
(10, 'Saint Barthelemy', 'Indiana', 'Bernhardstad', 89632, 'Dare Overpass', '', '6'),
(11, 'USA', 'Nevada', 'Las Vegas', 123456, 'Main Str', '145', '');

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
CREATE TABLE IF NOT EXISTS `token` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `token` text NOT NULL,
  `expire` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `token_type` enum('passwordReplacement','registration') NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `title` varchar(25) DEFAULT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `status_id` bigint(11) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `guid` text NOT NULL,
  `role_id` bigint(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `title`, `first_name`, `last_name`, `user_name`, `phone`, `status_id`, `last_login`, `created_at`, `deleted_at`, `updated_at`, `guid`, `role_id`) VALUES
(1, 'susanna.rogahn@example.org', '436f9918fef61cdd7ab20e253def3458ac137b85', 'Dr.', 'Rosetta', 'Bailey', 'átvagyírva haha', '1-717-106-57', 1, '1993-02-04 22:35:34', '2020-01-12 00:32:55', '1980-05-19 17:15:50', '2009-03-06 07:29:23', 'b83b155d-870a-3d12-b4b5-8586dcfe04dd', 3),
(2, 'nmedhurst@example.hu', '802accc55455e4358862dd2ee7b0a68fe65c2acd', 'Mr.', 'Gilberto', 'Kihn', 'ashley84', '662.446.8939', 0, '2013-08-05 00:12:32', '1994-03-09 05:47:31', '1974-09-27 17:56:50', '1989-07-27 15:09:13', '5c59bc76-32d3-3d8c-b7ea-02148baa4a93', 8),
(3, 'candelario01@example.org', '8a3605e2607c89065dbd6667de9512d3834db1c2', 'Prof.', 'Stephan', 'Cassin', 'evie.oberbrunner', '(733)699-226', 3, '1989-01-22 04:00:38', '1993-09-20 13:39:42', '2000-07-15 01:07:18', '1981-10-02 07:02:11', 'cda107e2-a3d4-3e63-b622-eda55b86f0c6', 6),
(4, 'vhudson@example.com', '22358487dc0fcaf885af63240ac8d1fd1dbab8df', 'Mrs.', 'Dagmar', 'Crist', 'evans.turcotte', '1-799-233-35', 8, '2016-09-26 15:51:35', '2019-09-05 12:38:04', '1988-12-24 22:08:17', '2001-08-17 00:04:30', '87771a16-c421-3c59-8625-92978dd6cd0d', 3),
(5, 'oweissnat@example.org', 'b20216960a463e74970388dabbb46a37b0184547', 'Miss', 'Roma', 'Lockman', 'reinhold.mertz', '1-160-250-82', 2, '1981-03-06 07:29:26', '1992-07-14 12:38:20', '2002-03-17 02:01:10', '1990-10-19 00:04:40', 'e036f230-aa25-34cc-8679-7d2c8502286f', 4),
(6, 'trent.toy@example.net', '21c955f5726b53c0195d122d7840ad9597748de2', 'Dr.', 'Mia', 'Roberts', 'mgleason', '07518242399', 4, '2009-08-24 03:43:45', '2005-04-19 22:44:52', '2015-04-18 20:02:13', '1999-11-06 18:00:46', '09e7fd4a-5dd8-31a9-90d5-db6518a09aa6', 7),
(7, 'conor86@example.net', '1703cf95bbf537f3a88b79f5a3291b4794ea20c9', 'Prof.', 'Kevin', 'Russel', 'gborer', '(858)144-415', 3, '1973-01-13 16:14:43', '2005-08-21 12:16:56', '1991-05-08 13:10:19', '1988-08-08 01:55:10', 'e95189c3-c91d-35ab-9e39-fba90f01610d', 8),
(8, 'runolfsdottir.vincenza@example.org', 'b94bf92fbe093612cf171900d8521ef07899dae0', 'Ms.', 'Brooklyn', 'Hermiston', 'pterry', '618.502.7952', 6, '2011-07-20 03:13:21', '1979-09-24 07:01:28', '1985-05-30 11:09:16', '2003-09-26 03:31:19', '1d951f40-7255-3665-95ed-6cadf62cc0d4', 8),
(9, 'qbahringer@example.net', 'e51180e2439fb64afb7746dd7daf2a2f7a385fa2', 'Mr.', 'Wade', 'Christiansen', 'karelle.lynch', '(695)628-241', 5, '1994-10-21 17:13:17', '1971-09-24 19:02:33', '1986-01-12 06:29:20', '1974-06-12 07:39:39', 'af1b6312-177e-3190-bc4c-a6081160b79b', 4),
(10, 'oma.tromp@example.net', '5de6a129cb8cc0d7b22461693c2179d012d91039', 'Dr.', 'Arden', 'Gislason', 'ckutch', '1-226-672-22', 5, '2013-12-13 10:59:47', '2014-07-16 06:33:34', '1979-01-08 04:59:01', '1985-05-05 04:11:38', 'd157ad36-f99d-3716-881c-baab0a10d2fb', 9),
(11, 'unga.bunga@gmail.com', 'asd123', 'Dr.', 'Béla', 'Király', 'krumplisteszta', '+36123456789', 0, NULL, '2023-03-03 11:23:11', NULL, NULL, '6624fd16-b9ad-11ed-b746-c85b760ec875', 1),
(12, 'x.y@gmail.com', 'd53751a66b586d433025c6d372833625d6d38c98697793bdc3bb69c6bd70d88d', '', 'Sanyi', 'Titletelen', 'Sanyiakiraly', '+36012345678', 0, NULL, '2023-03-03 11:40:29', NULL, NULL, 'd1183e64-b9af-11ed-b746-c85b760ec875', 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_x_shipping_address`
--

DROP TABLE IF EXISTS `user_x_shipping_address`;
CREATE TABLE IF NOT EXISTS `user_x_shipping_address` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) NOT NULL,
  `shipping_address_id` bigint(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
