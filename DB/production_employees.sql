-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2021 at 09:31 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `m_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `production_employees`
--

CREATE TABLE `production_employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) DEFAULT NULL,
  `employee_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `produce_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waste_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_employees`
--

INSERT INTO `production_employees` (`id`, `production_id`, `employee_name`, `produce_amount`, `waste_amount`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Miraj', '45', '5', 1, 1, 0, '2021-06-26 11:50:58', '2021-06-26 11:50:58'),
(2, 2, 'Lemon', '45', '5', 1, 1, 0, '2021-06-26 11:50:58', '2021-06-26 11:50:58'),
(3, 3, 'Miraj', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(4, 3, 'lemon', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(5, 3, 'fdfdf', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(6, 3, 'sdfsd', '44', '45', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(7, 3, 'feedd', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(8, 3, 'sdfs', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(9, 3, 'dfsdaf', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(10, 3, 'ewd', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(11, 3, 'as', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(12, 3, 'edff', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(13, 3, 'waf', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(14, 3, 'waf', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(15, 3, 'as', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(16, 3, 'edff', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(17, 3, 'waf', '10', '10', 1, 1, 0, '2021-06-26 13:21:28', '2021-06-26 13:21:28'),
(18, 4, 'fee', '10', '10', 1, 1, 0, '2021-06-26 13:28:06', '2021-06-26 13:28:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `production_employees`
--
ALTER TABLE `production_employees`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `production_employees`
--
ALTER TABLE `production_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
