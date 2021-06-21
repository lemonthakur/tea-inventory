/*
SQLyog Enterprise v13.1.1 (64 bit)
MySQL - 10.4.10-MariaDB : Database - tea_inventory
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `activities` */

DROP TABLE IF EXISTS `activities`;

CREATE TABLE `activities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `activities` */

insert  into `activities`(`id`,`name`,`description`,`created_by`,`updated_by`,`status`,`deleted_at`,`created_at`,`updated_at`) values 
(1,'Index','Index of module',1,1,1,NULL,'2020-01-24 18:52:00','2020-12-05 15:32:13'),
(2,'Create',NULL,1,1,1,NULL,'2020-01-24 18:52:10','2020-01-24 18:52:10'),
(3,'Edit',NULL,1,1,1,NULL,'2020-01-24 18:52:20','2020-03-02 21:23:32'),
(4,'Delete',NULL,1,1,1,NULL,'2020-01-24 18:52:30','2020-01-24 18:52:30'),
(5,'Change password',NULL,1,1,1,NULL,'2020-01-24 18:52:39','2020-01-24 18:52:39'),
(6,'Password reset',NULL,1,1,1,NULL,'2020-01-24 18:52:50','2020-01-24 18:52:50'),
(7,'Print',NULL,1,1,1,NULL,'2020-01-24 18:53:01','2020-01-24 18:53:01'),
(8,'Details',NULL,1,1,1,NULL,'2020-01-24 18:53:12','2020-01-24 18:53:12');

/*Table structure for table `brands` */

DROP TABLE IF EXISTS `brands`;

CREATE TABLE `brands` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;

/*Data for the table `brands` */

insert  into `brands`(`id`,`name`,`brand_thumbnail`,`brand_mobile`,`brand_email`,`brand_representatives_name`,`address`,`description`,`brand_banner`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(128,'Brand onesss','public/upload/brand/0P2KkKfV0wGwG5ozrOvS.png','01876543321ss','admin@email.comss','Representatives Namesss','dfgsssssssssssssssssssss','sgssssssssssssss','public/upload/brand/bmhkbsYeuU5L0fBJAxjq.jpg',1,NULL,1,1,'2021-06-04 21:31:08','2021-06-04 21:42:11'),
(129,'Size','public/upload/brand/5GuEkM3zivw0Qj2VyjbT.png','01876543321','admin@email.com',NULL,'dfg',NULL,'public/upload/brand/9ARf23ehxKgegckEZJUK.png',1,'2021-06-04 21:44:16',1,1,'2021-06-04 21:43:46','2021-06-04 21:44:16');

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `categories` */

insert  into `categories`(`id`,`name`,`category_id`,`created_by`,`updated_by`,`status`,`deleted_at`,`created_at`,`updated_at`) values 
(1,'Shop',NULL,1,1,1,NULL,'2021-06-07 21:44:34','2021-06-07 21:44:34');

/*Table structure for table `employee_warhouses` */

DROP TABLE IF EXISTS `employee_warhouses`;

CREATE TABLE `employee_warhouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `warehouse_id` bigint(20) unsigned NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `employee_warhouses` */

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(22,'2014_10_12_000000_create_users_table',1),
(23,'2014_10_12_100000_create_password_resets_table',1),
(24,'2019_08_19_000000_create_failed_jobs_table',1),
(25,'2020_01_17_040304_create_activities_table',1),
(26,'2020_01_17_040924_create_modules_table',1),
(27,'2020_01_17_041254_create_module_to_activities_table',1),
(28,'2020_01_17_041749_create_module_to_roles_table',1),
(29,'2020_01_17_041946_create_module_to_users_table',1),
(30,'2020_01_17_042141_create_roles_table',1),
(31,'2020_01_18_111739_add_created_by_to_roles',1),
(41,'2021_06_01_171209_create_site_settings_table',2),
(42,'2021_06_04_135142_create_categories_table',3),
(43,'2021_06_04_150829_create_suppliers_table',3),
(44,'2021_06_05_132524_add_column_to_users_table',3);

