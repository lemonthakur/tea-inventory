-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 30, 2021 at 11:17 AM
-- Server version: 10.3.22-MariaDB-cll-lve
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `duckbd_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `name`, `description`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'List', 'List of module', 1, 1, 1, NULL, '2020-01-25 01:52:00', '2020-12-05 22:32:13'),
(2, 'Create', NULL, 1, 1, 1, NULL, '2020-01-25 01:52:10', '2020-01-25 01:52:10'),
(3, 'Edit', NULL, 1, 1, 1, NULL, '2020-01-25 01:52:20', '2020-03-03 04:23:32'),
(4, 'Delete', NULL, 1, 1, 1, NULL, '2020-01-25 01:52:30', '2020-01-25 01:52:30'),
(5, 'Change password', NULL, 1, 1, 1, NULL, '2020-01-25 01:52:39', '2020-01-25 01:52:39'),
(6, 'Password reset', NULL, 1, 1, 1, NULL, '2020-01-25 01:52:50', '2020-01-25 01:52:50'),
(7, 'Print', NULL, 1, 1, 1, NULL, '2020-01-25 01:53:01', '2020-01-25 01:53:01'),
(8, 'Details', NULL, 1, 1, 1, NULL, '2020-01-25 01:53:12', '2020-01-25 01:53:12'),
(9, 'CSV', NULL, 5, 5, 1, NULL, '2021-06-25 00:09:01', '2021-06-25 00:09:01');

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustments`
--

INSERT INTO `adjustments` (`id`, `reference_no`, `warehouse_id`, `total_qty`, `item`, `note`, `document`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'adr-20210624-035046', 2, 2000, 1, NULL, NULL, NULL, 1, 1, '2021-06-24 22:50:46', '2021-06-24 22:50:46'),
(2, 'adr-20210624-041228', 1, 100, 1, NULL, NULL, NULL, 1, 1, '2021-06-24 23:12:28', '2021-06-24 23:12:28'),
(3, 'adr-20210629-061503', 1, 200, 1, NULL, NULL, NULL, 16, 16, '2021-06-30 01:15:03', '2021-06-30 01:15:03'),
(4, 'adr-20210630-115357', 1, 5, 1, 'Try to stock in', NULL, NULL, 16, 16, '2021-06-30 18:53:57', '2021-06-30 18:53:57'),
(5, 'adr-20210630-115503', 1, 5, 1, 'Remove prodcut', NULL, NULL, 16, 16, '2021-06-30 18:55:03', '2021-06-30 18:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) NOT NULL,
  `name` text CHARACTER SET latin1 NOT NULL,
  `brand_thumbnail` text CHARACTER SET latin1 DEFAULT NULL,
  `brand_mobile` text CHARACTER SET latin1 DEFAULT NULL,
  `brand_email` text CHARACTER SET latin1 DEFAULT NULL,
  `brand_representatives_name` text CHARACTER SET latin1 DEFAULT NULL,
  `address` text CHARACTER SET latin1 DEFAULT NULL,
  `description` text CHARACTER SET latin1 DEFAULT NULL,
  `brand_banner` varchar(250) CHARACTER SET latin1 DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `brand_thumbnail`, `brand_mobile`, `brand_email`, `brand_representatives_name`, `address`, `description`, `brand_banner`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Nascafe', NULL, '0171987654', 'Nascafe@email.com', 'Nascafe', 'Dhaka', NULL, NULL, 1, NULL, 1, 1, '2021-06-24 22:21:36', '2021-06-24 22:21:36');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `category_id`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Shop', NULL, 1, 1, 1, NULL, '2021-06-08 04:44:34', '2021-06-08 04:44:34');

-- --------------------------------------------------------

--
-- Table structure for table `employee_warhouses`
--

CREATE TABLE `employee_warhouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_warhouses`
--

