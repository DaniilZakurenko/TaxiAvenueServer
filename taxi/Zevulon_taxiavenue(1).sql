-- phpMyAdmin SQL Dump
-- version 3.4.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 18, 2014 at 11:52 AM
-- Server version: 5.5.33
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Zevulon_taxiavenue`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_services`
--

CREATE TABLE `additional_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `title` varchar(80) NOT NULL,
  `type` enum('UAH','PCT') NOT NULL,
  `value` float NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `additional_services`
--

INSERT INTO `additional_services` (`id`, `name`, `title`, `type`, `value`, `active`) VALUES
(1, 'salonLoading', 'Загрузка салона', 'UAH', 3, 1),
(2, 'animal', 'Животное', 'UAH', 8, 1),
(3, 'nameSign', 'Встреча с табл.', 'PCT', 15, 1),
(4, 'airCondition', 'Кондиционер', 'UAH', 5, 1),
(5, 'courierDelivery', 'Курьер', 'UAH', 25, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cash_payment_tarif`
--

CREATE TABLE `cash_payment_tarif` (
  `type` int(11) NOT NULL COMMENT 'Гибкий тариф',
  `name` varchar(50) NOT NULL,
  `fluidTarification` float NOT NULL COMMENT 'Добавочная стоимость',
  `extraCost` float NOT NULL COMMENT 'Минимум для гибкого тарифа',
  `fluidTarifMin` float NOT NULL COMMENT 'Учитывать км в минимуме',
  `kmMin` float NOT NULL COMMENT 'Простой',
  `downtime` float NOT NULL COMMENT 'Почасовой тариф',
  `hourTarif` float NOT NULL COMMENT 'Минимальный почасовой тариф',
  `minHourTarif` float NOT NULL COMMENT 'Тариф за город в один конец',
  `ootOneWayTarif` float NOT NULL COMMENT 'Тариф за город в один конец',
  `ootTnbTarif` float NOT NULL COMMENT 'Тариф за город в оба конца',
  `update_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cash_payment_tarif`
--

INSERT INTO `cash_payment_tarif` (`type`, `name`, `fluidTarification`, `extraCost`, `fluidTarifMin`, `kmMin`, `downtime`, `hourTarif`, `minHourTarif`, `ootOneWayTarif`, `ootTnbTarif`, `update_time`) VALUES
(1, 'Бизнес', 1.4, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:20'),
(2, 'Премиум', 2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:20'),
(3, 'Груз', 1.9, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:20'),
(4, 'Универсал', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:20'),
(5, 'Микроавтобус', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:20'),
(6, 'Базовый', 2.9, 5, 25, 5300, 0.8, 1.25, 80, 4.5, 2.25, '2014-06-04 17:50:20');

-- --------------------------------------------------------

--
-- Table structure for table `common_tariffication`
--

CREATE TABLE `common_tariffication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `common_tariffication`
--

INSERT INTO `common_tariffication` (`id`, `value`) VALUES
(1, '{"reservationOrderExtra":{"active":1,"value":"5.55","type":"CNT"},"eachPointExtra":{"active":1,"point":"2","value":"3.24"},"snowExtra":{"active":"on","value":"5.76","type":"PCT"},"nonCash":{"active":1,"value":"15","type":"CNT"},"grach":{"active":1,"value":"0.6","type":"CNT"}}');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `phone`, `name`) VALUES
(1, '+380957536866', 'Виталий'),
(2, '+380503427357', ''),
(3, '0503427357', ''),
(4, '+123456789', ''),
(5, '555-55-55', 'Чапаев'),
(6, '777-77-77', ''),
(7, '55-55-55', ''),
(8, '332211', ''),
(9, '+380957533686', ''),
(10, '555', ''),
(11, '8887777', ''),
(12, '', ''),
(13, '77788855', ''),
(14, '1112233', ''),
(15, '993355', ''),
(16, '3332255', 'Иван Сергеевич'),
(17, '3335588', ''),
(18, '33366999', ''),
(19, '7774455', ''),
(20, '555999666', ''),
(21, '1111148888', '');

-- --------------------------------------------------------

--
-- Table structure for table `driver_order_history`
--

CREATE TABLE `driver_order_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `order_send_datetime` datetime NOT NULL,
  `order_close_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `driver_id` (`driver_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `driver_order_history`
--

INSERT INTO `driver_order_history` (`id`, `driver_id`, `order_id`, `status`, `order_send_datetime`, `order_close_datetime`) VALUES
(1, 36, 1, 9, '0000-00-00 00:00:00', '2014-05-05 11:06:50'),
(2, 49, 2, 16, '0000-00-00 00:00:00', '2014-05-05 11:05:19'),
(3, 50, 2, 16, '0000-00-00 00:00:00', '2014-05-05 11:05:28'),
(4, 49, 5, 16, '0000-00-00 00:00:00', '2014-05-05 15:10:28'),
(5, 50, 5, 16, '0000-00-00 00:00:00', '2014-05-05 15:10:39'),
(6, 36, 5, 9, '0000-00-00 00:00:00', '2014-05-06 16:39:46'),
(7, 36, 6, 9, '0000-00-00 00:00:00', '2014-05-06 14:23:00'),
(8, 49, 6, 16, '0000-00-00 00:00:00', '2014-05-05 15:18:28'),
(9, 50, 6, 16, '0000-00-00 00:00:00', '2014-05-05 15:18:37'),
(10, 36, 7, 9, '0000-00-00 00:00:00', '2014-05-06 14:20:08'),
(11, 49, 7, 16, '0000-00-00 00:00:00', '2014-05-05 15:26:09'),
(12, 50, 7, 16, '0000-00-00 00:00:00', '2014-05-05 15:27:45'),
(13, 36, 8, 9, '0000-00-00 00:00:00', '2014-05-06 14:21:33'),
(14, 49, 8, 16, '0000-00-00 00:00:00', '2014-05-05 15:39:07'),
(15, 50, 8, 16, '0000-00-00 00:00:00', '2014-05-05 15:39:33'),
(16, 49, 9, 9, '0000-00-00 00:00:00', '2014-05-05 17:38:24'),
(17, 36, 10, 9, '0000-00-00 00:00:00', '2014-05-05 17:40:54'),
(18, 36, 3, 9, '0000-00-00 00:00:00', '2014-05-06 16:33:38'),
(19, 36, 2, 9, '0000-00-00 00:00:00', '2014-05-06 16:38:14'),
(20, 36, 4, 16, '0000-00-00 00:00:00', '2014-05-06 16:42:41'),
(21, 24, 4, 9, '0000-00-00 00:00:00', '2014-05-06 17:41:32'),
(22, 36, 16, 16, '0000-00-00 00:00:00', '2014-05-06 17:41:48'),
(23, 24, 16, 9, '0000-00-00 00:00:00', '2014-05-06 17:42:22'),
(24, 36, 18, 16, '0000-00-00 00:00:00', '2014-05-07 11:50:22'),
(25, 36, 21, 16, '0000-00-00 00:00:00', '2014-05-07 11:55:14'),
(26, 36, 22, 9, '0000-00-00 00:00:00', '2014-05-07 12:01:16'),
(27, 36, 23, 16, '0000-00-00 00:00:00', '2014-05-07 12:02:04'),
(28, 24, 23, 9, '0000-00-00 00:00:00', '2014-05-07 12:07:15'),
(29, 24, 21, 9, '0000-00-00 00:00:00', '2014-05-07 12:08:44'),
(30, 24, 13, 9, '0000-00-00 00:00:00', '2014-05-07 12:10:10'),
(31, 24, 19, 9, '0000-00-00 00:00:00', '2014-05-07 12:10:53'),
(32, 36, 14, 16, '0000-00-00 00:00:00', '2014-05-07 12:45:37'),
(33, 24, 15, 9, '0000-00-00 00:00:00', '2014-05-07 12:46:15'),
(34, 24, 11, 9, '0000-00-00 00:00:00', '2014-05-07 12:46:40'),
(35, 24, 20, 9, '0000-00-00 00:00:00', '2014-05-07 12:46:54'),
(36, 24, 28, 9, '0000-00-00 00:00:00', '2014-05-08 23:35:30'),
(37, 24, 29, 9, '0000-00-00 00:00:00', '2014-05-08 23:36:22'),
(38, 24, 30, 9, '0000-00-00 00:00:00', '2014-05-08 23:46:02'),
(39, 24, 31, 2, '0000-00-00 00:00:00', '2014-05-09 00:00:55'),
(40, 24, 32, 9, '0000-00-00 00:00:00', '2014-05-09 00:02:31'),
(41, 24, 33, 2, '0000-00-00 00:00:00', '2014-05-09 00:07:43'),
(42, 36, 37, 9, '0000-00-00 00:00:00', '2014-05-16 10:41:27'),
(43, 51, 37, 16, '0000-00-00 00:00:00', '2014-05-16 10:40:40'),
(44, 50, 37, 16, '0000-00-00 00:00:00', '2014-05-16 10:40:45'),
(45, 49, 37, 16, '0000-00-00 00:00:00', '2014-05-16 10:40:51'),
(46, 50, 38, 9, '0000-00-00 00:00:00', '2014-05-16 10:56:09'),
(47, 49, 38, 16, '0000-00-00 00:00:00', '2014-05-16 10:55:08'),
(48, 49, 40, 16, '0000-00-00 00:00:00', '2014-05-16 11:16:15'),
(49, 50, 40, 16, '0000-00-00 00:00:00', '2014-05-16 11:16:56'),
(50, 49, 41, 16, '0000-00-00 00:00:00', '2014-05-16 11:19:22'),
(51, 50, 41, 16, '0000-00-00 00:00:00', '2014-05-16 11:19:30'),
(52, 36, 42, 9, '0000-00-00 00:00:00', '2014-05-16 11:28:12'),
(53, 36, 43, 9, '0000-00-00 00:00:00', '2014-05-16 11:29:46'),
(54, 36, 44, 9, '0000-00-00 00:00:00', '2014-05-16 11:30:26'),
(55, 36, 45, 16, '0000-00-00 00:00:00', '2014-05-16 11:31:09'),
(56, 49, 45, 9, '0000-00-00 00:00:00', '2014-05-16 11:31:30'),
(57, 50, 45, 16, '0000-00-00 00:00:00', '2014-05-16 11:31:18'),
(58, 36, 46, 9, '0000-00-00 00:00:00', '2014-05-16 15:27:00'),
(59, 49, 47, 16, '0000-00-00 00:00:00', '2014-05-19 10:01:25'),
(60, 50, 49, 16, '0000-00-00 00:00:00', '2014-05-19 10:16:42'),
(61, 49, 49, 16, '0000-00-00 00:00:00', '2014-05-19 10:16:48'),
(62, 49, 50, 16, '0000-00-00 00:00:00', '2014-05-19 10:17:56'),
(63, 49, 51, 16, '0000-00-00 00:00:00', '2014-05-19 10:21:06'),
(64, 49, 52, 16, '0000-00-00 00:00:00', '2014-05-19 10:55:27'),
(65, 49, 53, 16, '0000-00-00 00:00:00', '2014-05-19 11:27:36'),
(66, 49, 54, 16, '0000-00-00 00:00:00', '2014-05-19 14:49:13'),
(67, 36, 56, 16, '0000-00-00 00:00:00', '2014-05-19 17:21:50'),
(68, 49, 56, 9, '0000-00-00 00:00:00', '2014-05-19 17:22:39'),
(69, 36, 57, 16, '0000-00-00 00:00:00', '2014-05-19 17:24:01'),
(70, 49, 57, 16, '0000-00-00 00:00:00', '2014-05-19 17:24:06'),
(71, 36, 58, 16, '0000-00-00 00:00:00', '2014-05-19 17:29:56'),
(72, 49, 58, 9, '0000-00-00 00:00:00', '2014-05-19 17:31:09'),
(73, 24, 59, 9, '0000-00-00 00:00:00', '2014-05-21 16:00:34'),
(74, 24, 60, 9, '0000-00-00 00:00:00', '2014-05-21 16:30:55'),
(75, 24, 61, 9, '0000-00-00 00:00:00', '2014-05-21 16:34:15'),
(76, 36, 62, 9, '0000-00-00 00:00:00', '2014-05-23 20:45:18'),
(77, 36, 63, 9, '0000-00-00 00:00:00', '2014-05-23 20:52:54'),
(78, 36, 64, 9, '0000-00-00 00:00:00', '2014-05-26 14:30:28'),
(79, 36, 65, 9, '0000-00-00 00:00:00', '2014-05-27 11:26:49'),
(80, 24, 66, 9, '0000-00-00 00:00:00', '2014-05-26 19:21:33'),
(81, 24, 67, 9, '0000-00-00 00:00:00', '2014-05-26 19:24:57'),
(82, 24, 68, 9, '0000-00-00 00:00:00', '2014-05-26 19:27:49'),
(83, 24, 69, 9, '0000-00-00 00:00:00', '2014-05-26 19:30:07'),
(84, 36, 71, 9, '0000-00-00 00:00:00', '2014-05-27 15:18:21'),
(85, 36, 70, 9, '0000-00-00 00:00:00', '2014-05-27 15:19:18'),
(86, 36, 72, 9, '0000-00-00 00:00:00', '2014-05-27 15:32:35'),
(87, 36, 73, 9, '0000-00-00 00:00:00', '2014-05-27 16:31:10'),
(88, 36, 74, 9, '0000-00-00 00:00:00', '2014-05-27 17:44:05'),
(89, 24, 75, 9, '0000-00-00 00:00:00', '2014-05-27 17:15:52'),
(90, 36, 79, 2, '0000-00-00 00:00:00', '2014-06-01 20:59:11'),
(91, 36, 80, 9, '0000-00-00 00:00:00', '2014-06-01 21:04:36'),
(92, 36, 81, 9, '0000-00-00 00:00:00', '2014-06-01 21:06:50'),
(93, 36, 82, 9, '0000-00-00 00:00:00', '2014-06-01 21:30:17'),
(94, 36, 78, 16, '0000-00-00 00:00:00', '2014-06-02 11:09:18'),
(95, 36, 83, 9, '0000-00-00 00:00:00', '2014-06-02 11:37:29'),
(96, 36, 84, 9, '0000-00-00 00:00:00', '2014-06-02 14:12:17'),
(97, 36, 85, 9, '0000-00-00 00:00:00', '2014-06-11 14:56:33'),
(98, 36, 86, 9, '0000-00-00 00:00:00', '2014-06-03 15:08:02'),
(99, 36, 89, 9, '0000-00-00 00:00:00', '2014-06-12 12:30:53'),
(100, 24, 93, 16, '0000-00-00 00:00:00', '2014-06-12 15:47:00');

-- --------------------------------------------------------

--
-- Table structure for table `message_list`
--

CREATE TABLE `message_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `datetime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `message_id` (`message_id`),
  KEY `driver_id` (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `message_text`
--

CREATE TABLE `message_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `message_type`
--

CREATE TABLE `message_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `non_cash_payment_tarif`
--

CREATE TABLE `non_cash_payment_tarif` (
  `type` int(11) NOT NULL COMMENT 'Гибкий тариф',
  `name` varchar(50) NOT NULL,
  `fluidTarification` float NOT NULL COMMENT 'Добавочная стоимость',
  `extraCost` float NOT NULL COMMENT 'Минимум для гибкого тарифа',
  `fluidTarifMin` float NOT NULL COMMENT 'Учитывать км в минимуме',
  `kmMin` float NOT NULL COMMENT 'Простой',
  `downtime` float NOT NULL COMMENT 'Почасовой тариф',
  `hourTarif` float NOT NULL COMMENT 'Минимальный почасовой тариф',
  `minHourTarif` float NOT NULL COMMENT 'Тариф за город в один конец',
  `ootOneWayTarif` float NOT NULL COMMENT 'Тариф за город в один конец',
  `ootTnbTarif` float NOT NULL COMMENT 'Тариф за город в оба конца',
  `update_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `non_cash_payment_tarif`
--

INSERT INTO `non_cash_payment_tarif` (`type`, `name`, `fluidTarification`, `extraCost`, `fluidTarifMin`, `kmMin`, `downtime`, `hourTarif`, `minHourTarif`, `ootOneWayTarif`, `ootTnbTarif`, `update_time`) VALUES
(1, 'Бизнес', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:06'),
(2, 'Премиум', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:06'),
(3, 'Груз', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:06'),
(4, 'Универсал', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:06'),
(5, 'Микроавтобус', 1.2, 2.43, 1.03, 5300, 1.37, 1.52, 1.42, 1.22, 0.64, '2014-06-04 17:50:06'),
(6, 'Базовый', 2.9, 5, 25, 5300, 0.8, 1.25, 80, 4.5, 2.25, '2014-06-04 17:50:06');

-- --------------------------------------------------------

--
-- Table structure for table `order_cl_info`
--

CREATE TABLE `order_cl_info` (
  `order_id` int(11) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_cl_info`
--

INSERT INTO `order_cl_info` (`order_id`, `phone`, `name`) VALUES
(1, '+380957536866', 'ВИталий'),
(2, '+380957536866', 'Клиент'),
(3, '+38957536866', ''),
(4, 'Кли+380957536', 'Клиент'),
(5, '+380957536866', 'Виталий'),
(6, '380957536866', 'Виталий'),
(7, '+380957536866', 'Виталий'),
(8, '+380957536866', 'Сергей'),
(9, '+380957536866', ''),
(10, '+380957536866', ''),
(11, '+380957536866', ''),
(12, '555-55-55', ''),
(13, '555-55-55', ''),
(14, '555-55-55', ''),
(15, '+380957536866', 'Виталий'),
(16, '+380957536866', ''),
(17, '+380957536866', ''),
(18, '+380957536866', ''),
(19, '+380957536866', ''),
(20, '+380957536866', ''),
(21, '+380957536866', ''),
(22, '+380957536866', ''),
(23, '+380957536866', ''),
(24, '+380957536866', 'Имя'),
(25, '+123456789', 'Клиент'),
(26, '+123456789', ''),
(27, '+123456789', ''),
(28, '555-55-55', 'Чапаев'),
(29, '777-77-77', ''),
(30, '555-55-55', ''),
(31, '555-55-55', ''),
(32, '555-55-55', 'Х-о Владимир Владимирович'),
(33, '55-55-55', ''),
(34, '885599', ''),
(35, '+380957536866', 'Виталий'),
(36, '332211', ''),
(37, '+380957536866', 'Виталий'),
(38, '+380957536866', 'Виталий'),
(39, '+380957536866', ''),
(40, '+380957536866', 'Виталий'),
(41, '+380957536866', 'Виталий'),
(42, '+380957536866', 'Виталий'),
(43, '+380957536866', ''),
(44, '+380957536866', 'Виталий'),
(45, '+380957536866', ''),
(46, '+380957536866', 'Виталий'),
(47, '+380957536866', ''),
(48, '+380957536866', ''),
(49, '+380957536866', ''),
(50, '+380957536866', ''),
(51, '+380957536866', ''),
(52, '+380957536866', 'Petr'),
(53, '+380957536866', ''),
(54, '+380957536866', ''),
(55, '+380957536866', ''),
(56, '+380957536866', ''),
(57, '+380957533686', ''),
(58, '+380957536866', ''),
(59, '555', ''),
(60, '555', ''),
(61, '555', 'Ivan'),
(62, '+380957536866', 'Виталий'),
(63, '+380957536866', 'Виталий'),
(64, '+380957536866', 'Виталий'),
(65, '+380957536866', 'Виталий'),
(66, '555', ''),
(67, '555', ''),
(68, '555', ''),
(69, '555', 'Petr'),
(70, '8887777', ''),
(71, '', ''),
(72, '+380957536866', 'Виталий'),
(73, '+380957536866', 'Виталий'),
(74, '+380957536866', ''),
(75, '555', ''),
(76, '79778885', ''),
(77, '1112233', ''),
(78, '993355', ''),
(79, '+380957536866', ''),
(80, '', ''),
(81, '', ''),
(82, '', ''),
(83, '', ''),
(84, '', ''),
(85, '', ''),
(86, '', ''),
(87, '3332255', 'Иван Сергеевич'),
(88, '+380957536866', ''),
(89, '+380957536866', ''),
(90, '3335588', ''),
(91, '33366999', ''),
(92, '7774455', ''),
(93, '555999666', ''),
(94, '1111148888', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_info`
--

CREATE TABLE `order_info` (
  `order_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `payment` varchar(25) NOT NULL,
  `tarif_id` int(11) NOT NULL,
  `tarif` varchar(255) NOT NULL,
  `length` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  `air_conditioning` tinyint(1) NOT NULL DEFAULT '0',
  `driver_note` varchar(255) NOT NULL,
  `dispatcher_note` varchar(255) NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_info`
--

INSERT INTO `order_info` (`order_id`, `type`, `payment`, `tarif_id`, `tarif`, `length`, `cost`, `air_conditioning`, `driver_note`, `dispatcher_note`) VALUES
(1, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9550, 37, 0, '', 'Заметка 1'),
(2, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8006, 41, 0, '', 'Заметка 2'),
(3, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9550, 45, 0, '', ''),
(4, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8006, 44, 0, '', ''),
(5, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9550, 37, 0, '', ''),
(6, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 2990, 25, 0, '', ''),
(7, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 11421, 43, 0, '', ''),
(8, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8335, 34, 0, '', ''),
(9, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8335, 34, 0, '', ''),
(10, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 5323, 25, 0, '', ''),
(11, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(12, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(13, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(14, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(15, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(16, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9550, 37, 0, '', ''),
(17, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(18, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(19, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(20, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(21, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(22, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(23, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(24, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 6990, 30, 0, '', ''),
(25, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(26, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(27, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(28, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(29, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(30, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 2630, 25, 0, '', ''),
(31, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(32, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(33, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(34, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9778, 54, 0, '', ''),
(35, 1, 'cash_payment_tarif', 2, '{"type":"2","name":"\\u041f\\u0440\\u0435\\u043c\\u0438\\u0443\\u043c","fluidTarification":"1.2","extraCost":"2.43","fluidTarifMin":"1.03","kmMin":"5300","downtime":"1.37","hourTarif":"1.52","minHourTarif":"1.42","ootOneWayTarif":"1.22","ootTnbTarif":"0.64","upd', 8335, 5, 0, '', ''),
(36, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 456726, 1340, 0, '', ''),
(37, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 4687, 25, 0, '', ''),
(38, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8007, 33, 0, '', ''),
(39, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8007, 33, 0, '', ''),
(40, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8007, 33, 0, '', ''),
(41, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(42, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(43, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(44, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(45, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(46, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(47, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8007, 33, 0, '', ''),
(48, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 6990, 30, 0, '', ''),
(49, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9276, 37, 0, '', ''),
(50, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8335, 34, 0, '', ''),
(51, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9550, 37, 0, '', ''),
(52, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9091, 36, 0, '', ''),
(53, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9091, 36, 0, '', ''),
(54, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9269, 37, 0, '', ''),
(55, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8070, 33, 0, '', ''),
(56, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8007, 33, 0, '', ''),
(57, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 8007, 41, 0, '', ''),
(58, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(59, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(60, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(61, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 5672, 26, 0, '123321', ''),
(62, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, 'wedwed wedwed wedwed wedwed', ''),
(63, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(64, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(65, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(66, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(67, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(68, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(69, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 28985, 97, 0, '', ''),
(70, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 15387, 55, 0, '', ''),
(71, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 11049, 42, 0, '', ''),
(72, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 33293, 110, 0, '', ''),
(73, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(74, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(75, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(76, 1, 'non_cash_payment_tarif', 4, '{"type":"4","name":"\\u0423\\u043d\\u0438\\u0432\\u0435\\u0440\\u0441\\u0430\\u043b","fluidTarification":"1.2","extraCost":"2.43","fluidTarifMin":"1.03","kmMin":"5300","downtime":"1.37","hourTarif":"1.52","minHourTarif":"1.42","ootOneWayTarif":"1.22","ootTnbTarif"', 16168, 19, 0, '', ''),
(77, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 17714, 66, 0, '', ''),
(78, 1, 'non_cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 9900, 44, 0, '', ''),
(79, 1, 'non_cash_payment_tarif', 4, '{"type":"4","name":"\\u0423\\u043d\\u0438\\u0432\\u0435\\u0440\\u0441\\u0430\\u043b","fluidTarification":"1.2","extraCost":"2.43","fluidTarifMin":"1.03","kmMin":"5300","downtime":"1.37","hourTarif":"1.52","minHourTarif":"1.42","ootOneWayTarif":"1.22","ootTnbTarif"', 0, 25, 0, '', ''),
(80, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(81, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(82, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(83, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(84, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(85, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 6001, 30, 0, '', ''),
(86, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(87, 1, 'cash_payment_tarif', 2, '{"type":"2","name":"\\u041f\\u0440\\u0435\\u043c\\u0438\\u0443\\u043c","fluidTarification":"2","extraCost":"2.43","fluidTarifMin":"1.03","kmMin":"5300","downtime":"1.37","hourTarif":"1.52","minHourTarif":"1.42","ootOneWayTarif":"1.22","ootTnbTarif":"0.64","updat', 8200, 12, 0, 'La-la-la', 'La-la-la'),
(88, 1, 'non_cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(89, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(90, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(91, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(92, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(93, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 0, 25, 0, '', ''),
(94, 1, 'cash_payment_tarif', 6, '{"type":"6","name":"\\u0411\\u0430\\u0437\\u043e\\u0432\\u044b\\u0439","fluidTarification":"2.9","extraCost":"5","fluidTarifMin":"25","kmMin":"5300","downtime":"0.8","hourTarif":"1.25","minHourTarif":"80","ootOneWayTarif":"4.5","ootTnbTarif":"2.25","update_time"', 7128, 38, 0, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_list`
--

CREATE TABLE `order_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dispatcher` int(11) NOT NULL,
  `driver` int(11) DEFAULT NULL,
  `customer` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dispatcher` (`dispatcher`),
  KEY `driver` (`driver`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=95 ;

--
-- Dumping data for table `order_list`
--

INSERT INTO `order_list` (`id`, `dispatcher`, `driver`, `customer`) VALUES
(1, 1, 36, 1),
(2, 1, 36, 1),
(3, 1, 36, 1),
(4, 1, 24, 1),
(5, 1, 36, 1),
(6, 1, 36, 1),
(7, 1, 36, 1),
(8, 1, 36, 1),
(9, 1, 49, 1),
(10, 1, 36, 1),
(11, 1, 24, 1),
(12, 1, 0, 1),
(13, 1, 24, 1),
(14, 1, 0, 1),
(15, 1, 24, 1),
(16, 1, 24, 1),
(17, 1, NULL, 1),
(18, 1, 0, 1),
(19, 1, 24, 1),
(20, 1, 24, 1),
(21, 1, 24, 1),
(22, 1, 36, 1),
(23, 1, 24, 1),
(24, 1, NULL, 1),
(25, 1, NULL, 1),
(26, 1, NULL, 1),
(27, 1, NULL, 4),
(28, 1, 24, 5),
(29, 1, 24, 6),
(30, 1, 24, 5),
(31, 1, 24, 5),
(32, 1, 24, 5),
(33, 1, 24, 7),
(34, 1, NULL, 7),
(35, 1, NULL, 1),
(36, 1, NULL, 8),
(37, 1, 36, 1),
(38, 1, 50, 1),
(39, 1, 0, 1),
(40, 1, 0, 1),
(41, 1, 0, 1),
(42, 1, 36, 1),
(43, 1, 36, 1),
(44, 1, 36, 1),
(45, 1, 49, 1),
(46, 1, 36, 1),
(47, 1, 0, 1),
(48, 1, 0, 1),
(49, 1, 0, 1),
(50, 1, 0, 1),
(51, 1, 0, 1),
(52, 1, 0, 1),
(53, 1, 0, 1),
(54, 1, 0, 1),
(55, 1, NULL, 1),
(56, 1, 49, 1),
(57, 1, 0, 9),
(58, 1, 49, 1),
(59, 1, 24, 10),
(60, 1, 24, 10),
(61, 1, 24, 10),
(62, 1, 36, 1),
(63, 1, 36, 1),
(64, 1, 36, 1),
(65, 1, 36, 1),
(66, 1, 24, 10),
(67, 1, 24, 10),
(68, 1, 24, 10),
(69, 1, 24, 10),
(70, 1, 36, 11),
(71, 1, 36, 12),
(72, 1, 36, 1),
(73, 1, 36, 1),
(74, 1, 36, 1),
(75, 1, 24, 10),
(76, 1, NULL, 13),
(77, 1, NULL, 14),
(78, 1, 0, 15),
(79, 1, 36, 1),
(80, 1, 36, 12),
(81, 1, 36, 12),
(82, 1, 36, 12),
(83, 1, 36, 12),
(84, 1, 36, 12),
(85, 1, 36, 12),
(86, 1, 36, 12),
(87, 1, NULL, 16),
(88, 1, 36, 1),
(89, 1, 36, 1),
(90, 1, 36, 17),
(91, 1, 36, 18),
(92, 1, 24, 19),
(93, 1, 24, 20),
(94, 1, NULL, 21);

-- --------------------------------------------------------

--
-- Table structure for table `order_points`
--

CREATE TABLE `order_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `point` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=503 ;

--
-- Dumping data for table `order_points`
--

INSERT INTO `order_points` (`id`, `order_id`, `point_id`, `point`, `location`) VALUES
(1, 1, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(2, 1, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(25, 3, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(26, 3, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(35, 5, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(36, 5, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(41, 7, 0, 'проспект Карла Маркса, 80', '{"lat":48.4717644,"lng":35.0328466}'),
(42, 7, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(45, 9, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(46, 9, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(47, 10, 0, 'проспект Карла Маркса, 17', '{"lat":48.454004,"lng":35.0654435}'),
(48, 10, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(53, 8, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(54, 8, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(55, 6, 0, 'проспект Карла Маркса, 80', '{"lat":48.4717644,"lng":35.0328466}'),
(56, 6, 1, 'Гомельская улица, 2', '{"lat":48.4668034,"lng":35.001344}'),
(57, 2, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734229,"lng":35.0262814}'),
(58, 2, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(59, 4, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734229,"lng":35.0262814}'),
(60, 4, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(71, 16, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(72, 16, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(87, 17, 0, 'проспект Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(89, 18, 0, 'бульвар Славы, 6', '{"lat":48.414697,"lng":35.067649}'),
(91, 20, 0, 'проспект Гагарина, 110', '{"lat":48.425668,"lng":35.026497}'),
(93, 21, 0, 'бульвар Славы, 7', '{"lat":48.413046,"lng":35.068316}'),
(94, 22, 0, 'бульвар Славы, 8', '{"lat":48.4139971,"lng":35.0658415}'),
(95, 23, 0, 'проспект Гагарина, 111', '{"lat":48.428144,"lng":35.039821}'),
(96, 11, 0, 'проспект Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(97, 12, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(98, 13, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(99, 14, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(100, 15, 0, 'проспект Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(101, 19, 0, 'проспект Гагарина, 110', '{"lat":48.425668,"lng":35.026497}'),
(102, 24, 0, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(103, 24, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(104, 25, 0, 'проспект Карла Маркса, 110', '{"lat":48.4735555,"lng":35.0254642}'),
(105, 26, 0, 'проспект Карла Маркса, 156', '{"lat":48.4749782,"lng":35.0148085}'),
(106, 27, 0, 'проспект Карла Маркса, 147', '{"lat":48.4749782,"lng":35.0148085}'),
(107, 28, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(108, 29, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(111, 30, 0, 'улица Чкалова, 12', '{"lat":48.4594386,"lng":35.042154}'),
(112, 30, 1, 'проспект Гагарина, 2', '{"lat":48.4540947,"lng":35.0647472}'),
(113, 31, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(114, 32, 0, 'проспект Пушкина, 3', '{"lat":48.46368,"lng":35.033167}'),
(115, 33, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(153, 35, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(154, 35, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(188, 34, 0, 'проспект Гагарина, 17', '{"lat":48.4512468,"lng":35.0614745}'),
(189, 34, 1, 'Красная улица, 5', '{"lat":48.4617326,"lng":35.0425818}'),
(190, 34, 2, 'Калиновая улица, 14', '{"lat":48.5114216,"lng":35.075657}'),
(191, 36, 0, 'переулок Шевченко, 15', '{"lat":48.45869,"lng":35.0500601}'),
(192, 36, 1, 'Яснополянская улица, 18', '{"lat":48.4056152,"lng":35.0759123}'),
(193, 36, 2, 'Odessa, 5', '{"lat":46.5738573,"lng":30.794569}'),
(196, 37, 0, 'проспект Гагарина, 11', '{"lat":48.4523264,"lng":35.0627233}'),
(197, 37, 1, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(198, 38, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(199, 38, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(200, 39, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(201, 39, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(202, 40, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(203, 40, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(204, 41, 0, 'проспект Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(207, 42, 0, 'проспект Гагарина, 112', '{"lat":48.425709,"lng":35.025614}'),
(208, 43, 0, 'проспект Гагарина, 106', '{"lat":48.426414,"lng":35.026905}'),
(209, 44, 0, 'проспект Гагарина, 106', '{"lat":48.426414,"lng":35.026905}'),
(210, 45, 0, 'ЦУМ, ', '{"lat":48.464359,"lng":35.045498}'),
(211, 46, 0, 'проспект Гагарина, 110', '{"lat":48.425668,"lng":35.026497}'),
(212, 47, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(213, 47, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(214, 48, 0, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(215, 48, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(216, 49, 0, 'Карла Маркса, 110', '{"lat":48.4735706,"lng":35.0254501}'),
(217, 49, 1, 'бульвар Славы, 106', '{"lat":48.4109739,"lng":35.0626167}'),
(218, 50, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(219, 50, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(220, 51, 0, 'проспект Карла Маркса, 117', '{"lat":48.4744958,"lng":35.0202583}'),
(221, 51, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(224, 53, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(225, 53, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(236, 54, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(237, 54, 1, 'бульвар Славы, 7', '{"lat":48.4134555,"lng":35.0679847}'),
(240, 55, 0, 'проспект Карла Маркса, 110', '{"lat":48.4735706,"lng":35.0254501}'),
(241, 55, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(242, 56, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(243, 56, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(248, 57, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(249, 57, 1, 'проспект Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(250, 58, 0, 'проспект Карла Маркса, 110', '{"lat":48.4735588,"lng":35.0254453}'),
(252, 60, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(256, 63, 0, 'Гагарина просп., 10', '{"lat":48.449196,"lng":35.058616}'),
(268, 65, 0, 'проспект Карла Маркса, 108', '{"lat":48.4734594,"lng":35.0260047}'),
(269, 66, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(270, 67, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(271, 68, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(328, 59, 0, 'Чкалова  ул., 12', '{"lat":48.459546,"lng":35.042284}'),
(345, 61, 0, 'улица Чкалова, 12', '{"lat":48.4594386,"lng":35.042154}'),
(346, 61, 1, 'Пушкина Генерала ул., 1', '{"lat":48.4350654,"lng":35.0295414}'),
(347, 52, 0, 'проспект Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(348, 52, 1, 'бульвар Славы, 6', '{"lat":48.4143586,"lng":35.0679249}'),
(352, 64, 0, 'Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(360, 73, 0, 'Гагарина просп., 110', '{"lat":48.425668,"lng":35.026497}'),
(402, 69, 0, 'улица Чкалова, 12', '{"lat":48.4594386,"lng":35.042154}'),
(403, 69, 1, 'Холодильная ул., 12', '{"lat":48.5258491,"lng":35.0752666}'),
(404, 69, 2, 'Паникахи ул., 15', '{"lat":48.4016537,"lng":35.0320415}'),
(405, 74, 0, 'Гагарина просп., 110', '{"lat":48.425668,"lng":35.026497}'),
(408, 75, 0, 'улица Чкалова, 12', '{"lat":48.459546,"lng":35.042284}'),
(431, 70, 0, 'Калиновая ул., 15', '{"lat":48.5115043,"lng":35.0752034}'),
(432, 70, 1, 'Яснополянская ул., 14', '{"lat":48.4069353,"lng":35.0769507}'),
(446, 71, 0, 'Карла Маркса, 107', '{"lat":48.4734249,"lng":35.0262705}'),
(447, 71, 1, 'Яснополянская ул., 15', '{"lat":48.4068641,"lng":35.0769012}'),
(448, 72, 0, 'Гагарина, 110', '{"lat":48.4252896,"lng":35.0266167}'),
(449, 72, 1, 'Холодильная ул., 81', '{"lat":48.526317,"lng":35.072654}'),
(450, 72, 2, 'Паникахи ул., 23', '{"lat":48.4006827,"lng":35.0293432}'),
(455, 77, 0, 'Янтарная ул., 81', '{"lat":48.5175446,"lng":35.0452108}'),
(456, 77, 1, 'Яснополянская ул., 12', '{"lat":48.4070064,"lng":35.0770002}'),
(459, 78, 0, 'Шевченко  ул., 23', '{"lat":48.4575257,"lng":35.0549314}'),
(460, 78, 1, 'Холодильная ул., 81', '{"lat":48.526317,"lng":35.072654}'),
(461, 76, 0, 'Калиновая ул., 15', '{"lat":48.5115043,"lng":35.0752034}'),
(462, 76, 1, 'Паникахи ул., 55', '{"lat":48.4003802,"lng":35.0285184}'),
(464, 80, 0, 'Гагарина, 100', '{"lat":48.426056,"lng":35.029442}'),
(465, 81, 0, 'Гагарина, 100', '{"lat":48.426056,"lng":35.029442}'),
(466, 82, 0, 'Гагарина, 100', '{"lat":48.426056,"lng":35.029442}'),
(467, 83, 0, 'Карла Маркса, 108', '{"lat":48.4734594,"lng":35.0260047}'),
(468, 84, 0, 'Карла Маркса, 100', '{"lat":48.474647,"lng":35.022589}'),
(469, 85, 0, 'Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(470, 86, 0, 'Гагарина просп., 110', '{"lat":48.425668,"lng":35.026497}'),
(478, 62, 0, 'Гагарина просп., 110', '{"lat":48.425668,"lng":35.026497}'),
(484, 89, 0, 'проспект Гагарина, 110', '{"lat":48.425668,"lng":35.026497}'),
(485, 88, 0, 'проспект Карла Маркса, 107', '{"lat":48.473211,"lng":35.026184}'),
(487, 90, 0, 'Заводская Набережная улица, 55', '{"lat":48.4860607,"lng":34.9249339}'),
(488, 91, 0, 'Новокрымская улица, 14', '{"lat":48.4274525,"lng":35.0088168}'),
(489, 92, 0, 'Киевская улица, 33', '{"lat":48.451156,"lng":34.964153}'),
(491, 93, 0, 'Харьковская улица, 21', '{"lat":48.467433,"lng":35.050041}'),
(492, 79, 0, 'Гагарина, 110', '{"lat":48.425668,"lng":35.026497}'),
(497, 87, 0, 'Батумская ул., 14', '{"lat":48.5159191,"lng":35.081665}'),
(498, 87, 1, 'Столярова ул., 8', '{"lat":48.4731274,"lng":35.0324679}'),
(501, 94, 0, 'Калиновая улица, 19', '{"lat":48.5107882,"lng":35.0789344}'),
(502, 94, 1, 'улица Шевченко, 10', '{"lat":48.457712,"lng":35.0545925}');

-- --------------------------------------------------------

--
-- Table structure for table `order_properties`
--

CREATE TABLE `order_properties` (
  `order_id` int(11) NOT NULL,
  `airCondition` tinyint(1) NOT NULL DEFAULT '0',
  `salonLoading` tinyint(1) NOT NULL DEFAULT '0',
  `animal` tinyint(1) NOT NULL DEFAULT '0',
  `city` tinyint(1) NOT NULL DEFAULT '0',
  `courierDelivery` tinyint(1) NOT NULL DEFAULT '0',
  `terminal` tinyint(1) NOT NULL DEFAULT '0',
  `nameSign` tinyint(1) NOT NULL DEFAULT '0',
  `hour` tinyint(1) NOT NULL DEFAULT '0',
  `grach` tinyint(1) NOT NULL DEFAULT '0',
  `ticket` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_properties`
--

INSERT INTO `order_properties` (`order_id`, `airCondition`, `salonLoading`, `animal`, `city`, `courierDelivery`, `terminal`, `nameSign`, `hour`, `grach`, `ticket`) VALUES
(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(4, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0),
(5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(12, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(13, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(14, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(15, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(18, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(19, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(20, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(21, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(22, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(26, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(27, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(28, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(29, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(32, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(33, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(34, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0),
(37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(42, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(43, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(44, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(45, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(46, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(52, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(53, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(58, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(59, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(60, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(61, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(62, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(63, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(64, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(65, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(66, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(67, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(68, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(69, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(70, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(71, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(72, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1),
(73, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(74, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(75, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(76, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0),
(77, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(80, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(81, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(82, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(83, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(84, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(85, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(86, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(87, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(88, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(89, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(90, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(91, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(92, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(93, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(94, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_sent`
--

CREATE TABLE `order_sent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `driver_ids` text NOT NULL,
  `driver_refused` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=95 ;

--
-- Dumping data for table `order_sent`
--

INSERT INTO `order_sent` (`id`, `order_id`, `driver_ids`, `driver_refused`) VALUES
(1, 1, '[36,"49","50","51"]', NULL),
(2, 2, '[36,"49","50","51"]', '[49,50]'),
(3, 3, '["36","49","50","51"]', NULL),
(4, 4, '[24,"36","49","50","51"]', '[36]'),
(5, 5, '["36","49","50","51"]', '[49,50,36]'),
(6, 6, '["36","49","50","51"]', '[36,49,50]'),
(7, 7, '[36,"49","50","51"]', '[36,49,50]'),
(8, 8, '["36","49","50","51"]', '[36,49,50,"51"]'),
(9, 9, '', '["50"]'),
(10, 10, '', NULL),
(11, 11, '[23,24,"36"]', '["36","24"]'),
(12, 12, '[23,24,"36"]', '["24","36"]'),
(13, 13, '[23,"24","36"]', '["24"]'),
(14, 14, '[23,24,36]', '["24","36"]'),
(15, 15, '[23,24,"36"]', '["36","24"]'),
(16, 16, '[24]', '[36]'),
(17, 17, '[23,24,36]', NULL),
(18, 18, '[24,"36"]', '[36]'),
(19, 19, '[24,36]', '["36"]'),
(20, 20, '[24,36]', '["36","24"]'),
(21, 21, '[24,"36"]', '[36]'),
(22, 22, '', NULL),
(23, 23, '[24,"36"]', '[36]'),
(24, 24, '["36"]', NULL),
(25, 25, '', NULL),
(26, 26, '', NULL),
(27, 27, '', NULL),
(28, 28, '["24"]', NULL),
(29, 29, '["24"]', NULL),
(30, 30, '["24"]', NULL),
(31, 31, '', NULL),
(32, 32, '[24]', NULL),
(33, 33, '', NULL),
(34, 34, '[24,36,49,"50","51"]', NULL),
(35, 35, '[36,49,50,51]', NULL),
(36, 36, '[36,49,"50","51"]', NULL),
(37, 37, '["36","49","50","51"]', '[36,51,50,49]'),
(38, 38, '["36","49","50","51"]', '[50,49]'),
(39, 39, '["36","49","50","51"]', '["49","50"]'),
(40, 40, '[36,"49","50"]', '["49","50"]'),
(41, 41, '["36","49","50"]', '[49,50]'),
(42, 42, '', NULL),
(43, 43, '', NULL),
(44, 44, '', NULL),
(45, 45, '["36","49","50"]', '[36,49,50]'),
(46, 46, '', NULL),
(47, 47, '[49,50]', '[49]'),
(48, 48, '["23",49,50]', '["23"]'),
(49, 49, '["49","50"]', '[50,49]'),
(50, 50, '["49"]', '[49]'),
(51, 51, '["23","49"]', '[49,"23"]'),
(52, 52, '["23","49"]', '[49,"23"]'),
(53, 53, '["49"]', '["49"]'),
(54, 54, '["49"]', '[49]'),
(55, 55, '["49"]', NULL),
(56, 56, '', '[36]'),
(57, 57, '["36","49"]', '[36,49]'),
(58, 58, '["36","49"]', '[36,"49"]'),
(59, 59, '', NULL),
(60, 60, '', NULL),
(61, 61, '["24"]', NULL),
(62, 62, '', NULL),
(63, 63, '', NULL),
(64, 64, '', NULL),
(65, 65, '', NULL),
(66, 66, '', NULL),
(67, 67, '', NULL),
(68, 68, '', NULL),
(69, 69, '', NULL),
(70, 70, '["36"]', NULL),
(71, 71, '["36"]', '[36]'),
(72, 72, '[36]', NULL),
(73, 73, '', NULL),
(74, 74, '', NULL),
(75, 75, '', NULL),
(76, 76, '[36]', NULL),
(77, 77, '[36]', NULL),
(78, 78, '[36,"53","56","61","62"]', '["61","53","56","62",36]'),
(79, 79, '', NULL),
(80, 80, '', NULL),
(81, 81, '', NULL),
(82, 82, '', NULL),
(83, 83, '', NULL),
(84, 84, '', NULL),
(85, 85, '', NULL),
(86, 86, '', NULL),
(87, 87, '["24","36"]', NULL),
(88, 88, '[36]', NULL),
(89, 89, '[36]', NULL),
(90, 90, '', NULL),
(91, 91, '', NULL),
(92, 92, '', NULL),
(93, 93, '["24"]', '[24]'),
(94, 94, '["24"]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_start_point`
--

CREATE TABLE `order_start_point` (
  `order_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `apartment` varchar(5) NOT NULL,
  `porch` varchar(5) NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_start_point`
--

INSERT INTO `order_start_point` (`order_id`, `address`, `apartment`, `porch`) VALUES
(1, 'проспект Карла Маркса, 117', '25', '8'),
(3, 'проспект Карла Маркса, 117', '', ''),
(4, 'проспект Карла Маркса, 107', '44', '5'),
(5, 'проспект Карла Маркса, 117', '149', '5'),
(6, 'проспект Карла Маркса, 80', '5', '1'),
(7, 'проспект Карла Маркса, 80', '13', ''),
(8, 'проспект Карла Маркса, 117', '', ''),
(9, 'проспект Карла Маркса, 117', '1672', '7'),
(10, 'проспект Карла Маркса, 17', '4', '1'),
(11, 'проспект Карла Маркса, 107', '', ''),
(12, 'улица Чкалова, 12', '', ''),
(13, 'улица Чкалова, 12', '', ''),
(14, 'улица Чкалова, 12', '', ''),
(15, 'проспект Карла Маркса, 107', '', ''),
(16, 'проспект Карла Маркса, 117', '', ''),
(17, 'проспект Карла Маркса, 107', '', ''),
(18, 'бульвар Славы, 6', '', ''),
(19, 'проспект Гагарина, 110', '', ''),
(20, 'проспект Гагарина, 110', '', ''),
(21, 'бульвар Славы, 7', '', ''),
(22, 'бульвар Славы, 8', '', ''),
(23, 'проспект Гагарина, 111', '', ''),
(24, 'проспект Гагарина, 110', '', ''),
(25, 'проспект Карла Маркса, 110', '', ''),
(26, 'проспект Карла Маркса, 156', '', ''),
(27, 'проспект Карла Маркса, 147', '', ''),
(28, 'улица Чкалова, 12', '', ''),
(29, 'улица Чкалова, 12', '', ''),
(30, 'улица Чкалова, 12', '', ''),
(31, 'улица Чкалова, 12', '', ''),
(32, 'проспект Пушкина, 3', '', ''),
(33, 'улица Чкалова, 12', '', ''),
(34, 'проспект Гагарина, 17', '', ''),
(35, 'проспект Карла Маркса, 117', '', ''),
(36, 'переулок Шевченко, 15', '', ''),
(37, 'проспект Гагарина, 11', '55', '6'),
(38, 'проспект Карла Маркса, 107', '14', '2'),
(39, 'проспект Карла Маркса, 107', '', ''),
(40, 'проспект Карла Маркса, 107', '567', '8'),
(41, 'проспект Карла Маркса, 107', '567', '4'),
(42, 'проспект Гагарина, 112', '45', '2'),
(43, 'проспект Гагарина, 106', '34', '3'),
(44, 'проспект Гагарина, 106', '45', '2'),
(45, 'ЦУМ', '', ''),
(46, 'проспект Гагарина, 110', '', ''),
(47, 'проспект Карла Маркса, 107', '', ''),
(48, 'проспект Гагарина, 110', '', ''),
(49, 'Карла Маркса, 110', '', ''),
(50, 'проспект Карла Маркса, 117', '', ''),
(51, 'проспект Карла Маркса, 117', '', ''),
(52, 'проспект Карла Маркса, 107', '', ''),
(53, 'проспект Карла Маркса, 107', '', ''),
(54, 'проспект Карла Маркса, 107', '', ''),
(55, 'проспект Карла Маркса, 110', '', ''),
(56, 'проспект Карла Маркса, 107', '', ''),
(57, 'проспект Карла Маркса, 107', '52', '3'),
(58, 'проспект Карла Маркса, 110', '', ''),
(59, 'Чкалова  ул., 12', '', ''),
(60, 'улица Чкалова, 12', '', ''),
(61, '', '', ''),
(62, '', '546', '6'),
(63, 'Гагарина просп., 10', '45', '2'),
(64, 'Карла Маркса, 107', '45', '2'),
(65, 'проспект Карла Маркса, 108', '67', '2'),
(66, 'улица Чкалова, 12', '', ''),
(67, 'улица Чкалова, 12', '', ''),
(68, 'улица Чкалова, 12', '', ''),
(69, '', '', ''),
(70, 'Калиновая ул., 15', '', ''),
(71, 'Карла Маркса, 107', '', ''),
(72, 'Гагарина, 110', '546', '6'),
(73, 'Гагарина просп., 110', '456', '5'),
(74, 'Гагарина просп., 110', '', ''),
(75, 'улица Чкалова, 12', '', ''),
(76, 'Калиновая ул., 15', '', ''),
(77, 'Янтарная ул., 81', '', ''),
(78, 'Шевченко  ул., 23', '', ''),
(79, 'Гагарина, 110', '', ''),
(80, 'Гагарина, 100', '', ''),
(81, 'Гагарина, 100', '', ''),
(82, 'Гагарина, 100', '', ''),
(83, 'Карла Маркса, 108', '', ''),
(84, 'Карла Маркса, 100', '', ''),
(85, 'Карла Маркса, 107', '', ''),
(86, 'Гагарина просп., 110', '', ''),
(87, 'Батумская ул., 14', '', ''),
(88, 'проспект Карла Маркса, 107', '', ''),
(89, 'проспект Гагарина, 110', '', ''),
(90, 'Заводская Набережная улица, 55', '', ''),
(91, 'Новокрымская улица, 14', '', ''),
(92, 'Киевская улица, 33', '', ''),
(93, 'Харьковская улица, 21', '', ''),
(94, 'Калиновая улица, 19', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `order_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `personal` tinyint(1) NOT NULL,
  `editing` tinyint(1) NOT NULL,
  `dispatcher` int(11) DEFAULT '0',
  `open_for_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `dispatcher` (`dispatcher`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`order_id`, `status`, `personal`, `editing`, `dispatcher`, `open_for_edit_time`) VALUES
(1, 9, 0, 0, 1, NULL),
(2, 9, 0, 0, 1, NULL),
(3, 9, 0, 0, 1, NULL),
(4, 9, 0, 0, 1, NULL),
(5, 9, 0, 0, 1, NULL),
(6, 9, 0, 0, 1, NULL),
(7, 9, 0, 0, 1, NULL),
(8, 9, 0, 0, 1, NULL),
(9, 9, 0, 0, 1, NULL),
(10, 9, 0, 0, 1, NULL),
(11, 9, 0, 0, 1, NULL),
(12, 18, 0, 0, 1, NULL),
(13, 9, 0, 0, 1, NULL),
(14, 18, 0, 0, 1, NULL),
(15, 9, 0, 0, 1, NULL),
(16, 9, 0, 0, 1, NULL),
(17, 18, 0, 0, 1, NULL),
(18, 18, 0, 0, 1, NULL),
(19, 9, 0, 0, 1, NULL),
(20, 9, 0, 0, 1, NULL),
(21, 9, 0, 0, 1, NULL),
(22, 9, 0, 0, 1, NULL),
(23, 9, 0, 0, 1, NULL),
(24, 18, 0, 0, 1, NULL),
(25, 18, 0, 0, 1, NULL),
(26, 18, 0, 0, 1, NULL),
(27, 18, 0, 0, 1, NULL),
(28, 9, 0, 0, 1, NULL),
(29, 9, 0, 0, 1, NULL),
(30, 9, 0, 0, 1, NULL),
(31, 12, 0, 0, 1, NULL),
(32, 9, 0, 0, 1, NULL),
(33, 12, 0, 0, 1, NULL),
(34, 18, 0, 0, 1, NULL),
(35, 18, 0, 0, 1, NULL),
(36, 18, 0, 0, 1, NULL),
(37, 9, 0, 0, 1, NULL),
(38, 9, 0, 0, 1, NULL),
(39, 18, 0, 0, 1, NULL),
(40, 18, 0, 0, 1, NULL),
(41, 18, 0, 0, 1, NULL),
(42, 9, 0, 0, 1, NULL),
(43, 9, 0, 0, 1, NULL),
(44, 9, 0, 0, 1, NULL),
(45, 9, 0, 0, 1, NULL),
(46, 9, 0, 0, 1, NULL),
(47, 18, 0, 0, 1, NULL),
(48, 18, 0, 0, 1, NULL),
(49, 18, 0, 0, 1, NULL),
(50, 18, 0, 0, 1, NULL),
(51, 18, 0, 0, 1, NULL),
(52, 18, 0, 0, 1, NULL),
(53, 18, 0, 0, 1, NULL),
(54, 18, 0, 0, 1, NULL),
(55, 18, 0, 0, 1, NULL),
(56, 9, 0, 0, 1, NULL),
(57, 18, 0, 0, 1, NULL),
(58, 9, 0, 0, 1, NULL),
(59, 9, 0, 0, 1, NULL),
(60, 9, 0, 0, 1, NULL),
(61, 9, 0, 0, 1, NULL),
(62, 9, 0, 0, 1, NULL),
(63, 9, 0, 0, 1, NULL),
(64, 9, 0, 0, 1, NULL),
(65, 9, 0, 0, 1, NULL),
(66, 9, 0, 0, 1, NULL),
(67, 9, 0, 0, 1, NULL),
(68, 9, 0, 0, 1, NULL),
(69, 9, 0, 0, 1, NULL),
(70, 9, 0, 0, 1, NULL),
(71, 9, 0, 0, 1, NULL),
(72, 9, 0, 0, 1, NULL),
(73, 9, 0, 0, 1, NULL),
(74, 9, 0, 0, 1, NULL),
(75, 9, 0, 0, 1, NULL),
(76, 18, 0, 0, 1, NULL),
(77, 18, 0, 0, 1, NULL),
(78, 18, 0, 0, 1, NULL),
(79, 8, 0, 0, 1, NULL),
(80, 9, 0, 0, 1, NULL),
(81, 9, 0, 0, 1, NULL),
(82, 9, 0, 0, 1, NULL),
(83, 9, 0, 0, 1, NULL),
(84, 9, 0, 0, 1, NULL),
(85, 9, 0, 0, 1, NULL),
(86, 9, 0, 0, 1, NULL),
(87, 6, 0, 0, 1, NULL),
(88, 9, 0, 0, 1, NULL),
(89, 9, 0, 0, 1, NULL),
(90, 9, 0, 0, 1, NULL),
(91, 9, 0, 0, 1, NULL),
(92, 9, 0, 0, 1, NULL),
(93, 9, 0, 0, 1, NULL),
(94, 6, 0, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_time`
--

CREATE TABLE `order_time` (
  `order_id` int(11) NOT NULL,
  `add` datetime NOT NULL,
  `take` datetime NOT NULL,
  `arrive` datetime NOT NULL,
  `start` datetime NOT NULL,
  `update` datetime NOT NULL,
  `finish` datetime NOT NULL,
  KEY `id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_time`
--

INSERT INTO `order_time` (`order_id`, `add`, `take`, `arrive`, `start`, `update`, `finish`) VALUES
(1, '2014-05-05 10:13:17', '2014-05-05 11:03:28', '2014-05-05 11:13:28', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-05 11:06:51'),
(2, '2014-05-05 11:05:11', '2014-05-06 16:37:08', '2014-05-06 16:47:08', '0000-00-00 00:00:00', '2014-05-06 16:37:53', '2014-05-06 16:38:14'),
(3, '2014-05-05 12:01:31', '2014-05-06 14:25:14', '2014-05-06 14:35:14', '0000-00-00 00:00:00', '2014-05-05 12:04:16', '2014-05-06 16:33:39'),
(4, '2014-05-05 12:03:00', '2014-05-06 17:41:21', '2014-05-06 17:51:21', '0000-00-00 00:00:00', '2014-05-06 16:40:08', '2014-05-06 17:41:32'),
(5, '2014-05-05 14:44:45', '2014-05-06 16:38:31', '2014-05-06 16:48:31', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-06 16:39:47'),
(6, '2014-05-05 15:12:49', '2014-05-06 14:22:33', '2014-05-06 14:32:33', '0000-00-00 00:00:00', '2014-05-06 14:21:51', '2014-05-06 14:23:00'),
(7, '2014-05-05 15:24:16', '2014-05-06 14:19:41', '2014-05-06 14:29:41', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-06 14:20:08'),
(8, '2014-05-05 15:37:12', '2014-05-06 14:20:58', '2014-05-06 14:30:58', '0000-00-00 00:00:00', '2014-05-06 14:20:41', '2014-05-06 14:21:33'),
(9, '2014-05-05 16:33:13', '2014-05-05 16:34:20', '2014-05-05 16:44:20', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-05 17:38:24'),
(10, '2014-05-05 17:39:12', '2014-05-05 17:40:47', '2014-05-05 17:50:47', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-05 17:40:54'),
(11, '2014-05-06 17:18:19', '2014-05-07 12:46:32', '2014-05-07 12:56:32', '0000-00-00 00:00:00', '2014-05-07 12:08:05', '2014-05-07 12:46:41'),
(12, '2014-05-06 17:20:28', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 12:08:32', '2014-05-07 17:03:28'),
(13, '2014-05-06 17:29:49', '2014-05-07 12:08:56', '2014-05-07 12:18:56', '0000-00-00 00:00:00', '2014-05-07 12:08:45', '2014-05-07 12:10:10'),
(14, '2014-05-06 17:30:18', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 12:08:56', '2014-05-07 17:03:28'),
(15, '2014-05-06 17:32:46', '2014-05-07 12:46:06', '2014-05-07 12:56:06', '0000-00-00 00:00:00', '2014-05-07 12:09:06', '2014-05-07 12:46:15'),
(16, '2014-05-06 17:41:28', '2014-05-06 17:41:56', '2014-05-06 17:51:56', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-06 17:42:22'),
(17, '2014-05-06 17:57:30', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 11:46:36', '2014-05-07 17:03:28'),
(18, '2014-05-07 11:48:11', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 11:50:00', '2014-05-07 17:03:28'),
(19, '2014-05-07 11:51:02', '2014-05-07 12:10:41', '2014-05-07 12:20:41', '0000-00-00 00:00:00', '2014-05-07 12:10:21', '2014-05-07 12:10:54'),
(20, '2014-05-07 11:51:55', '2014-05-07 12:46:47', '2014-05-07 12:56:47', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 12:46:54'),
(21, '2014-05-07 11:53:05', '2014-05-07 12:07:32', '2014-05-07 12:17:32', '0000-00-00 00:00:00', '2014-05-07 11:54:51', '2014-05-07 12:08:44'),
(22, '2014-05-07 12:01:01', '2014-05-07 12:01:09', '2014-05-07 12:11:09', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 12:01:17'),
(23, '2014-05-07 12:01:43', '2014-05-07 12:07:04', '2014-05-07 12:17:04', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 12:07:15'),
(24, '2014-05-07 17:05:54', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-07 17:13:08'),
(25, '2014-05-08 12:30:05', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-08 12:50:35'),
(26, '2014-05-08 12:39:33', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-08 12:50:35'),
(27, '2014-05-08 12:43:48', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-08 12:50:35'),
(28, '2014-05-08 23:34:56', '2014-05-08 23:35:16', '2014-05-08 23:45:16', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-08 23:35:30'),
(29, '2014-05-08 23:35:54', '2014-05-08 23:36:02', '2014-05-08 23:46:02', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-08 23:36:22'),
(30, '2014-05-08 23:45:27', '2014-05-08 23:45:56', '2014-05-08 23:55:56', '0000-00-00 00:00:00', '2014-05-08 23:45:47', '2014-05-08 23:46:02'),
(31, '2014-05-09 00:00:46', '2014-05-09 00:00:55', '2014-05-09 00:10:55', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, '2014-05-09 00:01:42', '2014-05-09 00:02:18', '2014-05-09 00:12:18', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-09 00:02:31'),
(33, '2014-05-09 00:07:37', '2014-05-09 00:07:43', '2014-05-09 00:17:43', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(34, '2014-05-09 00:08:04', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-13 09:55:04', '2014-05-16 10:33:42'),
(35, '2014-05-12 11:38:54', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-12 12:30:52', '2014-05-16 10:33:41'),
(36, '2014-05-12 11:40:50', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-13 15:37:48', '2014-05-16 10:33:41'),
(37, '2014-05-16 10:34:49', '2014-05-16 10:40:59', '2014-05-16 10:50:59', '0000-00-00 00:00:00', '2014-05-16 10:39:41', '2014-05-16 10:41:27'),
(38, '2014-05-16 10:54:54', '2014-05-16 10:55:55', '2014-05-16 11:05:55', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 10:56:09'),
(39, '2014-05-16 10:58:21', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 11:04:01'),
(40, '2014-05-16 11:13:19', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 11:17:01'),
(41, '2014-05-16 11:19:14', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 11:22:01'),
(42, '2014-05-16 11:22:47', '2014-05-16 11:22:55', '2014-05-16 11:32:55', '0000-00-00 00:00:00', '2014-05-16 11:26:32', '2014-05-16 11:28:12'),
(43, '2014-05-16 11:29:00', '2014-05-16 11:29:02', '2014-05-16 11:39:02', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 11:29:46'),
(44, '2014-05-16 11:30:15', '2014-05-16 11:30:19', '2014-05-16 11:40:19', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 11:30:26'),
(45, '2014-05-16 11:31:02', '2014-05-16 11:31:23', '2014-05-16 11:41:23', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 11:31:30'),
(46, '2014-05-16 15:26:37', '2014-05-16 15:26:40', '2014-05-16 15:36:40', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-16 15:27:00'),
(47, '2014-05-19 09:55:51', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 10:19:42'),
(48, '2014-05-19 10:02:08', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 10:33:53'),
(49, '2014-05-19 10:16:35', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 10:19:42'),
(50, '2014-05-19 10:17:33', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 10:19:41'),
(51, '2014-05-19 10:20:57', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 10:54:42'),
(52, '2014-05-19 10:55:19', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-27 14:53:17', '2014-05-19 11:27:29'),
(53, '2014-05-19 11:07:20', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 11:39:33'),
(54, '2014-05-19 14:24:30', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 14:50:31', '2014-05-19 16:29:31'),
(55, '2014-05-19 14:51:15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 14:51:40', '2014-05-19 16:29:31'),
(56, '2014-05-19 17:21:35', '2014-05-19 17:21:55', '2014-05-19 17:31:55', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 17:22:39'),
(57, '2014-05-19 17:23:50', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 17:26:12', '2014-05-19 17:30:25'),
(58, '2014-05-19 17:29:31', '2014-05-19 17:30:40', '2014-05-19 17:40:40', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-19 17:31:09'),
(59, '2014-05-21 15:57:32', '2014-05-21 15:57:37', '2014-05-21 16:07:37', '0000-00-00 00:00:00', '2014-05-27 14:48:25', '2014-05-21 16:00:34'),
(60, '2014-05-21 16:28:11', '2014-05-21 16:28:15', '2014-05-21 16:38:15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-21 16:30:55'),
(61, '2014-05-21 16:32:23', '2014-05-21 16:32:35', '2014-05-21 16:42:35', '0000-00-00 00:00:00', '2014-05-27 14:53:10', '2014-05-21 16:34:15'),
(62, '2014-05-23 20:36:21', '2014-05-23 20:36:33', '2014-05-23 20:46:33', '0000-00-00 00:00:00', '2014-06-11 17:46:55', '2014-05-23 20:45:18'),
(63, '2014-05-23 20:47:33', '2014-05-23 20:47:36', '2014-05-23 20:57:36', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-23 20:52:54'),
(64, '2014-05-26 14:26:26', '2014-05-26 14:26:35', '2014-05-26 14:36:35', '0000-00-00 00:00:00', '2014-05-27 14:54:37', '2014-05-26 14:30:28'),
(65, '2014-05-26 14:31:28', '2014-05-26 14:31:33', '2014-05-26 14:41:33', '0000-00-00 00:00:00', '2014-05-26 17:16:43', '2014-05-27 11:26:49'),
(66, '2014-05-26 18:04:11', '2014-05-26 18:04:17', '2014-05-26 18:14:17', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-26 19:21:33'),
(67, '2014-05-26 19:21:56', '2014-05-26 19:22:00', '2014-05-26 19:32:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-26 19:24:57'),
(68, '2014-05-26 19:25:30', '2014-05-26 19:25:33', '2014-05-26 19:35:33', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-26 19:27:49'),
(69, '2014-05-26 19:28:42', '2014-05-26 19:28:47', '2014-05-26 19:38:47', '0000-00-00 00:00:00', '2014-05-27 16:40:29', '2014-05-26 19:30:07'),
(70, '2014-05-27 13:02:41', '2014-05-27 15:18:35', '2014-05-27 15:28:35', '0000-00-00 00:00:00', '2014-05-27 17:35:51', '2014-05-27 15:19:18'),
(71, '2014-05-27 13:04:18', '2014-05-27 15:17:45', '2014-05-27 15:27:45', '0000-00-00 00:00:00', '2014-05-27 17:45:25', '2014-05-27 15:18:21'),
(72, '2014-05-27 15:23:12', '2014-05-27 15:24:57', '2014-05-27 15:34:57', '0000-00-00 00:00:00', '2014-05-27 17:47:55', '2014-05-27 15:32:35'),
(73, '2014-05-27 15:39:12', '2014-05-27 15:39:15', '2014-05-27 15:49:15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-27 16:31:10'),
(74, '2014-05-27 16:41:24', '2014-05-27 16:41:28', '2014-05-27 16:51:28', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-27 17:44:05'),
(75, '2014-05-27 17:05:11', '2014-05-27 17:05:16', '2014-05-27 17:15:16', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-27 17:15:52'),
(76, '2014-05-29 15:31:22', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-30 17:10:49', '2014-06-01 21:31:02'),
(77, '2014-05-29 17:04:06', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-01 21:31:02'),
(78, '2014-05-29 17:05:42', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-05-29 17:25:43', '2014-06-02 11:09:34'),
(79, '2014-06-01 20:59:02', '2014-06-01 20:59:11', '2014-06-01 21:09:11', '0000-00-00 00:00:00', '2014-06-16 10:32:59', '0000-00-00 00:00:00'),
(80, '2014-06-01 21:03:33', '2014-06-01 21:03:47', '2014-06-01 21:13:47', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-01 21:04:36'),
(81, '2014-06-01 21:05:11', '2014-06-01 21:05:14', '2014-06-01 21:15:14', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-01 21:06:50'),
(82, '2014-06-01 21:10:55', '2014-06-01 21:11:00', '2014-06-01 21:21:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-01 21:30:17'),
(83, '2014-06-02 11:15:30', '2014-06-02 11:15:56', '2014-06-02 11:25:56', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-02 11:37:29'),
(84, '2014-06-02 14:08:14', '2014-06-02 14:08:19', '2014-06-02 14:18:19', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-02 14:12:17'),
(85, '2014-06-02 14:12:41', '2014-06-02 14:12:57', '2014-06-02 14:22:57', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-11 14:56:33'),
(86, '2014-06-03 15:01:08', '2014-06-03 15:01:18', '2014-06-03 15:11:18', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-03 15:08:02'),
(87, '2014-06-12 09:40:27', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-16 12:03:18', '0000-00-00 00:00:00'),
(88, '2014-06-12 09:52:20', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-12 09:55:07', '2014-06-12 15:24:01'),
(89, '2014-06-12 09:53:28', '2014-06-12 12:22:39', '2014-06-12 12:32:39', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-12 12:30:53'),
(90, '2014-06-12 15:41:12', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-12 15:42:14', '2014-06-12 15:42:07'),
(91, '2014-06-12 15:43:41', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-12 15:43:36'),
(92, '2014-06-12 15:45:09', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-12 15:45:04'),
(93, '2014-06-12 15:46:51', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-12 15:47:25', '2014-06-12 15:47:17'),
(94, '2014-06-18 10:04:18', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2014-06-18 10:10:11', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `push`
--

CREATE TABLE `push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drivers` text NOT NULL,
  `order_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `date` datetime DEFAULT NULL,
  `result` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=162 ;

--
-- Dumping data for table `push`
--

INSERT INTO `push` (`id`, `drivers`, `order_id`, `message`, `date`, `result`) VALUES
(1, '["49","50","51"]', 1, '{"order":{"id":"1","clientName":"","clientPhone":"","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 10:13:19', '{"multicast_id":7219053361244265018,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399273999470930%cc17416ff9fd7ecd"},{"message_id":"0:1399273999470932%cc17416ff9fd7ecd"},{"message_id":"0:1399273999471446%cc17416ff9fd7ecd"}]}'),
(2, '["49","50","51"]', 1, '{"messageType":1003,"orderId":1}', '2014-05-05 11:03:28', '{"multicast_id":5377576111909407065,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399277008306889%cc17416ff9fd7ecd"},{"message_id":"0:1399277008306891%cc17416ff9fd7ecd"},{"message_id":"0:1399277008306024%cc17416ff9fd7ecd"}]}'),
(3, '["49","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"34","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:05:28', '{"multicast_id":7984461503205610914,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399277128180937%cc17416ff9fd7ecd"},{"message_id":"0:1399277128181565%cc17416ff9fd7ecd"},{"message_id":"0:1399277128180935%cc17416ff9fd7ecd"}]}'),
(4, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107\\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434  \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 ","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:30:07', '{"multicast_id":4986490027518079175,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399278607692863%cc17416ff9fd7ecd"},{"message_id":"0:1399278607692553%cc17416ff9fd7ecd"},{"message_id":"0:1399278607692416%cc17416ff9fd7ecd"},{"messa'),
(5, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"34","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117\\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434  \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430   [{\\"apartment\\":\\"\\",\\"porch\\":\\"\\"}]","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:33:05', '{"multicast_id":5668344868406916989,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399278785824966%cc17416ff9fd7ecd"},{"message_id":"0:1399278785823490%cc17416ff9fd7ecd"},{"message_id":"0:1399278785823758%cc17416ff9fd7ecd"},{"messa'),
(6, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107\\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 3 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 16  [{\\"apartment\\":\\"16\\",\\"porch\\":\\"3\\"}]","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:33:57', '{"multicast_id":8989464894678229270,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399278837929410%cc17416ff9fd7ecd"},{"message_id":"0:1399278837929828%cc17416ff9fd7ecd"},{"message_id":"0:1399278837929032%cc17416ff9fd7ecd"},{"messa'),
(7, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:39:23', '{"multicast_id":4734201853887590509,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399279163770862%cc17416ff9fd7ecd"},{"message_id":"0:1399279163770374%cc17416ff9fd7ecd"},{"message_id":"0:1399279163770376%cc17416ff9fd7ecd"},{"messa'),
(8, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"41","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:40:07', '{"multicast_id":7943685891687794253,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399279207451860%cc17416ff9fd7ecd"},{"message_id":"0:1399279207451436%cc17416ff9fd7ecd"},{"message_id":"0:1399279207450462%cc17416ff9fd7ecd"},{"messa'),
(9, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"44","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"SALON_LOADING"},{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:41:27', '{"multicast_id":6257376514284452659,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399279288037956%cc17416ff9fd7ecd"},{"message_id":"0:1399279288037958%cc17416ff9fd7ecd"},{"message_id":"0:1399279288037671%cc17416ff9fd7ecd"},{"messa'),
(10, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"41","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 11:42:26', '{"multicast_id":8943888393809454894,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399279347127635%cc17416ff9fd7ecd"},{"message_id":"0:1399279347127633%cc17416ff9fd7ecd"},{"message_id":"0:1399279347127631%cc17416ff9fd7ecd"},{"messa'),
(11, '["36","49","50","51","36","49","50","51"]', 2, '{"order":{"id":"2","clientName":"","clientPhone":"","clientId":"","price":"41","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:00:16', '{"multicast_id":5568658615094275180,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399280416307636%cc17416ff9fd7ecd"},{"message_id":"0:1399280416306283%cc17416ff9fd7ecd"},{"message_id":"0:1399280416306833%cc17416ff9fd7ecd"},{"messa'),
(12, '["36","49","50","51"]', 3, '{"order":{"id":"3","clientName":"","clientPhone":"","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117 \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 6","apartment":" \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 44","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:01:33', '{"multicast_id":6999258734761376984,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399280493725585%cc17416ff9fd7ecd"},{"message_id":"0:1399280493723240%cc17416ff9fd7ecd"},{"message_id":"0:1399280493725948%cc17416ff9fd7ecd"},{"messa'),
(13, '["36","49","50","51"]', 4, '{"order":{"id":"4","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107 \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 9","apartment":" \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 45","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:03:02', '{"multicast_id":8656398825900881397,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399280582382982%cc17416ff9fd7ecd"},{"message_id":"0:1399280582382984%cc17416ff9fd7ecd"},{"message_id":"0:1399280582382721%cc17416ff9fd7ecd"},{"messa'),
(14, '["36","49","50","51","36","49","50","51"]', 3, '{"order":{"id":"3","clientName":"","clientPhone":"","clientId":"","price":"45","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:04:18', '{"multicast_id":9142633678800822118,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399280658933985%cc17416ff9fd7ecd"},{"message_id":"0:1399280658933988%cc17416ff9fd7ecd"},{"message_id":"0:1399280658933984%cc17416ff9fd7ecd"},{"messa'),
(15, '["36","49","50","51","36","49","50","51"]', 4, '{"order":{"id":"4","clientName":"","clientPhone":"","clientId":"","price":"41","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107 \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 2 \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 56","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:05:26', '{"multicast_id":6053430333374810423,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399280725996911%cc17416ff9fd7ecd"},{"message_id":"0:1399280725996860%cc17416ff9fd7ecd"},{"message_id":"0:1399280725996859%cc17416ff9fd7ecd"},{"messa'),
(16, '["36","49","50","51","36","49","50","51"]', 4, '{"order":{"id":"4","clientName":"","clientPhone":"","clientId":"","price":"41","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:15:50', '{"multicast_id":6550105187871655139,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399281350212813%cc17416ff9fd7ecd"},{"message_id":"0:1399281350212815%cc17416ff9fd7ecd"},{"message_id":"0:1399281350212811%cc17416ff9fd7ecd"},{"messa'),
(17, '["36","49","50","51","36","49","50","51"]', 4, '{"order":{"id":"4","clientName":"","clientPhone":"","clientId":"","price":"44","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 3, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 56","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"SALON_LOADING"},{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:19:51', '{"multicast_id":5789194161361851611,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399281591193113%cc17416ff9fd7ecd"},{"message_id":"0:1399281591192463%cc17416ff9fd7ecd"},{"message_id":"0:1399281591192630%cc17416ff9fd7ecd"},{"messa'),
(18, '["36","49","50","51","36","49","50","51"]', 4, '{"order":{"id":"4","clientName":"","clientPhone":"","clientId":"","price":"44","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 5, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 44","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"SALON_LOADING"},{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 12:25:57', '{"multicast_id":9191123901885077513,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399281957750366%cc17416ff9fd7ecd"},{"message_id":"0:1399281957750243%cc17416ff9fd7ecd"},{"message_id":"0:1399281957750284%cc17416ff9fd7ecd"},{"messa'),
(19, '["49","50","36","49","50","51"]', 5, '{"order":{"id":"5","clientName":"","clientPhone":"","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 5, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 149","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 15:10:56', '{"multicast_id":7773236729958160814,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399291856245302%cc17416ff9fd7ecd"},{"message_id":"0:1399291856246549%cc17416ff9fd7ecd"},{"message_id":"0:1399291856243747%cc17416ff9fd7ecd"},{"messa'),
(20, '["36","49","50","51"]', 6, '{"order":{"id":"6","clientName":"","clientPhone":"","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 80, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 1, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 5","longitude":35.0328466,"latitude":48.4717644},{"id":"1","address":"\\u0413\\u043e\\u043c\\u0435\\u043b\\u044c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 2","longitude":35.001344,"latitude":48.4668034}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 15:12:52', '{"multicast_id":6363575945064246627,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399291972220933%cc17416ff9fd7ecd"},{"message_id":"0:1399291972220931%cc17416ff9fd7ecd"},{"message_id":"0:1399291972219946%cc17416ff9fd7ecd"},{"messa'),
(21, '["36","49","36","49","50","51"]', 6, '{"order":{"id":"6","clientName":"","clientPhone":"","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 80, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 1, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 5","longitude":35.0328466,"latitude":48.4717644},{"id":"1","address":"\\u0413\\u043e\\u043c\\u0435\\u043b\\u044c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 2","longitude":35.001344,"latitude":48.4668034}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 15:18:37', '{"multicast_id":5693296559863059238,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399292317717847%cc17416ff9fd7ecd"},{"message_id":"0:1399292317717845%cc17416ff9fd7ecd"},{"message_id":"0:1399292317717384%cc17416ff9fd7ecd"},{"messa'),
(22, '["36","49","36","49","50","51"]', 7, '{"order":{"id":"7","clientName":"","clientPhone":"","clientId":"","price":"43","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 80, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 13","longitude":35.0328466,"latitude":48.4717644},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 15:27:45', '{"multicast_id":7464785228317345046,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399292865859335%cc17416ff9fd7ecd"},{"message_id":"0:1399292865859913%cc17416ff9fd7ecd"},{"message_id":"0:1399292865859355%cc17416ff9fd7ecd"},{"messa'),
(23, '["36","49","36","49","50","51"]', 8, '{"order":{"id":"8","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 111","longitude":35.0251742,"latitude":48.4736199},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 15:39:32', '{"multicast_id":5967194180878012786,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399293573117816%cc17416ff9fd7ecd"},{"message_id":"0:1399293573117815%cc17416ff9fd7ecd"},{"message_id":"0:1399293573117348%cc17416ff9fd7ecd"},{"messa'),
(24, '["36","49","36","49","50","51"]', 7, '{"order":{"id":"7","clientName":"","clientPhone":"","clientId":"","price":"43","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 80, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 13","longitude":35.0328466,"latitude":48.4717644},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-05 16:32:13', '{"multicast_id":5525905907110266619,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399296733700664%cc17416ff9fd7ecd"},{"message_id":"0:1399296733702541%cc17416ff9fd7ecd"},{"message_id":"0:1399296733700842%cc17416ff9fd7ecd"},{"messa'),
(25, '["49","50","49","50","51"]', 8, '{"order":{"id":"8","clientName":"","clientPhone":"","clientId":"","price":"28","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, ","longitude":35.045481,"latitude":48.4645008},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 10:50:37', '{"multicast_id":8878675396675739984,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399362637908215%cc17416ff9fd7ecd"},{"message_id":"0:1399362637910438%cc17416ff9fd7ecd"},{"message_id":"0:1399362637908688%cc17416ff9fd7ecd"}]}'),
(26, '["36","49","50","51","36"]', 8, '{"order":{"id":"8","clientName":"","clientPhone":"","clientId":"","price":"34","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 10:54:14', '{"multicast_id":6690230458640303894,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399362854402759%cc17416ff9fd7ecd"},{"message_id":"0:1399362854402756%cc17416ff9fd7ecd"},{"message_id":"0:1399362854402057%cc17416ff9fd7ecd"},{"messa'),
(27, '["49","50","51"]', 7, '{"messageType":1003,"orderId":7}', '2014-05-06 14:19:41', '{"multicast_id":8457945472955040447,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399375181824996%cc17416ff9fd7ecd"},{"message_id":"0:1399375181824473%cc17416ff9fd7ecd"},{"message_id":"0:1399375181824471%cc17416ff9fd7ecd"}]}'),
(28, '["49","50","51"]', 8, '{"messageType":1003,"orderId":8}', '2014-05-06 14:20:58', '{"multicast_id":6730737136928287845,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399375258342158%cc17416ff9fd7ecd"},{"message_id":"0:1399375258342833%cc17416ff9fd7ecd"},{"message_id":"0:1399375258342835%cc17416ff9fd7ecd"}]}'),
(29, '["49","50","51"]', 6, '{"messageType":1003,"orderId":6}', '2014-05-06 14:22:34', '{"multicast_id":8691046624781956232,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399375354111990%cc17416ff9fd7ecd"},{"message_id":"0:1399375354111207%cc17416ff9fd7ecd"},{"message_id":"0:1399375354111987%cc17416ff9fd7ecd"}]}'),
(30, '["49","50","51"]', 3, '{"messageType":1003,"orderId":3}', '2014-05-06 14:25:14', '{"multicast_id":4709654315965583052,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399375514957235%cc17416ff9fd7ecd"},{"message_id":"0:1399375514957704%cc17416ff9fd7ecd"},{"message_id":"0:1399375514960473%cc17416ff9fd7ecd"}]}'),
(31, '["49","50","51"]', 2, '{"messageType":1003,"orderId":2}', '2014-05-06 16:37:09', '{"multicast_id":8887952995185865313,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399383429382182%cc17416ff9fd7ecd"},{"message_id":"0:1399383429382385%cc17416ff9fd7ecd"},{"message_id":"0:1399383429388464%cc17416ff9fd7ecd"}]}'),
(32, '["49","50","51"]', 5, '{"messageType":1003,"orderId":5}', '2014-05-06 16:38:31', '{"multicast_id":6891373303513224007,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399383511839809%cc17416ff9fd7ecd"},{"message_id":"0:1399383511838735%cc17416ff9fd7ecd"},{"message_id":"0:1399383511838737%cc17416ff9fd7ecd"}]}'),
(33, '["36"]', 4, '{"order":{"id":"4","clientName":"\\u041a\\u043b\\u0438\\u0435\\u043d\\u0442","clientPhone":"\\u041a\\u043b\\u0438+380957536","clientId":"","price":"44","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 5, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 44","longitude":35.0262814,"latitude":48.4734229},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"SALON_LOADING"},{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 16:42:41', '{"multicast_id":6680349636638638639,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399383761591910%cc17416ff9fd7ecd"}]}'),
(34, '["24","24"]', 12, '{"order":{"id":"12","clientName":"","clientPhone":"555-55-55","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","location":"null"}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 17:29:09', '{"multicast_id":8432056622166500021,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399386550013412%cc17416ff9fd7ecd"}]}'),
(35, '["36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 17:40:07', '{"multicast_id":8199655289797661363,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399387207437108%cc17416ff9fd7ecd"}]}'),
(36, '["24","36"]', 13, '{"order":{"id":"13","clientName":"","clientPhone":"555-55-55","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 17:40:07', '{"multicast_id":5686067958129658104,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399387207727806%cc17416ff9fd7ecd"},{"message_id":"0:1399387207727457%cc17416ff9fd7ecd"}]}'),
(37, '["24","36"]', 12, '{"order":{"id":"12","clientName":"","clientPhone":"555-55-55","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","location":"null"}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 17:40:07', '{"multicast_id":6458837427004464966,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399387207993668%cc17416ff9fd7ecd"},{"message_id":"0:1399387207993666%cc17416ff9fd7ecd"}]}'),
(38, '["24","36"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-06 17:40:08', '{"multicast_id":5616898982584171962,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399387208244996%cc17416ff9fd7ecd"},{"message_id":"0:1399387208244635%cc17416ff9fd7ecd"}]}'),
(39, '["36","49","50","51"]', 4, '{"messageType":1003,"orderId":4}', '2014-05-06 17:41:22', '{"multicast_id":7162837371021746979,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399387282308884%cc17416ff9fd7ecd"},{"message_id":"0:1399387282309918%cc17416ff9fd7ecd"},{"message_id":"0:1399387282310817%cc17416ff9fd7ecd"},{"messa'),
(40, '[]', 16, '{"messageType":1003,"orderId":16}', '2014-05-06 17:41:56', '"registration_ids" field cannot be empty\n'),
(41, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 09:45:56', '{"multicast_id":6330365712131706296,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399445156696198%cc17416ff9fd7ecd"},{"message_id":"0:1399445156696819%cc17416ff9fd7ecd"},{"message_id":"0:1399445156696818%cc17416ff9fd7ecd"}]}'),
(42, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 09:55:35', '{"multicast_id":7957996169053431934,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399445735305606%cc17416ff9fd7ecd"},{"message_id":"0:1399445735305733%cc17416ff9fd7ecd"},{"message_id":"0:1399445735305310%cc17416ff9fd7ecd"}]}'),
(43, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 10:22:54', '{"multicast_id":4769072135739978084,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399447374096964%cc17416ff9fd7ecd"},{"message_id":"0:1399447374096900%cc17416ff9fd7ecd"},{"message_id":"0:1399447374096899%cc17416ff9fd7ecd"}]}'),
(44, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 10:25:28', '{"multicast_id":7691210444442547201,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399447528372789%cc17416ff9fd7ecd"},{"message_id":"0:1399447528372912%cc17416ff9fd7ecd"},{"message_id":"0:1399447528372910%cc17416ff9fd7ecd"}]}'),
(45, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 10:26:19', '{"multicast_id":8275709337391266309,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399447579569495%cc17416ff9fd7ecd"},{"message_id":"0:1399447579569961%cc17416ff9fd7ecd"},{"message_id":"0:1399447579569502%cc17416ff9fd7ecd"}]}'),
(46, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 11:37:45', '{"multicast_id":5632245232789642718,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399451865832339%cc17416ff9fd7ecd"},{"message_id":"0:1399451865832559%cc17416ff9fd7ecd"},{"message_id":"0:1399451865831493%cc17416ff9fd7ecd"}]}'),
(47, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 11:41:06', '{"multicast_id":4892192208530921172,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399452066433773%cc17416ff9fd7ecd"},{"message_id":"0:1399452066433963%cc17416ff9fd7ecd"},{"message_id":"0:1399452066433008%cc17416ff9fd7ecd"}]}'),
(48, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":"null"}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 11:43:02', '{"multicast_id":5080777190885120556,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399452182298295%cc17416ff9fd7ecd"},{"message_id":"0:1399452182298836%cc17416ff9fd7ecd"},{"message_id":"0:1399452182298187%cc17416ff9fd7ecd"}]}'),
(49, '["23","24","36","36"]', 17, '{"order":{"id":"17","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 11:46:39', '{"multicast_id":5114319452595256380,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399452399592143%cc17416ff9fd7ecd"},{"message_id":"0:1399452399592788%cc17416ff9fd7ecd"},{"message_id":"0:1399452399591884%cc17416ff9fd7ecd"}]}'),
(50, '["36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 11:50:22', '{"multicast_id":5702721861204554031,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399452622692709%cc17416ff9fd7ecd"}]}'),
(51, '["36"]', 21, '{"order":{"id":"21","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 7","longitude":35.068316,"latitude":48.413046}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 11:55:14', '{"multicast_id":7573138095144219584,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399452914204243%cc17416ff9fd7ecd"}]}'),
(52, '["36"]', 23, '{"order":{"id":"23","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 111","longitude":35.039821,"latitude":48.428144}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:02:03', '{"multicast_id":8641674683690839054,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453323689804%cc17416ff9fd7ecd"}]}'),
(53, '["36"]', 21, '{"order":{"id":"21","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 7","longitude":35.068316,"latitude":48.413046}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:40', '{"multicast_id":7810109604225711819,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453540002109%cc17416ff9fd7ecd"}]}'),
(54, '["36"]', 20, '{"order":{"id":"20","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.026497,"latitude":48.425668}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:40', '{"multicast_id":5838085492377205294,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453540255942%cc17416ff9fd7ecd"}]}'),
(55, '["36"]', 19, '{"order":{"id":"19","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:40', '{"multicast_id":7250204522345161703,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453540528623%cc17416ff9fd7ecd"}]}'),
(56, '["36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:40', '{"multicast_id":8888426886641995177,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453540787884%cc17416ff9fd7ecd"}]}'),
(57, '["36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:41', '{"multicast_id":7895221791770646117,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453541056645%cc17416ff9fd7ecd"}]}'),
(58, '["24","36"]', 14, '{"order":{"id":"14","clientName":"","clientPhone":"555-55-55","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","location":""}],"extras":[{"name":"ANIMAL"},{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:41', '{"multicast_id":9028609556643224929,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453541311673%cc17416ff9fd7ecd"},{"message_id":"0:1399453541311822%cc17416ff9fd7ecd"}]}'),
(59, '["24","36"]', 13, '{"order":{"id":"13","clientName":"","clientPhone":"555-55-55","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:42', '{"multicast_id":8579031414047265625,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453541571617%cc17416ff9fd7ecd"},{"message_id":"0:1399453541571852%cc17416ff9fd7ecd"}]}'),
(60, '["24","36"]', 12, '{"order":{"id":"12","clientName":"","clientPhone":"555-55-55","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","location":"null"}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:43', '{"multicast_id":4720344576532352602,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453542969367%cc17416ff9fd7ecd"},{"message_id":"0:1399453542969704%cc17416ff9fd7ecd"}]}'),
(61, '["24","36"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"0","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","location":""}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:05:43', '{"multicast_id":4909032734439235851,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453543249703%cc17416ff9fd7ecd"},{"message_id":"0:1399453543249913%cc17416ff9fd7ecd"}]}'),
(62, '["36"]', 23, '{"messageType":1003,"orderId":23}', '2014-05-07 12:07:05', '{"multicast_id":6660238474060332353,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453624990864%cc17416ff9fd7ecd"}]}'),
(63, '["36"]', 21, '{"messageType":1003,"orderId":21}', '2014-05-07 12:07:33', '{"multicast_id":6720352708740911660,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453653127088%cc17416ff9fd7ecd"}]}'),
(64, '["23","24","36","36"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:08:08', '{"multicast_id":7165733518876792938,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453688170800%cc17416ff9fd7ecd"},{"message_id":"0:1399453688170799%cc17416ff9fd7ecd"},{"message_id":"0:1399453688170633%cc17416ff9fd7ecd"}]}'),
(65, '["23","24","36","36"]', 12, '{"order":{"id":"12","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:08:33', '{"multicast_id":5597795065039133648,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453713362603%cc17416ff9fd7ecd"},{"message_id":"0:1399453713362972%cc17416ff9fd7ecd"},{"message_id":"0:1399453713362970%cc17416ff9fd7ecd"}]}'),
(66, '["23","24","36","24","36"]', 13, '{"order":{"id":"13","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:08:46', '{"multicast_id":8990810666740837988,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453725988928%cc17416ff9fd7ecd"},{"message_id":"0:1399453725988926%cc17416ff9fd7ecd"},{"message_id":"0:1399453725988924%cc17416ff9fd7ecd"}]}');
INSERT INTO `push` (`id`, `drivers`, `order_id`, `message`, `date`, `result`) VALUES
(67, '["23","36"]', 13, '{"messageType":1003,"orderId":13}', '2014-05-07 12:08:56', '{"multicast_id":8023998900377449841,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453736528349%cc17416ff9fd7ecd"},{"message_id":"0:1399453736528229%cc17416ff9fd7ecd"}]}'),
(68, '["23","24","36","36"]', 14, '{"order":{"id":"14","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:08:57', '{"multicast_id":5187243854923692035,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453737444998%cc17416ff9fd7ecd"},{"message_id":"0:1399453737445002%cc17416ff9fd7ecd"},{"message_id":"0:1399453737444999%cc17416ff9fd7ecd"}]}'),
(69, '["23","24","36","36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:09:08', '{"multicast_id":6939967303916224037,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453748519999%cc17416ff9fd7ecd"},{"message_id":"0:1399453748520001%cc17416ff9fd7ecd"},{"message_id":"0:1399453748520003%cc17416ff9fd7ecd"}]}'),
(70, '["24","36","24","36"]', 19, '{"order":{"id":"19","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.026497,"latitude":48.425668}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:10:21', '{"multicast_id":7065478313833205543,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453821955517%cc17416ff9fd7ecd"},{"message_id":"0:1399453821954516%cc17416ff9fd7ecd"}]}'),
(71, '["36"]', 19, '{"messageType":1003,"orderId":19}', '2014-05-07 12:10:41', '{"multicast_id":4823292221159168958,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399453841964710%cc17416ff9fd7ecd"}]}'),
(72, '["36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:12', '{"multicast_id":6471072119427661027,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455792924277%cc17416ff9fd7ecd"}]}'),
(73, '["36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:13', '{"multicast_id":8142422598014718178,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455793189415%cc17416ff9fd7ecd"}]}'),
(74, '["24"]', 12, '{"order":{"id":"12","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:13', '{"multicast_id":5466946370876245146,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455793716517%cc17416ff9fd7ecd"}]}'),
(75, '["36","24","36"]', 20, '{"order":{"id":"20","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.026497,"latitude":48.425668}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:22', '{"multicast_id":4997527368686312284,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455803073971%cc17416ff9fd7ecd"},{"message_id":"0:1399455803073969%cc17416ff9fd7ecd"}]}'),
(76, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:23', '{"multicast_id":8263021434184623620,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455803494992%cc17416ff9fd7ecd"},{"message_id":"0:1399455803494870%cc17416ff9fd7ecd"}]}'),
(77, '["36"]', 14, '{"order":{"id":"14","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:23', '{"multicast_id":7409050508413957809,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455804003880%cc17416ff9fd7ecd"}]}'),
(78, '["24"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:43:24', '{"multicast_id":6151342397833070109,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455804524547%cc17416ff9fd7ecd"}]}'),
(79, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:37', '{"multicast_id":9186797825462517855,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455877491734%cc17416ff9fd7ecd"},{"message_id":"0:1399455877491501%cc17416ff9fd7ecd"}]}'),
(80, '["24","36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:37', '{"multicast_id":8337023334692152258,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455877792906%cc17416ff9fd7ecd"},{"message_id":"0:1399455877792904%cc17416ff9fd7ecd"}]}'),
(81, '["24","24","36"]', 14, '{"order":{"id":"14","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:37', '{"multicast_id":8620539480259038852,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455878064967%cc17416ff9fd7ecd"},{"message_id":"0:1399455878064205%cc17416ff9fd7ecd"}]}'),
(82, '["24","24","36"]', 12, '{"order":{"id":"12","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:38', '{"multicast_id":8736772698311768882,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455878312495%cc17416ff9fd7ecd"},{"message_id":"0:1399455878312497%cc17416ff9fd7ecd"}]}'),
(83, '["24","36"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:38', '{"multicast_id":8630251182730584393,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455878575955%cc17416ff9fd7ecd"},{"message_id":"0:1399455878575954%cc17416ff9fd7ecd"}]}'),
(84, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:49', '{"multicast_id":8073870494614298745,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455889375409%cc17416ff9fd7ecd"},{"message_id":"0:1399455889375844%cc17416ff9fd7ecd"}]}'),
(85, '["24","36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:49', '{"multicast_id":5649619385538579457,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455889645902%cc17416ff9fd7ecd"},{"message_id":"0:1399455889644303%cc17416ff9fd7ecd"}]}'),
(86, '["24","36"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:44:49', '{"multicast_id":4782040945612001390,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455889918119%cc17416ff9fd7ecd"},{"message_id":"0:1399455889918941%cc17416ff9fd7ecd"}]}'),
(87, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:45:06', '{"multicast_id":8076457288202528790,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455906720848%cc17416ff9fd7ecd"},{"message_id":"0:1399455906720670%cc17416ff9fd7ecd"}]}'),
(88, '["24","36"]', 15, '{"order":{"id":"15","clientName":"\\u0412\\u0438\\u0442\\u0430\\u043b\\u0438\\u0439","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:45:06', '{"multicast_id":5495556096458671593,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455906977569%cc17416ff9fd7ecd"},{"message_id":"0:1399455906977567%cc17416ff9fd7ecd"}]}'),
(89, '["24","36"]', 11, '{"order":{"id":"11","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:45:07', '{"multicast_id":6752400346624206283,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455907241668%cc17416ff9fd7ecd"},{"message_id":"0:1399455907241666%cc17416ff9fd7ecd"}]}'),
(90, '["24","24","36"]', 14, '{"order":{"id":"14","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:45:37', '{"multicast_id":6349671596901316018,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455937367959%cc17416ff9fd7ecd"},{"message_id":"0:1399455937367960%cc17416ff9fd7ecd"}]}'),
(91, '["24","24","36"]', 14, '{"order":{"id":"14","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:45:43', '{"multicast_id":6057958887587936120,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455943916790%cc17416ff9fd7ecd"},{"message_id":"0:1399455943916788%cc17416ff9fd7ecd"}]}'),
(92, '["23","36"]', 15, '{"messageType":1003,"orderId":15}', '2014-05-07 12:46:07', '{"multicast_id":4999576043281499865,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455967302221%cc17416ff9fd7ecd"},{"message_id":"0:1399455967295834%cc17416ff9fd7ecd"}]}'),
(93, '["23","36"]', 11, '{"messageType":1003,"orderId":11}', '2014-05-07 12:46:32', '{"multicast_id":7174696289568290797,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399455992848134%cc17416ff9fd7ecd"},{"message_id":"0:1399455992848975%cc17416ff9fd7ecd"}]}'),
(94, '["36"]', 20, '{"messageType":1003,"orderId":20}', '2014-05-07 12:46:47', '{"multicast_id":6715812619812708344,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399456007561028%cc17416ff9fd7ecd"}]}'),
(95, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:48:18', '{"multicast_id":6271444730185596502,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399456098272165%cc17416ff9fd7ecd"},{"message_id":"0:1399456098272822%cc17416ff9fd7ecd"}]}'),
(96, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:48:27', '{"multicast_id":7599992925447654358,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399456107996805%cc17416ff9fd7ecd"},{"message_id":"0:1399456107996807%cc17416ff9fd7ecd"}]}'),
(97, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:49:20', '{"multicast_id":6742366368688540333,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399456160251195%cc17416ff9fd7ecd"},{"message_id":"0:1399456160251672%cc17416ff9fd7ecd"}]}'),
(98, '["24","36"]', 18, '{"order":{"id":"18","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.067649,"latitude":48.414697}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 12:50:02', '{"multicast_id":7143998773225312447,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399456203044117%cc17416ff9fd7ecd"},{"message_id":"0:1399456203052859%cc17416ff9fd7ecd"}]}'),
(99, '["36"]', 24, '{"order":{"id":"24","clientName":"\\u0418\\u043c\\u044f","clientPhone":"+380957536866","clientId":"","price":"30","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-07 17:05:55', '{"multicast_id":5095598719618858956,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399471555080885%cc17416ff9fd7ecd"}]}'),
(100, '["24"]', 28, '{"order":{"id":"28","clientName":"\\u0427\\u0430\\u043f\\u0430\\u0435\\u0432","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-08 23:34:56', '{"multicast_id":4712211350536971450,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399581296565028%cc17416ff9fd7ecd"}]}'),
(101, '[]', 28, '{"messageType":1003,"orderId":28}', '2014-05-08 23:35:16', '"registration_ids" field cannot be empty\n'),
(102, '["24"]', 29, '{"order":{"id":"29","clientName":"","clientPhone":"777-77-77","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042284,"latitude":48.459546}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-08 23:35:54', '{"multicast_id":5027244245130489050,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399581355055447%cc17416ff9fd7ecd"}]}'),
(103, '[]', 29, '{"messageType":1003,"orderId":29}', '2014-05-08 23:36:02', '"registration_ids" field cannot be empty\n'),
(104, '["24"]', 30, '{"order":{"id":"30","clientName":"","clientPhone":"555-55-55","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042154,"latitude":48.4594386},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041f\\u0435\\u0442\\u0440\\u043e\\u0432\\u0441\\u043a\\u043e\\u0433\\u043e, 15","longitude":34.9834543,"latitude":48.4689793}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-08 23:45:27', '{"multicast_id":8026549059409437165,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399581928105960%cc17416ff9fd7ecd"}]}'),
(105, '["24","24"]', 30, '{"order":{"id":"30","clientName":"","clientPhone":"555-55-55","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042154,"latitude":48.4594386},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 2","longitude":35.0647472,"latitude":48.4540947}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-08 23:45:48', '{"multicast_id":7428126672140976041,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399581948433542%cc17416ff9fd7ecd"}]}'),
(106, '[]', 30, '{"messageType":1003,"orderId":30}', '2014-05-08 23:45:56', '"registration_ids" field cannot be empty\n'),
(107, '[]', 32, '{"messageType":1003,"orderId":32}', '2014-05-09 00:02:18', '"registration_ids" field cannot be empty\n'),
(108, '["24","36","36"]', 34, '{"order":{"id":"34","clientName":"","clientPhone":"","clientId":"","price":"98","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 17","longitude":35.0614745,"latitude":48.4512468},{"id":"1","address":"\\u041a\\u0440\\u0430\\u0441\\u043d\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 5","longitude":35.0425818,"latitude":48.4617326},{"id":"2","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u041d\\u0430\\u0431\\u0435\\u0440\\u0435\\u0436\\u043d\\u0430\\u044f \\u041f\\u043e\\u0431\\u0435\\u0434\\u044b, 18","longitude":35.0757778,"latitude":48.4505202},{"id":"3","address":"\\u041a\\u0430\\u043b\\u0438\\u043d\\u043e\\u0432\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 18","longitude":35.0737605,"latitude":48.5117723}],"extras":[{"name":"AIR_CONDITIONING"},{"name":"ANIMAL"},{"name":"COURIER_DELIVERY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-12 15:12:13', '{"multicast_id":6297984257318942110,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399896733622866%cc17416ff9fd7ecd"},{"message_id":"0:1399896733622864%cc17416ff9fd7ecd"}]}'),
(109, '["24","36","50","51"]', 34, '{"order":{"id":"34","clientName":"","clientPhone":"","clientId":"","price":"54","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 17","longitude":35.0614745,"latitude":48.4512468},{"id":"1","address":"\\u041a\\u0440\\u0430\\u0441\\u043d\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 5","longitude":35.0425818,"latitude":48.4617326},{"id":"2","address":"\\u041a\\u0430\\u043b\\u0438\\u043d\\u043e\\u0432\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 14","longitude":35.075657,"latitude":48.5114216}],"extras":[{"name":"AIR_CONDITIONING"},{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-13 09:55:06', '{"multicast_id":7978530418881924587,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399964106768388%cc17416ff9fd7ecd"},{"message_id":"0:1399964106767331%cc17416ff9fd7ecd"},{"message_id":"0:1399964106768704%cc17416ff9fd7ecd"},{"messa'),
(110, '["36","50","51"]', 36, '{"order":{"id":"36","clientName":"","clientPhone":"","clientId":"","price":"1340","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0435\\u0440\\u0435\\u0443\\u043b\\u043e\\u043a \\u0428\\u0435\\u0432\\u0447\\u0435\\u043d\\u043a\\u043e, 15","longitude":35.0500601,"latitude":48.45869},{"id":"1","address":"\\u042f\\u0441\\u043d\\u043e\\u043f\\u043e\\u043b\\u044f\\u043d\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 18","longitude":35.0759123,"latitude":48.4056152},{"id":"2","address":"Odessa, 5","longitude":30.794569,"latitude":46.5738573}],"extras":[{"name":"SALON_LOADING"},{"name":"TERMINAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-13 15:37:51', '{"multicast_id":4863066531489098241,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1399984671488203%cc17416ff9fd7ecd"},{"message_id":"0:1399984671486960%cc17416ff9fd7ecd"},{"message_id":"0:1399984671486065%cc17416ff9fd7ecd"}]}'),
(111, '["36","49","50","51"]', 37, '{"order":{"id":"37","clientName":"","clientPhone":"","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 11, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 6, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 54","longitude":35.0627233,"latitude":48.4523264},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 10:34:51', '{"multicast_id":5543339425464167202,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400225691604542%cc17416ff9fd7ecd"},{"message_id":"0:1400225691604488%cc17416ff9fd7ecd"},{"message_id":"0:1400225691604543%cc17416ff9fd7ecd"},{"messa'),
(112, '["36","50","51","36","49","50","51"]', 37, '{"order":{"id":"37","clientName":"","clientPhone":"","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 11, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 6, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 55","longitude":35.0627233,"latitude":48.4523264},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 10:40:51', '{"multicast_id":5510558292365105858,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400226051847669%cc17416ff9fd7ecd"},{"message_id":"0:1400226051848283%cc17416ff9fd7ecd"},{"message_id":"0:1400226051848799%cc17416ff9fd7ecd"},{"messa'),
(113, '["49","50","51"]', 37, '{"messageType":1003,"orderId":37}', '2014-05-16 10:40:59', '{"multicast_id":8862174102789228518,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400226059769166%cc17416ff9fd7ecd"},{"message_id":"0:1400226059772340%cc17416ff9fd7ecd"},{"message_id":"0:1400226059769346%cc17416ff9fd7ecd"}]}'),
(114, '["50","36","49","50","51"]', 38, '{"order":{"id":"38","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 2, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 14","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 10:55:08', '{"multicast_id":9037065694126501829,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400226908967355%cc17416ff9fd7ecd"},{"message_id":"0:1400226908967669%cc17416ff9fd7ecd"},{"message_id":"0:1400226908968591%cc17416ff9fd7ecd"},{"messa'),
(115, '["36","49","51"]', 38, '{"messageType":1003,"orderId":38}', '2014-05-16 10:55:55', '{"multicast_id":5682905502845957098,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400226955671926%cc17416ff9fd7ecd"},{"message_id":"0:1400226955671075%cc17416ff9fd7ecd"},{"message_id":"0:1400226955671928%cc17416ff9fd7ecd"}]}'),
(116, '["49","36","49","50","51"]', 39, '{"order":{"id":"39","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 11:03:04', '{"multicast_id":6291489786364469340,"success":4,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400227384068929%cc17416ff9fd7ecd"},{"message_id":"0:1400227384068650%cc17416ff9fd7ecd"},{"message_id":"0:1400227384070504%cc17416ff9fd7ecd"},{"messa'),
(117, '["49","49","50"]', 40, '{"order":{"id":"40","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 8, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 567","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 11:16:04', '{"multicast_id":5482772419476880516,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400228164196655%cc17416ff9fd7ecd"},{"message_id":"0:1400228164196653%cc17416ff9fd7ecd"}]}'),
(118, '["50","36","49","50"]', 40, '{"order":{"id":"40","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 8, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 567","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 11:16:15', '{"multicast_id":6343436928617016815,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400228175141319%cc17416ff9fd7ecd"},{"message_id":"0:1400228175142440%cc17416ff9fd7ecd"},{"message_id":"0:1400228175142683%cc17416ff9fd7ecd"}]}'),
(119, '["49","36","49","50"]', 40, '{"order":{"id":"40","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 8, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 567","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 11:16:56', '{"multicast_id":8722599213747388494,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400228216468816%cc17416ff9fd7ecd"},{"message_id":"0:1400228216468818%cc17416ff9fd7ecd"},{"message_id":"0:1400228216468942%cc17416ff9fd7ecd"}]}'),
(120, '["49","36","49","50"]', 41, '{"order":{"id":"41","clientName":"","clientPhone":"","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 4, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 567","longitude":35.026184,"latitude":48.473211}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 11:19:30', '{"multicast_id":6008292362248205574,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400228371001607%cc17416ff9fd7ecd"},{"message_id":"0:1400228371001516%cc17416ff9fd7ecd"},{"message_id":"0:1400228371001517%cc17416ff9fd7ecd"}]}'),
(121, '["36","49","36","49","50"]', 45, '{"order":{"id":"45","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0426\\u0423\\u041c, ","longitude":35.045498,"latitude":48.464359}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-16 11:31:18', '{"multicast_id":4932832679209898436,"success":3,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400229078535003%cc17416ff9fd7ecd"},{"message_id":"0:1400229078535762%cc17416ff9fd7ecd"},{"message_id":"0:1400229078535775%cc17416ff9fd7ecd"}]}'),
(122, '["36","50"]', 45, '{"messageType":1003,"orderId":45}', '2014-05-16 11:31:23', '{"multicast_id":5587570142090626946,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400229084053042%cc17416ff9fd7ecd"},{"message_id":"0:1400229084052060%cc17416ff9fd7ecd"}]}'),
(123, '["49"]', 47, '{"order":{"id":"47","clientName":"","clientPhone":"+380957536866","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 10:01:24', '{"multicast_id":7818723236463609503,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400482884958801%cc17416ff9fd7ecd"}]}'),
(124, '["50","49","50"]', 49, '{"order":{"id":"49","clientName":"","clientPhone":"+380957536866","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 110","longitude":35.0254501,"latitude":48.4735706},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 106","longitude":35.0626167,"latitude":48.4109739}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 10:16:48', '{"multicast_id":6952469286694125501,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400483808591378%cc17416ff9fd7ecd"},{"message_id":"0:1400483808591727%cc17416ff9fd7ecd"}]}'),
(125, '["49"]', 50, '{"order":{"id":"50","clientName":"","clientPhone":"+380957536866","clientId":"","price":"34","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 10:17:56', '{"multicast_id":5329272536731432812,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400483876782938%cc17416ff9fd7ecd"}]}'),
(126, '["23","49"]', 48, '{"order":{"id":"48","clientName":"","clientPhone":"+380957536866","clientId":"","price":"30","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 10:19:42', '{"multicast_id":7639340933204936660,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400483982773885%cc17416ff9fd7ecd"},{"message_id":"0:1400483982773887%cc17416ff9fd7ecd"}]}'),
(127, '["49","23","49"]', 51, '{"order":{"id":"51","clientName":"","clientPhone":"+380957536866","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 117","longitude":35.0202583,"latitude":48.4744958},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 10:33:53', '{"multicast_id":6098924240830494068,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400484833763827%cc17416ff9fd7ecd"},{"message_id":"0:1400484833763829%cc17416ff9fd7ecd"}]}'),
(128, '["49","23","49"]', 52, '{"order":{"id":"52","clientName":"","clientPhone":"+380957536866","clientId":"","price":"36","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 11:03:34', '{"multicast_id":8042665071694372448,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400486614295092%cc17416ff9fd7ecd"},{"message_id":"0:1400486614294598%cc17416ff9fd7ecd"}]}'),
(129, '["49"]', 53, '{"order":{"id":"53","clientName":"","clientPhone":"+380957536866","clientId":"","price":"36","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 11:27:29', '{"multicast_id":6545873336004876390,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400488049899124%cc17416ff9fd7ecd"}]}'),
(130, '["49"]', 53, '{"order":{"id":"53","clientName":"","clientPhone":"+380957536866","clientId":"","price":"36","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 11:27:36', '{"multicast_id":7211911171615392408,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400488056903028%cc17416ff9fd7ecd"}]}'),
(131, '["49"]', 54, '{"order":{"id":"54","clientName":"","clientPhone":"+380957536866","clientId":"","price":"36","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 6","longitude":35.0679249,"latitude":48.4143586}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:24:30', '{"multicast_id":5560217960742897275,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400498670901382%cc17416ff9fd7ecd"}]}'),
(132, '["49"]', 54, '{"order":{"id":"54","clientName":"","clientPhone":"+380957536866","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 7","longitude":35.0679847,"latitude":48.4134555}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:49:13', '{"multicast_id":7608348871886888426,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400500154065569%cc17416ff9fd7ecd"}]}'),
(133, '["49"]', 54, '{"order":{"id":"54","clientName":"","clientPhone":"+380957536866","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 7","longitude":35.0679847,"latitude":48.4134555}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:49:17', '{"multicast_id":8351457423642093158,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400500157509257%cc17416ff9fd7ecd"}]}'),
(134, '["49","49"]', 54, '{"order":{"id":"54","clientName":"","clientPhone":"+380957536866","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 108","longitude":35.0260095,"latitude":48.4734712},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 7","longitude":35.0679847,"latitude":48.4134555}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:50:09', '{"multicast_id":5152004908927416168,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400500210170495%cc17416ff9fd7ecd"}]}'),
(135, '["49","49"]', 54, '{"order":{"id":"54","clientName":"","clientPhone":"+380957536866","clientId":"","price":"37","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0431\\u0443\\u043b\\u044c\\u0432\\u0430\\u0440 \\u0421\\u043b\\u0430\\u0432\\u044b, 7","longitude":35.0679847,"latitude":48.4134555}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:50:31', '{"multicast_id":8896038254017354757,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400500232048409%cc17416ff9fd7ecd"}]}'),
(136, '["49"]', 55, '{"order":{"id":"55","clientName":"","clientPhone":"+380957536866","clientId":"","price":"38","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 100","longitude":35.0224809,"latitude":48.474366},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:51:16', '{"multicast_id":9085265896819953934,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400500276234420%cc17416ff9fd7ecd"}]}'),
(137, '["49","49"]', 55, '{"order":{"id":"55","clientName":"","clientPhone":"+380957536866","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 110","longitude":35.0254501,"latitude":48.4735706},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 14:51:40', '{"multicast_id":9051462711611907260,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400500301050978%cc17416ff9fd7ecd"}]}');
INSERT INTO `push` (`id`, `drivers`, `order_id`, `message`, `date`, `result`) VALUES
(138, '["36","36","49"]', 57, '{"order":{"id":"57","clientName":"","clientPhone":"+380957533686","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 17:24:06', '{"multicast_id":7202923153809689980,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400509446285122%cc17416ff9fd7ecd"},{"message_id":"0:1400509446285303%cc17416ff9fd7ecd"}]}'),
(139, '["36","49","36","49"]', 57, '{"order":{"id":"57","clientName":"","clientPhone":"+380957533686","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 3, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 52","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 17:25:33', '{"multicast_id":8589882016857224995,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400509533933982%cc17416ff9fd7ecd"},{"message_id":"0:1400509533934574%cc17416ff9fd7ecd"}]}'),
(140, '["36","49","36","49"]', 57, '{"order":{"id":"57","clientName":"","clientPhone":"+380957533686","clientId":"","price":"41","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107, \\u043f\\u043e\\u0434\\u044a\\u0435\\u0437\\u0434 3, \\u043a\\u0432\\u0430\\u0440\\u0442\\u0438\\u0440\\u0430 52","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"extras":[{"name":"ANIMAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 17:26:14', '{"multicast_id":8191039025768821776,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400509574878870%cc17416ff9fd7ecd"},{"message_id":"0:1400509574878872%cc17416ff9fd7ecd"}]}'),
(141, '["36","36","49"]', 58, '{"order":{"id":"58","clientName":"","clientPhone":"+380957536866","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u043f\\u0440\\u043e\\u0441\\u043f\\u0435\\u043a\\u0442 \\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 110","longitude":35.0254453,"latitude":48.4735588}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-19 17:30:25', '{"multicast_id":9146551022431345576,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400509825371412%cc17416ff9fd7ecd"},{"message_id":"0:1400509825371587%cc17416ff9fd7ecd"}]}'),
(142, '["36"]', 58, '{"messageType":1003,"orderId":58}', '2014-05-19 17:30:41', '{"multicast_id":5854547152322702079,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400509841115608%cc17416ff9fd7ecd"}]}'),
(143, '["24"]', 61, '{"order":{"id":"61","clientName":"","clientPhone":"555","clientId":"","price":"26","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0427\\u043a\\u0430\\u043b\\u043e\\u0432\\u0430, 12","longitude":35.042154,"latitude":48.4594386},{"id":"1","address":"\\u041f\\u0443\\u0448\\u043a\\u0438\\u043d\\u0430 \\u0413\\u0435\\u043d\\u0435\\u0440\\u0430\\u043b\\u0430 \\u0443\\u043b., 1","longitude":35.0295414,"latitude":48.4350654}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-21 16:32:23', '{"multicast_id":5951680423717371025,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1400679143614932%cc17416ff9fd7ecd"}]}'),
(144, '[]', 61, '{"messageType":1003,"orderId":61}', '2014-05-21 16:32:35', '"registration_ids" field cannot be empty\n'),
(145, '["36"]', 70, '{"order":{"id":"70","clientName":"","clientPhone":"8887777","clientId":"","price":"59","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u041a\\u0430\\u043b\\u0438\\u043d\\u043e\\u0432\\u0430\\u044f \\u0443\\u043b., 15","longitude":35.0752034,"latitude":48.5115043},{"id":"1","address":"\\u042f\\u0441\\u043d\\u043e\\u043f\\u043e\\u043b\\u044f\\u043d\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.0769507,"latitude":48.4069353}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-27 13:02:41', '{"multicast_id":5113934256497786520,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1401184961894772%cc17416ff9fd7ecd"}]}'),
(146, '["36"]', 71, '{"order":{"id":"71","clientName":"","clientPhone":"","clientId":"","price":"33","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u041a\\u0430\\u0440\\u043b\\u0430 \\u041c\\u0430\\u0440\\u043a\\u0441\\u0430, 107","longitude":35.0262705,"latitude":48.4734249},{"id":"1","address":"\\u0413\\u0430\\u0433\\u0430\\u0440\\u0438\\u043d\\u0430, 110","longitude":35.0266167,"latitude":48.4252896}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-27 13:09:58', '{"multicast_id":5448923920100703730,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1401185398141246%cc17416ff9fd7ecd"}]}'),
(147, '["36","36"]', 70, '{"order":{"id":"70","clientName":"","clientPhone":"8887777","clientId":"","price":"59","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u041a\\u0430\\u043b\\u0438\\u043d\\u043e\\u0432\\u0430\\u044f \\u0443\\u043b., 15","longitude":35.0752034,"latitude":48.5115043},{"id":"1","address":"\\u042f\\u0441\\u043d\\u043e\\u043f\\u043e\\u043b\\u044f\\u043d\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.0769507,"latitude":48.4069353}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-05-27 14:07:23', '{"multicast_id":8295644482506211010,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1401188843251621%cc17416ff9fd7ecd"}]}'),
(148, '[null]', 71, '{"messageType":1003,"orderId":71}', '2014-05-27 15:17:46', '{"multicast_id":5169361279425682633,"success":0,"failure":1,"canonical_ids":0,"results":[{"error":"MissingRegistration"}]}'),
(149, '[null]', 70, '{"messageType":1003,"orderId":70}', '2014-05-27 15:18:35', '{"multicast_id":6119535043276075848,"success":0,"failure":1,"canonical_ids":0,"results":[{"error":"MissingRegistration"}]}'),
(150, '[]', 72, '{"messageType":1003,"orderId":72}', '2014-05-27 15:24:58', '"registration_ids" field cannot be empty\n'),
(151, '["53","56","61","62","36"]', 78, '{"order":{"id":"78","clientName":"","clientPhone":"993355","clientId":"","price":"44","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0428\\u0435\\u0432\\u0447\\u0435\\u043d\\u043a\\u043e  \\u0443\\u043b., 23","longitude":35.0549314,"latitude":48.4575257},{"id":"1","address":"\\u0425\\u043e\\u043b\\u043e\\u0434\\u0438\\u043b\\u044c\\u043d\\u0430\\u044f \\u0443\\u043b., 81","longitude":35.072654,"latitude":48.526317}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-02 11:09:18', '{"multicast_id":6957140351986167753,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1401696558474671%cc17416ff9fd7ecd"}]}'),
(152, '["36"]', 87, '{"order":{"id":"87","clientName":"\\u0418\\u0432\\u0430\\u043d \\u0421\\u0435\\u0440\\u0433\\u0435\\u0435\\u0432\\u0438\\u0447","clientPhone":"3332255","clientId":"","price":"38","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0411\\u0430\\u0442\\u0443\\u043c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.081665,"latitude":48.5159191},{"id":"1","address":"\\u0421\\u0442\\u043e\\u043b\\u044f\\u0440\\u043e\\u0432\\u0430 \\u0443\\u043b., 8","longitude":35.0324679,"latitude":48.4731274}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-12 09:40:27', '{"multicast_id":6870172605864207738,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402555227991544%cc17416ff9fd7ecd"}]}'),
(153, '["36","36"]', 87, '{"order":{"id":"87","clientName":"\\u0418\\u0432\\u0430\\u043d \\u0421\\u0435\\u0440\\u0433\\u0435\\u0435\\u0432\\u0438\\u0447","clientPhone":"3332255","clientId":"","price":"38","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0411\\u0430\\u0442\\u0443\\u043c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.081665,"latitude":48.5159191},{"id":"1","address":"\\u0421\\u0442\\u043e\\u043b\\u044f\\u0440\\u043e\\u0432\\u0430 \\u0443\\u043b., 8","longitude":35.0324679,"latitude":48.4731274}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-12 09:43:08', '{"multicast_id":4974602167238322506,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402555388304415%cc17416ff9fd7ecd"}]}'),
(154, '[]', 89, '{"messageType":1003,"orderId":89}', '2014-06-12 12:22:40', '"registration_ids" field cannot be empty\n'),
(155, '["24"]', 93, '{"order":{"id":"93","clientName":"","clientPhone":"555999666","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0425\\u0430\\u0440\\u044c\\u043a\\u043e\\u0432\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 21","longitude":35.050041,"latitude":48.467433}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-12 15:47:00', '{"multicast_id":7857927710767932213,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402577220805610%cc17416ff9fd7ecd"}]}'),
(156, '["24"]', 93, '{"order":{"id":"93","clientName":"","clientPhone":"555999666","clientId":"","price":"25","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0425\\u0430\\u0440\\u044c\\u043a\\u043e\\u0432\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 21","longitude":35.050041,"latitude":48.467433}],"extras":[{"name":"CITY"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-12 15:47:31', '{"multicast_id":5459273162396656205,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402577252125443%cc17416ff9fd7ecd"}]}'),
(157, '["36","24"]', 87, '{"order":{"id":"87","clientName":"\\u0418\\u0432\\u0430\\u043d \\u0421\\u0435\\u0440\\u0433\\u0435\\u0435\\u0432\\u0438\\u0447","clientPhone":"3332255","clientId":"","price":"43","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0411\\u0430\\u0442\\u0443\\u043c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.081665,"latitude":48.5159191},{"id":"1","address":"\\u0421\\u0442\\u043e\\u043b\\u044f\\u0440\\u043e\\u0432\\u0430 \\u0443\\u043b., 8","longitude":35.0324679,"latitude":48.4731274}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-16 11:54:48', '{"multicast_id":8502003465392663300,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402908888555074%cc17416ff9fd7ecd"},{"message_id":"0:1402908888553855%cc17416ff9fd7ecd"}]}'),
(158, '["24","36","24"]', 87, '{"order":{"id":"87","clientName":"\\u0418\\u0432\\u0430\\u043d \\u0421\\u0435\\u0440\\u0433\\u0435\\u0435\\u0432\\u0438\\u0447","clientPhone":"3332255","clientId":"","price":"10","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0411\\u0430\\u0442\\u0443\\u043c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.081665,"latitude":48.5159191},{"id":"1","address":"\\u0421\\u0442\\u043e\\u043b\\u044f\\u0440\\u043e\\u0432\\u0430 \\u0443\\u043b., 8","longitude":35.0324679,"latitude":48.4731274}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-16 11:55:15', '{"multicast_id":5980755771309032223,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402908915467568%cc17416ff9fd7ecd"},{"message_id":"0:1402908915467319%cc17416ff9fd7ecd"}]}'),
(159, '["24","36","24"]', 87, '{"order":{"id":"87","clientName":"\\u0418\\u0432\\u0430\\u043d \\u0421\\u0435\\u0440\\u0433\\u0435\\u0435\\u0432\\u0438\\u0447","clientPhone":"3332255","clientId":"","price":"12","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u0411\\u0430\\u0442\\u0443\\u043c\\u0441\\u043a\\u0430\\u044f \\u0443\\u043b., 14","longitude":35.081665,"latitude":48.5159191},{"id":"1","address":"\\u0421\\u0442\\u043e\\u043b\\u044f\\u0440\\u043e\\u0432\\u0430 \\u0443\\u043b., 8","longitude":35.0324679,"latitude":48.4731274}],"extras":[{"name":"AIR_CONDITIONING"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-16 12:03:20', '{"multicast_id":4868213379437611347,"success":2,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1402909400859929%cc17416ff9fd7ecd"},{"message_id":"0:1402909400859927%cc17416ff9fd7ecd"}]}'),
(160, '["24"]', 94, '{"order":{"id":"94","clientName":"","clientPhone":"1111148888","clientId":"","price":"38","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u041a\\u0430\\u043b\\u0438\\u043d\\u043e\\u0432\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 19","longitude":35.0789344,"latitude":48.5107882},{"id":"1","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0428\\u0435\\u0432\\u0447\\u0435\\u043d\\u043a\\u043e, 445","longitude":35.053016,"latitude":48.458557}],"extras":[{"name":"ANIMAL"},{"name":"TERMINAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-18 10:04:18', '{"multicast_id":7166180449196114840,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1403075058878014%cc17416ff9fd7ecd"}]}'),
(161, '["24","24"]', 94, '{"order":{"id":"94","clientName":"","clientPhone":"1111148888","clientId":"","price":"38","isReservation":false,"isCashless":false,"points":[{"id":"0","address":"\\u041a\\u0430\\u043b\\u0438\\u043d\\u043e\\u0432\\u0430\\u044f \\u0443\\u043b\\u0438\\u0446\\u0430, 19","longitude":35.0789344,"latitude":48.5107882},{"id":"1","address":"\\u0443\\u043b\\u0438\\u0446\\u0430 \\u0428\\u0435\\u0432\\u0447\\u0435\\u043d\\u043a\\u043e, 10","longitude":35.0545925,"latitude":48.457712}],"extras":[{"name":"ANIMAL"},{"name":"TERMINAL"}],"tariff":"\\u0422\\u0410\\u0420\\u0418\\u0424","GPRSmessage":"GPRS message"},"messageType":1002}', '2014-06-18 10:10:11', '{"multicast_id":8381390053394901529,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1403075411967957%cc17416ff9fd7ecd"}]}');

-- --------------------------------------------------------

--
-- Table structure for table `status_list`
--

CREATE TABLE `status_list` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` enum('car','order') DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `status_list`
--

INSERT INTO `status_list` (`status_id`, `name`, `type`) VALUES
(1, 'Водитель свободен', 'car'),
(2, 'Взял заказ', 'car'),
(3, 'Выполняет заказ', 'car'),
(4, 'Водитель занят', 'car'),
(5, 'Водитель не в сети', 'car'),
(6, 'Заказ доступен', 'order'),
(7, 'Заказ взят', 'order'),
(8, 'Заказ выполняется', 'order'),
(9, 'Заказ выполнен', 'order'),
(10, 'Заказ удалён', 'order'),
(11, 'В ожидании пассажира', 'car'),
(12, 'Пассажир не вышёл', 'order'),
(13, 'Опаздываю на 5 минут', 'car'),
(14, 'Опаздываю на 10 минут', 'car'),
(15, 'Опаздываю на 15 минут', 'car'),
(16, 'Отказ от принятия персонального заказа', 'order'),
(17, 'Заказ закрыт (не выполнен)', 'order'),
(18, 'Заказ закрыт (нет машины)', 'order'),
(19, 'Водитель заблокирован', 'car'),
(20, 'Водитель удалён', 'car'),
(21, 'Байкал', 'car'),
(22, 'Заказ закрыт (Не завершён по уважительной причине)', 'order'),
(23, 'Водитель (недоступен)', 'car'),
(24, 'Заказ закрыт (отказ клиента)', 'order'),
(25, 'Заказ удалён (ошибочно созданный)', 'order'),
(26, 'Заказ закрыт (отказ водителя)', 'order');

-- --------------------------------------------------------

--
-- Table structure for table `taxi_car_info`
--

CREATE TABLE `taxi_car_info` (
  `driver_id` int(11) NOT NULL,
  `number` varchar(100) NOT NULL,
  `insurance` varchar(100) NOT NULL,
  `model` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `year` year(4) NOT NULL,
  `type` varchar(25) NOT NULL,
  `datasheet` varchar(15) NOT NULL,
  `condition` tinyint(1) DEFAULT NULL,
  `terminal` tinyint(1) DEFAULT NULL,
  `commission` float NOT NULL,
  `commission_period_pay` int(11) NOT NULL,
  `fee` float NOT NULL,
  `fee_period` int(11) NOT NULL,
  `own_car` tinyint(1) DEFAULT NULL,
  `tariff_ind` int(11) NOT NULL,
  `self_carport` tinyint(1) NOT NULL,
  `gps_tracker` int(11) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `taxi_car_info`
--

INSERT INTO `taxi_car_info` (`driver_id`, `number`, `insurance`, `model`, `color`, `year`, `type`, `datasheet`, `condition`, `terminal`, `commission`, `commission_period_pay`, `fee`, `fee_period`, `own_car`, `tariff_ind`, `self_carport`, `gps_tracker`, `notes`) VALUES
(23, 'sd9999', '', 'sdfs', 'Бордовый', 0000, '1', '', 0, 1, 0, 0, 0, 0, NULL, 0, 0, 0, 'gggggggggggggggg g ooooooooo hjhg kkkkkkkkkkkk vjlk ssssssssss gggggggggggggggg g ooooooooo hjhg kkkkkkkkkkkk vjlk ssssssssss gggggggggggggggg g ooooooooo hjhg kkkkkkkkkkkk vjlk ssssssssss gggggggggggggggg g ooooooooo hjhg kkkkkkkkkkkk vjlk ssssssssss'),
(24, 'sdsd', '', 'sdfsdf', 'Бордовый', 0000, '6', '', 1, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(28, 'sdfsdf', '', 'sdfsdf', 'Белый', 0000, '1', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(29, '123213123', '', '123123213', '#000000', 0000, '6', '', 0, 1, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(30, '', '', '', '#000000', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(31, '', '', '', '', 0000, '', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(32, '', '', '', '#000000', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(33, 'asdfasdf', '', 'asdfasdf', 'Белый', 0000, '5', '', 1, 1, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(34, 'sdf', '', 'sdf', 'Белый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(35, 'sadvsdv', '', 'sadsdc', 'Белый', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(36, 'sdf', '', 'sdf', 'Синий', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(37, 'sdfsdf', '', 'sdfsdf', 'Желтый', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(48, '', '', '', '#0000ff', 0000, '4', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(49, 'qwq', '', 'qwwq', 'Бордовый', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(50, 'sss888', '', 'sss', 'Бордовый', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(51, 'ffefe', '', 'fewfef', 'Красный', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(52, 'sdf', '', 'volvo', 'Оливковый', 0000, '6', '', 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(53, 'АЕ5555АЕ', '', 'МЕРСЕДЕС', 'Бежевый', 2014, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(54, 'АЕ4567', '', 'деу ланос', 'Белый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(55, 'sdfsdfsdf', '', 'dfsdfs', 'Бежевый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 0, 0, ''),
(56, 'АЕ1234АЕ', '', 'КОРАНДА', 'Белый', 2014, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(57, 'sdfsdfsdf', '', 'sdfsdfsdf', 'Бордовый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(58, 'dsdsdfsd', '', 'sdfsdfsdf', 'Бордовый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(59, 'sdfsdf', '', 'sdfsdfsdf', 'Белый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(60, 'ае5656ае', '', 'деу-ланос', 'Белый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(61, '00588AA', '', 'VAZ', 'Белый', 0000, '6', '', 1, 1, 0, 0, 0, 0, NULL, 0, 1, 0, ''),
(62, 'Ае7777еа', '', 'Запор', 'Бежевый', 0000, '6', '', 0, 0, 10, 0, 10, 0, NULL, 0, 1, 0, ''),
(63, 'аа2233уу', '', 'дэу', '#000', 1980, '6', '', 0, 0, 10, 0, 30, 0, NULL, 0, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `taxi_car_type`
--

CREATE TABLE `taxi_car_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `taxi_car_type`
--

INSERT INTO `taxi_car_type` (`id`, `type`) VALUES
(1, 'Бизнес'),
(2, 'Премиум'),
(3, 'Груз'),
(4, 'Универсал'),
(5, 'Микроавтобус'),
(6, 'Базовый');

-- --------------------------------------------------------

--
-- Table structure for table `taxi_driver_info`
--

CREATE TABLE `taxi_driver_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `callsign` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `g_reg_id` tinytext NOT NULL,
  `surname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `patronymic` varchar(255) NOT NULL,
  `mobile_phone` int(11) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `phone2` int(11) NOT NULL,
  `admission_date` date NOT NULL,
  `dismissal_date` date NOT NULL,
  `passport` varchar(8) NOT NULL,
  `credit_auto` tinyint(1) DEFAULT NULL,
  `only_non_cash` tinyint(1) DEFAULT NULL,
  `passenger_phone` tinyint(1) DEFAULT NULL,
  `dob` date NOT NULL,
  `gprs_notes` varchar(255) NOT NULL,
  `report_number` int(11) NOT NULL,
  `see_non_cash` tinyint(1) DEFAULT NULL,
  `photo` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=64 ;

--
-- Dumping data for table `taxi_driver_info`
--

INSERT INTO `taxi_driver_info` (`id`, `callsign`, `password`, `session_id`, `g_reg_id`, `surname`, `name`, `patronymic`, `mobile_phone`, `address1`, `phone2`, `admission_date`, `dismissal_date`, `passport`, `credit_auto`, `only_non_cash`, `passenger_phone`, `dob`, `gprs_notes`, `report_number`, `see_non_cash`, `photo`) VALUES
(23, 11, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'dr40kr5g8c9fg5mfld8bt1ubu7', '', 'Иванов', 'Игорь', 'Сергеевич', 8855566, 'some address', 0, '2012-01-18', '1970-01-01', 'АА181233', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(24, 24, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', '9lk1nnlr12hbcbgqaoilnvcq97', 'APA91bEQKg_qM_uhE4_r4EWGRlqWYGRVqhvBWiSrDQ2ZfLcSQRGXGnC4ziLXzo5x5fGm1xgBPBnLMrhjw3DIRV1wfZiV9xZqUE5ZAtZvyketAZQnMWSb327UKog9N0Ovo8boIEQBm9sN9l9NusyfgCmK6XBWfKTESzoWYjRE0ThsONaT6Tybce0', 'Селезнёв', 'Джин', 'Михайлович', 88877755, 'Свердлова 1', 2147483647, '2014-04-09', '1970-01-01', 'ФЫ123456', NULL, 0, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(28, 16, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'g5io2oeb1neklas6ns4dc03cb2', '', 'Ivanenko', 'Vasiliy', 'qwe', 888999444, 'afefwefwe', 0, '1970-01-01', '1970-01-01', 'as123213', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(29, 17, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', '9481u6t0o3clutuv2ehdvucpt3', '', '123', '123', '888', 132132130, 'fghfg', 0, '1970-01-01', '1970-01-01', 'reervrev', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(30, 18, '68265b960387d0525d0144f6467549e6d785b0ad82109e0f4188630381ed0108', 's8laj3gskdnq16kj2jlq3ga336', '', '123', '123', '9999', 0, 'sdfsd', 0, '1970-01-01', '1970-01-01', 'WW778899', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(31, 19, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', '7g0ate8d6flqg6bili4cpg3oe6', '', '123', '123', '', 0, '', 0, '0000-00-00', '0000-00-00', '', NULL, 0, 0, '0000-00-00', '', 0, 0, ''),
(32, 20, '68265b960387d0525d0144f6467549e6d785b0ad82109e0f4188630381ed0108', 'p84g2rdh31e2dl2lrjms3iak20', '', '123', '123', 'sdf', 0, 'sdf', 0, '0000-00-00', '0000-00-00', 'sdf', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(33, 21, '68265b960387d0525d0144f6467549e6d785b0ad82109e0f4188630381ed0108', '1e6r8dgmvs977jibfb70qqnfn4', '', '123', '123', 'qwewqe', 88877777, 'qweqweq', 0, '1970-01-01', '1970-01-01', 'qwwqeqea', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(34, 22, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 's097napf2l8qtbd2feni40iih2', '', 'Симоненко', 'Виталий', 'Сергеевич', 2147483647, 'ул. Новая, 15', 0, '1970-01-01', '1970-01-01', 'ФФ158877', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(35, 25, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'c3j1qd7iaj5fgsee42u6a4clo3', '', '123', '123', '123', 232332, 'erververv', 0, '1970-01-01', '1970-01-01', 'eervrevr', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(36, 7, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'rsqv8cgijeme7inqaqu73vpd40', 'APA91bGNHj0X3OuMW4tlyWUUWtEBJg32s7Z1uQ3UrNf904kfe0MHB4e-CnS2iar0daPL1ncBCBsSL1jCOdXg3lEcVB7kRtIlamrDkZ5GHax7Q4KKUuIiH-5QUu5iJMpLtHd6FsUCbfP8arkF976OROy-h2fki8If0TOlzaRjWqPPTUbUvwSFjSA', '123', '123', 'sdf', 332255, 'sdfs', 0, '1970-01-01', '1970-01-01', 'aaa22222', NULL, 0, 0, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(37, 27, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'cfvdfgerd8m2pk7se4fl38agr3', '', '123', '123', 'sdfsdfsdf', 88888888, 'sdfsdfsdf', 0, '1970-01-01', '1970-01-01', 'sdfsdfsd', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(48, 68, '68265b960387d0525d0144f6467549e6d785b0ad82109e0f4188630381ed0108', '', '', 'cxz 2', 'cxz 2', 'cxz 2', 0, 'weververver', 0, '1970-01-01', '0000-00-00', 'ds2324', NULL, 0, 0, '1970-01-01', '', 0, 0, ''),
(49, 12, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'guej0kv58g719rqs8arqjd8952', '', 'Кравец', 'Илья', 'Сергеевич', 2147483647, 'ул. Плеханова, 17', 0, '2005-11-03', '1970-01-01', 'УУ224875', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(50, 13, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'i8br7m0dok7m6ps373cr4ccgd3', '', 'Николенко', 'Вадим', 'Евгеньевич', 1112233, 'ул. Какая-то, 22', 0, '1970-01-01', '1970-01-01', 'ЛЛ445556', NULL, 0, 0, '1970-01-01', '', 0, 0, '/uploads/driverPhoto/foto1.jpeg'),
(51, 14, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', '8qekr99k0konj8thr77t0aouq2', '', 'Сергеенко', 'Петр', 'Николаевич', 2323230, 'ул. Новая, 2', 0, '1970-01-01', '1970-01-01', 'ИВ259866', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(52, 15, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', '1sta7b40u0ne0pv1932ocl3q56', '', 'Василенко', 'Геннадий', 'Николаевич', 2225588, 'ул. Паникахи, 17', 0, '1970-01-01', '1970-01-01', 'ФФ778844', NULL, 0, 0, '1970-01-01', '', 0, 0, '/images/background_Preview_picture.png'),
(53, 50, 'e9dead34667226a60537111351ada48ff80f1090a80366ea16d4cd7c16260c95', 'ivssqm0us6mi9sgshe7qd7o4p7', '', 'Иванов', 'Иван', 'Иванович', 981330465, 'Карла Маркса 1', 0, '2014-04-17', '1970-01-01', 'АК343534', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(54, 51, 'c5513141059e557795280d274b92e389b4406610f9203da24266413792996a38', '86i6pl46206dhd65rt60i0a245', '', 'Иванов', 'Иван', 'Иванович', 981330465, 'К. Маркса 52', 0, '2014-04-17', '1970-01-01', 'АМ123456', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(55, 88, '9093069720193c49a01ad31fc4d09041f1afbf78af68e3b59a5567bd4ebcdae9', 'uctq3ugf0pvnimehddbaqn5r97', '', 'Новый', 'Тестовый', 'Водитель', 123213213, 'asdsdfsdf', 0, '1970-01-01', '1970-01-01', 'asdsdfsd', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(56, 55, 'c52c2eb0a1a4c1537af1bab3113fcfc8c32898e52f3f5ce84f2e2283cae72158', '2sau02o65ibkr4op6mnonomhh6', '', 'Петров', 'Максим', 'Юрьевич', 504500010, 'Тополь 2 дом 2', 0, '2014-04-01', '1970-01-01', 'АК532435', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(57, 56, 'db11ed03a20d014f79963fe7becf8413a28fdc34d27660a1cfb8f999df3ef81c', 'verm06t5bcconmlkra13cri911', '', 'Прохницкий', 'Юрий', 'Иванович', 507710334, 'Поля 2', 0, '1970-01-01', '1970-01-01', 'АК456789', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(58, 57, '6e7faa398f2e3d7329c0196c86e9022660a9d183477b340f15d82b62bcccd3bf', '3hja0l95rb3guq4svhes7sbps0', '', 'Сидоров', 'Александр', 'Станиславович', 501661458, 'Канатная 1', 0, '1970-01-01', '1970-01-01', 'АК567890', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(59, 52, 'ab2fdebdfa6606b6369bc6246427939e048ec8054966740d18fa39d8018f74e6', 'rk2cog2tn3doe77t8ro8h12384', '', 'Лобунец', 'Роман', 'Геннадиевич', 636368222, 'Тополь 1', 0, '1970-01-01', '1970-01-01', 'АК123456', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(60, 53, 'e979c2a4e71375281a2c1e628e4e9edfbca6d309c9d2078a622814d3a1c87a28', 'go00095el0hlvuk3624pn7qbu0', '', 'Пронин', 'Алексей', 'Юрьевич', 939977282, 'тополь 2 дом 2', 0, '2014-03-03', '1970-01-01', 'ак456375', NULL, 1, 1, '2014-04-08', '', 0, 1, '/images/background_Preview_picture.png'),
(61, 54, '5487a4b5b3a2b4d7b0446950e397fa0f30708a2277fe7c39efe199efbf5413a9', 'v4th8fgtcorf69aj995vonkcv6', '', 'Петров', 'Петр', 'Петрович', 501234567, 'Серова 4', 0, '1970-01-01', '1970-01-01', 'АК123490', NULL, 1, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(62, 59, 'c5513141059e557795280d274b92e389b4406610f9203da24266413792996a38', 'a1lebj8sokjthkjkclp2lvhv41', '', 'Он', 'Юр', 'Ник', 5050505, 'Зап шоссе 60/60', 0, '2014-04-23', '1970-01-01', 'Ае 77665', NULL, 0, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png'),
(63, 60, 'c5513141059e557795280d274b92e389b4406610f9203da24266413792996a38', 'uineht6tp548s9la0qr5vdn994', '', 'он1', 'пе', 'не', 938836888, 'зап шоссе 60\\1', 0, '2014-04-23', '1970-01-01', 'ан223344', NULL, 0, 1, '1970-01-01', '', 0, 1, '/images/background_Preview_picture.png');

-- --------------------------------------------------------

--
-- Table structure for table `taxi_status`
--

CREATE TABLE `taxi_status` (
  `taxi_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `location_update` datetime NOT NULL,
  `status_update` datetime NOT NULL,
  PRIMARY KEY (`taxi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `taxi_status`
--

INSERT INTO `taxi_status` (`taxi_id`, `status`, `lat`, `lng`, `location_update`, `status_update`) VALUES
(23, 5, 48.4729245, 35.0261032, '2014-05-22 10:46:31', '2014-05-19 10:55:27'),
(24, 1, 48.4588621, 35.0441582, '2014-06-11 15:45:28', '2014-06-12 15:47:26'),
(28, 5, 48.47261, 35.0262633, '2014-04-28 16:06:28', '2014-04-28 16:06:37'),
(29, 5, 48.4722116, 35.02569, '2014-04-28 16:05:58', '2014-04-28 16:06:13'),
(30, 5, 48.4143586, 35.0679249, '2014-02-05 16:39:45', '2014-02-18 15:11:56'),
(31, 5, 48.4647258, 35.0461931, '2014-02-10 10:10:13', '2014-02-10 10:10:21'),
(32, 5, 48.3962332, 35.027109, '2014-02-08 14:41:02', '2014-02-08 13:42:03'),
(33, 5, 48.510149, 35.013904000000025, '2014-02-08 13:30:14', '2014-02-08 13:30:13'),
(34, 5, 48.5175443, 35.04519230000005, '2014-02-03 10:40:28', '2014-02-03 10:35:13'),
(35, 5, 48.4727676, 35.0259316, '2014-04-23 14:37:51', '2014-04-23 14:38:09'),
(36, 4, 48.4727944, 35.0261684, '2014-06-11 15:38:41', '2014-06-12 15:43:41'),
(37, 5, 48.44288599999999, 34.797240999999985, '2014-02-18 16:48:44', '2014-02-18 16:26:19'),
(48, 5, 48.417766, 35.05426399999999, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(49, 5, 48.474047, 35.014822, '0000-00-00 00:00:00', '2014-05-19 18:00:14'),
(50, 5, 48.474047, 35.014822, '0000-00-00 00:00:00', '2014-05-19 10:16:59'),
(51, 5, 48.425666, 35.02649, '2014-04-23 14:50:06', '2014-05-16 11:08:58'),
(52, 5, 48.4727956, 35.0259357, '2014-04-29 15:45:37', '2014-04-29 15:46:02'),
(53, 5, 48.4633686, 35.0445244, '2014-04-23 15:08:40', '2014-06-01 21:31:02'),
(54, 5, 48.46373, 35.04475, '2014-04-18 15:24:07', '2014-04-23 15:09:30'),
(55, 5, 0, 0, '0000-00-00 00:00:00', '2014-04-22 17:04:50'),
(56, 5, 48.4738076, 35.0261099, '2014-04-23 15:03:05', '2014-06-02 11:03:09'),
(57, 5, 48.51621, 35.0874283, '2014-04-23 15:10:34', '2014-04-22 18:59:48'),
(58, 5, 48.4646166, 35.04516, '2014-04-18 14:15:56', '2014-04-18 11:18:30'),
(59, 5, 0, 0, '0000-00-00 00:00:00', '2014-04-18 11:13:53'),
(60, 5, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(61, 5, 48.4622545, 35.0452033, '2014-04-18 14:47:37', '2014-05-29 17:25:43'),
(62, 5, 48.4742369, 35.0222428, '2014-04-23 15:10:31', '2014-06-02 11:03:26'),
(63, 5, 48.4675196, 35.040621, '2014-04-23 14:35:37', '2014-04-23 14:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `taxi_user`
--

CREATE TABLE `taxi_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `patronymic` varchar(200) NOT NULL,
  `role` int(11) NOT NULL,
  `passport` varchar(8) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `taxi_user`
--

INSERT INTO `taxi_user` (`id`, `login`, `surname`, `name`, `patronymic`, `role`, `passport`, `email`, `password`, `photo`) VALUES
(1, 'admin', 'Surname', 'Name', 'Patronymic', 1, 'Passport', 'admin@email.admin', 'de4a75f635cbe2501b43a4664b342a5acd83cae5744d1adc12134812c2a36d46 ', ''),
(2, 'dispatcher1', '', 'Юрий', 'Николаевич', 1, 'Passport', 'admin@email.admin', '1f1a8a5f24c347afe2da5416444c1a56ac0574225fadb4e0ff68eb0cbfede99e', ''),
(3, 'dispatcher2', '', '', '', 2, 'Passport', 'admin@email.admin', '605222abd97c9fec4ec7063c3ed4551ffb3093d0326c3f9e0a108e4121a8b310', ''),
(4, 'dispatcher3', '', '', '', 2, 'Passport', 'admin@email.admin', '85809d5c7ae2dd18f9f21c922f229f7251b00464af5950bcc1526403790b8a92', ''),
(5, 'dispatcher4', '', '', '', 2, 'Passport', 'admin@email.admin', 'ad49e148d929a7ee78dade1b06b1a47b10fca4869cf021d7a03a213989d4dd63', ''),
(6, 'dispatcher5', '', '', '', 2, 'Passport', 'admin@email.admin', '31e7ccae82d2ce63b007de9aa113748c6f48cc02d233a9c25375b39a777570b9', ''),
(7, 'dispatcher6', '', '', '', 2, 'Passport', 'admin@email.admin', '3441807f2039f18e4758950084fbb8d5709927e2b7a4dc27023a3402a6281860', '');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `driver_order_history`
--
ALTER TABLE `driver_order_history`
  ADD CONSTRAINT `driver_order_history_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `taxi_driver_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `message_list`
--
ALTER TABLE `message_list`
  ADD CONSTRAINT `message_list_ibfk_1` FOREIGN KEY (`type`) REFERENCES `message_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `message_list_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `message_text` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `message_list_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `taxi_driver_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `taxi_car_info`
--
ALTER TABLE `taxi_car_info`
  ADD CONSTRAINT `taxi_car_info_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `taxi_driver_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taxi_status`
--
ALTER TABLE `taxi_status`
  ADD CONSTRAINT `taxi_status_ibfk_1` FOREIGN KEY (`taxi_id`) REFERENCES `taxi_driver_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