/*Table structure for table `module_to_activities` */

DROP TABLE IF EXISTS `module_to_activities`;

CREATE TABLE `module_to_activities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `module_to_activities` */

insert  into `module_to_activities`(`id`,`module_id`,`activity_id`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(5,2,2,1,NULL,1,1,'2020-01-24 18:54:32','2020-01-24 18:54:32'),
(6,2,4,1,NULL,1,1,'2020-01-24 18:54:32','2020-01-24 18:54:32'),
(7,2,3,1,NULL,1,1,'2020-01-24 18:54:32','2020-01-24 18:54:32'),
(8,2,1,1,NULL,1,1,'2020-01-24 18:54:32','2020-01-24 18:54:32'),
(9,3,2,1,NULL,1,1,'2020-01-24 18:54:59','2020-01-24 18:54:59'),
(10,3,4,1,NULL,1,1,'2020-01-24 18:54:59','2020-01-24 18:54:59'),
(11,3,3,1,NULL,1,1,'2020-01-24 18:54:59','2020-01-24 18:54:59'),
(12,3,1,1,NULL,1,1,'2020-01-24 18:54:59','2020-01-24 18:54:59'),
(13,4,2,1,NULL,1,1,'2020-01-24 18:55:37','2020-01-24 18:55:37'),
(14,4,4,1,NULL,1,1,'2020-01-24 18:55:37','2020-01-24 18:55:37'),
(15,4,3,1,NULL,1,1,'2020-01-24 18:55:37','2020-01-24 18:55:37'),
(16,4,1,1,NULL,1,1,'2020-01-24 18:55:37','2020-01-24 18:55:37'),
(17,5,2,1,NULL,1,1,'2020-01-24 18:55:58','2020-01-24 18:55:58'),
(18,5,4,1,NULL,1,1,'2020-01-24 18:55:58','2020-01-24 18:55:58'),
(19,5,3,1,NULL,1,1,'2020-01-24 18:55:58','2020-01-24 18:55:58'),
(20,5,1,1,NULL,1,1,'2020-01-24 18:55:58','2020-01-24 18:55:58'),
(25,6,5,1,NULL,1,1,'2020-01-24 19:07:39','2020-01-24 19:07:39'),
(26,6,2,1,NULL,1,1,'2020-01-24 19:07:39','2020-01-24 19:07:39'),
(27,6,4,1,NULL,1,1,'2020-01-24 19:07:39','2020-01-24 19:07:39'),
(28,6,6,1,NULL,1,1,'2020-01-24 19:07:39','2020-01-24 19:07:39'),
(29,6,3,1,NULL,1,1,'2020-01-24 19:07:39','2020-01-24 19:07:39'),
(30,6,1,1,NULL,1,1,'2020-01-24 19:07:39','2020-01-24 19:07:39'),
(50,1,2,1,NULL,1,1,'2020-12-05 15:05:04','2020-12-05 15:05:04'),
(51,1,4,1,NULL,1,1,'2020-12-05 15:05:04','2020-12-05 15:05:04'),
(52,1,3,1,NULL,1,1,'2020-12-05 15:05:04','2020-12-05 15:05:04'),
(53,1,1,1,NULL,1,1,'2020-12-05 15:05:04','2020-12-05 15:05:04');

/*Table structure for table `module_to_roles` */

DROP TABLE IF EXISTS `module_to_roles`;

CREATE TABLE `module_to_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `module_to_roles` */

