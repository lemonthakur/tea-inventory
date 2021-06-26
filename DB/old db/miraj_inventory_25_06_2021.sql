-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2021 at 10:04 PM
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
(1, 'Index', 'Index of module', 1, 1, 1, NULL, '2020-01-24 12:52:00', '2020-12-05 09:32:13'),
(2, 'Create', NULL, 1, 1, 1, NULL, '2020-01-24 12:52:10', '2020-01-24 12:52:10'),
(3, 'Edit', NULL, 1, 1, 1, NULL, '2020-01-24 12:52:20', '2020-03-02 15:23:32'),
(4, 'Delete', NULL, 1, 1, 1, NULL, '2020-01-24 12:52:30', '2020-01-24 12:52:30'),
(5, 'Change password', NULL, 1, 1, 1, NULL, '2020-01-24 12:52:39', '2020-01-24 12:52:39'),
(6, 'Password reset', NULL, 1, 1, 1, NULL, '2020-01-24 12:52:50', '2020-01-24 12:52:50'),
(7, 'Print', NULL, 1, 1, 1, NULL, '2020-01-24 12:53:01', '2020-01-24 12:53:01'),
(8, 'Details', NULL, 1, 1, 1, NULL, '2020-01-24 12:53:12', '2020-01-24 12:53:12'),
(9, 'CSV', NULL, 5, 5, 1, NULL, '2021-06-24 11:09:01', '2021-06-24 11:09:01');

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
(1, 'adr-20210624-035046', 2, 2000, 1, NULL, NULL, NULL, 1, 1, '2021-06-24 09:50:46', '2021-06-24 09:50:46'),
(2, 'adr-20210624-041228', 1, 100, 1, NULL, NULL, NULL, 1, 1, '2021-06-24 10:12:28', '2021-06-24 10:12:28');

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
(1, 'Nascafe', NULL, '0171987654', 'Nascafe@email.com', 'Nascafe', 'Dhaka', NULL, NULL, 1, NULL, 1, 1, '2021-06-24 09:21:36', '2021-06-24 09:21:36');

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
(1, 'Shop', NULL, 1, 1, 1, NULL, '2021-06-07 15:44:34', '2021-06-07 15:44:34');

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
(3, 8, 1, 8, 8, 1, '2021-06-24 09:35:46', '2021-06-24 09:35:46'),
(4, 10, 1, 1, 1, 1, '2021-06-24 09:39:11', '2021-06-24 09:39:11'),
(5, 10, 2, 1, 1, 1, '2021-06-24 09:39:12', '2021-06-24 09:39:12'),
(6, 9, 2, 1, 1, 1, '2021-06-24 09:45:07', '2021-06-24 09:45:07');

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
(2, 10, 1, 1, 0, NULL, '2021-06-24 13:48:20', '2021-06-24 13:48:20'),
(3, 9, 1, 1, 0, NULL, '2021-06-24 13:48:20', '2021-06-24 13:48:20');

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
(1, 'Role Management', NULL, 1, NULL, 1, 1, '2020-01-24 12:53:44', '2020-12-05 09:05:04'),
(2, 'Role Access Control', NULL, 1, NULL, 1, 1, '2020-01-24 12:54:32', '2020-01-24 12:54:32'),
(3, 'User Access Control', NULL, 1, NULL, 1, 1, '2020-01-24 12:54:59', '2020-01-24 12:54:59'),
(4, 'Module Management', NULL, 1, NULL, 1, 1, '2020-01-24 12:55:37', '2020-01-24 12:55:37'),
(5, 'Activity Management', NULL, 1, NULL, 1, 1, '2020-01-24 12:55:58', '2020-01-24 12:55:58'),
(6, 'Admin Panel User', NULL, 1, NULL, 1, 1, '2020-01-24 12:58:53', '2020-01-24 12:58:53'),
(10, 'Employee Management', NULL, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(11, 'Category', NULL, 1, NULL, 5, 5, '2021-06-21 05:27:40', '2021-06-21 05:27:40'),
(12, 'Product', NULL, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(13, 'Adjustment List', NULL, 1, NULL, 5, 5, '2021-06-21 05:49:27', '2021-06-21 05:49:27'),
(14, 'Print Barcode', NULL, 1, NULL, 5, 5, '2021-06-21 05:54:43', '2021-06-21 05:54:43'),
(15, 'Order', NULL, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(16, 'Transfer', NULL, 1, NULL, 5, 5, '2021-06-21 06:08:34', '2021-06-21 06:08:34'),
(17, 'Transfer Received', NULL, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(18, 'Production', NULL, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(19, 'Brand', NULL, 1, NULL, 5, 5, '2021-06-21 06:38:01', '2021-06-21 06:38:01'),
(20, 'Supplier', NULL, 1, NULL, 5, 5, '2021-06-21 06:42:42', '2021-06-21 06:42:42'),
(21, 'Warehouse', NULL, 1, NULL, 5, 5, '2021-06-21 06:48:15', '2021-06-21 06:48:15'),
(22, 'Unit', NULL, 1, NULL, 5, 5, '2021-06-21 06:52:14', '2021-06-21 06:52:14'),
(23, 'Setting', NULL, 1, NULL, 5, 5, '2021-06-21 06:56:06', '2021-06-21 06:56:06'),
(24, 'Email Receiver', NULL, 1, NULL, 1, 1, '2021-06-24 11:04:19', '2021-06-24 11:04:19'),
(25, 'Order Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:09:44', '2021-06-24 11:09:44'),
(26, 'Quantity Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:14:54', '2021-06-24 11:14:54'),
(27, 'Production Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:19:19', '2021-06-24 11:19:19'),
(28, 'Transfer Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:22:18', '2021-06-24 11:22:18'),
(29, 'Stock Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:25:36', '2021-06-24 11:25:36'),
(30, 'Transfer Receive Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:31:05', '2021-06-24 11:31:05'),
(31, 'Stock Register Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:33:07', '2021-06-24 11:33:07'),
(32, 'Adjustment Report', NULL, 1, NULL, 5, 5, '2021-06-24 11:35:28', '2021-06-24 11:35:28');

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
(5, 2, 2, 1, NULL, 1, 1, '2020-01-24 12:54:32', '2020-01-24 12:54:32'),
(6, 2, 4, 1, NULL, 1, 1, '2020-01-24 12:54:32', '2020-01-24 12:54:32'),
(7, 2, 3, 1, NULL, 1, 1, '2020-01-24 12:54:32', '2020-01-24 12:54:32'),
(8, 2, 1, 1, NULL, 1, 1, '2020-01-24 12:54:32', '2020-01-24 12:54:32'),
(9, 3, 2, 1, NULL, 1, 1, '2020-01-24 12:54:59', '2020-01-24 12:54:59'),
(10, 3, 4, 1, NULL, 1, 1, '2020-01-24 12:54:59', '2020-01-24 12:54:59'),
(11, 3, 3, 1, NULL, 1, 1, '2020-01-24 12:54:59', '2020-01-24 12:54:59'),
(12, 3, 1, 1, NULL, 1, 1, '2020-01-24 12:54:59', '2020-01-24 12:54:59'),
(13, 4, 2, 1, NULL, 1, 1, '2020-01-24 12:55:37', '2020-01-24 12:55:37'),
(14, 4, 4, 1, NULL, 1, 1, '2020-01-24 12:55:37', '2020-01-24 12:55:37'),
(15, 4, 3, 1, NULL, 1, 1, '2020-01-24 12:55:37', '2020-01-24 12:55:37'),
(16, 4, 1, 1, NULL, 1, 1, '2020-01-24 12:55:37', '2020-01-24 12:55:37'),
(17, 5, 2, 1, NULL, 1, 1, '2020-01-24 12:55:58', '2020-01-24 12:55:58'),
(18, 5, 4, 1, NULL, 1, 1, '2020-01-24 12:55:58', '2020-01-24 12:55:58'),
(19, 5, 3, 1, NULL, 1, 1, '2020-01-24 12:55:58', '2020-01-24 12:55:58'),
(20, 5, 1, 1, NULL, 1, 1, '2020-01-24 12:55:58', '2020-01-24 12:55:58'),
(25, 6, 5, 1, NULL, 1, 1, '2020-01-24 13:07:39', '2020-01-24 13:07:39'),
(26, 6, 2, 1, NULL, 1, 1, '2020-01-24 13:07:39', '2020-01-24 13:07:39'),
(27, 6, 4, 1, NULL, 1, 1, '2020-01-24 13:07:39', '2020-01-24 13:07:39'),
(28, 6, 6, 1, NULL, 1, 1, '2020-01-24 13:07:39', '2020-01-24 13:07:39'),
(29, 6, 3, 1, NULL, 1, 1, '2020-01-24 13:07:39', '2020-01-24 13:07:39'),
(30, 6, 1, 1, NULL, 1, 1, '2020-01-24 13:07:39', '2020-01-24 13:07:39'),
(50, 1, 2, 1, NULL, 1, 1, '2020-12-05 09:05:04', '2020-12-05 09:05:04'),
(51, 1, 4, 1, NULL, 1, 1, '2020-12-05 09:05:04', '2020-12-05 09:05:04'),
(52, 1, 3, 1, NULL, 1, 1, '2020-12-05 09:05:04', '2020-12-05 09:05:04'),
(53, 1, 1, 1, NULL, 1, 1, '2020-12-05 09:05:04', '2020-12-05 09:05:04'),
(54, 10, 5, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(55, 10, 2, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(56, 10, 4, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(57, 10, 8, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(58, 10, 3, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(59, 10, 1, 1, NULL, 1, 1, '2021-06-21 05:12:28', '2021-06-21 05:12:28'),
(60, 11, 2, 1, NULL, 5, 5, '2021-06-21 05:27:40', '2021-06-21 05:27:40'),
(61, 11, 4, 1, NULL, 5, 5, '2021-06-21 05:27:40', '2021-06-21 05:27:40'),
(62, 11, 3, 1, NULL, 5, 5, '2021-06-21 05:27:40', '2021-06-21 05:27:40'),
(63, 11, 1, 1, NULL, 5, 5, '2021-06-21 05:27:40', '2021-06-21 05:27:40'),
(64, 12, 2, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(65, 12, 4, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(66, 12, 8, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(67, 12, 3, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(68, 12, 1, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(69, 12, 7, 1, NULL, 5, 5, '2021-06-21 05:35:23', '2021-06-21 05:35:23'),
(70, 13, 2, 1, NULL, 5, 5, '2021-06-21 05:49:27', '2021-06-21 05:49:27'),
(71, 13, 4, 1, NULL, 5, 5, '2021-06-21 05:49:27', '2021-06-21 05:49:27'),
(72, 13, 3, 1, NULL, 5, 5, '2021-06-21 05:49:27', '2021-06-21 05:49:27'),
(73, 13, 1, 1, NULL, 5, 5, '2021-06-21 05:49:27', '2021-06-21 05:49:27'),
(74, 14, 7, 1, NULL, 5, 5, '2021-06-21 05:54:43', '2021-06-21 05:54:43'),
(75, 15, 2, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(76, 15, 4, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(77, 15, 8, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(78, 15, 3, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(79, 15, 1, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(80, 15, 7, 1, NULL, 5, 5, '2021-06-21 05:58:41', '2021-06-21 05:58:41'),
(86, 16, 2, 1, NULL, 5, 5, '2021-06-21 06:13:44', '2021-06-21 06:13:44'),
(87, 16, 4, 1, NULL, 5, 5, '2021-06-21 06:13:44', '2021-06-21 06:13:44'),
(88, 16, 8, 1, NULL, 5, 5, '2021-06-21 06:13:44', '2021-06-21 06:13:44'),
(89, 16, 3, 1, NULL, 5, 5, '2021-06-21 06:13:44', '2021-06-21 06:13:44'),
(90, 16, 1, 1, NULL, 5, 5, '2021-06-21 06:13:44', '2021-06-21 06:13:44'),
(91, 16, 7, 1, NULL, 5, 5, '2021-06-21 06:13:44', '2021-06-21 06:13:44'),
(92, 17, 2, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(93, 17, 4, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(94, 17, 8, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(95, 17, 3, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(96, 17, 1, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(97, 17, 7, 1, NULL, 5, 5, '2021-06-21 06:14:52', '2021-06-21 06:14:52'),
(98, 18, 2, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(99, 18, 4, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(100, 18, 8, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(101, 18, 3, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(102, 18, 1, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(103, 18, 7, 1, NULL, 5, 5, '2021-06-21 06:29:47', '2021-06-21 06:29:47'),
(104, 19, 2, 1, NULL, 5, 5, '2021-06-21 06:38:01', '2021-06-21 06:38:01'),
(105, 19, 4, 1, NULL, 5, 5, '2021-06-21 06:38:01', '2021-06-21 06:38:01'),
(106, 19, 3, 1, NULL, 5, 5, '2021-06-21 06:38:01', '2021-06-21 06:38:01'),
(107, 19, 1, 1, NULL, 5, 5, '2021-06-21 06:38:01', '2021-06-21 06:38:01'),
(108, 20, 2, 1, NULL, 5, 5, '2021-06-21 06:42:42', '2021-06-21 06:42:42'),
(109, 20, 4, 1, NULL, 5, 5, '2021-06-21 06:42:42', '2021-06-21 06:42:42'),
(110, 20, 3, 1, NULL, 5, 5, '2021-06-21 06:42:42', '2021-06-21 06:42:42'),
(111, 20, 1, 1, NULL, 5, 5, '2021-06-21 06:42:42', '2021-06-21 06:42:42'),
(112, 21, 2, 1, NULL, 5, 5, '2021-06-21 06:48:15', '2021-06-21 06:48:15'),
(113, 21, 4, 1, NULL, 5, 5, '2021-06-21 06:48:15', '2021-06-21 06:48:15'),
(114, 21, 3, 1, NULL, 5, 5, '2021-06-21 06:48:15', '2021-06-21 06:48:15'),
(115, 21, 1, 1, NULL, 5, 5, '2021-06-21 06:48:15', '2021-06-21 06:48:15'),
(116, 22, 2, 1, NULL, 5, 5, '2021-06-21 06:52:14', '2021-06-21 06:52:14'),
(117, 22, 4, 1, NULL, 5, 5, '2021-06-21 06:52:14', '2021-06-21 06:52:14'),
(118, 22, 3, 1, NULL, 5, 5, '2021-06-21 06:52:14', '2021-06-21 06:52:14'),
(119, 22, 1, 1, NULL, 5, 5, '2021-06-21 06:52:14', '2021-06-21 06:52:14'),
(120, 23, 3, 1, NULL, 5, 5, '2021-06-21 06:56:06', '2021-06-21 06:56:06'),
(121, 24, 2, 1, NULL, 1, 1, '2021-06-24 11:04:19', '2021-06-24 11:04:19'),
(122, 24, 4, 1, NULL, 1, 1, '2021-06-24 11:04:19', '2021-06-24 11:04:19'),
(123, 24, 1, 1, NULL, 1, 1, '2021-06-24 11:04:19', '2021-06-24 11:04:19'),
(124, 25, 9, 1, NULL, 5, 5, '2021-06-24 11:09:44', '2021-06-24 11:09:44'),
(125, 25, 1, 1, NULL, 5, 5, '2021-06-24 11:09:44', '2021-06-24 11:09:44'),
(126, 25, 7, 1, NULL, 5, 5, '2021-06-24 11:09:44', '2021-06-24 11:09:44'),
(127, 26, 9, 1, NULL, 5, 5, '2021-06-24 11:14:54', '2021-06-24 11:14:54'),
(128, 26, 1, 1, NULL, 5, 5, '2021-06-24 11:14:54', '2021-06-24 11:14:54'),
(129, 26, 7, 1, NULL, 5, 5, '2021-06-24 11:14:54', '2021-06-24 11:14:54'),
(130, 27, 9, 1, NULL, 5, 5, '2021-06-24 11:19:19', '2021-06-24 11:19:19'),
(131, 27, 1, 1, NULL, 5, 5, '2021-06-24 11:19:19', '2021-06-24 11:19:19'),
(132, 27, 7, 1, NULL, 5, 5, '2021-06-24 11:19:19', '2021-06-24 11:19:19'),
(133, 28, 9, 1, NULL, 5, 5, '2021-06-24 11:22:18', '2021-06-24 11:22:18'),
(134, 28, 1, 1, NULL, 5, 5, '2021-06-24 11:22:18', '2021-06-24 11:22:18'),
(135, 28, 7, 1, NULL, 5, 5, '2021-06-24 11:22:18', '2021-06-24 11:22:18'),
(136, 29, 9, 1, NULL, 5, 5, '2021-06-24 11:25:36', '2021-06-24 11:25:36'),
(137, 29, 1, 1, NULL, 5, 5, '2021-06-24 11:25:36', '2021-06-24 11:25:36'),
(138, 29, 7, 1, NULL, 5, 5, '2021-06-24 11:25:36', '2021-06-24 11:25:36'),
(139, 30, 9, 1, NULL, 5, 5, '2021-06-24 11:31:05', '2021-06-24 11:31:05'),
(140, 30, 1, 1, NULL, 5, 5, '2021-06-24 11:31:05', '2021-06-24 11:31:05'),
(141, 30, 7, 1, NULL, 5, 5, '2021-06-24 11:31:05', '2021-06-24 11:31:05'),
(142, 31, 9, 1, NULL, 5, 5, '2021-06-24 11:33:07', '2021-06-24 11:33:07'),
(143, 31, 1, 1, NULL, 5, 5, '2021-06-24 11:33:07', '2021-06-24 11:33:07'),
(144, 31, 7, 1, NULL, 5, 5, '2021-06-24 11:33:07', '2021-06-24 11:33:07'),
(145, 32, 9, 1, NULL, 5, 5, '2021-06-24 11:35:28', '2021-06-24 11:35:28'),
(146, 32, 1, 1, NULL, 5, 5, '2021-06-24 11:35:28', '2021-06-24 11:35:28'),
(147, 32, 7, 1, NULL, 5, 5, '2021-06-24 11:35:28', '2021-06-24 11:35:28');

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
(2203, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2204, 1, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2205, 1, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2206, 1, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2207, 2, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2208, 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2209, 2, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2210, 2, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2211, 3, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2212, 3, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2213, 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2214, 3, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2215, 4, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2216, 4, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2217, 4, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2218, 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2219, 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2220, 5, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2221, 5, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2222, 5, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2223, 6, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2224, 6, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2225, 6, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2226, 6, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2227, 6, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(2228, 6, 1, 6, 1, NULL, NULL, NULL, NULL, NULL),
(2229, 10, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2230, 10, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2231, 10, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2232, 10, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2233, 10, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(2234, 10, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2235, 11, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2236, 11, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2237, 11, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2238, 11, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2239, 12, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2240, 12, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2241, 12, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2242, 12, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2243, 12, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2244, 12, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2245, 13, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2246, 13, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2247, 13, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2248, 13, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2249, 14, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2250, 15, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2251, 15, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2252, 15, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2253, 15, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2254, 15, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2255, 15, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2256, 16, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2257, 16, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2258, 16, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2259, 16, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2260, 16, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2261, 16, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2262, 17, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2263, 17, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2264, 17, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2265, 17, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2266, 17, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2267, 17, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2268, 18, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2269, 18, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2270, 18, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2271, 18, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2272, 18, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2273, 18, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2274, 19, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2275, 19, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2276, 19, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2277, 19, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2278, 20, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2279, 20, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2280, 20, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2281, 20, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2282, 21, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2283, 21, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2284, 21, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2285, 21, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2286, 22, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2287, 22, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2288, 22, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2289, 22, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2290, 23, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2291, 24, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2292, 24, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2293, 24, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2294, 25, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2295, 25, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2296, 25, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2297, 26, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2298, 26, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2299, 26, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2300, 27, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2301, 27, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2302, 27, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2303, 28, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2304, 28, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2305, 28, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2306, 29, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2307, 29, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2308, 29, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2309, 30, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2310, 30, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2311, 30, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2312, 31, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2313, 31, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2314, 31, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2315, 32, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2316, 32, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2317, 32, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2318, 1, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2319, 1, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2320, 1, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2321, 1, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2322, 2, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2323, 2, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2324, 2, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2325, 2, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2326, 3, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2327, 3, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2328, 3, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2329, 3, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2330, 4, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2331, 4, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2332, 4, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2333, 4, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2334, 5, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2335, 5, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2336, 5, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2337, 5, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2338, 6, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2339, 6, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2340, 6, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2341, 6, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2342, 10, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2343, 10, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2344, 10, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2345, 10, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2346, 10, 2, 5, 1, NULL, NULL, NULL, NULL, NULL),
(2347, 10, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2348, 11, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2349, 11, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2350, 11, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2351, 11, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2352, 12, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2353, 12, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2354, 12, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2355, 12, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2356, 12, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2357, 12, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2358, 13, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2359, 13, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2360, 13, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2361, 13, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2362, 14, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2363, 15, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2364, 15, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2365, 15, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2366, 15, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2367, 15, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2368, 15, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2369, 16, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2370, 16, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2371, 16, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2372, 16, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2373, 16, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2374, 16, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2375, 17, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2376, 17, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2377, 17, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2378, 17, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2379, 17, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2380, 17, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2381, 18, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2382, 18, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2383, 18, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2384, 18, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2385, 18, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2386, 18, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(2387, 19, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2388, 19, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2389, 19, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2390, 19, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2391, 20, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2392, 20, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2393, 20, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2394, 20, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2395, 21, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2396, 21, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2397, 21, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2398, 21, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2399, 22, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2400, 22, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2401, 22, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2402, 22, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2403, 23, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(2404, 24, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2405, 24, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(2406, 24, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(2407, 25, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2408, 25, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2409, 25, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2410, 26, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2411, 26, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2412, 26, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2413, 27, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2414, 27, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2415, 27, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2416, 28, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2417, 28, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2418, 28, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2419, 29, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2420, 29, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2421, 29, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2422, 30, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2423, 30, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2424, 30, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2425, 31, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2426, 31, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2427, 31, 2, 9, 1, NULL, NULL, NULL, NULL, NULL),
(2428, 32, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(2429, 32, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(2430, 32, 2, 9, 1, NULL, NULL, NULL, NULL, NULL);

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
(6120, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6121, 1, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6122, 1, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6123, 1, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6124, 2, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6125, 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6126, 2, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6127, 2, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6128, 3, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6129, 3, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6130, 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6131, 3, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6132, 4, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6133, 4, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6134, 4, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6135, 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6136, 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6137, 5, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6138, 5, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6139, 5, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6140, 6, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6141, 6, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6142, 6, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6143, 6, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6144, 6, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(6145, 6, 1, 6, 1, NULL, NULL, NULL, NULL, NULL),
(6146, 10, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6147, 10, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6148, 10, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6149, 10, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6150, 10, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(6151, 10, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6152, 11, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6153, 11, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6154, 11, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6155, 11, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6156, 12, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6157, 12, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6158, 12, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6159, 12, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6160, 12, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6161, 12, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6162, 13, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6163, 13, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6164, 13, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6165, 13, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6166, 14, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6167, 15, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6168, 15, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6169, 15, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6170, 15, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6171, 15, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6172, 15, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6173, 16, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6174, 16, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6175, 16, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6176, 16, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6177, 16, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6178, 16, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6179, 17, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6180, 17, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6181, 17, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6182, 17, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6183, 17, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6184, 17, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6185, 18, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6186, 18, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6187, 18, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6188, 18, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6189, 18, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6190, 18, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6191, 19, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6192, 19, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6193, 19, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6194, 19, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6195, 20, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6196, 20, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6197, 20, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6198, 20, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6199, 21, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6200, 21, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6201, 21, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6202, 21, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6203, 22, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6204, 22, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6205, 22, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6206, 22, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6207, 23, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6208, 24, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6209, 24, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6210, 24, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6211, 25, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6212, 25, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6213, 25, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6214, 26, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6215, 26, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6216, 26, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6217, 27, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6218, 27, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6219, 27, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6220, 28, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6221, 28, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6222, 28, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6223, 29, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6224, 29, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6225, 29, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6226, 30, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6227, 30, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6228, 30, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6229, 31, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6230, 31, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6231, 31, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6232, 32, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6233, 32, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6234, 32, 1, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6235, 1, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6236, 1, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6237, 1, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6238, 1, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6239, 1, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6240, 1, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6241, 1, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6242, 1, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6243, 1, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6244, 1, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6245, 1, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6246, 1, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6247, 1, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6248, 1, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6249, 1, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6250, 1, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6251, 2, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6252, 2, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6253, 2, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6254, 2, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6255, 2, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6256, 2, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6257, 2, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6258, 2, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6259, 2, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6260, 2, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6261, 2, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6262, 2, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6263, 2, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6264, 2, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6265, 2, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6266, 2, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6267, 3, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6268, 3, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6269, 3, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6270, 3, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6271, 3, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6272, 3, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6273, 3, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6274, 3, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6275, 3, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6276, 3, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6277, 3, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6278, 3, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6279, 3, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6280, 3, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6281, 3, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6282, 3, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6283, 4, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6284, 4, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6285, 4, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6286, 4, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6287, 4, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6288, 4, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6289, 4, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6290, 4, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6291, 4, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6292, 4, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6293, 4, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6294, 4, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6295, 4, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6296, 4, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6297, 4, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6298, 4, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6299, 5, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6300, 5, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6301, 5, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6302, 5, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6303, 5, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6304, 5, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6305, 5, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6306, 5, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6307, 5, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6308, 5, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6309, 5, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6310, 5, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6311, 5, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6312, 5, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6313, 5, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6314, 5, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6315, 6, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6316, 6, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6317, 6, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6318, 6, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6319, 6, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6320, 6, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6321, 6, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6322, 6, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6323, 6, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6324, 6, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6325, 6, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6326, 6, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6327, 6, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6328, 6, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6329, 6, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6330, 6, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6331, 10, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6332, 10, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6333, 10, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6334, 10, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6335, 10, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6336, 10, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6337, 10, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6338, 10, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6339, 10, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6340, 10, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6341, 10, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6342, 10, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6343, 10, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6344, 10, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6345, 10, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6346, 10, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6347, 10, 5, 5, 1, NULL, NULL, NULL, NULL, NULL),
(6348, 10, 8, 5, 1, NULL, NULL, NULL, NULL, NULL),
(6349, 10, 9, 5, 1, NULL, NULL, NULL, NULL, NULL),
(6350, 10, 10, 5, 1, NULL, NULL, NULL, NULL, NULL),
(6351, 10, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6352, 10, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6353, 10, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6354, 10, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6355, 11, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6356, 11, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6357, 11, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6358, 11, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6359, 11, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6360, 11, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6361, 11, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6362, 11, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6363, 11, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6364, 11, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6365, 11, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6366, 11, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6367, 11, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6368, 11, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6369, 11, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6370, 11, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6371, 12, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6372, 12, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6373, 12, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6374, 12, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6375, 12, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6376, 12, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6377, 12, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6378, 12, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6379, 12, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6380, 12, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6381, 12, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6382, 12, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6383, 12, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6384, 12, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6385, 12, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6386, 12, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6387, 12, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6388, 12, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6389, 12, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6390, 12, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6391, 12, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6392, 12, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6393, 12, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6394, 12, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6395, 13, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6396, 13, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6397, 13, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6398, 13, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6399, 13, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6400, 13, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6401, 13, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6402, 13, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6403, 13, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6404, 13, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6405, 13, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6406, 13, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6407, 13, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6408, 13, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6409, 13, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6410, 13, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6411, 14, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6412, 14, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6413, 14, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6414, 14, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6415, 15, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6416, 15, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6417, 15, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6418, 15, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6419, 15, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6420, 15, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6421, 15, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6422, 15, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6423, 15, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6424, 15, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6425, 15, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6426, 15, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6427, 15, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6428, 15, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6429, 15, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6430, 15, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6431, 15, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6432, 15, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6433, 15, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6434, 15, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6435, 15, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6436, 15, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6437, 15, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6438, 15, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6439, 16, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6440, 16, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6441, 16, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6442, 16, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6443, 16, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6444, 16, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6445, 16, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6446, 16, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6447, 16, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6448, 16, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6449, 16, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6450, 16, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6451, 16, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6452, 16, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6453, 16, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6454, 16, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6455, 16, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6456, 16, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6457, 16, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6458, 16, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6459, 16, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6460, 16, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6461, 16, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6462, 16, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6463, 17, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6464, 17, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6465, 17, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6466, 17, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6467, 17, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6468, 17, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6469, 17, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6470, 17, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6471, 17, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6472, 17, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6473, 17, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6474, 17, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6475, 17, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6476, 17, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6477, 17, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6478, 17, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6479, 17, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6480, 17, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6481, 17, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6482, 17, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6483, 17, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6484, 17, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6485, 17, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6486, 17, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6487, 18, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6488, 18, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6489, 18, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6490, 18, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6491, 18, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6492, 18, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6493, 18, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6494, 18, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6495, 18, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6496, 18, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6497, 18, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6498, 18, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6499, 18, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6500, 18, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6501, 18, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6502, 18, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6503, 18, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6504, 18, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6505, 18, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6506, 18, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6507, 18, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6508, 18, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6509, 18, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6510, 18, 10, 8, 1, NULL, NULL, NULL, NULL, NULL),
(6511, 19, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6512, 19, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6513, 19, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6514, 19, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6515, 19, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6516, 19, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6517, 19, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6518, 19, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6519, 19, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6520, 19, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6521, 19, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6522, 19, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6523, 19, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6524, 19, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6525, 19, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6526, 19, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6527, 20, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6528, 20, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6529, 20, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6530, 20, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6531, 20, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6532, 20, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6533, 20, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6534, 20, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6535, 20, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6536, 20, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6537, 20, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6538, 20, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6539, 20, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6540, 20, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6541, 20, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6542, 20, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6543, 21, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6544, 21, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6545, 21, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6546, 21, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6547, 21, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6548, 21, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6549, 21, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6550, 21, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6551, 21, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6552, 21, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6553, 21, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6554, 21, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6555, 21, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6556, 21, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6557, 21, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6558, 21, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6559, 22, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6560, 22, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6561, 22, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6562, 22, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6563, 22, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6564, 22, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6565, 22, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6566, 22, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6567, 22, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6568, 22, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6569, 22, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6570, 22, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6571, 22, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6572, 22, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6573, 22, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6574, 22, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6575, 23, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6576, 23, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6577, 23, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6578, 23, 10, 3, 1, NULL, NULL, NULL, NULL, NULL),
(6579, 24, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6580, 24, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6581, 24, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6582, 24, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6583, 24, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6584, 24, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6585, 24, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6586, 24, 10, 2, 1, NULL, NULL, NULL, NULL, NULL),
(6587, 24, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6588, 24, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6589, 24, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6590, 24, 10, 4, 1, NULL, NULL, NULL, NULL, NULL),
(6591, 25, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6592, 25, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6593, 25, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6594, 25, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6595, 25, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6596, 25, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6597, 25, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6598, 25, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6599, 25, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6600, 25, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6601, 25, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6602, 25, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6603, 26, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6604, 26, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6605, 26, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6606, 26, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6607, 26, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6608, 26, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6609, 26, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6610, 26, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6611, 26, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6612, 26, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6613, 26, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6614, 26, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6615, 27, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6616, 27, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6617, 27, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6618, 27, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6619, 27, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6620, 27, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6621, 27, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6622, 27, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6623, 27, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6624, 27, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6625, 27, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6626, 27, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6627, 28, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6628, 28, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6629, 28, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6630, 28, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6631, 28, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6632, 28, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6633, 28, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6634, 28, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6635, 28, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6636, 28, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6637, 28, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6638, 28, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6639, 29, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6640, 29, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6641, 29, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6642, 29, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6643, 29, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6644, 29, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6645, 29, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6646, 29, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6647, 29, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6648, 29, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6649, 29, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6650, 29, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6651, 30, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6652, 30, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6653, 30, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6654, 30, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6655, 30, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6656, 30, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6657, 30, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6658, 30, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6659, 30, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6660, 30, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6661, 30, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6662, 30, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6663, 31, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6664, 31, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6665, 31, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6666, 31, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6667, 31, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6668, 31, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6669, 31, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6670, 31, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6671, 31, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6672, 31, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6673, 31, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6674, 31, 10, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6675, 32, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6676, 32, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6677, 32, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6678, 32, 10, 1, 1, NULL, NULL, NULL, NULL, NULL),
(6679, 32, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6680, 32, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6681, 32, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6682, 32, 10, 7, 1, NULL, NULL, NULL, NULL, NULL),
(6683, 32, 5, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6684, 32, 8, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6685, 32, 9, 9, 1, NULL, NULL, NULL, NULL, NULL),
(6686, 32, 10, 9, 1, NULL, NULL, NULL, NULL, NULL);

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

INSERT INTO `productions` (`id`, `production_number`, `warehouse_id`, `product_id`, `employee_id`, `produce_amount`, `waste_amount`, `unit_name`, `unit_id`, `note`, `created_by`, `updated_by`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'pr-20210624-041100', 1, 3, 8, 4900, '100.00', 'GRAM', 1, 'production', 8, 8, 1, NULL, '2021-06-24 10:11:00', '2021-06-24 10:11:36');

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
(1, 1, 1, 1, '5000.00', 'GRAM', 1, 8, 8, 0, NULL, '2021-06-24 10:11:00', '2021-06-24 10:11:00');

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
(1, 'Product 1', '6642113927', 'C39+', 1, 1, 1, 10, 45000, 0, 0, '[\"public\\/upload\\/product\\/images\\/download.jpg\"]', 'public/upload/product/files/RoiE6zEO8WcVfj8Yv9X8.png', '<p>Product details</p>', 1, NULL, 1, 8, '2021-06-24 09:26:18', '2021-06-24 10:11:00'),
(2, 'Product 2', '0204470939', 'C39+', 1, 1, 1, 30, 4000, 0, 0, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, '<p>dddd</p>', 1, NULL, 1, 1, '2021-06-24 09:46:45', '2021-06-24 09:50:46'),
(3, 'Product 3', '1329314102', 'C39+', 1, 1, 1, 50, 6000, 100, 0, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, '<p>dddd</p>', 1, NULL, 1, 8, '2021-06-24 09:50:03', '2021-06-24 10:31:28');

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
(1, 1, 2, 2000, '+', 1, 30, 60000, 2000, 1, '2021-06-24 09:50:46', '2021-06-24 09:50:46'),
(2, 2, 3, 100, '+', 1, 0, 0, 100, 1, '2021-06-24 10:12:28', '2021-06-24 10:12:28');

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
(1, 1, 1, 50000, 1, 10, 500000, 50000, 1, '2021-06-24 09:32:32', '2021-06-24 09:32:32'),
(2, 2, 2, 2000, 1, 30, 60000, 2000, 1, '2021-06-24 09:47:16', '2021-06-24 09:47:16'),
(3, 3, 3, 1000, 1, 0, 0, 1000, 1, '2021-06-24 10:30:56', '2021-06-24 10:30:56');

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
(1, 1, 1, 10000, 1, 10, 100000, 10000, 1, '2021-06-24 09:55:00', '2021-06-24 09:55:00');

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
(1, '1', 1, 35000, 0, '2021-06-24 09:34:45', '2021-06-24 10:11:00'),
(2, '2', 2, 4000, 0, '2021-06-24 09:47:16', '2021-06-24 09:50:46'),
(3, '1', 2, 10000, 0, '2021-06-24 09:55:00', '2021-06-24 09:55:00'),
(4, '3', 1, 6000, 100, '2021-06-24 10:11:37', '2021-06-24 10:30:56');

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
(1, 'order-1', 1, 1, 1, 1, 50000, 500000, 500000, 1, NULL, NULL, '2021-06-24 15:34:45', 1, NULL, 1, 1, '2021-06-24 09:32:31', '2021-06-24 09:34:45'),
(2, 'order-2', 9, 2, NULL, 1, 2000, 60000, 60000, 1, 'Note', NULL, '2021-06-24 15:47:16', 9, NULL, 9, 9, '2021-06-24 09:47:16', '2021-06-24 09:47:16'),
(3, 'order-3', 8, 1, 1, 1, 1000, 0, 0, 1, NULL, NULL, '2021-06-24 16:30:55', 8, NULL, 8, 8, '2021-06-24 10:30:55', '2021-06-24 10:30:56');

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
(1, 'Super Admin', NULL, 1, NULL, 1, '2020-01-24 12:50:33', '2020-12-05 07:05:06', 1),
(2, 'Admin', NULL, 1, NULL, 1, '2020-01-24 12:50:48', '2020-01-24 12:50:48', NULL),
(3, 'Customer', NULL, 1, NULL, 1, '2020-03-03 05:13:42', '2020-03-03 05:13:42', 1),
(4, 'Test role', NULL, 0, '2020-11-23 08:56:47', 1, '2020-11-23 08:53:06', '2020-11-23 08:56:47', 1);

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
(1, 'public/upload/site-setting/otPhjJpkiC2b4jAZABYy.png', 'public/upload/site-setting/821lt8b2T0V7ivyHno7b.png', 'thakurlemon@gmail.com', '01719287734', 'Inventory', 'Web Embed', 'Inventory', 'Inventory', 15000, 1, 1, 1, '2021-06-01 11:26:39', '2021-06-24 10:55:17');

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
(1, 'Supplier 1', '01719287734444', 'supplier1@email.com', NULL, 1, 1, 1, NULL, '2021-06-24 09:25:22', '2021-06-24 09:25:29');

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
(1, 'tr-20210624-035500', 8, 1, 2, 1, 10000, 100000, 100000, NULL, NULL, NULL, 8, 8, '2021-06-24 09:55:00', '2021-06-24 09:55:02');

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
(1, 'GRAM', 1, 'GRAM', 1, NULL, 1, 1, '2021-06-24 08:46:27', '2021-06-24 08:46:27');

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
(1, 1, 'admin', 'admin@email.com', NULL, '01682234164', 'public/upload/portfolio-pic/f0pFrHvIHOApjaNZLlKi.jpg', NULL, 0, '$2y$10$AnA/vs6uSlEhQEpIecffbuv9jBcVemoPKil8NjkZYCZyjrPSNSfEq', '2021-06-24 19:40:38', 1, NULL, 'g4MFPC59927S9gz1EnFmCXK1J3WUwEcYMFxYvoenOSvodANJlY7C9BgzFkE7', 1, 1, '2020-01-18 10:14:02', '2021-06-24 13:40:38'),
(2, 1, 'Myles Key', 'jymyjopuny@mailinator.com', NULL, '123456', 'public/upload/rofile-pic/Vty0kqzBV9o3coKVIyqI.jpg', NULL, 0, '$2y$10$lJHuiDyxiw/yq/.bfz01BeygTc9Tl0mZbAM0JS7NADJlVjXmBSsDK', NULL, 1, '2020-03-02 15:06:00', NULL, 1, 1, '2020-01-18 10:33:52', '2020-03-02 15:06:00'),
(3, 2, 'Phelan Brown', 'fynojewu@mailinator.com', NULL, '1465', 'public/upload/rofile-pic/IfhDPL9wVq1IPh6J4d4w.png', NULL, 0, '$2y$10$BvWoKwT6Toe1WgiVuxutxufuaqhUb1VXiZKaRYsSyK6TQz3NcFVge', NULL, 1, '2020-01-24 14:39:51', NULL, 1, 1, '2020-01-18 10:37:14', '2020-01-24 14:39:51'),
(4, 2, 'Charlotte Villarreal', 'cusesohyko@mailinator.com', NULL, '12456', 'public/upload/rofile-pic/bcE7Fewm45VV3WtuoL0v.png', NULL, 0, '$2y$10$2aF8MBYraBpAzxw/ye2bXuKieJp6FoBuVQBHL6YHbSN1CIouTQf9C', NULL, 1, '2020-03-02 15:06:04', NULL, 1, 1, '2020-01-18 10:48:36', '2020-03-02 15:06:04'),
(5, 2, 'miraj', 'miraj@email.com', NULL, '1465456', 'public/upload/portfolio-pic/vTxAhtmmbJki2ecWr083.png', NULL, 0, '$2y$10$37DUfPgJ6HA/.L/zkrX6h.VXEWNqnU4kVqCBIhuDl5vjeYMSVpr9W', '2021-06-24 15:37:59', 1, NULL, NULL, 1, 1, '2020-03-02 15:06:56', '2021-06-24 09:37:59'),
(6, 1, 'Juliet Harrison', 'kazyx@mailinator.com', NULL, '123456874', NULL, NULL, 0, '$2y$10$alGTDKUcytKoLnUFYyOWmer7EoXknY1911HsMCa496lq2LYV13JDK', NULL, 1, '2020-11-23 07:55:39', NULL, 1, 1, '2020-11-23 07:53:19', '2020-11-23 07:55:39'),
(7, 1, 'Tara Erickson', 'gobimohyja@mailinator.com', NULL, 'U146545', 'public/upload/portfolio-pic/sydBo3dqmxqmFgaRT3u3.png', NULL, 0, '$2y$10$qgZrvHAaoziTx9EsRQKyN.RDRELo3StfBHsmTajQFOAyQ0/o/W1n2', NULL, 1, '2020-11-23 07:56:55', NULL, 1, 1, '2020-11-23 07:56:49', '2020-11-23 07:56:55'),
(8, 2, 'warehouse1', 'warehouse1@email.com', NULL, '01876543321', NULL, NULL, 1, '$2y$10$iHA7Tj16AysbnWxD9ZHauuSd/uwX4aP6/ow.BQel0TFYDabhsTFLW', '2021-06-24 19:10:49', 1, NULL, NULL, 1, 1, '2021-06-18 13:03:20', '2021-06-24 13:10:49'),
(9, 2, 'warehouse2', 'warehouse2@email.com', NULL, '01719287738', NULL, NULL, 1, '$2y$10$Y6lDLVqdqA1niI8g.kJrru0v20CpNKdN0JYBHnbg6ftSdOwycBkz.', '2021-06-24 15:44:25', 1, NULL, NULL, 1, 1, '2021-06-18 13:03:50', '2021-06-24 09:44:25'),
(10, 2, 'Lemon', 'lemon@email.com', NULL, '01876543325', NULL, NULL, 1, '$2y$10$AkQVcHqQHL9OHGfksrE.UeMbmelLcmXv7OSEi7Ba3Nvl1sY.eIE0i', '2021-06-24 19:10:32', 1, NULL, NULL, 1, 1, '2021-06-24 09:15:00', '2021-06-24 13:10:32');

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
(1, 'Warehouse 1', 'warehouse1@email.com', '01876543321', 'Dhaka', 1, NULL, 1, 1, '2021-06-24 08:47:26', '2021-06-24 08:47:26'),
(2, 'Warehouse 2', 'warehouse2@email.com', '01682234164', 'Dhaka', 1, NULL, 1, 1, '2021-06-24 08:47:49', '2021-06-24 08:47:49');

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `module_to_activities`
--
ALTER TABLE `module_to_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `module_to_roles`
--
ALTER TABLE `module_to_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2431;

--
-- AUTO_INCREMENT for table `module_to_users`
--
ALTER TABLE `module_to_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6687;

--
-- AUTO_INCREMENT for table `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `production_use_products`
--
ALTER TABLE `production_use_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