INSERT INTO `employee_warhouses` (`id`, `user_id`, `warehouse_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(3, 8, 1, 8, 8, 1, '2021-06-24 22:35:46', '2021-06-24 22:35:46'),
(4, 10, 1, 1, 1, 1, '2021-06-24 22:39:11', '2021-06-24 22:39:11'),
(5, 10, 2, 1, 1, 1, '2021-06-24 22:39:12', '2021-06-24 22:39:12'),
(6, 9, 2, 1, 1, 1, '2021-06-24 22:45:07', '2021-06-24 22:45:07');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_receivers`
--

CREATE TABLE `mail_receivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mail_receivers`
--

INSERT INTO `mail_receivers` (`id`, `user_id`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 8, 1, 1, 0, NULL, '2021-06-24 21:51:55', '2021-06-24 21:51:55');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(22, '2014_10_12_000000_create_users_table', 1),
(23, '2014_10_12_100000_create_password_resets_table', 1),
(24, '2019_08_19_000000_create_failed_jobs_table', 1),
(25, '2020_01_17_040304_create_activities_table', 1),
(26, '2020_01_17_040924_create_modules_table', 1),
(27, '2020_01_17_041254_create_module_to_activities_table', 1),
(28, '2020_01_17_041749_create_module_to_roles_table', 1),
(29, '2020_01_17_041946_create_module_to_users_table', 1),
(30, '2020_01_17_042141_create_roles_table', 1),
(31, '2020_01_18_111739_add_created_by_to_roles', 1),
(41, '2021_06_01_171209_create_site_settings_table', 2),
(42, '2021_06_04_135142_create_categories_table', 3),
(43, '2021_06_04_150829_create_suppliers_table', 3),
(44, '2021_06_05_132524_add_column_to_users_table', 3),
(45, '2021_06_19_104537_create_productions_table', 4),
(46, '2021_06_19_111302_create_production_use_products_table', 4),
(47, '2021_06_22_100150_create_mail_receivers_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `name`, `description`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Role Management', NULL, 1, NULL, 1, 1, '2020-01-25 01:53:44', '2020-12-05 22:05:04'),
(2, 'Role Access Control', NULL, 1, NULL, 1, 1, '2020-01-25 01:54:32', '2020-01-25 01:54:32'),
(3, 'User Access Control', NULL, 1, NULL, 1, 1, '2020-01-25 01:54:59', '2020-01-25 01:54:59'),
(4, 'Module Management', NULL, 1, NULL, 1, 1, '2020-01-25 01:55:37', '2020-01-25 01:55:37'),
(5, 'Activity Management', NULL, 1, NULL, 1, 1, '2020-01-25 01:55:58', '2020-01-25 01:55:58'),
(6, 'Admin Panel User', NULL, 1, NULL, 1, 1, '2020-01-25 01:58:53', '2020-01-25 01:58:53'),
(10, 'Employee Management', NULL, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(11, 'Category', NULL, 1, NULL, 5, 5, '2021-06-21 18:27:40', '2021-06-21 18:27:40'),
(12, 'Product', NULL, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(13, 'Adjustment List', NULL, 1, NULL, 5, 5, '2021-06-21 18:49:27', '2021-06-21 18:49:27'),
(14, 'Print Barcode', NULL, 1, NULL, 5, 5, '2021-06-21 18:54:43', '2021-06-21 18:54:43'),
(15, 'Order', NULL, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(16, 'Transfer', NULL, 1, NULL, 5, 5, '2021-06-21 19:08:34', '2021-06-21 19:08:34'),
(17, 'Transfer Received', NULL, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(18, 'Production', NULL, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(19, 'Brand', NULL, 1, NULL, 5, 5, '2021-06-21 19:38:01', '2021-06-21 19:38:01'),
(20, 'Supplier', NULL, 1, NULL, 5, 5, '2021-06-21 19:42:42', '2021-06-21 19:42:42'),
(21, 'Warehouse', NULL, 1, NULL, 5, 5, '2021-06-21 19:48:15', '2021-06-21 19:48:15'),
(22, 'Unit', NULL, 1, NULL, 5, 5, '2021-06-21 19:52:14', '2021-06-21 19:52:14'),
(23, 'Setting', NULL, 1, NULL, 5, 5, '2021-06-21 19:56:06', '2021-06-21 19:56:06'),
(24, 'Email Receiver', NULL, 1, NULL, 1, 1, '2021-06-25 00:04:19', '2021-06-25 00:04:19'),
(25, 'Order Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:09:44', '2021-06-25 00:09:44'),
(26, 'Quantity Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:14:54', '2021-06-25 00:14:54'),
(27, 'Production Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:19:19', '2021-06-25 00:19:19'),
(28, 'Transfer Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:22:18', '2021-06-25 00:22:18'),
(29, 'Stock Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:25:36', '2021-06-25 00:25:36'),
(30, 'Transfer Receive Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:31:05', '2021-06-25 00:31:05'),
(31, 'Stock Register Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:33:07', '2021-06-25 00:33:07'),
(32, 'Adjustment Report', NULL, 1, NULL, 5, 5, '2021-06-25 00:35:28', '2021-06-25 00:35:28'),
(33, 'Product History', 'Product History', 1, NULL, 1, 1, '2021-06-25 04:06:58', '2021-06-25 04:06:58');

-- --------------------------------------------------------

--
-- Table structure for table `module_to_activities`
--

CREATE TABLE `module_to_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module_to_activities`
--

INSERT INTO `module_to_activities` (`id`, `module_id`, `activity_id`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(5, 2, 2, 1, NULL, 1, 1, '2020-01-25 01:54:32', '2020-01-25 01:54:32'),
(6, 2, 4, 1, NULL, 1, 1, '2020-01-25 01:54:32', '2020-01-25 01:54:32'),
(7, 2, 3, 1, NULL, 1, 1, '2020-01-25 01:54:32', '2020-01-25 01:54:32'),
(8, 2, 1, 1, NULL, 1, 1, '2020-01-25 01:54:32', '2020-01-25 01:54:32'),
(9, 3, 2, 1, NULL, 1, 1, '2020-01-25 01:54:59', '2020-01-25 01:54:59'),
(10, 3, 4, 1, NULL, 1, 1, '2020-01-25 01:54:59', '2020-01-25 01:54:59'),
(11, 3, 3, 1, NULL, 1, 1, '2020-01-25 01:54:59', '2020-01-25 01:54:59'),
(12, 3, 1, 1, NULL, 1, 1, '2020-01-25 01:54:59', '2020-01-25 01:54:59'),
(13, 4, 2, 1, NULL, 1, 1, '2020-01-25 01:55:37', '2020-01-25 01:55:37'),
(14, 4, 4, 1, NULL, 1, 1, '2020-01-25 01:55:37', '2020-01-25 01:55:37'),
(15, 4, 3, 1, NULL, 1, 1, '2020-01-25 01:55:37', '2020-01-25 01:55:37'),
(16, 4, 1, 1, NULL, 1, 1, '2020-01-25 01:55:37', '2020-01-25 01:55:37'),
(17, 5, 2, 1, NULL, 1, 1, '2020-01-25 01:55:58', '2020-01-25 01:55:58'),
(18, 5, 4, 1, NULL, 1, 1, '2020-01-25 01:55:58', '2020-01-25 01:55:58'),
(19, 5, 3, 1, NULL, 1, 1, '2020-01-25 01:55:58', '2020-01-25 01:55:58'),
(20, 5, 1, 1, NULL, 1, 1, '2020-01-25 01:55:58', '2020-01-25 01:55:58'),
(25, 6, 5, 1, NULL, 1, 1, '2020-01-25 02:07:39', '2020-01-25 02:07:39'),
(26, 6, 2, 1, NULL, 1, 1, '2020-01-25 02:07:39', '2020-01-25 02:07:39'),
(27, 6, 4, 1, NULL, 1, 1, '2020-01-25 02:07:39', '2020-01-25 02:07:39'),
(28, 6, 6, 1, NULL, 1, 1, '2020-01-25 02:07:39', '2020-01-25 02:07:39'),
(29, 6, 3, 1, NULL, 1, 1, '2020-01-25 02:07:39', '2020-01-25 02:07:39'),
(30, 6, 1, 1, NULL, 1, 1, '2020-01-25 02:07:39', '2020-01-25 02:07:39'),
(50, 1, 2, 1, NULL, 1, 1, '2020-12-05 22:05:04', '2020-12-05 22:05:04'),
(51, 1, 4, 1, NULL, 1, 1, '2020-12-05 22:05:04', '2020-12-05 22:05:04'),
(52, 1, 3, 1, NULL, 1, 1, '2020-12-05 22:05:04', '2020-12-05 22:05:04'),
(53, 1, 1, 1, NULL, 1, 1, '2020-12-05 22:05:04', '2020-12-05 22:05:04'),
(54, 10, 5, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(55, 10, 2, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(56, 10, 4, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(57, 10, 8, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(58, 10, 3, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(59, 10, 1, 1, NULL, 1, 1, '2021-06-21 18:12:28', '2021-06-21 18:12:28'),
(60, 11, 2, 1, NULL, 5, 5, '2021-06-21 18:27:40', '2021-06-21 18:27:40'),
(61, 11, 4, 1, NULL, 5, 5, '2021-06-21 18:27:40', '2021-06-21 18:27:40'),
(62, 11, 3, 1, NULL, 5, 5, '2021-06-21 18:27:40', '2021-06-21 18:27:40'),
(63, 11, 1, 1, NULL, 5, 5, '2021-06-21 18:27:40', '2021-06-21 18:27:40'),
(64, 12, 2, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(65, 12, 4, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(66, 12, 8, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(67, 12, 3, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(68, 12, 1, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(69, 12, 7, 1, NULL, 5, 5, '2021-06-21 18:35:23', '2021-06-21 18:35:23'),
(70, 13, 2, 1, NULL, 5, 5, '2021-06-21 18:49:27', '2021-06-21 18:49:27'),
(71, 13, 4, 1, NULL, 5, 5, '2021-06-21 18:49:27', '2021-06-21 18:49:27'),
(72, 13, 3, 1, NULL, 5, 5, '2021-06-21 18:49:27', '2021-06-21 18:49:27'),
(73, 13, 1, 1, NULL, 5, 5, '2021-06-21 18:49:27', '2021-06-21 18:49:27'),
(74, 14, 7, 1, NULL, 5, 5, '2021-06-21 18:54:43', '2021-06-21 18:54:43'),
(75, 15, 2, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(76, 15, 4, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(77, 15, 8, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(78, 15, 3, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(79, 15, 1, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(80, 15, 7, 1, NULL, 5, 5, '2021-06-21 18:58:41', '2021-06-21 18:58:41'),
(86, 16, 2, 1, NULL, 5, 5, '2021-06-21 19:13:44', '2021-06-21 19:13:44'),
(87, 16, 4, 1, NULL, 5, 5, '2021-06-21 19:13:44', '2021-06-21 19:13:44'),
(88, 16, 8, 1, NULL, 5, 5, '2021-06-21 19:13:44', '2021-06-21 19:13:44'),
(89, 16, 3, 1, NULL, 5, 5, '2021-06-21 19:13:44', '2021-06-21 19:13:44'),
(90, 16, 1, 1, NULL, 5, 5, '2021-06-21 19:13:44', '2021-06-21 19:13:44'),
(91, 16, 7, 1, NULL, 5, 5, '2021-06-21 19:13:44', '2021-06-21 19:13:44'),
(92, 17, 2, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(93, 17, 4, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(94, 17, 8, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(95, 17, 3, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(96, 17, 1, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(97, 17, 7, 1, NULL, 5, 5, '2021-06-21 19:14:52', '2021-06-21 19:14:52'),
(98, 18, 2, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(99, 18, 4, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(100, 18, 8, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(101, 18, 3, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(102, 18, 1, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(103, 18, 7, 1, NULL, 5, 5, '2021-06-21 19:29:47', '2021-06-21 19:29:47'),
(104, 19, 2, 1, NULL, 5, 5, '2021-06-21 19:38:01', '2021-06-21 19:38:01'),
(105, 19, 4, 1, NULL, 5, 5, '2021-06-21 19:38:01', '2021-06-21 19:38:01'),
(106, 19, 3, 1, NULL, 5, 5, '2021-06-21 19:38:01', '2021-06-21 19:38:01'),
(107, 19, 1, 1, NULL, 5, 5, '2021-06-21 19:38:01', '2021-06-21 19:38:01'),
(108, 20, 2, 1, NULL, 5, 5, '2021-06-21 19:42:42', '2021-06-21 19:42:42'),
(109, 20, 4, 1, NULL, 5, 5, '2021-06-21 19:42:42', '2021-06-21 19:42:42'),
(110, 20, 3, 1, NULL, 5, 5, '2021-06-21 19:42:42', '2021-06-21 19:42:42'),
(111, 20, 1, 1, NULL, 5, 5, '2021-06-21 19:42:42', '2021-06-21 19:42:42'),
(112, 21, 2, 1, NULL, 5, 5, '2021-06-21 19:48:15', '2021-06-21 19:48:15'),
(113, 21, 4, 1, NULL, 5, 5, '2021-06-21 19:48:15', '2021-06-21 19:48:15'),
(114, 21, 3, 1, NULL, 5, 5, '2021-06-21 19:48:15', '2021-06-21 19:48:15'),
(115, 21, 1, 1, NULL, 5, 5, '2021-06-21 19:48:15', '2021-06-21 19:48:15'),
(116, 22, 2, 1, NULL, 5, 5, '2021-06-21 19:52:14', '2021-06-21 19:52:14'),
(117, 22, 4, 1, NULL, 5, 5, '2021-06-21 19:52:14', '2021-06-21 19:52:14'),
(118, 22, 3, 1, NULL, 5, 5, '2021-06-21 19:52:14', '2021-06-21 19:52:14'),
(119, 22, 1, 1, NULL, 5, 5, '2021-06-21 19:52:14', '2021-06-21 19:52:14'),
(120, 23, 3, 1, NULL, 5, 5, '2021-06-21 19:56:06', '2021-06-21 19:56:06'),
(121, 24, 2, 1, NULL, 1, 1, '2021-06-25 00:04:19', '2021-06-25 00:04:19'),
(122, 24, 4, 1, NULL, 1, 1, '2021-06-25 00:04:19', '2021-06-25 00:04:19'),
(123, 24, 1, 1, NULL, 1, 1, '2021-06-25 00:04:19', '2021-06-25 00:04:19'),
(124, 25, 9, 1, NULL, 5, 5, '2021-06-25 00:09:44', '2021-06-25 00:09:44'),
(125, 25, 1, 1, NULL, 5, 5, '2021-06-25 00:09:44', '2021-06-25 00:09:44'),
(126, 25, 7, 1, NULL, 5, 5, '2021-06-25 00:09:44', '2021-06-25 00:09:44'),
(127, 26, 9, 1, NULL, 5, 5, '2021-06-25 00:14:54', '2021-06-25 00:14:54'),
(128, 26, 1, 1, NULL, 5, 5, '2021-06-25 00:14:54', '2021-06-25 00:14:54'),
(129, 26, 7, 1, NULL, 5, 5, '2021-06-25 00:14:54', '2021-06-25 00:14:54'),
(130, 27, 9, 1, NULL, 5, 5, '2021-06-25 00:19:19', '2021-06-25 00:19:19'),
(131, 27, 1, 1, NULL, 5, 5, '2021-06-25 00:19:19', '2021-06-25 00:19:19'),
(132, 27, 7, 1, NULL, 5, 5, '2021-06-25 00:19:19', '2021-06-25 00:19:19'),
(133, 28, 9, 1, NULL, 5, 5, '2021-06-25 00:22:18', '2021-06-25 00:22:18'),
(134, 28, 1, 1, NULL, 5, 5, '2021-06-25 00:22:18', '2021-06-25 00:22:18'),
(135, 28, 7, 1, NULL, 5, 5, '2021-06-25 00:22:18', '2021-06-25 00:22:18'),
(136, 29, 9, 1, NULL, 5, 5, '2021-06-25 00:25:36', '2021-06-25 00:25:36'),
(137, 29, 1, 1, NULL, 5, 5, '2021-06-25 00:25:36', '2021-06-25 00:25:36'),
(138, 29, 7, 1, NULL, 5, 5, '2021-06-25 00:25:36', '2021-06-25 00:25:36'),
(139, 30, 9, 1, NULL, 5, 5, '2021-06-25 00:31:05', '2021-06-25 00:31:05'),
(140, 30, 1, 1, NULL, 5, 5, '2021-06-25 00:31:05', '2021-06-25 00:31:05'),
(141, 30, 7, 1, NULL, 5, 5, '2021-06-25 00:31:05', '2021-06-25 00:31:05'),
(142, 31, 9, 1, NULL, 5, 5, '2021-06-25 00:33:07', '2021-06-25 00:33:07'),
(143, 31, 1, 1, NULL, 5, 5, '2021-06-25 00:33:07', '2021-06-25 00:33:07'),
(144, 31, 7, 1, NULL, 5, 5, '2021-06-25 00:33:07', '2021-06-25 00:33:07'),
(145, 32, 9, 1, NULL, 5, 5, '2021-06-25 00:35:28', '2021-06-25 00:35:28'),
(146, 32, 1, 1, NULL, 5, 5, '2021-06-25 00:35:28', '2021-06-25 00:35:28'),
(147, 32, 7, 1, NULL, 5, 5, '2021-06-25 00:35:28', '2021-06-25 00:35:28'),
(148, 33, 1, 1, NULL, 1, 1, '2021-06-25 04:06:58', '2021-06-25 04:06:58');

-- --------------------------------------------------------

--
-- Table structure for table `module_to_roles`
--

CREATE TABLE `module_to_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module_to_roles`
--

INSERT INTO `module_to_roles` (`id`, `module_id`, `role_id`, `activity_id`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(2545, 1, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2546, 1, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2547, 1, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2548, 1, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2549, 2, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2550, 2, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2551, 2, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2552, 2, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2553, 3, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2554, 3, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2555, 3, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2556, 3, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2557, 4, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2558, 4, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2559, 4, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2560, 4, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2561, 5, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2562, 5, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2563, 5, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2564, 5, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2565, 6, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2566, 6, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2567, 6, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2568, 6, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2569, 10, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2570, 10, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2571, 10, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2572, 10, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2573, 10, 2, 5, 1, NULL, NULL, NULL, NULL, NULL),
(2574, 10, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2575, 11, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2576, 11, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2577, 11, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2578, 11, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2579, 12, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2580, 12, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2581, 12, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2582, 12, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2583, 12, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2584, 12, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2585, 13, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2586, 13, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2587, 13, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2588, 13, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2589, 14, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2590, 15, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2591, 15, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2592, 15, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2593, 15, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2594, 15, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2595, 15, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2596, 16, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2597, 16, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2598, 16, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2599, 16, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2600, 16, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2601, 16, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2602, 17, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2603, 17, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2604, 17, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2605, 17, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2606, 17, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2607, 17, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2608, 18, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2609, 18, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2610, 18, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2611, 18, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2612, 18, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2613, 18, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2614, 19, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2615, 19, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2616, 19, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2617, 19, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2618, 20, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2619, 20, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2620, 20, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2621, 20, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2622, 21, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2623, 21, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2624, 21, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2625, 21, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2626, 22, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2627, 22, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2628, 22, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2629, 22, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2630, 23, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2631, 24, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2632, 24, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2633, 24, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2634, 25, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2635, 25, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2636, 25, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2637, 26, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2638, 26, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2639, 26, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2640, 27, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2641, 27, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2642, 27, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2643, 28, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2644, 28, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2645, 28, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2646, 29, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2647, 29, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2648, 29, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2649, 30, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2650, 30, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2651, 30, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2652, 31, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2653, 31, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2654, 31, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2655, 32, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2656, 32, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2657, 32, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2658, 33, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2659, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2660, 1, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2661, 1, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2662, 1, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2663, 2, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2664, 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2665, 2, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2666, 2, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2667, 3, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2668, 3, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2669, 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2670, 3, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2671, 4, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2672, 4, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2673, 4, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2674, 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2675, 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2676, 5, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2677, 5, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2678, 5, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2679, 6, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2680, 6, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2681, 6, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2682, 6, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2683, 6, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(2684, 6, 1, 6, 1, NULL, NULL, NULL, NULL, NULL),
(2685, 10, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2686, 10, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2687, 10, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2688, 10, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2689, 10, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(2690, 10, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2691, 11, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2692, 11, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2693, 11, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2694, 11, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2695, 12, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2696, 12, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2697, 12, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2698, 12, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2699, 12, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2700, 12, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2701, 13, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2702, 13, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2703, 13, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2704, 13, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2705, 14, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2706, 15, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2707, 15, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2708, 15, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2709, 15, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2710, 15, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2711, 15, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2712, 16, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2713, 16, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2714, 16, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2715, 16, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2716, 16, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2717, 16, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2718, 17, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2719, 17, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2720, 17, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2721, 17, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2722, 17, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2723, 17, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2724, 18, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2725, 18, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2726, 18, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2727, 18, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2728, 18, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2729, 18, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2730, 19, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2731, 19, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2732, 19, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2733, 19, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2734, 20, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2735, 20, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2736, 20, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2737, 20, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2738, 21, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2739, 21, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2740, 21, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2741, 21, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2742, 22, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2743, 22, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2744, 22, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2745, 22, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2746, 23, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2747, 24, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2748, 24, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2749, 24, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2750, 25, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2751, 25, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2752, 25, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2753, 26, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2754, 26, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2755, 26, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2756, 27, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2757, 27, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2758, 27, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2759, 28, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2760, 28, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2761, 28, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2762, 29, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2763, 29, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2764, 29, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2765, 30, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2766, 30, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2767, 30, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2768, 31, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2769, 31, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2770, 31, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2771, 32, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2772, 32, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2773, 32, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2774, 33, 1, 1, 1, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `module_to_users`
--

CREATE TABLE `module_to_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module_to_users`
--

INSERT INTO `module_to_users` (`id`, `module_id`, `user_id`, `activity_id`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(130, 1, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(132, 1, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(134, 1, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(136, 1, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(138, 2, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(140, 2, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(142, 2, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(144, 2, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(146, 3, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(148, 3, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(150, 3, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(152, 3, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(154, 4, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(156, 4, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(158, 4, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(160, 4, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(162, 5, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(164, 5, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(166, 5, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(168, 5, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(170, 6, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(172, 6, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(174, 6, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(176, 6, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(178, 7, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(180, 7, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(182, 7, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(184, 7, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7143, 1, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7144, 1, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7145, 1, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7146, 1, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7147, 1, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7148, 1, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7149, 1, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7150, 1, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7151, 1, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7152, 1, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7153, 1, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7154, 1, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7155, 1, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7156, 1, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7157, 1, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7158, 1, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7159, 2, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7160, 2, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7161, 2, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7162, 2, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7163, 2, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7164, 2, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7165, 2, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7166, 2, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7167, 2, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7168, 2, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7169, 2, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7170, 2, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7171, 2, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7172, 2, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7173, 2, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7174, 2, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7175, 3, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7176, 3, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7177, 3, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7178, 3, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7179, 3, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7180, 3, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7181, 3, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7182, 3, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7183, 3, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7184, 3, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7185, 3, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7186, 3, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7187, 3, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7188, 3, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7189, 3, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7190, 3, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7191, 4, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7192, 4, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7193, 4, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7194, 4, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7195, 4, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7196, 4, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7197, 4, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7198, 4, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7199, 4, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7200, 4, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7201, 4, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7202, 4, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7203, 4, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7204, 4, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7205, 4, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7206, 4, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7207, 5, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7208, 5, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7209, 5, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7210, 5, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7211, 5, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7212, 5, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7213, 5, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7214, 5, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7215, 5, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7216, 5, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7217, 5, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7218, 5, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7219, 5, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7220, 5, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7221, 5, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7222, 5, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7223, 6, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7224, 6, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7225, 6, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7226, 6, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7227, 6, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7228, 6, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7229, 6, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7230, 6, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7231, 6, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7232, 6, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7233, 6, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7234, 6, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7235, 6, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7236, 6, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7237, 6, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7238, 6, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7239, 10, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7240, 10, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7241, 10, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7242, 10, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7243, 10, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7244, 10, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7245, 10, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7246, 10, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7247, 10, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7248, 10, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7249, 10, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7250, 10, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7251, 10, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7252, 10, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7253, 10, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7254, 10, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7255, 10, 5, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7256, 10, 8, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7257, 10, 9, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7258, 10, 10, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7259, 10, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7260, 10, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7261, 10, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7262, 10, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7263, 11, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7264, 11, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7265, 11, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7266, 11, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7267, 11, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7268, 11, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7269, 11, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7270, 11, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7271, 11, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7272, 11, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7273, 11, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7274, 11, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7275, 11, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7276, 11, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7277, 11, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7278, 11, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7279, 12, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7280, 12, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7281, 12, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7282, 12, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7283, 12, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7284, 12, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7285, 12, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7286, 12, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7287, 12, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7288, 12, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7289, 12, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7290, 12, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7291, 12, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7292, 12, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7293, 12, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7294, 12, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7295, 12, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7296, 12, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7297, 12, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7298, 12, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7299, 12, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7300, 12, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7301, 12, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7302, 12, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7303, 13, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7304, 13, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7305, 13, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7306, 13, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7307, 13, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7308, 13, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7309, 13, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7310, 13, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7311, 13, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7312, 13, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7313, 13, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7314, 13, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7315, 13, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7316, 13, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7317, 13, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7318, 13, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7319, 14, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7320, 14, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7321, 14, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7322, 14, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7323, 15, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7324, 15, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7325, 15, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7326, 15, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7327, 15, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7328, 15, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7329, 15, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7330, 15, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7331, 15, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7332, 15, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7333, 15, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7334, 15, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7335, 15, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7336, 15, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7337, 15, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7338, 15, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7339, 15, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7340, 15, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7341, 15, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7342, 15, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7343, 15, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7344, 15, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7345, 15, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7346, 15, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7347, 16, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7348, 16, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7349, 16, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7350, 16, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7351, 16, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7352, 16, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7353, 16, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7354, 16, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7355, 16, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7356, 16, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7357, 16, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7358, 16, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7359, 16, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7360, 16, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7361, 16, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7362, 16, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7363, 16, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7364, 16, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7365, 16, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7366, 16, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7367, 16, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7368, 16, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7369, 16, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7370, 16, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7371, 17, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7372, 17, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7373, 17, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7374, 17, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7375, 17, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7376, 17, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7377, 17, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7378, 17, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7379, 17, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7380, 17, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7381, 17, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7382, 17, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7383, 17, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7384, 17, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7385, 17, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7386, 17, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7387, 17, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7388, 17, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7389, 17, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7390, 17, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7391, 17, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7392, 17, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7393, 17, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7394, 17, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7395, 18, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7396, 18, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7397, 18, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7398, 18, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7399, 18, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7400, 18, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7401, 18, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7402, 18, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7403, 18, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7404, 18, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7405, 18, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7406, 18, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7407, 18, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7408, 18, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7409, 18, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7410, 18, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7411, 18, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7412, 18, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7413, 18, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7414, 18, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7415, 18, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7416, 18, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7417, 18, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7418, 18, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7419, 19, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7420, 19, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7421, 19, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7422, 19, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7423, 19, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7424, 19, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7425, 19, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7426, 19, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7427, 19, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7428, 19, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7429, 19, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7430, 19, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7431, 19, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7432, 19, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7433, 19, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7434, 19, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7435, 20, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7436, 20, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7437, 20, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7438, 20, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7439, 20, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7440, 20, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7441, 20, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7442, 20, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7443, 20, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7444, 20, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7445, 20, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7446, 20, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7447, 20, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7448, 20, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7449, 20, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7450, 20, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7451, 21, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7452, 21, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7453, 21, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7454, 21, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7455, 21, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7456, 21, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7457, 21, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7458, 21, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7459, 21, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7460, 21, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7461, 21, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7462, 21, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7463, 21, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7464, 21, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7465, 21, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7466, 21, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7467, 22, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7468, 22, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7469, 22, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7470, 22, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7471, 22, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7472, 22, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7473, 22, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7474, 22, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7475, 22, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7476, 22, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7477, 22, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7478, 22, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7479, 22, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7480, 22, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7481, 22, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7482, 22, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7483, 23, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7484, 23, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7485, 23, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7486, 23, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7487, 24, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7488, 24, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7489, 24, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7490, 24, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7491, 24, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7492, 24, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7493, 24, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7494, 24, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7495, 24, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7496, 24, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7497, 24, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7498, 24, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7499, 25, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7500, 25, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7501, 25, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7502, 25, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7503, 25, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7504, 25, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7505, 25, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7506, 25, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7507, 25, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7508, 25, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7509, 25, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7510, 25, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7511, 26, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7512, 26, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7513, 26, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7514, 26, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7515, 26, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7516, 26, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7517, 26, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7518, 26, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7519, 26, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7520, 26, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7521, 26, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7522, 26, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7523, 27, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7524, 27, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7525, 27, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7526, 27, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7527, 27, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7528, 27, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7529, 27, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7530, 27, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7531, 27, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7532, 27, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7533, 27, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7534, 27, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7535, 28, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7536, 28, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7537, 28, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7538, 28, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7539, 28, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7540, 28, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7541, 28, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7542, 28, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7543, 28, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7544, 28, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7545, 28, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7546, 28, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7547, 29, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7548, 29, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7549, 29, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7550, 29, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7551, 29, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7552, 29, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7553, 29, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7554, 29, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7555, 29, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7556, 29, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7557, 29, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7558, 29, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7559, 30, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7560, 30, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7561, 30, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7562, 30, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7563, 30, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7564, 30, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7565, 30, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7566, 30, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7567, 30, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7568, 30, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7569, 30, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7570, 30, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7571, 31, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7572, 31, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7573, 31, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7574, 31, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7575, 31, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7576, 31, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7577, 31, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7578, 31, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7579, 31, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7580, 31, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7581, 31, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7582, 31, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7583, 32, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7584, 32, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7585, 32, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7586, 32, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7587, 32, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7588, 32, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7589, 32, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7590, 32, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7591, 32, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7592, 32, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7593, 32, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7594, 32, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7595, 33, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7596, 33, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7597, 33, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7598, 33, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7599, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7600, 1, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7601, 1, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7602, 1, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7603, 2, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7604, 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7605, 2, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7606, 2, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7607, 3, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7608, 3, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7609, 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7610, 3, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7611, 4, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7612, 4, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7613, 4, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7614, 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7615, 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7616, 5, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7617, 5, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7618, 5, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7619, 6, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7620, 6, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7621, 6, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7622, 6, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7623, 6, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7624, 6, 1, 6, 1, NULL, NULL, NULL, NULL, NULL),
(7625, 10, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7626, 10, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7627, 10, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7628, 10, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7629, 10, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7630, 10, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7631, 11, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7632, 11, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7633, 11, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7634, 11, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7635, 12, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7636, 12, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7637, 12, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7638, 12, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7639, 12, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7640, 12, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7641, 13, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7642, 13, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7643, 13, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7644, 13, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7645, 14, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7646, 15, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7647, 15, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7648, 15, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7649, 15, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7650, 15, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7651, 15, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7652, 16, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7653, 16, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7654, 16, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7655, 16, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7656, 16, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7657, 16, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7658, 17, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7659, 17, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7660, 17, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7661, 17, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7662, 17, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7663, 17, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7664, 18, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7665, 18, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7666, 18, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7667, 18, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7668, 18, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7669, 18, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7670, 19, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7671, 19, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7672, 19, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7673, 19, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7674, 20, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7675, 20, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7676, 20, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7677, 20, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7678, 21, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7679, 21, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7680, 21, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7681, 21, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7682, 22, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7683, 22, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7684, 22, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7685, 22, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7686, 23, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7687, 24, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7688, 24, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7689, 24, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7690, 25, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7691, 25, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7692, 25, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7693, 26, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7694, 26, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7695, 26, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7696, 27, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7697, 27, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7698, 27, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7699, 28, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7700, 28, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7701, 28, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7702, 29, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7703, 29, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7704, 29, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7705, 30, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7706, 30, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7707, 30, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7708, 31, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7709, 31, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7710, 31, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7711, 32, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7712, 32, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7713, 32, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7714, 33, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7715, 1, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7716, 1, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7717, 1, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7718, 1, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7719, 2, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7720, 2, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7721, 2, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7722, 2, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7723, 3, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7724, 3, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7725, 3, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7726, 3, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7727, 4, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7728, 4, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7729, 4, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7730, 4, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7731, 5, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7732, 5, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7733, 5, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7734, 5, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7735, 6, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7736, 6, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7737, 6, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7738, 6, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7739, 10, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7740, 10, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7741, 10, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7742, 10, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7743, 10, 14, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7744, 10, 14, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7745, 11, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7746, 11, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7747, 11, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7748, 11, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7749, 12, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7750, 12, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7751, 12, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7752, 12, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7753, 12, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7754, 12, 14, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7755, 13, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7756, 13, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7757, 13, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7758, 13, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7759, 14, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7760, 15, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7761, 15, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7762, 15, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7763, 15, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7764, 15, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7765, 15, 14, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7766, 16, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7767, 16, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7768, 16, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7769, 16, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7770, 16, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7771, 16, 14, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7772, 17, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7773, 17, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7774, 17, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7775, 17, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7776, 17, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7777, 17, 14, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7778, 18, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7779, 18, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7780, 18, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7781, 18, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7782, 18, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7783, 18, 14, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7784, 19, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7785, 19, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7786, 19, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7787, 19, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7788, 20, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7789, 20, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7790, 20, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7791, 20, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7792, 21, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7793, 21, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7794, 21, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7795, 21, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7796, 22, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7797, 22, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7798, 22, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7799, 22, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7800, 23, 14, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7801, 24, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7802, 24, 14, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7803, 24, 14, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7804, 25, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7805, 25, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7806, 25, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7807, 26, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7808, 26, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7809, 26, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7810, 27, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7811, 27, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7812, 27, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7813, 28, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7814, 28, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7815, 28, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7816, 29, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7817, 29, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7818, 29, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7819, 30, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7820, 30, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7821, 30, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7822, 31, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7823, 31, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7824, 31, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7825, 32, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7826, 32, 14, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7827, 32, 14, 9, 1, NULL, NULL, NULL, NULL, NULL),
(7828, 33, 14, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7829, 1, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7830, 1, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7831, 1, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7832, 1, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7833, 2, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7834, 2, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7835, 2, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7836, 2, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7837, 3, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7838, 3, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7839, 3, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7840, 3, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7841, 4, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7842, 4, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7843, 4, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7844, 4, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7845, 5, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7846, 5, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7847, 5, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7848, 5, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7849, 6, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7850, 6, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7851, 6, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7852, 6, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7853, 10, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7854, 10, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7855, 10, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7856, 10, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7857, 10, 16, 5, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7858, 10, 16, 8, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7859, 11, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7860, 11, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7861, 11, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7862, 11, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7863, 12, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7864, 12, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7865, 12, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7866, 12, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7867, 12, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7868, 12, 16, 8, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7869, 13, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7870, 13, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7871, 13, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7872, 13, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7873, 14, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7874, 15, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7875, 15, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7876, 15, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7877, 15, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7878, 15, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7879, 15, 16, 8, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7880, 16, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7881, 16, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7882, 16, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7883, 16, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7884, 16, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7885, 16, 16, 8, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7886, 17, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7887, 17, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7888, 17, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7889, 17, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7890, 17, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7891, 17, 16, 8, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7892, 18, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7893, 18, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7894, 18, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7895, 18, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7896, 18, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7897, 18, 16, 8, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7898, 19, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7899, 19, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7900, 19, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7901, 19, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7902, 20, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7903, 20, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7904, 20, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7905, 20, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7906, 21, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7907, 21, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7908, 21, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7909, 21, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7910, 22, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7911, 22, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7912, 22, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7913, 22, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7914, 23, 16, 3, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7915, 24, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7916, 24, 16, 2, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7917, 24, 16, 4, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7918, 25, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7919, 25, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7920, 25, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7921, 26, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7922, 26, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7923, 26, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7924, 27, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7925, 27, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7926, 27, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7927, 28, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7928, 28, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7929, 28, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7930, 29, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7931, 29, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7932, 29, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7933, 30, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7934, 30, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7935, 30, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7936, 31, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7937, 31, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7938, 31, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7939, 32, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7940, 32, 16, 7, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7941, 32, 16, 9, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7942, 33, 16, 1, 1, '2021-06-25 13:43:19', NULL, NULL, NULL, '2021-06-25 13:43:19'),
(7943, 1, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7944, 1, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7945, 1, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7946, 1, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7947, 2, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7948, 2, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7949, 2, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7950, 2, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7951, 3, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7952, 3, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7953, 3, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7954, 3, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7955, 4, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7956, 4, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7957, 4, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7958, 4, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7959, 5, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7960, 5, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7961, 5, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7962, 5, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7963, 6, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7964, 6, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7965, 6, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7966, 6, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7967, 10, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7968, 10, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7969, 10, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7970, 10, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7971, 10, 16, 5, 1, NULL, NULL, NULL, NULL, NULL),
(7972, 10, 16, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7973, 11, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7974, 11, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7975, 11, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7976, 11, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7977, 12, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7978, 12, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7979, 12, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7980, 12, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7981, 12, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7982, 12, 16, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7983, 13, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7984, 13, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7985, 13, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7986, 13, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7987, 14, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7988, 15, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7989, 15, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7990, 15, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7991, 15, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7992, 15, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7993, 15, 16, 8, 1, NULL, NULL, NULL, NULL, NULL),
(7994, 16, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(7995, 16, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(7996, 16, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(7997, 16, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(7998, 16, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(7999, 16, 16, 8, 1, NULL, NULL, NULL, NULL, NULL),
(8000, 17, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8001, 17, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8002, 17, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8003, 17, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8004, 17, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8005, 17, 16, 8, 1, NULL, NULL, NULL, NULL, NULL),
(8006, 18, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8007, 18, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8008, 18, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8009, 18, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8010, 18, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8011, 18, 16, 8, 1, NULL, NULL, NULL, NULL, NULL),
(8012, 19, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8013, 19, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8014, 19, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8015, 19, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8016, 20, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8017, 20, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8018, 20, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8019, 20, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8020, 21, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8021, 21, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8022, 21, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8023, 21, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8024, 22, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8025, 22, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8026, 22, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8027, 22, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8028, 23, 16, 3, 1, NULL, NULL, NULL, NULL, NULL),
(8029, 24, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8030, 24, 16, 2, 1, NULL, NULL, NULL, NULL, NULL),
(8031, 24, 16, 4, 1, NULL, NULL, NULL, NULL, NULL),
(8032, 25, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8033, 25, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8034, 25, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8035, 26, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8036, 26, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8037, 26, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8038, 27, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8039, 27, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8040, 27, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8041, 28, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8042, 28, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8043, 28, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8044, 29, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8045, 29, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8046, 29, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8047, 30, 16, 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `module_to_users` (`id`, `module_id`, `user_id`, `activity_id`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(8048, 30, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8049, 30, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8050, 31, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8051, 31, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8052, 31, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8053, 32, 16, 1, 1, NULL, NULL, NULL, NULL, NULL),
(8054, 32, 16, 7, 1, NULL, NULL, NULL, NULL, NULL),
(8055, 32, 16, 9, 1, NULL, NULL, NULL, NULL, NULL),
(8056, 33, 16, 1, 1, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productions`
--

CREATE TABLE `productions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `produce_amount` double DEFAULT NULL,
  `waste_amount` decimal(10,2) DEFAULT NULL,
  `unit_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` bigint(20) DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `targate_amount` double(10,2) NOT NULL,
  `ref_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode_symbology` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = production running, 1 =production end',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productions`
--

INSERT INTO `productions` (`id`, `production_number`, `warehouse_id`, `product_id`, `employee_id`, `produce_amount`, `waste_amount`, `unit_name`, `unit_id`, `note`, `targate_amount`, `ref_no`, `barcode_symbology`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'pr-20210624-041100', 1, 3, 8, 4900, 100.00, 'GRAM', 1, 'production', 4900.00, NULL, 'C39+', 8, 8, 1, NULL, '2021-06-24 23:11:00', '2021-06-24 23:11:36'),
(2, 'pr-20210627-112121', 1, 1, 16, 10, 4.00, 'GRAM', 1, NULL, 50.00, '', 'C39+', 16, 16, 1, NULL, '2021-06-27 18:21:21', '2021-06-27 18:22:45'),
(3, 'pr-20210629-060536', 2, 4, 16, 250, 50.00, 'GRAM', 1, NULL, 300.00, 'Lemon11233', 'C39+', 16, 16, 1, NULL, '2021-06-30 01:05:36', '2021-06-30 01:07:59'),
(4, 'pr-20210629-061336', 1, 5, 16, 200, 50.00, 'GRAM', 1, NULL, 300.00, 'jkjjkj', 'C39+', 16, 16, 1, NULL, '2021-06-30 01:13:36', '2021-06-30 01:14:15'),
(5, 'pr-20210630-034553', 1, 4, 16, 45, 5.00, 'GRAM', 1, NULL, 50.00, '', 'C39+', 16, 16, 1, NULL, '2021-06-30 10:45:53', '2021-06-30 10:47:23'),
(6, 'pr-20210630-113114', 1, 4, 16, 45, 5.00, 'GRAM', 1, NULL, 50.00, '', 'C39+', 16, 16, 1, NULL, '2021-06-30 18:31:14', '2021-06-30 18:34:31');

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
(1, 1, 'Miraj', '3000', '5', 1, 1, 0, '2021-06-26 11:50:58', '2021-06-26 11:50:58'),
(2, 1, 'Lemon', '1900', '5', 1, 1, 0, '2021-06-26 11:50:58', '2021-06-26 11:50:58'),
(3, 2, 'Jone', '5', '2', 16, 16, 0, '2021-06-27 18:22:45', '2021-06-27 18:22:45'),
(4, 2, 'Jane', '5', '2', 16, 16, 0, '2021-06-27 18:22:45', '2021-06-27 18:22:45'),
(5, 3, 'younes', '250', '50', 16, 16, 0, '2021-06-30 01:07:59', '2021-06-30 01:07:59'),
(6, 4, 'younes', '200', '50', 16, 16, 0, '2021-06-30 01:14:15', '2021-06-30 01:14:15'),
(7, 5, 'Jone', '45', '5', 16, 16, 0, '2021-06-30 10:47:23', '2021-06-30 10:47:23'),
(8, 6, 'Jone', '45', '5', 16, 16, 0, '2021-06-30 18:34:31', '2021-06-30 18:34:31');

-- --------------------------------------------------------

--
-- Table structure for table `production_use_products`
--

CREATE TABLE `production_use_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `production_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `unit_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` bigint(20) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `production_use_products`
--

INSERT INTO `production_use_products` (`id`, `production_id`, `warehouse_id`, `product_id`, `qty`, `unit_name`, `unit_id`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 5000.00, 'GRAM', 1, 8, 8, 0, NULL, '2021-06-24 23:11:00', '2021-06-24 23:11:00'),
(2, 2, 1, 1, 8.00, 'GRAM', 1, 16, 16, 0, NULL, '2021-06-27 18:21:21', '2021-06-27 18:21:21'),
(3, 2, 2, 2, 5.00, 'GRAM', 1, 16, 16, 0, NULL, '2021-06-27 18:21:21', '2021-06-27 18:21:21'),
(4, 3, 1, 5, 300.00, 'GRAM', 1, 16, 16, 0, NULL, '2021-06-30 01:05:36', '2021-06-30 01:05:36'),
(5, 4, 2, 4, 250.00, 'GRAM', 1, 16, 16, 0, NULL, '2021-06-30 01:13:36', '2021-06-30 01:13:36'),
(6, 5, 1, 5, 50.00, 'GRAM', 1, 16, 16, 0, NULL, '2021-06-30 10:45:53', '2021-06-30 10:45:53'),
(7, 6, 1, 5, 50.00, 'GRAM', 1, 16, 16, 0, NULL, '2021-06-30 18:31:14', '2021-06-30 18:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_symbology` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `product_price` float DEFAULT NULL,
  `qty` double DEFAULT 0,
  `waste_qty` double DEFAULT 0,
  `alert_quantity` double DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `code`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `product_price`, `qty`, `waste_qty`, `alert_quantity`, `image`, `file`, `product_details`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Product 1', '6642113927', 'C39+', 1, 1, 1, 10, 45002, 4, 0, '[\"public\\/upload\\/product\\/images\\/download.jpg\"]', 'public/upload/product/files/RoiE6zEO8WcVfj8Yv9X8.png', '<p>Product details</p>', 1, NULL, 1, 16, '2021-06-24 22:26:18', '2021-06-30 18:55:03'),
(2, 'Product 2', '0204470939', 'C39+', 1, 1, 1, 30, 3995, 0, 0, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, '<p>dddd</p>', 1, NULL, 1, 16, '2021-06-24 22:46:45', '2021-06-27 18:21:21'),
(3, 'Product 3', '1329314102', 'C39+', 1, 1, 1, 50, 6000, 100, 0, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, '<p>dddd</p>', 1, NULL, 1, 8, '2021-06-24 22:50:03', '2021-06-24 23:31:28'),
(4, 'Lemon', '2220791479', 'C39', 1, 1, 1, 3, 90, 60, 0, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, NULL, 1, NULL, 16, 16, '2021-06-30 01:01:25', '2021-06-30 18:34:31'),
(5, 'Lemon hase', '22207914793', 'C39+', 1, 1, 1, 0, 300, 50, 0, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, NULL, 1, NULL, 16, 16, '2021-06-30 01:01:38', '2021-06-30 18:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adjustment_unit_id` int(11) DEFAULT NULL,
  `net_unit_cost` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `org_input` double DEFAULT NULL,
  `unit_value` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_adjustments`
--

INSERT INTO `product_adjustments` (`id`, `adjustment_id`, `product_id`, `qty`, `action`, `adjustment_unit_id`, `net_unit_cost`, `total`, `org_input`, `unit_value`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 2000, '+', 1, 30, 60000, 2000, 1, '2021-06-24 22:50:46', '2021-06-24 22:50:46'),
(2, 2, 3, 100, '+', 1, 0, 0, 100, 1, '2021-06-24 23:12:28', '2021-06-24 23:12:28'),
(3, 3, 5, 200, '+', 1, 0, 0, 200, 1, '2021-06-30 01:15:03', '2021-06-30 01:15:03'),
(4, 4, 1, 5, '+', 1, 10, 50, 5, 1, '2021-06-30 18:53:57', '2021-06-30 18:53:57'),
(5, 5, 1, 5, '-', 1, 10, 50, 5, 1, '2021-06-30 18:55:03', '2021-06-30 18:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `total` double NOT NULL,
  `org_input` double DEFAULT NULL,
  `unit_value` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `qty`, `purchase_unit_id`, `net_unit_cost`, `total`, `org_input`, `unit_value`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 50000, 1, 10, 500000, 50000, 1, '2021-06-24 22:32:32', '2021-06-24 22:32:32'),
(2, 2, 2, 2000, 1, 30, 60000, 2000, 1, '2021-06-24 22:47:16', '2021-06-24 22:47:16'),
(3, 3, 3, 1000, 1, 0, 0, 1000, 1, '2021-06-24 23:30:56', '2021-06-24 23:30:56'),
(4, 4, 5, 300, 1, 0, 0, 300, 1, '2021-06-30 01:03:17', '2021-06-30 01:03:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `total` double NOT NULL,
  `org_input` double DEFAULT NULL,
  `unit_value` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_transfer`
--

INSERT INTO `product_transfer` (`id`, `transfer_id`, `product_id`, `qty`, `purchase_unit_id`, `net_unit_cost`, `total`, `org_input`, `unit_value`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10000, 1, 10, 100000, 10000, 1, '2021-06-24 22:55:00', '2021-06-24 22:55:00');

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `waste_qty` double DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `warehouse_id`, `qty`, `waste_qty`, `created_at`, `updated_at`) VALUES
(1, '1', 1, 35002, 4, '2021-06-24 22:34:45', '2021-06-30 18:55:03'),
(2, '2', 2, 3995, 0, '2021-06-24 22:47:16', '2021-06-27 18:21:21'),
(3, '1', 2, 10000, 0, '2021-06-24 22:55:00', '2021-06-24 22:55:00'),
(4, '3', 1, 6000, 100, '2021-06-24 23:11:37', '2021-06-24 23:30:56'),
(5, '5', 1, 300, 50, '2021-06-30 01:03:28', '2021-06-30 18:31:14'),
(6, '4', 2, 0, 50, '2021-06-30 01:07:59', '2021-06-30 01:13:36'),
(7, '4', 1, 90, 10, '2021-06-30 10:47:23', '2021-06-30 18:34:31');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_cost` double NOT NULL,
  `grand_total` double NOT NULL,
  `status` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `received_date` datetime DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `item`, `total_qty`, `total_cost`, `grand_total`, `status`, `note`, `document`, `received_date`, `received_by`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'order-1', 1, 1, 1, 1, 50000, 500000, 500000, 1, NULL, NULL, '2021-06-24 15:34:45', 1, NULL, 1, 1, '2021-06-24 22:32:31', '2021-06-24 22:34:45'),
(2, 'order-2', 9, 2, NULL, 1, 2000, 60000, 60000, 1, 'Note', NULL, '2021-06-24 15:47:16', 9, NULL, 9, 9, '2021-06-24 22:47:16', '2021-06-24 22:47:16'),
(3, 'order-3', 8, 1, 1, 1, 1000, 0, 0, 1, NULL, NULL, '2021-06-24 16:30:55', 8, NULL, 8, 8, '2021-06-24 23:30:55', '2021-06-24 23:30:56'),
(4, '88767', 16, 1, 2, 1, 300, 0, 0, 1, NULL, NULL, '2021-06-29 18:03:28', 16, NULL, 16, 16, '2021-06-30 01:03:17', '2021-06-30 01:03:28');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `info` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `info`, `status`, `deleted_at`, `updated_by`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'Super Admin', NULL, 1, NULL, 1, '2020-01-25 01:50:33', '2020-12-05 20:05:06', 1),
(2, 'Admin', NULL, 1, NULL, 1, '2020-01-25 01:50:48', '2020-01-25 01:50:48', NULL),
(3, 'Customer', NULL, 1, NULL, 1, '2020-03-03 18:13:42', '2020-03-03 18:13:42', 1),
(4, 'Test role', NULL, 0, '2020-11-23 21:56:47', 1, '2020-11-23 21:53:06', '2020-11-23 21:56:47', 1);

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `logo` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_no` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_title` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(765) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(765) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `copy_right` varchar(765) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alert_quantity` int(11) NOT NULL DEFAULT 5,
  `display_unit` int(11) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `updated_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `logo`, `icon`, `email`, `contact_no`, `site_title`, `meta_description`, `meta_keyword`, `copy_right`, `alert_quantity`, `display_unit`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'public/upload/site-setting/otPhjJpkiC2b4jAZABYy.png', 'public/upload/site-setting/821lt8b2T0V7ivyHno7b.png', 'thakurlemon@gmail.com', '01719287734', 'Inventory', 'Web Embed', 'Inventory', 'Inventory', 15000, 1, 1, 1, '2021-06-02 00:26:39', '2021-06-24 23:55:17');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `contact_no`, `email`, `address`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Supplier 1', '01719287734444', 'supplier1@email.com', NULL, 1, 1, 1, NULL, '2021-06-24 22:25:22', '2021-06-24 22:25:29'),
(2, 'Green', '0012635653', 'greenmiles@wdedede.de', NULL, 16, 16, 1, NULL, '2021-06-30 01:02:18', '2021-06-30 01:02:18');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`id`, `reference_no`, `user_id`, `from_warehouse_id`, `to_warehouse_id`, `item`, `total_qty`, `total_cost`, `grand_total`, `document`, `note`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'tr-20210624-035500', 8, 1, 2, 1, 10000, 100000, 100000, NULL, NULL, NULL, 8, 8, '2021-06-24 22:55:00', '2021-06-24 22:55:02');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` float DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `value`, `description`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'GRAM', 1, 'GRAM', 1, NULL, 1, 1, '2021-06-24 21:46:27', '2021-06-24 21:46:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `contact_no` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isEmployee` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=not employee,1=employee',
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastLoginTime` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `email_verified_at`, `contact_no`, `photo`, `designation`, `isEmployee`, `password`, `lastLoginTime`, `status`, `deleted_at`, `remember_token`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'superadmin', 'superadmin@email.com', NULL, '01682234164', 'public/upload/portfolio-pic/f0pFrHvIHOApjaNZLlKi.jpg', NULL, 0, '$2y$10$AnA/vs6uSlEhQEpIecffbuv9jBcVemoPKil8NjkZYCZyjrPSNSfEq', '2021-06-25 06:32:01', 1, NULL, 'guiS9a1zRzuDKz5dxSkbIiRnLoeRMOxnewg97a0ALuCZbkqCgadbWZbwYD3l', 1, 1, '2020-01-18 23:14:02', '2021-06-25 13:32:01'),
(2, 1, 'Myles Key', 'jymyjopuny@mailinator.com', NULL, '123456', 'public/upload/rofile-pic/Vty0kqzBV9o3coKVIyqI.jpg', NULL, 0, '$2y$10$lJHuiDyxiw/yq/.bfz01BeygTc9Tl0mZbAM0JS7NADJlVjXmBSsDK', NULL, 1, '2020-03-03 04:06:00', NULL, 1, 1, '2020-01-18 23:33:52', '2020-03-03 04:06:00'),
(3, 2, 'Phelan Brown', 'fynojewu@mailinator.com', NULL, '1465', 'public/upload/rofile-pic/IfhDPL9wVq1IPh6J4d4w.png', NULL, 0, '$2y$10$BvWoKwT6Toe1WgiVuxutxufuaqhUb1VXiZKaRYsSyK6TQz3NcFVge', NULL, 1, '2020-01-25 03:39:51', NULL, 1, 1, '2020-01-18 23:37:14', '2020-01-25 03:39:51'),
(4, 2, 'Charlotte Villarreal', 'cusesohyko@mailinator.com', NULL, '12456', 'public/upload/rofile-pic/bcE7Fewm45VV3WtuoL0v.png', NULL, 0, '$2y$10$2aF8MBYraBpAzxw/ye2bXuKieJp6FoBuVQBHL6YHbSN1CIouTQf9C', NULL, 1, '2020-03-03 04:06:04', NULL, 1, 1, '2020-01-18 23:48:36', '2020-03-03 04:06:04'),
(5, 2, 'miraj', 'miraj@email.com', NULL, '1465456', 'public/upload/portfolio-pic/vTxAhtmmbJki2ecWr083.png', NULL, 0, '$2y$10$37DUfPgJ6HA/.L/zkrX6h.VXEWNqnU4kVqCBIhuDl5vjeYMSVpr9W', '2021-06-24 15:37:59', 1, NULL, NULL, 1, 1, '2020-03-03 04:06:56', '2021-06-24 22:37:59'),
(6, 1, 'Juliet Harrison', 'kazyx@mailinator.com', NULL, '123456874', NULL, NULL, 0, '$2y$10$alGTDKUcytKoLnUFYyOWmer7EoXknY1911HsMCa496lq2LYV13JDK', NULL, 1, '2020-11-23 20:55:39', NULL, 1, 1, '2020-11-23 20:53:19', '2020-11-23 20:55:39'),
(7, 1, 'Tara Erickson', 'gobimohyja@mailinator.com', NULL, 'U146545', 'public/upload/portfolio-pic/sydBo3dqmxqmFgaRT3u3.png', NULL, 0, '$2y$10$qgZrvHAaoziTx9EsRQKyN.RDRELo3StfBHsmTajQFOAyQ0/o/W1n2', NULL, 1, '2020-11-23 20:56:55', NULL, 1, 1, '2020-11-23 20:56:49', '2020-11-23 20:56:55'),
(8, 2, 'warehouse1', 'warehouse1@email.com', NULL, '01876543321', NULL, NULL, 1, '$2y$10$iHA7Tj16AysbnWxD9ZHauuSd/uwX4aP6/ow.BQel0TFYDabhsTFLW', '2021-06-24 21:21:57', 1, NULL, NULL, 1, 1, '2021-06-19 02:03:20', '2021-06-25 04:21:57'),
(9, 2, 'warehouse2', 'warehouse2@email.com', NULL, '01719287738', NULL, NULL, 1, '$2y$10$Y6lDLVqdqA1niI8g.kJrru0v20CpNKdN0JYBHnbg6ftSdOwycBkz.', '2021-06-24 15:44:25', 1, NULL, NULL, 1, 1, '2021-06-19 02:03:50', '2021-06-24 22:44:25'),
(10, 2, 'Lemon', 'lemon@email.com', NULL, '01876543325', NULL, NULL, 1, '$2y$10$AkQVcHqQHL9OHGfksrE.UeMbmelLcmXv7OSEi7Ba3Nvl1sY.eIE0i', '2021-06-24 19:10:32', 1, NULL, NULL, 1, 1, '2021-06-24 22:15:00', '2021-06-25 02:10:32'),
(14, 2, 'testuser', 'testuser@email.com', NULL, '222222222222', NULL, NULL, 1, '$2y$10$bKN44r8gK5736KUVi4HCieyJb4yyzVdse88jWWfDtOny4W6smyOmS', '2021-06-25 06:39:38', 1, NULL, NULL, 1, 1, '2021-06-25 13:33:29', '2021-06-25 13:39:38'),
(16, 2, 'Admin', 'admin@email.com', NULL, '33333333333', NULL, NULL, 1, '$2y$10$KMFmYbvQJNr3xHQvNKsSnOFVKqIH373H5/JuUZHJsYPpo7JKMR.Um', '2021-06-30 15:25:40', 1, NULL, 'bhPrVifFbJabKc8ATgCGsjW4cRy3IcUSxe4sbhHoflXCwMXI5rnCFKoJl5Gb', 14, 16, '2021-06-25 13:42:50', '2021-06-30 22:25:40');

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(128) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `email`, `contact_no`, `address`, `status`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Warehouse 1', 'warehouse1@email.com', '01876543321', 'Dhaka', 1, NULL, 1, 1, '2021-06-24 21:47:26', '2021-06-24 21:47:26'),
(2, 'Warehouse 2', 'warehouse2@email.com', '01682234164', 'Dhaka', 1, NULL, 1, 1, '2021-06-24 21:47:49', '2021-06-24 21:47:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_warhouses`
--
ALTER TABLE `employee_warhouses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_receivers`
--
ALTER TABLE `mail_receivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module_to_activities`
--
ALTER TABLE `module_to_activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module_to_roles`
--
ALTER TABLE `module_to_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module_to_users`
--
ALTER TABLE `module_to_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `productions`
--
ALTER TABLE `productions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `production_employees`
--
ALTER TABLE `production_employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `production_use_products`
--
ALTER TABLE `production_use_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_contact_no_unique` (`contact_no`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee_warhouses`
--
ALTER TABLE `employee_warhouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_receivers`
--
ALTER TABLE `mail_receivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `module_to_activities`
--
ALTER TABLE `module_to_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `module_to_roles`
--
ALTER TABLE `module_to_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2775;

--
-- AUTO_INCREMENT for table `module_to_users`
--
ALTER TABLE `module_to_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8057;

--
-- AUTO_INCREMENT for table `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `production_employees`
--
ALTER TABLE `production_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `production_use_products`
--
ALTER TABLE `production_use_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;