/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.14-MariaDB : Database - tea_inventory
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(41,'2021_06_01_171209_create_site_settings_table',2);

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
(1,'public/upload/site-setting/TYPsUmUflX99Zmg7nFxF.png','public/upload/site-setting/jFkOL0gjAkQdBc0hBVIu.png','thakurlemon@gmail.com','01719287734','Web Embed','Web Embed','Web Embed','Web Embed',1,1,'2021-06-01 17:26:39','2021-06-04 19:29:46');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `units` */

insert  into `units`(`id`,`name`,`value`,`description`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,'K.Gssss',NULL,'Killo gramsss',2,NULL,1,1,'2021-06-04 20:35:56','2021-06-04 20:41:21');

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

insert  into `users`(`id`,`role_id`,`name`,`email`,`email_verified_at`,`contact_no`,`photo`,`password`,`lastLoginTime`,`status`,`deleted_at`,`remember_token`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(1,1,'admin','admin@email.com',NULL,'01682234164','public/upload/portfolio-pic/f0pFrHvIHOApjaNZLlKi.jpg','$2y$10$m4ZSPJRaz3C7chseDTpqCub3ZeN4Pn4IRfXFiifnbYN21hkP.4hbm','2021-06-04 19:28:11',1,NULL,'RU3faioaqTW49FZQHE7dgHe9Fb4g3LUlN14lQUxqB2CAFlbLVL7oILjc9Bns',1,1,'2020-01-18 16:14:02','2021-06-04 19:28:11'),
(2,1,'Myles Key','jymyjopuny@mailinator.com',NULL,'123456','public/upload/rofile-pic/Vty0kqzBV9o3coKVIyqI.jpg','$2y$10$lJHuiDyxiw/yq/.bfz01BeygTc9Tl0mZbAM0JS7NADJlVjXmBSsDK',NULL,1,'2020-03-02 21:06:00',NULL,1,1,'2020-01-18 16:33:52','2020-03-02 21:06:00'),
(3,2,'Phelan Brown','fynojewu@mailinator.com',NULL,'1465','public/upload/rofile-pic/IfhDPL9wVq1IPh6J4d4w.png','$2y$10$BvWoKwT6Toe1WgiVuxutxufuaqhUb1VXiZKaRYsSyK6TQz3NcFVge',NULL,1,'2020-01-24 20:39:51',NULL,1,1,'2020-01-18 16:37:14','2020-01-24 20:39:51'),
(4,2,'Charlotte Villarreal','cusesohyko@mailinator.com',NULL,'12456','public/upload/rofile-pic/bcE7Fewm45VV3WtuoL0v.png','$2y$10$2aF8MBYraBpAzxw/ye2bXuKieJp6FoBuVQBHL6YHbSN1CIouTQf9C',NULL,1,'2020-03-02 21:06:04',NULL,1,1,'2020-01-18 16:48:36','2020-03-02 21:06:04'),
(5,2,'miraj','miraj@email.com',NULL,'1465456',NULL,'$2y$10$gpyKgl1cj4Yh6qAEN/Z5ZOZ9Lkp75B.DgwLev./4CIHdGLG71m7iG','2020-03-03 11:23:09',1,NULL,NULL,1,1,'2020-03-02 21:06:56','2020-03-03 11:23:09'),
(6,1,'Juliet Harrison','kazyx@mailinator.com',NULL,'123456874',NULL,'$2y$10$alGTDKUcytKoLnUFYyOWmer7EoXknY1911HsMCa496lq2LYV13JDK',NULL,1,'2020-11-23 13:55:39',NULL,1,1,'2020-11-23 13:53:19','2020-11-23 13:55:39'),
(7,1,'Tara Erickson','gobimohyja@mailinator.com',NULL,'U146545','public/upload/portfolio-pic/sydBo3dqmxqmFgaRT3u3.png','$2y$10$qgZrvHAaoziTx9EsRQKyN.RDRELo3StfBHsmTajQFOAyQ0/o/W1n2',NULL,1,'2020-11-23 13:56:55',NULL,1,1,'2020-11-23 13:56:49','2020-11-23 13:56:55');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `warehouses` */

insert  into `warehouses`(`id`,`name`,`email`,`contact_no`,`address`,`status`,`deleted_at`,`created_by`,`updated_by`,`created_at`,`updated_at`) values 
(2,'Warehouse11','warehouse1@gmail.com1','018765433211','Address 11',1,NULL,1,1,'2021-06-04 20:05:30','2021-06-04 20:20:57');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