insert  into `module_to_roles`(`id`,`module_id`,`role_id`,`activity_id`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(238,1,1,1,1,NULL,NULL,NULL,NULL,NULL),
(239,1,1,2,1,NULL,NULL,NULL,NULL,NULL),
(240,1,1,3,1,NULL,NULL,NULL,NULL,NULL),
(241,1,1,4,1,NULL,NULL,NULL,NULL,NULL),
(242,2,1,1,1,NULL,NULL,NULL,NULL,NULL),
(243,2,1,2,1,NULL,NULL,NULL,NULL,NULL),
(244,2,1,3,1,NULL,NULL,NULL,NULL,NULL),
(245,2,1,4,1,NULL,NULL,NULL,NULL,NULL),
(246,3,1,1,1,NULL,NULL,NULL,NULL,NULL),
(247,3,1,2,1,NULL,NULL,NULL,NULL,NULL),
(248,3,1,3,1,NULL,NULL,NULL,NULL,NULL),
(249,3,1,4,1,NULL,NULL,NULL,NULL,NULL),
(250,4,1,1,1,NULL,NULL,NULL,NULL,NULL),
(251,4,1,2,1,NULL,NULL,NULL,NULL,NULL),
(252,4,1,3,1,NULL,NULL,NULL,NULL,NULL),
(253,4,1,4,1,NULL,NULL,NULL,NULL,NULL),
(254,5,1,1,1,NULL,NULL,NULL,NULL,NULL),
(255,5,1,2,1,NULL,NULL,NULL,NULL,NULL),
(256,5,1,3,1,NULL,NULL,NULL,NULL,NULL),
(257,5,1,4,1,NULL,NULL,NULL,NULL,NULL),
(258,6,1,1,1,NULL,NULL,NULL,NULL,NULL),
(259,6,1,2,1,NULL,NULL,NULL,NULL,NULL),
(260,6,1,3,1,NULL,NULL,NULL,NULL,NULL),
(261,6,1,4,1,NULL,NULL,NULL,NULL,NULL),
(262,6,1,5,1,NULL,NULL,NULL,NULL,NULL),
(263,6,1,6,1,NULL,NULL,NULL,NULL,NULL),
(264,1,2,1,1,NULL,NULL,NULL,NULL,NULL),
(265,1,2,2,1,NULL,NULL,NULL,NULL,NULL),
(266,1,2,3,1,NULL,NULL,NULL,NULL,NULL),
(267,1,2,4,1,NULL,NULL,NULL,NULL,NULL),
(268,2,2,1,1,NULL,NULL,NULL,NULL,NULL),
(269,2,2,2,1,NULL,NULL,NULL,NULL,NULL),
(270,2,2,3,1,NULL,NULL,NULL,NULL,NULL),
(271,2,2,4,1,NULL,NULL,NULL,NULL,NULL),
(272,3,2,1,1,NULL,NULL,NULL,NULL,NULL),
(273,3,2,2,1,NULL,NULL,NULL,NULL,NULL),
(274,3,2,3,1,NULL,NULL,NULL,NULL,NULL),
(275,3,2,4,1,NULL,NULL,NULL,NULL,NULL),
(276,4,2,1,1,NULL,NULL,NULL,NULL,NULL),
(277,4,2,2,1,NULL,NULL,NULL,NULL,NULL),
(278,4,2,3,1,NULL,NULL,NULL,NULL,NULL),
(279,4,2,4,1,NULL,NULL,NULL,NULL,NULL),
(280,5,2,1,1,NULL,NULL,NULL,NULL,NULL),
(281,5,2,2,1,NULL,NULL,NULL,NULL,NULL),
(282,5,2,3,1,NULL,NULL,NULL,NULL,NULL),
(283,5,2,4,1,NULL,NULL,NULL,NULL,NULL),
(284,6,2,1,1,NULL,NULL,NULL,NULL,NULL),
(285,6,2,2,1,NULL,NULL,NULL,NULL,NULL),
(286,6,2,3,1,NULL,NULL,NULL,NULL,NULL),
(287,6,2,4,1,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `module_to_users` */

DROP TABLE IF EXISTS `module_to_users`;

CREATE TABLE `module_to_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=435 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `module_to_users` */

insert  into `module_to_users`(`id`,`module_id`,`user_id`,`activity_id`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(130,1,2,1,1,NULL,NULL,NULL,NULL,NULL),
(132,1,2,2,1,NULL,NULL,NULL,NULL,NULL),
(134,1,2,3,1,NULL,NULL,NULL,NULL,NULL),
(136,1,2,4,1,NULL,NULL,NULL,NULL,NULL),
(138,2,2,1,1,NULL,NULL,NULL,NULL,NULL),
(140,2,2,2,1,NULL,NULL,NULL,NULL,NULL),
(142,2,2,3,1,NULL,NULL,NULL,NULL,NULL),
(144,2,2,4,1,NULL,NULL,NULL,NULL,NULL),
(146,3,2,1,1,NULL,NULL,NULL,NULL,NULL),
(148,3,2,2,1,NULL,NULL,NULL,NULL,NULL),
(150,3,2,3,1,NULL,NULL,NULL,NULL,NULL),
(152,3,2,4,1,NULL,NULL,NULL,NULL,NULL),
(154,4,2,1,1,NULL,NULL,NULL,NULL,NULL),
(156,4,2,2,1,NULL,NULL,NULL,NULL,NULL),
(158,4,2,3,1,NULL,NULL,NULL,NULL,NULL),
(160,4,2,4,1,NULL,NULL,NULL,NULL,NULL),
(162,5,2,1,1,NULL,NULL,NULL,NULL,NULL),
(164,5,2,2,1,NULL,NULL,NULL,NULL,NULL),
(166,5,2,3,1,NULL,NULL,NULL,NULL,NULL),
(168,5,2,4,1,NULL,NULL,NULL,NULL,NULL),
(170,6,2,1,1,NULL,NULL,NULL,NULL,NULL),
(172,6,2,2,1,NULL,NULL,NULL,NULL,NULL),
(174,6,2,3,1,NULL,NULL,NULL,NULL,NULL),
(176,6,2,4,1,NULL,NULL,NULL,NULL,NULL),
(178,7,2,1,1,NULL,NULL,NULL,NULL,NULL),
(180,7,2,2,1,NULL,NULL,NULL,NULL,NULL),
(182,7,2,3,1,NULL,NULL,NULL,NULL,NULL),
(184,7,2,4,1,NULL,NULL,NULL,NULL,NULL),
(345,1,5,1,1,NULL,NULL,NULL,NULL,NULL),
(346,1,5,2,1,NULL,NULL,NULL,NULL,NULL),
(347,1,5,3,1,NULL,NULL,NULL,NULL,NULL),
(348,1,5,4,1,NULL,NULL,NULL,NULL,NULL),
(349,2,5,1,1,NULL,NULL,NULL,NULL,NULL),
(350,2,5,2,1,NULL,NULL,NULL,NULL,NULL),
(351,2,5,3,1,NULL,NULL,NULL,NULL,NULL),
(352,2,5,4,1,NULL,NULL,NULL,NULL,NULL),
(353,3,5,1,1,NULL,NULL,NULL,NULL,NULL),
(354,3,5,2,1,NULL,NULL,NULL,NULL,NULL),
(355,3,5,3,1,NULL,NULL,NULL,NULL,NULL),
(356,3,5,4,1,NULL,NULL,NULL,NULL,NULL),
(357,4,5,1,1,NULL,NULL,NULL,NULL,NULL),
(358,4,5,2,1,NULL,NULL,NULL,NULL,NULL),
(359,4,5,3,1,NULL,NULL,NULL,NULL,NULL),
(360,4,5,4,1,NULL,NULL,NULL,NULL,NULL),
(361,5,5,1,1,NULL,NULL,NULL,NULL,NULL),
(362,5,5,2,1,NULL,NULL,NULL,NULL,NULL),
(363,5,5,3,1,NULL,NULL,NULL,NULL,NULL),
(364,5,5,4,1,NULL,NULL,NULL,NULL,NULL),
(365,6,5,1,1,NULL,NULL,NULL,NULL,NULL),
(366,6,5,2,1,NULL,NULL,NULL,NULL,NULL),
(367,6,5,3,1,NULL,NULL,NULL,NULL,NULL),
(368,6,5,4,1,NULL,NULL,NULL,NULL,NULL),
(411,1,1,1,1,NULL,NULL,NULL,NULL,NULL),
(412,1,1,2,1,NULL,NULL,NULL,NULL,NULL),
(413,1,1,3,1,NULL,NULL,NULL,NULL,NULL),
(414,1,1,4,1,NULL,NULL,NULL,NULL,NULL),
(415,2,1,1,1,NULL,NULL,NULL,NULL,NULL),
(416,2,1,2,1,NULL,NULL,NULL,NULL,NULL),
(417,2,1,3,1,NULL,NULL,NULL,NULL,NULL),
(418,2,1,4,1,NULL,NULL,NULL,NULL,NULL),
(419,3,1,1,1,NULL,NULL,NULL,NULL,NULL),
(420,3,1,2,1,NULL,NULL,NULL,NULL,NULL),
(421,3,1,3,1,NULL,NULL,NULL,NULL,NULL),
(422,3,1,4,1,NULL,NULL,NULL,NULL,NULL),
(423,4,1,1,1,NULL,NULL,NULL,NULL,NULL),
(424,4,1,2,1,NULL,NULL,NULL,NULL,NULL),
(425,4,1,3,1,NULL,NULL,NULL,NULL,NULL),
(426,4,1,4,1,NULL,NULL,NULL,NULL,NULL),
(427,5,1,1,1,NULL,NULL,NULL,NULL,NULL),
(428,5,1,2,1,NULL,NULL,NULL,NULL,NULL),
(429,5,1,3,1,NULL,NULL,NULL,NULL,NULL),
(430,5,1,4,1,NULL,NULL,NULL,NULL,NULL),
(431,6,1,1,1,NULL,NULL,NULL,NULL,NULL),
(432,6,1,2,1,NULL,NULL,NULL,NULL,NULL),
(433,6,1,3,1,NULL,NULL,NULL,NULL,NULL),
(434,6,1,4,1,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `modules` */

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `modules` */

insert  into `modules`(`id`,`name`,`description`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'Role Management',NULL,1,NULL,1,1,'2020-01-24 18:53:44','2020-12-05 15:05:04'),
(2,'Role Access Control',NULL,1,NULL,1,1,'2020-01-24 18:54:32','2020-01-24 18:54:32'),
(3,'User Access Control',NULL,1,NULL,1,1,'2020-01-24 18:54:59','2020-01-24 18:54:59'),
(4,'Module Management',NULL,1,NULL,1,1,'2020-01-24 18:55:37','2020-01-24 18:55:37'),
(5,'Activity Management',NULL,1,NULL,1,1,'2020-01-24 18:55:58','2020-01-24 18:55:58'),
(6,'Admin Panel User',NULL,1,NULL,1,1,'2020-01-24 18:58:53','2020-01-24 18:58:53');

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `product_purchases` */

DROP TABLE IF EXISTS `product_purchases`;

CREATE TABLE `product_purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `waste_qty` double DEFAULT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `total` double NOT NULL,
  `waste_total` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_purchases` */

insert  into `product_purchases`(`id`,`purchase_id`,`product_id`,`qty`,`waste_qty`,`purchase_unit_id`,`net_unit_cost`,`total`,`waste_total`,`created_at`,`updated_at`) values 
(2,1,1,600,30,2,20,1200,60,'2021-06-14 12:17:29','2021-06-14 12:17:29');

/*Table structure for table `product_transfer` */

DROP TABLE IF EXISTS `product_transfer`;

CREATE TABLE `product_transfer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `waste_qty` double DEFAULT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `total` double NOT NULL,
  `waste_total` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_transfer` */

insert  into `product_transfer`(`id`,`transfer_id`,`product_id`,`qty`,`waste_qty`,`purchase_unit_id`,`net_unit_cost`,`total`,`waste_total`,`created_at`,`updated_at`) values 
(2,1,1,200,10,2,20,400,20,'2021-06-14 12:18:26','2021-06-14 12:18:26'),
(3,2,1,100,5,2,20,200,10,'2021-06-14 12:18:47','2021-06-14 12:18:47'),
(6,3,1,100,5,2,20,200,10,'2021-06-14 12:35:32','2021-06-14 12:35:32');

/*Table structure for table `product_warehouse` */

DROP TABLE IF EXISTS `product_warehouse`;

CREATE TABLE `product_warehouse` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `waste_qty` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_warehouse` */

insert  into `product_warehouse`(`id`,`product_id`,`warehouse_id`,`qty`,`waste_qty`,`created_at`,`updated_at`) values 
(1,'1',2,400,20,'2021-06-14 12:17:13','2021-06-14 12:35:32'),
(2,'1',3,200,10,'2021-06-14 12:18:26','2021-06-14 12:35:32');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`name`,`code`,`barcode_symbology`,`brand_id`,`category_id`,`unit_id`,`product_price`,`qty`,`waste_qty`,`alert_quantity`,`image`,`file`,`product_details`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'Ball','14650861','UPCA',128,1,2,20,600,30,20,'[\"public\\/upload\\/product\\/images\\/alif_database_tempering.PNG\",\"public\\/upload\\/product\\/images\\/download.jpg\",\"public\\/upload\\/product\\/images\\/lemonLast.png\",\"public\\/upload\\/product\\/images\\/w2p06Rilwdvmta26Hmmy.jpg\"]','public/upload/product/files/uOAj7J6ND2cUieqK00PW.docx','<p>Hi</p>\r\n<p><img src=\"data:image/jpeg;base64,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\" alt=\"\" width=\"224\" height=\"224\" /></p>',2,NULL,1,1,'2021-06-09 16:57:07','2021-06-14 12:17:29'),
(2,'Bat','146508615','C39',128,1,2,50,0,0,5,'[\"public\\/upload\\/product\\/images\\/w2p06Rilwdvmta26Hmmy.jpg\",\"public\\/upload\\/product\\/images\\/Welcome-to-BRAC-Bank.png\"]','public/upload/product/files/uOAj7J6ND2cUieqK00PW.docx','<p>dffds</p>\r\n<p><img src=\"data:image/jpeg;base64,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\" alt=\"\" width=\"224\" height=\"224\" /></p>',1,NULL,5,1,'2021-06-09 20:16:07','2021-06-12 22:31:15'),
(3,'BADMINTON','5402671019','C39+',128,1,2,50,0,0,10,'[\"public\\/upload\\/product\\/images\\/zummXD2dvAtI.png\"]',NULL,'<p>ffdfas</p>',1,NULL,1,1,'2021-06-14 07:12:35','2021-06-14 07:14:14');

/*Table structure for table `purchases` */

DROP TABLE IF EXISTS `purchases`;

CREATE TABLE `purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_waste_qty` double DEFAULT NULL,
  `total_cost` double NOT NULL,
  `grand_total` double NOT NULL,
  `grand_total_waste` double DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `purchases` */

insert  into `purchases`(`id`,`reference_no`,`user_id`,`warehouse_id`,`supplier_id`,`item`,`total_qty`,`total_waste_qty`,`total_cost`,`grand_total`,`grand_total_waste`,`status`,`note`,`document`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'pr-20210614-121713',1,2,NULL,1,600,30,1200,1200,60,1,NULL,NULL,NULL,1,1,'2021-06-14 12:17:13','2021-06-14 12:17:29');

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `info` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

insert  into `roles`(`id`,`name`,`info`,`status`,`deleted_at`,`updated_by`,`created_at`,`updated_at`,`created_by`) values 
(1,'Super Admin',NULL,1,NULL,1,'2020-01-24 18:50:33','2020-12-05 13:05:06',1),
(2,'Admin',NULL,1,NULL,1,'2020-01-24 18:50:48','2020-01-24 18:50:48',NULL),
(3,'Customer',NULL,1,NULL,1,'2020-03-03 11:13:42','2020-03-03 11:13:42',1),
(4,'Test role',NULL,0,'2020-11-23 14:56:47',1,'2020-11-23 14:53:06','2020-11-23 14:56:47',1);

/*Table structure for table `site_settings` */

DROP TABLE IF EXISTS `site_settings`;

CREATE TABLE `site_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `logo` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_no` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_title` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(765) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(765) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `copy_right` varchar(765) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `site_settings` */

insert  into `site_settings`(`id`,`logo`,`icon`,`email`,`contact_no`,`site_title`,`meta_description`,`meta_keyword`,`copy_right`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'public/upload/site-setting/otPhjJpkiC2b4jAZABYy.png','public/upload/site-setting/821lt8b2T0V7ivyHno7b.png','thakurlemon@gmail.com','01719287734','Inventory','Web Embed','Inventory','Inventory',1,1,'2021-06-01 17:26:39','2021-06-10 19:49:39');

/*Table structure for table `suppliers` */

DROP TABLE IF EXISTS `suppliers`;

CREATE TABLE `suppliers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `suppliers` */

insert  into `suppliers`(`id`,`name`,`contact_no`,`email`,`address`,`created_by`,`updated_by`,`status`,`deleted_at`,`created_at`,`updated_at`) values 
(1,'BC group','01719232323','bd@email.com','Address',1,1,1,NULL,'2021-06-10 20:10:44','2021-06-10 20:10:44');

/*Table structure for table `transfers` */

DROP TABLE IF EXISTS `transfers`;

CREATE TABLE `transfers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_waste_qty` double DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `grand_total_waste` double DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `transfers` */

insert  into `transfers`(`id`,`reference_no`,`user_id`,`from_warehouse_id`,`to_warehouse_id`,`item`,`total_qty`,`total_waste_qty`,`total_cost`,`grand_total`,`grand_total_waste`,`document`,`note`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'tr-20210614-121757',1,2,3,1,200,10,400,400,20,NULL,NULL,NULL,1,1,'2021-06-14 12:17:57','2021-06-14 12:18:26'),
(2,'tr-20210614-121847',1,2,3,1,100,5,200,200,10,NULL,NULL,NULL,1,1,'2021-06-14 12:18:47','2021-06-14 12:18:47'),
(3,'tr-20210614-121910',1,3,2,1,100,5,200,200,10,'public/upload/transfer/document/EVwmT9llG7frQ1tpdQEG.jpg',NULL,NULL,1,1,'2021-06-14 12:19:10','2021-06-14 12:35:32');

/*Table structure for table `units` */

DROP TABLE IF EXISTS `units`;

CREATE TABLE `units` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` float DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `units` */

insert  into `units`(`id`,`name`,`value`,`description`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'K.G',1000,'Killo gramsss',1,NULL,1,1,'2021-06-04 20:35:56','2021-06-07 21:57:08'),
(2,'Dekagram',10,NULL,1,NULL,1,1,'2021-06-07 21:56:35','2021-06-07 21:56:35');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_contact_no_unique` (`contact_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`role_id`,`name`,`email`,`email_verified_at`,`contact_no`,`photo`,`designation`,`isEmployee`,`password`,`lastLoginTime`,`status`,`deleted_at`,`remember_token`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,1,'admin','admin@email.com',NULL,'01682234164','public/upload/portfolio-pic/f0pFrHvIHOApjaNZLlKi.jpg',NULL,0,'$2y$10$m4ZSPJRaz3C7chseDTpqCub3ZeN4Pn4IRfXFiifnbYN21hkP.4hbm','2021-06-14 09:06:14',1,NULL,'QNQCzYSMa1wWi3APsbVxzBKi1QvEEzMSAgNIBW5uA8j3kv8lepTh0APeU4Rj',1,1,'2020-01-18 16:14:02','2021-06-14 09:06:14'),
(2,1,'Myles Key','jymyjopuny@mailinator.com',NULL,'123456','public/upload/rofile-pic/Vty0kqzBV9o3coKVIyqI.jpg',NULL,0,'$2y$10$lJHuiDyxiw/yq/.bfz01BeygTc9Tl0mZbAM0JS7NADJlVjXmBSsDK',NULL,1,'2020-03-02 21:06:00',NULL,1,1,'2020-01-18 16:33:52','2020-03-02 21:06:00'),
(3,2,'Phelan Brown','fynojewu@mailinator.com',NULL,'1465','public/upload/rofile-pic/IfhDPL9wVq1IPh6J4d4w.png',NULL,0,'$2y$10$BvWoKwT6Toe1WgiVuxutxufuaqhUb1VXiZKaRYsSyK6TQz3NcFVge',NULL,1,'2020-01-24 20:39:51',NULL,1,1,'2020-01-18 16:37:14','2020-01-24 20:39:51'),
(4,2,'Charlotte Villarreal','cusesohyko@mailinator.com',NULL,'12456','public/upload/rofile-pic/bcE7Fewm45VV3WtuoL0v.png',NULL,0,'$2y$10$2aF8MBYraBpAzxw/ye2bXuKieJp6FoBuVQBHL6YHbSN1CIouTQf9C',NULL,1,'2020-03-02 21:06:04',NULL,1,1,'2020-01-18 16:48:36','2020-03-02 21:06:04'),
(5,2,'miraj','miraj@email.com',NULL,'1465456','public/upload/portfolio-pic/XpftUeX3sRprxBlP3ZeX.jpg',NULL,0,'$2y$10$gpyKgl1cj4Yh6qAEN/Z5ZOZ9Lkp75B.DgwLev./4CIHdGLG71m7iG','2021-06-09 17:30:09',1,NULL,NULL,1,5,'2020-03-02 21:06:56','2021-06-09 19:41:24'),
(6,1,'Juliet Harrison','kazyx@mailinator.com',NULL,'123456874',NULL,NULL,0,'$2y$10$alGTDKUcytKoLnUFYyOWmer7EoXknY1911HsMCa496lq2LYV13JDK',NULL,1,'2020-11-23 13:55:39',NULL,1,1,'2020-11-23 13:53:19','2020-11-23 13:55:39'),
(7,1,'Tara Erickson','gobimohyja@mailinator.com',NULL,'U146545','public/upload/portfolio-pic/sydBo3dqmxqmFgaRT3u3.png',NULL,0,'$2y$10$qgZrvHAaoziTx9EsRQKyN.RDRELo3StfBHsmTajQFOAyQ0/o/W1n2',NULL,1,'2020-11-23 13:56:55',NULL,1,1,'2020-11-23 13:56:49','2020-11-23 13:56:55');

/*Table structure for table `warehouses` */

DROP TABLE IF EXISTS `warehouses`;

CREATE TABLE `warehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_no` varchar(128) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `warehouses` */

insert  into `warehouses`(`id`,`name`,`email`,`contact_no`,`address`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(2,'Warehouse 1','warehouse1@gmail.com1','018765433211','Address 11',1,NULL,1,1,'2021-06-04 20:05:30','2021-06-13 15:26:53'),
(3,'Warehouse 2','admin@email.com','01682234164','fadfafasf',1,NULL,1,1,'2021-06-13 15:26:38','2021-06-14 10:08:41');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
