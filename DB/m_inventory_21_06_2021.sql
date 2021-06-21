-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2021 at 04:30 PM
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
(8, 'Details', NULL, 1, 1, 1, NULL, '2020-01-24 12:53:12', '2020-01-24 12:53:12');

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
(1, 'adr-20210617-095857', 3, 500, 1, 'dsf', NULL, '2021-06-17 16:22:03', 1, 1, '2021-06-17 15:58:57', '2021-06-17 16:22:03'),
(2, 'adr-20210617-102459', 3, 500, 1, NULL, 'public/upload/adjustment/document/yIB91D5ajEpBlO1zQ9M4.jpg', NULL, 1, 1, '2021-06-17 16:24:59', '2021-06-17 16:35:21'),
(3, 'adr-20210617-104130', 3, 300, 1, NULL, NULL, '2021-06-17 16:41:54', 1, 1, '2021-06-17 16:41:30', '2021-06-17 16:41:54'),
(4, 'adr-20210617-104219', 2, 300, 1, NULL, NULL, NULL, 1, 1, '2021-06-17 16:42:19', '2021-06-17 16:42:19');

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
(128, 'Brand onesss', 'public/upload/brand/0P2KkKfV0wGwG5ozrOvS.png', '01876543321ss', 'admin@email.comss', 'Representatives Namesss', 'dfgsssssssssssssssssssss', 'sgssssssssssssss', 'public/upload/brand/bmhkbsYeuU5L0fBJAxjq.jpg', 1, NULL, 1, 1, '2021-06-04 15:31:08', '2021-06-04 15:42:11'),
(129, 'Size', 'public/upload/brand/5GuEkM3zivw0Qj2VyjbT.png', '01876543321', 'admin@email.com', NULL, 'dfg', NULL, 'public/upload/brand/9ARf23ehxKgegckEZJUK.png', 1, '2021-06-04 15:44:16', 1, 1, '2021-06-04 15:43:46', '2021-06-04 15:44:16');

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
(34, 9, 3, 1, 1, 1, '2021-06-18 13:03:50', '2021-06-18 13:03:50'),
(35, 8, 2, 1, 1, 1, '2021-06-18 13:03:59', '2021-06-18 13:03:59'),
(37, 5, 2, 1, 1, 1, '2021-06-21 07:16:43', '2021-06-21 07:16:43');

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
(46, '2021_06_19_111302_create_production_use_products_table', 4);

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
(23, 'Setting', NULL, 1, NULL, 5, 5, '2021-06-21 06:56:06', '2021-06-21 06:56:06');

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
(120, 23, 3, 1, NULL, 5, 5, '2021-06-21 06:56:06', '2021-06-21 06:56:06');

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
(1144, 1, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1145, 1, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1146, 1, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1147, 1, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1148, 2, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1149, 2, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1150, 2, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1151, 2, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1152, 3, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1153, 3, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1154, 3, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1155, 3, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1156, 4, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1157, 4, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1158, 4, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1159, 4, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1160, 5, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1161, 5, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1162, 5, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1163, 5, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1164, 6, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1165, 6, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1166, 6, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1167, 6, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1168, 10, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1169, 10, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1170, 10, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1171, 10, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1172, 10, 2, 5, 1, NULL, NULL, NULL, NULL, NULL),
(1173, 10, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1174, 11, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1175, 11, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1176, 11, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1177, 11, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1178, 12, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1179, 12, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1180, 12, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1181, 12, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1182, 12, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1183, 12, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1184, 13, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1185, 13, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1186, 13, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1187, 13, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1188, 14, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1189, 15, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1190, 15, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1191, 15, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1192, 15, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1193, 15, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1194, 15, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1195, 16, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1196, 16, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1197, 16, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1198, 16, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1199, 16, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1200, 16, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1201, 17, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1202, 17, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1203, 17, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1204, 17, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1205, 17, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1206, 17, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1207, 18, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1208, 18, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1209, 18, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1210, 18, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1211, 18, 2, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1212, 18, 2, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1213, 19, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1214, 19, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1215, 19, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1216, 19, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1217, 20, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1218, 20, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1219, 20, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1220, 20, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1221, 21, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1222, 21, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1223, 21, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1224, 21, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1225, 22, 2, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1226, 22, 2, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1227, 22, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1228, 22, 2, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1229, 23, 2, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1230, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1231, 1, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1232, 1, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1233, 1, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1234, 2, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1235, 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1236, 2, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1237, 2, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1238, 3, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1239, 3, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1240, 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1241, 3, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1242, 4, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1243, 4, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1244, 4, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1245, 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1246, 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1247, 5, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1248, 5, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1249, 5, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1250, 6, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1251, 6, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1252, 6, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1253, 6, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1254, 6, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(1255, 6, 1, 6, 1, NULL, NULL, NULL, NULL, NULL),
(1256, 10, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1257, 10, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1258, 10, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1259, 10, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1260, 10, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(1261, 10, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1262, 11, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1263, 11, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1264, 11, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1265, 11, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1266, 12, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1267, 12, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1268, 12, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1269, 12, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1270, 12, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1271, 12, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1272, 13, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1273, 13, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1274, 13, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1275, 13, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1276, 14, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1277, 15, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1278, 15, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1279, 15, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1280, 15, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1281, 15, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1282, 15, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1283, 16, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1284, 16, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1285, 16, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1286, 16, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1287, 16, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1288, 16, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1289, 17, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1290, 17, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1291, 17, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1292, 17, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1293, 17, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1294, 17, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1295, 18, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1296, 18, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1297, 18, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1298, 18, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1299, 18, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(1300, 18, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(1301, 19, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1302, 19, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1303, 19, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1304, 19, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1305, 20, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1306, 20, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1307, 20, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1308, 20, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1309, 21, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1310, 21, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1311, 21, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1312, 21, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1313, 22, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(1314, 22, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(1315, 22, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(1316, 22, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(1317, 23, 1, 3, 1, NULL, NULL, NULL, NULL, NULL);

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
(3119, 1, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3120, 1, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3121, 1, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3122, 1, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3123, 1, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3124, 1, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3125, 1, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3126, 1, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3127, 1, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3128, 1, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3129, 1, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3130, 1, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3131, 2, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3132, 2, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3133, 2, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3134, 2, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3135, 2, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3136, 2, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3137, 2, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3138, 2, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3139, 2, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3140, 2, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3141, 2, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3142, 2, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3143, 3, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3144, 3, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3145, 3, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3146, 3, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3147, 3, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3148, 3, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3149, 3, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3150, 3, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3151, 3, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3152, 3, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3153, 3, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3154, 3, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3155, 4, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3156, 4, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3157, 4, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3158, 4, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3159, 4, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3160, 4, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3161, 4, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3162, 4, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3163, 4, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3164, 4, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3165, 4, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3166, 4, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3167, 5, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3168, 5, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3169, 5, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3170, 5, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3171, 5, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3172, 5, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3173, 5, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3174, 5, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3175, 5, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3176, 5, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3177, 5, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3178, 5, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3179, 6, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3180, 6, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3181, 6, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3182, 6, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3183, 6, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3184, 6, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3185, 6, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3186, 6, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3187, 6, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3188, 6, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3189, 6, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3190, 6, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3191, 10, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3192, 10, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3193, 10, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3194, 10, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3195, 10, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3196, 10, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3197, 10, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3198, 10, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3199, 10, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3200, 10, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3201, 10, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3202, 10, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3203, 10, 5, 5, 1, NULL, NULL, NULL, NULL, NULL),
(3204, 10, 8, 5, 1, NULL, NULL, NULL, NULL, NULL),
(3205, 10, 9, 5, 1, NULL, NULL, NULL, NULL, NULL),
(3206, 10, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3207, 10, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3208, 10, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3209, 11, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3210, 11, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3211, 11, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3212, 11, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3213, 11, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3214, 11, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3215, 11, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3216, 11, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3217, 11, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3218, 11, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3219, 11, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3220, 11, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3221, 12, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3222, 12, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3223, 12, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3224, 12, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3225, 12, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3226, 12, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3227, 12, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3228, 12, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3229, 12, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3230, 12, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3231, 12, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3232, 12, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3233, 12, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3234, 12, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3235, 12, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3236, 12, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3237, 12, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3238, 12, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3239, 13, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3240, 13, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3241, 13, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3242, 13, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3243, 13, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3244, 13, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3245, 13, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3246, 13, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3247, 13, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3248, 13, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3249, 13, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3250, 13, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3251, 14, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3252, 14, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3253, 14, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3254, 15, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3255, 15, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3256, 15, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3257, 15, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3258, 15, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3259, 15, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3260, 15, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3261, 15, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3262, 15, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3263, 15, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3264, 15, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3265, 15, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3266, 15, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3267, 15, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3268, 15, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3269, 15, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3270, 15, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3271, 15, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3272, 16, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3273, 16, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3274, 16, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3275, 16, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3276, 16, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3277, 16, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3278, 16, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3279, 16, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3280, 16, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3281, 16, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3282, 16, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3283, 16, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3284, 16, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3285, 16, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3286, 16, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3287, 16, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3288, 16, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3289, 16, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3290, 17, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3291, 17, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3292, 17, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3293, 17, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3294, 17, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3295, 17, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3296, 17, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3297, 17, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3298, 17, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3299, 17, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3300, 17, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3301, 17, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3302, 17, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3303, 17, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3304, 17, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3305, 17, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3306, 17, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3307, 17, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3308, 18, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3309, 18, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3310, 18, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3311, 18, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3312, 18, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3313, 18, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3314, 18, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3315, 18, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3316, 18, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3317, 18, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3318, 18, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3319, 18, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3320, 18, 5, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3321, 18, 8, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3322, 18, 9, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3323, 18, 5, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3324, 18, 8, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3325, 18, 9, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3326, 19, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3327, 19, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3328, 19, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3329, 19, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3330, 19, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3331, 19, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3332, 19, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3333, 19, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3334, 19, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3335, 19, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3336, 19, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3337, 19, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3338, 20, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3339, 20, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3340, 20, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3341, 20, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3342, 20, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3343, 20, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3344, 20, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3345, 20, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3346, 20, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3347, 20, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3348, 20, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3349, 20, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3350, 21, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3351, 21, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3352, 21, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3353, 21, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3354, 21, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3355, 21, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3356, 21, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3357, 21, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3358, 21, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3359, 21, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3360, 21, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3361, 21, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3362, 22, 5, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3363, 22, 8, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3364, 22, 9, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3365, 22, 5, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3366, 22, 8, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3367, 22, 9, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3368, 22, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3369, 22, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3370, 22, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3371, 22, 5, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3372, 22, 8, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3373, 22, 9, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3374, 23, 5, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3375, 23, 8, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3376, 23, 9, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3377, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3378, 1, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3379, 1, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3380, 1, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3381, 2, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3382, 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3383, 2, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3384, 2, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3385, 3, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3386, 3, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3387, 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3388, 3, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3389, 4, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3390, 4, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3391, 4, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3392, 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3393, 5, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3394, 5, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3395, 5, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3396, 5, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3397, 6, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3398, 6, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3399, 6, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3400, 6, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3401, 6, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(3402, 6, 1, 6, 1, NULL, NULL, NULL, NULL, NULL),
(3403, 10, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3404, 10, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3405, 10, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3406, 10, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3407, 10, 1, 5, 1, NULL, NULL, NULL, NULL, NULL),
(3408, 10, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3409, 11, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3410, 11, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3411, 11, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3412, 11, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3413, 12, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3414, 12, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3415, 12, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3416, 12, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3417, 12, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3418, 12, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3419, 13, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3420, 13, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3421, 13, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3422, 13, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3423, 14, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3424, 15, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3425, 15, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3426, 15, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3427, 15, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3428, 15, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3429, 15, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3430, 16, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3431, 16, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3432, 16, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3433, 16, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3434, 16, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3435, 16, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3436, 17, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3437, 17, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3438, 17, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3439, 17, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3440, 17, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3441, 17, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3442, 18, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3443, 18, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3444, 18, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3445, 18, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3446, 18, 1, 7, 1, NULL, NULL, NULL, NULL, NULL),
(3447, 18, 1, 8, 1, NULL, NULL, NULL, NULL, NULL),
(3448, 19, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3449, 19, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3450, 19, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3451, 19, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3452, 20, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3453, 20, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3454, 20, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3455, 20, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3456, 21, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3457, 21, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3458, 21, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3459, 21, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3460, 22, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(3461, 22, 1, 2, 1, NULL, NULL, NULL, NULL, NULL),
(3462, 22, 1, 3, 1, NULL, NULL, NULL, NULL, NULL),
(3463, 22, 1, 4, 1, NULL, NULL, NULL, NULL, NULL),
(3464, 23, 1, 3, 1, NULL, NULL, NULL, NULL, NULL);

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
  `produce_amount` decimal(10,2) DEFAULT NULL,
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
(1, 'pr-20210621-122832', 3, 1, 5, '500.00', '5.00', 'GRM', 2, NULL, 5, 1, 1, NULL, '2021-06-21 06:28:32', '2021-06-21 07:16:24'),
(2, 'pr-20210621-122922', 2, 1, 5, '50.00', '5.00', 'GRM', 2, NULL, 5, 1, 1, NULL, '2021-06-21 06:29:22', '2021-06-21 07:15:57'),
(3, 'pr-20210621-013636', NULL, 2, 5, NULL, NULL, 'GRM', 2, NULL, 5, 5, 0, NULL, '2021-06-21 07:36:36', '2021-06-21 07:36:36');

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
(1, 2, 2, 1, '5.00', 'GRM', 2, 5, 5, 0, NULL, '2021-06-21 06:29:22', '2021-06-21 06:29:22'),
(2, 3, 2, 1, '5.00', 'GRM', 2, 5, 5, 0, NULL, '2021-06-21 07:36:36', '2021-06-21 07:36:36');

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
(1, 'Ball', '14650861', 'C39+', 128, 1, 2, 20, 2735, 10, 10, '[\"public\\/upload\\/product\\/images\\/alif_database_tempering.PNG\",\"public\\/upload\\/product\\/images\\/download.jpg\",\"public\\/upload\\/product\\/images\\/lemonLast.png\",\"public\\/upload\\/product\\/images\\/w2p06Rilwdvmta26Hmmy.jpg\"]', 'public/upload/product/files/uOAj7J6ND2cUieqK00PW.docx', '<p>Hi</p>\r\n<p><img src=\"data:image/jpeg;base64,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\" alt=\"\" width=\"224\" height=\"224\" /></p>', 1, NULL, 1, 5, '2021-06-09 10:57:07', '2021-06-21 07:36:36'),
(2, 'Bat', '146508615', 'C39', 128, 1, 2, 50, 0, 0, 10, '[\"public\\/upload\\/product\\/images\\/w2p06Rilwdvmta26Hmmy.jpg\",\"public\\/upload\\/product\\/images\\/Welcome-to-BRAC-Bank.png\"]', 'public/upload/product/files/uOAj7J6ND2cUieqK00PW.docx', '<p>dffds</p>\r\n<p><img src=\"data:image/jpeg;base64,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\" alt=\"\" width=\"224\" height=\"224\" /></p>', 1, NULL, 5, 1, '2021-06-09 14:16:07', '2021-06-12 16:31:15'),
(3, 'BADMINTON', '5402671019', 'C39+', 128, 1, 2, 50, 400, 0, 10, '[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]', NULL, '<p>ffdfas</p>', 1, NULL, 1, 1, '2021-06-14 01:12:35', '2021-06-18 14:01:10');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_adjustments`
--

INSERT INTO `product_adjustments` (`id`, `adjustment_id`, `product_id`, `qty`, `action`, `created_at`, `updated_at`) VALUES
(4, 2, 1, 500, '+', '2021-06-17 16:35:21', '2021-06-17 16:35:21'),
(6, 4, 1, 300, '-', '2021-06-17 16:42:19', '2021-06-17 16:42:19');

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
(9, 2, 1, 2000, 2, 20, 40000, 2000, 1, '2021-06-17 13:50:50', '2021-06-17 13:50:50'),
(12, 3, 3, 400, 2, 50, 20000, 400, 1, '2021-06-18 14:01:10', '2021-06-18 14:01:10');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_transfer`
--

INSERT INTO `product_transfer` (`id`, `transfer_id`, `product_id`, `qty`, `purchase_unit_id`, `net_unit_cost`, `total`, `created_at`, `updated_at`) VALUES
(4, 3, 1, 200, 2, 20, 4000, '2021-06-17 15:20:12', '2021-06-17 15:20:12');

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
(1, '1', 2, 1535, 5, '2021-06-16 14:34:28', '2021-06-21 07:36:36'),
(2, '1', 3, 1200, 5, '2021-06-17 15:05:53', '2021-06-21 07:16:24'),
(3, '3', 3, 400, 0, '2021-06-18 14:01:10', '2021-06-18 14:01:10');

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
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `item`, `total_qty`, `total_cost`, `grand_total`, `status`, `note`, `document`, `deleted_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'pr-20210616-083246', 1, 2, 1, 1, 1000, 20000, 20000, 1, 'Note', 'public/upload/purchase/document/JINQfwJaD5uzHsafdbVJ.png', '2021-06-16 14:41:43', 1, 1, '2021-06-16 14:32:46', '2021-06-16 14:41:43'),
(2, 'lem-555jjjj', 1, 2, 1, 1, 2000, 40000, 40000, 1, NULL, 'public/upload/purchase/document/sTFROHqwWAsTEPz4nDGk.png', NULL, 1, 1, '2021-06-16 15:07:59', '2021-06-17 13:50:50'),
(3, 'order-2', 1, 3, 1, 1, 400, 20000, 20000, 1, NULL, NULL, NULL, 1, 1, '2021-06-18 12:50:28', '2021-06-18 14:01:10');

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
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `updated_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `logo`, `icon`, `email`, `contact_no`, `site_title`, `meta_description`, `meta_keyword`, `copy_right`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'public/upload/site-setting/otPhjJpkiC2b4jAZABYy.png', 'public/upload/site-setting/821lt8b2T0V7ivyHno7b.png', 'thakurlemon@gmail.com', '01719287734', 'Inventory', 'Web Embed', 'Inventory', 'Inventory', 1, 1, '2021-06-01 11:26:39', '2021-06-10 13:49:39');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
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
(1, 'BC group', '01719232323', 'bd@email.com', 'Address', 1, 1, 1, NULL, '2021-06-10 14:10:44', '2021-06-10 14:10:44');

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
(2, 'tr-20210617-090553', 1, 2, 3, 1, 100, 2000, 2000, NULL, 'Send to warehouse 2', '2021-06-17 15:22:12', 1, 1, '2021-06-17 15:05:53', '2021-06-17 15:22:12'),
(3, 'tr-20210617-091426', 1, 2, 3, 1, 200, 4000, 4000, 'public/upload/transfer/document/dYTQbE0bl1B8UWXBBAP2.jpg', NULL, NULL, 1, 1, '2021-06-17 15:14:26', '2021-06-17 15:20:12');

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
(1, 'K.G', 1000, 'Killo gramsss', 1, NULL, 1, 1, '2021-06-04 14:35:56', '2021-06-07 15:57:08'),
(2, 'GRM', 1, NULL, 1, NULL, 1, 1, '2021-06-07 15:56:35', '2021-06-16 14:24:52');

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
(1, 1, 'admin', 'admin@email.com', NULL, '01682234164', 'public/upload/portfolio-pic/f0pFrHvIHOApjaNZLlKi.jpg', NULL, 0, '$2y$10$m4ZSPJRaz3C7chseDTpqCub3ZeN4Pn4IRfXFiifnbYN21hkP.4hbm', '2021-06-21 13:17:18', 1, NULL, 'fGGg9WnFcALCre0FEllKwlNicWQGNuNXEV3muM9L1YlnhKfOJNiupzbTn4mT', 1, 1, '2020-01-18 10:14:02', '2021-06-21 07:17:18'),
(2, 1, 'Myles Key', 'jymyjopuny@mailinator.com', NULL, '123456', 'public/upload/rofile-pic/Vty0kqzBV9o3coKVIyqI.jpg', NULL, 0, '$2y$10$lJHuiDyxiw/yq/.bfz01BeygTc9Tl0mZbAM0JS7NADJlVjXmBSsDK', NULL, 1, '2020-03-02 15:06:00', NULL, 1, 1, '2020-01-18 10:33:52', '2020-03-02 15:06:00'),
(3, 2, 'Phelan Brown', 'fynojewu@mailinator.com', NULL, '1465', 'public/upload/rofile-pic/IfhDPL9wVq1IPh6J4d4w.png', NULL, 0, '$2y$10$BvWoKwT6Toe1WgiVuxutxufuaqhUb1VXiZKaRYsSyK6TQz3NcFVge', NULL, 1, '2020-01-24 14:39:51', NULL, 1, 1, '2020-01-18 10:37:14', '2020-01-24 14:39:51'),
(4, 2, 'Charlotte Villarreal', 'cusesohyko@mailinator.com', NULL, '12456', 'public/upload/rofile-pic/bcE7Fewm45VV3WtuoL0v.png', NULL, 0, '$2y$10$2aF8MBYraBpAzxw/ye2bXuKieJp6FoBuVQBHL6YHbSN1CIouTQf9C', NULL, 1, '2020-03-02 15:06:04', NULL, 1, 1, '2020-01-18 10:48:36', '2020-03-02 15:06:04'),
(5, 2, 'miraj', 'miraj@email.com', NULL, '1465456', 'public/upload/portfolio-pic/vTxAhtmmbJki2ecWr083.png', NULL, 0, '$2y$10$37DUfPgJ6HA/.L/zkrX6h.VXEWNqnU4kVqCBIhuDl5vjeYMSVpr9W', '2021-06-21 13:20:28', 1, NULL, NULL, 1, 1, '2020-03-02 15:06:56', '2021-06-21 07:20:28'),
(6, 1, 'Juliet Harrison', 'kazyx@mailinator.com', NULL, '123456874', NULL, NULL, 0, '$2y$10$alGTDKUcytKoLnUFYyOWmer7EoXknY1911HsMCa496lq2LYV13JDK', NULL, 1, '2020-11-23 07:55:39', NULL, 1, 1, '2020-11-23 07:53:19', '2020-11-23 07:55:39'),
(7, 1, 'Tara Erickson', 'gobimohyja@mailinator.com', NULL, 'U146545', 'public/upload/portfolio-pic/sydBo3dqmxqmFgaRT3u3.png', NULL, 0, '$2y$10$qgZrvHAaoziTx9EsRQKyN.RDRELo3StfBHsmTajQFOAyQ0/o/W1n2', NULL, 1, '2020-11-23 07:56:55', NULL, 1, 1, '2020-11-23 07:56:49', '2020-11-23 07:56:55'),
(8, 2, 'warehouse1', 'warehouse1@email.com', NULL, '01876543321', NULL, NULL, 1, '$2y$10$iHA7Tj16AysbnWxD9ZHauuSd/uwX4aP6/ow.BQel0TFYDabhsTFLW', '2021-06-18 20:01:53', 1, NULL, NULL, 1, 1, '2021-06-18 13:03:20', '2021-06-18 14:01:53'),
(9, 2, 'warehouse2', 'warehouse2@email.com', NULL, '01719287738', NULL, NULL, 1, '$2y$10$Y6lDLVqdqA1niI8g.kJrru0v20CpNKdN0JYBHnbg6ftSdOwycBkz.', '2021-06-18 19:34:23', 1, NULL, NULL, 1, 1, '2021-06-18 13:03:50', '2021-06-18 13:34:23');

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
(2, 'Warehouse 1', 'warehouse1@gmail.com1', '018765433211', 'Address 11', 1, NULL, 1, 1, '2021-06-04 14:05:30', '2021-06-13 09:26:53'),
(3, 'Warehouse 2', 'admin@email.com', '01682234164', 'fadfafasf', 1, NULL, 1, 1, '2021-06-13 09:26:38', '2021-06-14 04:08:41');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee_warhouses`
--
ALTER TABLE `employee_warhouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `module_to_activities`
--
ALTER TABLE `module_to_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `module_to_roles`
--
ALTER TABLE `module_to_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1318;

--
-- AUTO_INCREMENT for table `module_to_users`
--
ALTER TABLE `module_to_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3465;

--
-- AUTO_INCREMENT for table `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `production_use_products`
--
ALTER TABLE `production_use_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
