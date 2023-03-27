-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 27, 2023 at 09:52 AM
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
-- Database: `filmek03_27`
--
CREATE DATABASE IF NOT EXISTS `filmek03_27` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `filmek03_27`;

-- --------------------------------------------------------

--
-- Table structure for table `felirat_nyelv`
--

DROP TABLE IF EXISTS `felirat_nyelv`;
CREATE TABLE `felirat_nyelv` (
  `id` int(11) NOT NULL,
  `film_id` int(11) DEFAULT NULL,
  `nyelv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `filmek`
--

DROP TABLE IF EXISTS `filmek`;
CREATE TABLE `filmek` (
  `id` int(11) NOT NULL,
  `cim` varchar(100) DEFAULT NULL,
  `leiras` text,
  `orszag` varchar(60) DEFAULT NULL,
  `evjarat` year(4) DEFAULT NULL,
  `ertekeles` float DEFAULT NULL,
  `hossz` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `filmek_x_szinesz`
--

DROP TABLE IF EXISTS `filmek_x_szinesz`;
CREATE TABLE `filmek_x_szinesz` (
  `id` int(11) NOT NULL,
  `film_id` int(11) DEFAULT NULL,
  `szinesz_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kedvenc_filmek`
--

DROP TABLE IF EXISTS `kedvenc_filmek`;
CREATE TABLE `kedvenc_filmek` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `film_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nyelvenum`
--

DROP TABLE IF EXISTS `nyelvenum`;
CREATE TABLE `nyelvenum` (
  `id` int(11) NOT NULL,
  `nyelv` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `szinesz`
--

DROP TABLE IF EXISTS `szinesz`;
CREATE TABLE `szinesz` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `szuletes` date DEFAULT NULL,
  `nemzetiseg` varchar(20) DEFAULT NULL,
  `nem` varchar(20) DEFAULT NULL,
  `dijakszama` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `szinkron_nyelv`
--

DROP TABLE IF EXISTS `szinkron_nyelv`;
CREATE TABLE `szinkron_nyelv` (
  `id` int(11) NOT NULL,
  `film_id` int(11) DEFAULT NULL,
  `nyelv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` char(64) DEFAULT NULL,
  `szuletes` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_x_filmertekeles`
--

DROP TABLE IF EXISTS `user_x_filmertekeles`;
CREATE TABLE `user_x_filmertekeles` (
  `id` int(11) NOT NULL,
  `film_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ertekeles` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `felirat_nyelv`
--
ALTER TABLE `felirat_nyelv`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `filmek`
--
ALTER TABLE `filmek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `filmek_x_szinesz`
--
ALTER TABLE `filmek_x_szinesz`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kedvenc_filmek`
--
ALTER TABLE `kedvenc_filmek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nyelvenum`
--
ALTER TABLE `nyelvenum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `szinesz`
--
ALTER TABLE `szinesz`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `szinkron_nyelv`
--
ALTER TABLE `szinkron_nyelv`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_x_filmertekeles`
--
ALTER TABLE `user_x_filmertekeles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `felirat_nyelv`
--
ALTER TABLE `felirat_nyelv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `filmek`
--
ALTER TABLE `filmek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `filmek_x_szinesz`
--
ALTER TABLE `filmek_x_szinesz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kedvenc_filmek`
--
ALTER TABLE `kedvenc_filmek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nyelvenum`
--
ALTER TABLE `nyelvenum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `szinesz`
--
ALTER TABLE `szinesz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `szinkron_nyelv`
--
ALTER TABLE `szinkron_nyelv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_x_filmertekeles`
--
ALTER TABLE `user_x_filmertekeles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
