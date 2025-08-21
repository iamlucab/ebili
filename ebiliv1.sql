-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 20, 2025 at 08:20 PM
-- Server version: 10.6.22-MariaDB-cll-lve
-- PHP Version: 8.3.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebili`
--

-- --------------------------------------------------------

--
-- Table structure for table `benefits`
--

CREATE TABLE `benefits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `event_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `benefit_member`
--

CREATE TABLE `benefit_member` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `benefit_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Given',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cashback_logs`
--

CREATE TABLE `cashback_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `level` tinyint(3) UNSIGNED DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_in_requests`
--

CREATE TABLE `cash_in_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `proof_path` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Food', 'categories/6UMDbNbZ5NK6tvjyue2Q8GCBkfR0CMaXoIGpkMUQ.png', NULL, '2025-07-29 02:39:30'),
(2, 'Drinks', 'categories/MGvDiCXqpgas087eEG8N2AzZwhLnQ5CB6OXOvyrS.png', NULL, '2025-07-29 02:39:40'),
(3, 'Household', 'categories/o30CgFBUreWEotg15QYpKQtD0uzMccR2YwTj2nv5.png', NULL, '2025-07-29 02:39:49'),
(4, 'Apparels', 'categories/9ODgsUt34mSlRMRw6DrKT8Tna4raGoEGOdmYcvr3.png', NULL, '2025-07-29 02:39:58'),
(5, 'Health & Beauty', 'categories/bWlVRjqIFrQXSIfStvejXlzjW0knPDpwRPR7rhB5.png', NULL, '2025-07-29 02:40:22'),
(6, 'Electronics', 'categories/5fexRjogus2ROMF6CRw8x58aMtZQBtYVZ6WeDrSo.png', NULL, '2025-07-29 02:40:36'),
(7, 'Sports & Outdoors', 'categories/6g6UUtJAFSp5LNCQnlCCIoPOYCKlWgKQu8vppA3i.png', NULL, '2025-07-29 02:40:46'),
(8, 'Toys & Games', 'categories/gxXY0IOvA6jpnPEG6lL9h1Pb9q7T8Z9DrXzdgZgg.png', NULL, '2025-07-29 02:40:56'),
(9, 'Books & Stationery', 'categories/yHF5St6apCTIjJHqD0V26eG99znPCeFlt151RMTc.png', NULL, '2025-07-29 02:41:06'),
(10, 'Automotive', 'categories/ozinXurk91zigybUpBwXYaD9Kma2SbTjmSq8kEix.png', NULL, '2025-07-29 02:41:29'),
(11, 'Pets', 'categories/T5P5ETwt43jAYdGdv18UG9aIGjPigDbEv9Oz5wje.png', NULL, '2025-07-29 02:41:38'),
(12, 'Gardening', 'categories/VXBMub3idn5WHzLFUmou7znOO5Ph39ruuONNcYh0.png', NULL, '2025-07-29 02:41:47'),
(13, 'Office Supplies', 'categories/onFaqETb7wipnghzvshdtCAxrkqbXV4uM3HRzB5W.png', NULL, '2025-07-29 02:41:57'),
(14, 'Jewelry & Accessories', 'categories/310JAQK6lNoxR04BjyO11LDIUEudTWQ1CHpz4K1Z.png', NULL, '2025-07-29 02:42:07'),
(15, 'Music & Movies', 'categories/uuephG4mwAXlUir30C9D81iTiVgAkoIyZgdV2XW6.png', NULL, '2025-07-29 02:42:14'),
(16, 'Skills Directory', 'categories/kUnWkZj2mtBRFA2KqzD0kN101NdxGqGDF5hMZ6uq.png', '2025-07-22 05:15:08', '2025-07-29 02:25:20');

-- --------------------------------------------------------

--
-- Table structure for table `device_tokens`
--

CREATE TABLE `device_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `device_token` varchar(500) NOT NULL,
  `device_type` varchar(255) NOT NULL DEFAULT 'mobile',
  `platform` varchar(255) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `app_version` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `term_months` int(11) NOT NULL,
  `monthly_payment` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_payments`
--

CREATE TABLE `loan_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `due_date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `payment_method` varchar(255) DEFAULT NULL,
  `reference_number` varchar(255) DEFAULT NULL,
  `payment_proof` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `verified_at` timestamp NULL DEFAULT NULL,
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `role` enum('Admin','Staff','Member') NOT NULL DEFAULT 'Member',
  `sponsor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `voter_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `loan_eligible` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `first_name`, `middle_name`, `last_name`, `birthday`, `mobile_number`, `occupation`, `address`, `photo`, `role`, `sponsor_id`, `voter_id`, `created_at`, `updated_at`, `loan_eligible`, `status`) VALUES
(1, 'System', NULL, 'Administrator', '1990-01-01', '09177260180', 'The Actor', 'Tony Stark Tower 2, Hongkong, HK', '68a5a0602e02e.png', 'Admin', NULL, NULL, '2025-07-31 22:45:12', '2025-08-21 01:16:00', 0, 'Active'),
(2, 'Chief', 'T', 'Technology Officer', '1990-01-01', '09171234567', 'Not Specified', 'Default Address', NULL, 'Staff', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:41:02', 1, 'Active'),
(3, 'Chief', 'O', 'Operating Officer', '1990-01-01', '09171234568', 'COO', 'Tony Stark Tower 2, Hongkong, HK', NULL, 'Staff', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:30:59', 1, 'Active'),
(4, 'Chief', 'E', 'Executive Officer', '1990-01-01', '09191111111', 'Chief Executive Officer', 'Tony Stark Tower 2, Hongkong, HK', NULL, 'Member', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:42:39', 0, 'Approved'),
(5, 'Chief', 'M', 'Marketing Officer', '1990-01-01', '09181234568', 'Not Specified', 'Tony Stark Tower, Hongkong', NULL, 'Member', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:43:01', 1, 'Approved'),
(6, 'Chief', 'Branding', 'Customer Service', '1990-01-01', '09181234569', 'Not Specified', 'Tony Stark Tower 2, HK', NULL, 'Member', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:41:30', 1, 'Approved'),
(7, 'Benje', NULL, 'e-bili', '1975-02-01', '09151836162', 'Chief Marketing Officer', NULL, NULL, 'Member', 4, NULL, '2025-07-31 23:22:01', '2025-08-01 14:54:16', 0, 'Approved'),
(8, 'Lu', 'Naong', 'Cab', '1980-01-25', '09192222222', 'Atty-in-General', 'SpaceX Tower 100th Floor Mars Planet', NULL, 'Member', 9, NULL, '2025-07-31 23:23:12', '2025-08-01 14:52:06', 1, 'Approved'),
(9, 'Paul', 'James', 'Allen', '1980-02-01', '09193333333', 'Chief technology officer', NULL, NULL, 'Member', 4, NULL, '2025-07-31 23:27:06', '2025-08-09 22:17:57', 1, 'Approved'),
(10, 'Macaria', NULL, 'Opeńa', '2025-08-01', '09556778397', 'Negosyante', NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:15:39', '2025-08-01 15:15:39', 0, 'Approved'),
(11, 'Marissa', NULL, 'Labrador', '2025-08-01', '09109868673', NULL, NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:18:17', '2025-08-01 15:19:08', 0, 'Approved'),
(12, 'Lorina', NULL, 'Phuno', '2025-08-01', '09306730491', NULL, NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:22:29', '2025-08-01 15:23:14', 0, 'Approved'),
(13, 'Perla', NULL, 'Andio', '2025-08-01', '09701678140', NULL, NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:27:33', '2025-08-01 15:28:12', 0, 'Approved'),
(14, 'Jericho', NULL, 'Noveno', '2025-08-01', '09273001094', 'Leader', NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:34:26', '2025-08-01 15:34:26', 0, 'Approved'),
(15, 'MTC\'s Fruits hakes and', NULL, 'Foodhub', '2025-08-01', '09651233549', 'Merchant', NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:38:22', '2025-08-01 15:38:22', 0, 'Approved'),
(16, 'Ian Amiel', NULL, 'Santidad', '2025-08-01', '09915508102', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-01 15:41:32', '2025-08-01 15:41:32', 0, 'Approved'),
(17, 'Rhona', NULL, 'Morilla', '2025-08-01', '09126748581', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-01 15:42:44', '2025-08-01 15:42:44', 0, 'Approved'),
(18, 'Elvira', NULL, 'Rutagines', '2025-08-01', '09612019238', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-01 15:43:54', '2025-08-01 15:43:54', 0, 'Approved'),
(19, 'Jancel', 'Rivera', 'Andrade', '2007-12-09', '09703100243', NULL, NULL, NULL, 'Member', 10, NULL, '2025-08-03 00:22:16', '2025-08-03 19:35:24', 0, 'Approved'),
(20, 'Renz', 'Lim', 'Licarte', '1998-09-09', '09763632594', 'Businessman', NULL, NULL, 'Member', 8, NULL, '2025-08-03 19:37:13', '2025-08-03 19:37:13', 0, 'Approved'),
(21, 'Mary ann', 'Olbez', 'Pagas', '1982-10-25', '09264663844', NULL, NULL, NULL, 'Member', 8, NULL, '2025-08-03 19:39:36', '2025-08-03 19:44:28', 1, 'Approved'),
(22, 'Nor', 'U', 'Umpar', '1982-04-04', '09099200018', NULL, NULL, NULL, 'Member', 8, NULL, '2025-08-03 19:42:42', '2025-08-03 19:43:55', 1, 'Approved'),
(23, 'Ariel', 'Bismar', 'Capili', '1967-10-19', '09171852313', NULL, NULL, NULL, 'Member', 22, NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09', 0, 'Approved'),
(24, 'Melanie', 'Moran', 'Guiday', '1988-12-01', '09165210706', NULL, NULL, NULL, 'Member', 22, NULL, '2025-08-03 19:55:11', '2025-08-03 19:57:25', 1, 'Approved'),
(25, 'Bernie', 'Paraguya', 'Baldesco', '1980-04-04', '09465935416', NULL, NULL, NULL, 'Member', 8, NULL, '2025-08-04 03:30:15', '2025-08-04 04:12:17', 1, 'Approved'),
(26, 'Margie', 'Navea', 'Palacio', '1993-07-12', '09670891993', 'Business owner', NULL, NULL, 'Member', 8, NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18', 0, 'Approved'),
(27, 'Cindy', 'Polison', 'Bandao', '1998-01-23', '09914528619', 'Saleswoman', NULL, NULL, 'Member', 25, NULL, '2025-08-04 04:13:08', '2025-08-06 19:42:56', 1, 'Approved'),
(28, 'Ma theresa', 'Molina', 'Garcia', '1994-09-05', '09519274739', NULL, NULL, 'photos/I2ZzbvgZa5hGExGSBgAH5moqdfpLZ6EV2B8u8PMC.jpg', 'Member', 10, NULL, '2025-08-07 01:14:45', '2025-08-07 01:18:37', 0, 'Approved'),
(29, 'Melba', NULL, 'Gruta', '2025-08-06', '09946437107', NULL, NULL, NULL, 'Member', 28, NULL, '2025-08-07 01:25:45', '2025-08-07 01:27:49', 0, 'Approved'),
(30, 'Sauda', 'Ajani', 'Nasirin', '1989-12-25', '09564907495', NULL, NULL, NULL, 'Member', 10, NULL, '2025-08-07 01:39:42', '2025-08-07 05:36:33', 0, 'Approved'),
(31, 'Ejay', 'L', 'Castro', '2002-12-06', '09945653049', NULL, NULL, 'photos/zbPr7EhWgPXk3KIyFO5M7I5SUT166RBQ53kCFx29.jpg', 'Member', 7, NULL, '2025-08-08 20:16:24', '2025-08-08 20:16:24', 0, 'Pending'),
(32, 'Jusel', 'Dela cruz', 'Ormenita', '2025-08-11', '09631248271', 'Negosyante', 'Infanta', NULL, 'Member', 11, NULL, '2025-08-11 19:43:28', '2025-08-11 19:45:58', 0, 'Approved'),
(33, 'Infanta cafe-tea-ria', NULL, 'Cashless payment', '2025-08-11', '09151836163', 'Mechant', 'Infanta quezon', NULL, 'Member', 5, NULL, '2025-08-12 01:10:35', '2025-08-12 22:38:05', 1, 'Approved'),
(34, 'Chester', NULL, 'Laroga', '2002-11-17', '09705759833', NULL, NULL, NULL, 'Member', 11, NULL, '2025-08-12 19:29:24', '2025-08-12 19:30:18', 0, 'Approved'),
(35, 'Ivana', NULL, 'Food hub', '2025-08-12', '09155874701', 'Merchant', NULL, NULL, 'Member', 11, NULL, '2025-08-12 20:29:55', '2025-08-12 22:36:38', 0, 'Approved'),
(36, 'Nathalia', 'Romantico', 'Dazo', '2006-11-28', '09381651324', NULL, NULL, NULL, 'Member', 11, NULL, '2025-08-12 21:33:14', '2025-08-12 21:33:14', 0, 'Approved'),
(37, 'Francisco', 'Platon', 'Gomba jr', '2025-09-17', '09923764121', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-13 04:11:58', '2025-08-13 04:11:58', 0, 'Approved'),
(38, 'Celeste belle jane', 'Dela torre', 'Gomba', '2025-08-12', '09203088948', 'Student', NULL, NULL, 'Member', 37, NULL, '2025-08-13 04:16:43', '2025-08-13 04:16:43', 0, 'Approved'),
(39, 'Maribel', 'Dela torre', 'Gomba', '2025-08-12', '09098006375', 'Leader', NULL, NULL, 'Member', 37, NULL, '2025-08-13 04:18:00', '2025-08-13 04:18:00', 0, 'Approved'),
(40, 'Carol', NULL, 'Evangelista', '2025-08-13', '09061207811', 'Billionaire', NULL, NULL, 'Member', 12, NULL, '2025-08-13 18:57:20', '2025-08-13 18:57:20', 0, 'Approved'),
(41, 'Jennelyn', NULL, 'Devera', '2025-08-13', '09935589239', 'Leader', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:00:21', '2025-08-13 19:00:21', 0, 'Approved'),
(42, 'Sharon', NULL, 'Culala', '2025-08-13', '09661772908', 'Negosyante', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:03:41', '2025-08-13 19:03:41', 0, 'Approved'),
(43, 'Mylene', NULL, 'Pabillaran', '2025-08-13', '09515415343', 'Leader', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04', 0, 'Approved'),
(44, 'Jenny', NULL, 'Masaganda', '2025-08-13', '09602444087', 'Negosyante', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34', 0, 'Approved'),
(45, 'Lorena', NULL, 'Caburnay', '2025-08-13', '09285452074', 'Member', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:53:19', '2025-08-13 21:53:19', 0, 'Approved'),
(46, 'Jerry', NULL, 'Turgo', '2025-08-13', '09353011044', 'Member', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29', 0, 'Approved'),
(47, 'Mhara jhoy', NULL, 'Penaverde', '2025-08-13', '09319060559', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02', 0, 'Approved'),
(48, 'Lorna', NULL, 'Cereneo', '2025-08-13', '09516970806', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16', 0, 'Approved'),
(49, 'Janice', 'King', 'Lam', '1980-01-31', '09778273389', 'Negosyante', NULL, NULL, 'Member', 10, NULL, '2025-08-15 19:24:50', '2025-08-15 19:27:19', 0, 'Approved'),
(50, 'Jocelyn', NULL, 'Gonzalez', '2025-08-15', '09105069453', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13', 0, 'Approved'),
(51, 'Denden', NULL, 'Casucom', '2025-08-15', '09617086040', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51', 0, 'Approved'),
(52, 'Liela', NULL, 'Ponce', '2025-08-15', '09198068020', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48', 0, 'Approved'),
(53, 'Kim', NULL, 'Ponce', '2025-08-15', '09851426349', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05', 0, 'Approved'),
(54, 'Hayde', NULL, 'America', '2025-08-15', '09693126050', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57', 0, 'Approved'),
(55, 'Rene', NULL, 'Merana', '2025-08-15', '09923764651', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19', 0, 'Approved'),
(56, 'Ramil', NULL, 'Superlativo', '2025-08-15', '09461950872', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13', 0, 'Approved'),
(57, 'Marilou', NULL, 'Galvez', '2025-08-15', '09516964321', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08', 0, 'Approved'),
(58, 'Rosalind', NULL, 'Salinas', '2025-08-15', '09355793825', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58', 0, 'Approved'),
(59, 'Christine', NULL, 'Ocampo', '2025-08-15', '09204022876', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42', 0, 'Approved'),
(60, 'Ellanilsa', NULL, 'Emita', '2025-08-17', '09661921448', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55', 0, 'Approved'),
(61, 'Erika', NULL, 'Quiambao', '2025-08-17', '09916055488', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07', 0, 'Approved'),
(62, 'Creza', NULL, 'Gallano', '2025-08-17', '09434732727', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49', 0, 'Approved'),
(63, 'Joselito', NULL, 'Puno', '2025-08-17', '09128691010', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33', 0, 'Approved'),
(64, 'Alma', NULL, 'Puno', '2025-08-17', '09568745175', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48', 0, 'Approved'),
(65, 'William', NULL, 'Puno', '2025-08-17', '09096093422', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59', 0, 'Approved'),
(66, 'William', NULL, 'Puno jr', '2025-08-17', '09306614438', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20', 0, 'Approved'),
(67, 'Christopher', NULL, 'Combaliceo', '2025-08-18', '095131229861', 'Member', NULL, NULL, 'Member', 11, NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10', 0, 'Approved'),
(68, 'Diana', NULL, 'Sanchez', '2025-08-18', '09454987860', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21', 0, 'Approved'),
(69, 'Roman', NULL, 'Franquia', '2025-08-18', '09308925735', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52', 0, 'Approved'),
(70, 'Armando', 'Intsik', 'Intrina', '1990-08-20', '09399282386', 'Dj sa radio', NULL, NULL, 'Member', 4, NULL, '2025-08-21 03:43:36', '2025-08-21 03:43:36', 0, 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `membership_codes`
--

CREATE TABLE `membership_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(8) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `reserved` tinyint(1) NOT NULL DEFAULT 0,
  `reserved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `used_by` bigint(20) UNSIGNED DEFAULT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `membership_codes`
--

INSERT INTO `membership_codes` (`id`, `code`, `used`, `reserved`, `reserved_by`, `used_by`, `used_at`, `created_at`, `updated_at`) VALUES
(1, '3G0JKSYU', 1, 0, NULL, 7, '2025-07-31 23:22:02', '2025-07-31 23:12:50', '2025-07-31 23:22:02'),
(2, 'KNZK8XIS', 1, 0, NULL, 3, '2025-07-31 23:30:15', '2025-07-31 23:12:50', '2025-07-31 23:30:15'),
(3, 'ENSCEG6R', 1, 0, NULL, 2, '2025-07-31 23:40:49', '2025-07-31 23:12:50', '2025-07-31 23:40:49'),
(4, 'PTCLO5JN', 1, 0, NULL, 6, '2025-07-31 23:41:30', '2025-07-31 23:12:50', '2025-07-31 23:41:30'),
(5, '8DCE9COX', 1, 0, NULL, 4, '2025-07-31 23:42:39', '2025-07-31 23:12:50', '2025-07-31 23:42:39'),
(6, 'RIINUUKT', 1, 0, NULL, 5, '2025-07-31 23:43:01', '2025-07-31 23:12:50', '2025-07-31 23:43:01'),
(7, 'QHJXS4WI', 1, 0, NULL, 8, '2025-08-01 14:52:06', '2025-07-31 23:12:50', '2025-08-01 14:52:06'),
(8, 'U3UCX4FF', 1, 0, NULL, 22, '2025-08-03 19:43:55', '2025-07-31 23:12:50', '2025-08-03 19:43:55'),
(9, '5URIPMHY', 1, 0, NULL, 9, '2025-07-31 23:27:06', '2025-07-31 23:12:50', '2025-07-31 23:27:06'),
(10, 'AOA45ULR', 1, 0, NULL, 21, '2025-08-03 19:44:28', '2025-07-31 23:12:50', '2025-08-03 19:44:28'),
(11, 'RYECZHQP', 1, 0, NULL, 19, '2025-08-03 00:24:30', '2025-08-01 14:52:36', '2025-08-03 00:24:30'),
(12, 'PHLTU5Y3', 1, 0, NULL, 18, '2025-08-01 15:43:54', '2025-08-01 14:52:36', '2025-08-01 15:43:54'),
(13, 'G2TJHKXE', 1, 0, NULL, 17, '2025-08-01 15:42:44', '2025-08-01 14:52:36', '2025-08-01 15:42:44'),
(14, 'KGEIOO5A', 1, 0, NULL, 16, '2025-08-01 15:41:32', '2025-08-01 14:52:36', '2025-08-01 15:41:32'),
(15, 'YHPFSIFP', 1, 0, NULL, 15, '2025-08-01 15:38:22', '2025-08-01 14:52:36', '2025-08-01 15:38:22'),
(16, 'UUAJCKPZ', 1, 0, NULL, 14, '2025-08-01 15:34:27', '2025-08-01 14:52:36', '2025-08-01 15:34:27'),
(17, 'HEFY06L9', 1, 0, NULL, 10, '2025-08-01 15:15:40', '2025-08-01 14:52:36', '2025-08-01 15:15:40'),
(18, 'YRWPFRFK', 1, 0, NULL, 13, '2025-08-01 15:28:12', '2025-08-01 14:52:36', '2025-08-01 15:28:12'),
(19, '25XNODDS', 1, 0, NULL, 12, '2025-08-01 15:23:14', '2025-08-01 14:52:36', '2025-08-01 15:23:14'),
(20, 'JSAD9N9J', 1, 0, NULL, 11, '2025-08-01 15:19:08', '2025-08-01 14:52:36', '2025-08-01 15:19:08'),
(21, 'LXUNZBEL', 1, 0, NULL, 24, '2025-08-03 19:57:25', '2025-08-03 19:32:47', '2025-08-03 19:57:25'),
(22, 'G3UMVDXV', 1, 0, NULL, 26, '2025-08-04 04:09:18', '2025-08-03 19:32:47', '2025-08-04 04:09:18'),
(23, 'H44XKJWX', 1, 0, NULL, 20, '2025-08-03 19:37:14', '2025-08-03 19:32:47', '2025-08-03 19:37:14'),
(24, '3MMMEH5I', 1, 0, NULL, 23, '2025-08-03 19:49:09', '2025-08-03 19:32:47', '2025-08-03 19:49:09'),
(25, 'NDJRFDL3', 1, 0, NULL, 25, '2025-08-04 04:12:17', '2025-08-03 19:32:47', '2025-08-04 04:12:17'),
(26, '15EXPXQS', 1, 0, NULL, 27, '2025-08-04 04:13:08', '2025-08-04 03:27:15', '2025-08-04 04:13:08'),
(27, 'Q4MUJNPH', 1, 0, NULL, 28, '2025-08-07 01:18:37', '2025-08-04 03:27:15', '2025-08-07 01:18:37'),
(28, 'IHDBFRFR', 1, 0, NULL, 29, '2025-08-07 01:27:49', '2025-08-04 03:27:15', '2025-08-07 01:27:49'),
(29, 'PVEZBUVU', 1, 0, NULL, 30, '2025-08-07 05:36:33', '2025-08-04 03:27:15', '2025-08-07 05:36:33'),
(30, 'I2KEPMFZ', 1, 0, NULL, 32, '2025-08-11 19:45:58', '2025-08-04 03:27:15', '2025-08-11 19:45:58'),
(31, 'XKSURM7C', 1, 0, NULL, 35, '2025-08-12 20:29:55', '2025-08-06 20:07:58', '2025-08-12 20:29:55'),
(32, 'MUBYDLYJ', 1, 0, NULL, 37, '2025-08-13 04:11:58', '2025-08-06 20:07:58', '2025-08-13 04:11:58'),
(33, 'K2HILXFK', 1, 0, NULL, 36, '2025-08-12 21:33:14', '2025-08-06 20:07:58', '2025-08-12 21:33:14'),
(34, 'UNF3TY9K', 1, 0, NULL, 34, '2025-08-12 19:30:18', '2025-08-06 20:07:58', '2025-08-12 19:30:18'),
(35, 'WQHEATPB', 1, 0, NULL, 33, '2025-08-12 01:14:55', '2025-08-06 20:07:58', '2025-08-12 01:14:55'),
(36, 'V37M6P2T', 1, 0, NULL, 38, '2025-08-13 04:16:43', '2025-08-13 04:15:16', '2025-08-13 04:16:43'),
(37, 'V4FJONMQ', 1, 0, NULL, 70, '2025-08-21 03:43:36', '2025-08-13 04:15:16', '2025-08-21 03:43:36'),
(38, '47LYK2HO', 0, 1, 3, NULL, NULL, '2025-08-13 04:15:16', '2025-08-19 07:22:17'),
(39, 'WOXXNFMB', 0, 1, 3, NULL, NULL, '2025-08-13 04:15:16', '2025-08-19 07:22:17'),
(40, 'ESZ79AAM', 0, 1, 3, NULL, NULL, '2025-08-13 04:15:16', '2025-08-19 07:22:17'),
(41, 'F0G1JLRF', 1, 0, NULL, 41, '2025-08-13 19:00:22', '2025-08-13 04:15:16', '2025-08-13 19:00:22'),
(42, 'TWHW7W64', 0, 1, 3, NULL, NULL, '2025-08-13 04:15:16', '2025-08-19 07:22:17'),
(43, 'QXP7QIKK', 0, 1, 3, NULL, NULL, '2025-08-13 04:15:16', '2025-08-19 07:22:17'),
(44, '4TPMRKSA', 1, 0, NULL, 39, '2025-08-13 04:18:01', '2025-08-13 04:15:16', '2025-08-13 04:18:01'),
(45, 'PHBKNEIA', 1, 0, NULL, 40, '2025-08-13 18:57:20', '2025-08-13 04:15:16', '2025-08-13 18:57:20'),
(46, 'OHDPD5EK', 0, 1, 3, NULL, NULL, '2025-08-13 19:01:09', '2025-08-19 07:22:17'),
(47, '7VF3HTYM', 0, 1, 3, NULL, NULL, '2025-08-13 19:01:09', '2025-08-19 07:22:17'),
(48, 'Q7XHF6WF', 0, 1, 3, NULL, NULL, '2025-08-13 19:01:10', '2025-08-19 07:22:17'),
(49, 'TVPEUJP6', 0, 1, 3, NULL, NULL, '2025-08-13 19:01:10', '2025-08-19 07:22:17'),
(50, 'EXP0XJDF', 0, 1, 4, NULL, NULL, '2025-08-13 19:01:10', '2025-08-20 06:35:42'),
(51, '8OJ39ED1', 0, 1, 4, NULL, NULL, '2025-08-13 19:01:10', '2025-08-20 06:35:42'),
(52, 'KJQIETJZ', 0, 1, 5, NULL, NULL, '2025-08-13 19:01:10', '2025-08-20 06:43:39'),
(53, 'REDAPZDM', 0, 0, NULL, NULL, NULL, '2025-08-13 19:01:10', '2025-08-13 19:01:10'),
(54, 'MPHTEICQ', 0, 0, NULL, NULL, NULL, '2025-08-13 19:01:10', '2025-08-13 19:01:10'),
(55, 'FVEMJMIN', 0, 0, NULL, NULL, NULL, '2025-08-13 19:01:10', '2025-08-13 19:01:10'),
(56, 'OLFLNJYB', 0, 0, NULL, NULL, NULL, '2025-08-13 19:01:10', '2025-08-13 19:01:10'),
(57, 'XUURKPWN', 1, 0, NULL, 50, '2025-08-15 21:48:13', '2025-08-13 19:01:10', '2025-08-15 21:48:13'),
(58, 'YGHAPG4A', 1, 0, NULL, 42, '2025-08-13 19:03:41', '2025-08-13 19:01:10', '2025-08-13 19:03:41'),
(59, 'ZE8GO5F6', 1, 0, NULL, 43, '2025-08-13 19:07:04', '2025-08-13 19:01:10', '2025-08-13 19:07:04'),
(60, 'MRFCAZTJ', 1, 0, NULL, 44, '2025-08-13 19:08:34', '2025-08-13 19:01:10', '2025-08-13 19:08:34'),
(61, 'NNGGIIQ6', 1, 0, NULL, 45, '2025-08-13 21:53:20', '2025-08-13 19:01:10', '2025-08-13 21:53:20'),
(62, 'NGZFKRYM', 1, 0, NULL, 46, '2025-08-13 21:54:29', '2025-08-13 19:01:10', '2025-08-13 21:54:29'),
(63, 'BOEXHWMT', 1, 0, NULL, 48, '2025-08-13 21:57:16', '2025-08-13 19:01:10', '2025-08-13 21:57:16'),
(64, 'I7P4JITC', 1, 0, NULL, 47, '2025-08-13 21:56:02', '2025-08-13 19:01:10', '2025-08-13 21:56:02'),
(65, 'GFVUOW9Y', 1, 0, NULL, 49, '2025-08-15 19:27:19', '2025-08-13 19:01:10', '2025-08-15 19:27:19'),
(66, 'USCFQ0C5', 0, 0, NULL, NULL, NULL, '2025-08-15 21:48:31', '2025-08-15 21:48:31'),
(67, 'SFE9YSKW', 1, 0, NULL, 60, '2025-08-17 23:43:55', '2025-08-15 21:48:31', '2025-08-17 23:43:55'),
(68, 'KMRAAW2O', 1, 0, NULL, 62, '2025-08-17 23:48:49', '2025-08-15 21:48:31', '2025-08-17 23:48:49'),
(69, 'HKCWBYAO', 1, 0, NULL, 61, '2025-08-17 23:45:07', '2025-08-15 21:48:31', '2025-08-17 23:45:07'),
(70, 'XY2QIROS', 1, 0, NULL, 64, '2025-08-17 23:51:48', '2025-08-15 21:48:31', '2025-08-17 23:51:48'),
(71, 'GEOR87HN', 1, 0, NULL, 63, '2025-08-17 23:50:33', '2025-08-15 21:48:31', '2025-08-17 23:50:33'),
(72, 'WZURQQEW', 1, 0, NULL, 65, '2025-08-17 23:52:59', '2025-08-15 21:48:31', '2025-08-17 23:52:59'),
(73, 'A0XFKC5R', 1, 0, NULL, 67, '2025-08-19 02:26:10', '2025-08-15 21:48:31', '2025-08-19 02:26:10'),
(74, '3ABFSCQ2', 1, 0, NULL, 66, '2025-08-17 23:54:20', '2025-08-15 21:48:31', '2025-08-17 23:54:20'),
(75, '4ZHBYXY0', 1, 0, NULL, 68, '2025-08-19 02:27:21', '2025-08-15 21:48:31', '2025-08-19 02:27:21'),
(76, 'QYKCH7CJ', 0, 0, NULL, NULL, NULL, '2025-08-15 21:48:31', '2025-08-15 21:48:31'),
(77, 'YQFKENPM', 1, 0, NULL, 59, '2025-08-15 21:57:42', '2025-08-15 21:48:31', '2025-08-15 21:57:42'),
(78, 'RKNOO6XK', 1, 0, NULL, 58, '2025-08-15 21:56:58', '2025-08-15 21:48:31', '2025-08-15 21:56:58'),
(79, 'Y4SGRJKG', 1, 0, NULL, 57, '2025-08-15 21:56:08', '2025-08-15 21:48:31', '2025-08-15 21:56:08'),
(80, '0K6KBESD', 1, 0, NULL, 56, '2025-08-15 21:55:13', '2025-08-15 21:48:31', '2025-08-15 21:55:13'),
(81, 'WOC2PBEL', 1, 0, NULL, 55, '2025-08-15 21:54:19', '2025-08-15 21:48:31', '2025-08-15 21:54:19'),
(82, 'OD0W4NRW', 1, 0, NULL, 54, '2025-08-15 21:52:57', '2025-08-15 21:48:31', '2025-08-15 21:52:57'),
(83, 'JCTUZNDC', 1, 0, NULL, 52, '2025-08-15 21:50:48', '2025-08-15 21:48:31', '2025-08-15 21:50:48'),
(84, 'WPWHRSWB', 1, 0, NULL, 53, '2025-08-15 21:52:05', '2025-08-15 21:48:31', '2025-08-15 21:52:05'),
(85, 'UUP5PEIR', 1, 0, NULL, 51, '2025-08-15 21:49:51', '2025-08-15 21:48:31', '2025-08-15 21:49:51'),
(86, '2ENG6OAO', 1, 0, NULL, 69, '2025-08-19 02:28:52', '2025-08-17 23:41:46', '2025-08-19 02:28:52'),
(87, 'GXV1B6KK', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(88, 'WQLJOO3Y', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(89, 'E5TRBZRT', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(90, 'OSNL2JYE', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(91, 'XQFRFONH', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(92, 'LVOER9LN', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(93, '7YCGX8RU', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(94, 'JLH6GQTS', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(95, 'YNLEVPXS', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(96, '5MQN6OWG', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(97, 'M8MFPDFC', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(98, 'U1OEQH7E', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(99, 'LQA7CAYB', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(100, 'RVJOK6A5', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(101, 'TA6CI4YH', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(102, 'IKERQJLR', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(103, 'MAPTELUA', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(104, 'WGZS1HIB', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(105, 'IFEE9RKO', 0, 0, NULL, NULL, NULL, '2025-08-17 23:41:46', '2025-08-17 23:41:46'),
(106, 'LRK4XXLX', 0, 0, NULL, NULL, NULL, '2025-08-19 05:53:48', '2025-08-19 05:53:48'),
(107, 'YKNQOOUZ', 0, 0, NULL, NULL, NULL, '2025-08-19 05:53:48', '2025-08-19 05:53:48'),
(108, 'P5QJPOIO', 0, 0, NULL, NULL, NULL, '2025-08-19 05:53:48', '2025-08-19 05:53:48'),
(109, 'EIA0T099', 0, 0, NULL, NULL, NULL, '2025-08-19 05:53:48', '2025-08-19 05:53:48'),
(110, 'S5THRYIM', 0, 0, NULL, NULL, NULL, '2025-08-19 05:53:48', '2025-08-19 05:53:48');

-- --------------------------------------------------------

--
-- Table structure for table `membership_code_requests`
--

CREATE TABLE `membership_code_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `amount_per_code` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `proof_path` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `membership_code_requests`
--

INSERT INTO `membership_code_requests` (`id`, `member_id`, `quantity`, `amount_per_code`, `total_amount`, `payment_method`, `proof_path`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 9, 1, 100.00, 100.00, 'GCash', 'payment_proofs/2gB4mUpIXaucHOGZTfaPh8ylD0u0U6sgEQbLgw2O.png', NULL, 'rejected', '2025-08-19 05:40:33', '2025-08-19 05:52:45'),
(2, 9, 1, 100.00, 100.00, 'GCash', 'payment_proofs/eR6biUOwpcbvE93jkUTPfgC6XtX7XtSOs0spHleI.png', NULL, 'rejected', '2025-08-19 05:40:33', '2025-08-19 05:52:27'),
(3, 4, 10, 100.00, 1000.00, 'GCash', 'payment_proofs/Um6xxIMFMDvsHugjHOl0VwU55D5S8cwmk2k9tXt6.png', NULL, 'approved', '2025-08-19 05:57:09', '2025-08-19 07:22:17'),
(4, 7, 2, 100.00, 200.00, 'Wallet', NULL, NULL, 'approved', '2025-08-20 06:31:08', '2025-08-20 06:35:42'),
(5, 7, 1, 100.00, 100.00, 'GCash', 'payment_proofs/hGPOMNdRCSAmkwpM8b5LhtxcDdAhCzqBopb1XWS7.jpg', 'Payment code', 'approved', '2025-08-20 06:42:47', '2025-08-20 06:43:39');

-- --------------------------------------------------------

--
-- Table structure for table `membership_code_request_codes`
--

CREATE TABLE `membership_code_request_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `membership_code_request_id` bigint(20) UNSIGNED NOT NULL,
  `membership_code_id` bigint(20) UNSIGNED NOT NULL,
  `reserved_at` timestamp NULL DEFAULT NULL,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `membership_code_request_codes`
--

INSERT INTO `membership_code_request_codes` (`id`, `membership_code_request_id`, `membership_code_id`, `reserved_at`, `assigned_at`, `created_at`, `updated_at`) VALUES
(1, 3, 37, '2025-08-19 07:22:17', NULL, NULL, NULL),
(2, 3, 38, '2025-08-19 07:22:17', NULL, NULL, NULL),
(3, 3, 39, '2025-08-19 07:22:17', NULL, NULL, NULL),
(4, 3, 40, '2025-08-19 07:22:17', NULL, NULL, NULL),
(5, 3, 42, '2025-08-19 07:22:17', NULL, NULL, NULL),
(6, 3, 43, '2025-08-19 07:22:17', NULL, NULL, NULL),
(7, 3, 46, '2025-08-19 07:22:17', NULL, NULL, NULL),
(8, 3, 47, '2025-08-19 07:22:17', NULL, NULL, NULL),
(9, 3, 48, '2025-08-19 07:22:17', NULL, NULL, NULL),
(10, 3, 49, '2025-08-19 07:22:17', NULL, NULL, NULL),
(11, 4, 50, '2025-08-20 06:35:42', NULL, NULL, NULL),
(12, 4, 51, '2025-08-20 06:35:42', NULL, NULL, NULL),
(13, 5, 52, '2025-08-20 06:43:39', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2025_06_18_000000_create_members_table', 1),
(5, '2025_06_18_000001_create_users_table', 1),
(6, '2025_06_18_110030_create_voters_table', 1),
(7, '2025_06_18_110255_create_benefits_table', 1),
(8, '2025_06_18_110337_create_benefit_member_table', 1),
(9, '2025_06_18_110359_create_loans_table', 1),
(10, '2025_06_18_115815_create_wallets_table', 1),
(11, '2025_06_19_005439_add_wallet_id_to_wallets_table', 1),
(12, '2025_06_19_020350_create_cash_in_requests_table', 1),
(13, '2025_06_19_034014_alter_status_column_in_loans_table', 1),
(14, '2025_06_19_035728_add_term_months_to_loans_table', 1),
(15, '2025_06_19_040132_create_loan_payments_table', 1),
(16, '2025_06_19_090214_add_purpose_to_loans_table', 1),
(17, '2025_06_29_013134_add_user_id_to_wallets_table', 1),
(18, '2025_06_29_013643_add_user_id_to_wallets_table', 1),
(19, '2025_06_29_014103_make_member_id_nullable_on_wallets_table', 1),
(20, '2025_06_29_115442_create_membership_codes_table', 1),
(21, '2025_06_29_125724_add_address_to_members_table', 1),
(22, '2025_06_30_150111_create_reward_programs_table', 1),
(23, '2025_06_30_150225_create_reward_winners_table', 1),
(24, '2025_06_30_151341_add_winner_id_to_reward_programs_table', 1),
(25, '2025_06_30_154307_add_foreign_key_to_reward_winners_table', 1),
(26, '2025_06_30_161911_add_seen_to_reward_winners_table', 1),
(27, '2025_06_30_170336_add_status_to_reward_winners_table', 1),
(28, '2025_06_30_172643_create_tickets_table', 1),
(29, '2025_06_30_174814_create_ticket_replies_table', 1),
(30, '2025_06_30_183242_add_member_id_to_ticket_replies_table', 1),
(31, '2025_06_30_194012_add_user_id_to_ticket_replies_table', 1),
(32, '2025_06_30_200510_add_wallet_id_to_wallets_table', 1),
(33, '2025_07_01_013959_add_loan_eligible_to_members_table', 1),
(34, '2025_07_01_034004_add_note_to_loan_payments_table', 1),
(35, '2025_07_02_031340_add_status_to_members_and_users', 1),
(36, '2025_07_02_064335_create_mobile_password_resets_table', 1),
(37, '2025_07_05_003513_add_proof_path_to_cash_in_requests_table', 1),
(38, '2025_07_05_102128_add_payment_method_to_cash_in_requests_table', 1),
(39, '2025_07_10_170926_create_referral_bonus_logs_table', 1),
(40, '2025_07_11_192351_create_products_table', 1),
(41, '2025_07_11_192501_create_orders_table', 1),
(42, '2025_07_11_192505_create_order_items_table', 1),
(43, '2025_07_11_192507_create_cashback_logs_table', 1),
(44, '2025_07_11_220911_create_categories_table', 1),
(45, '2025_07_11_220916_create_units_table', 1),
(46, '2025_07_11_220959_add_fields_to_products_table', 1),
(47, '2025_07_11_222707_add_stock_quantity_to_products_table', 1),
(48, '2025_07_12_105759_create_wallet_transactions_table', 1),
(49, '2025_07_12_111511_add_wallet_id_to_wallet_transactions_table', 1),
(50, '2025_07_13_061230_add_checkout_fields_to_orders_table', 1),
(51, '2025_07_13_064546_alter_orders_add_default_to_total_cashback', 1),
(52, '2025_07_13_115111_create_settings_table', 1),
(53, '2025_07_13_150011_add_discounts_to_products_table', 1),
(54, '2025_07_14_053443_add_type_to_wallets_table', 1),
(55, '2025_07_14_092645_add_source_to_cashback_logs_table', 1),
(56, '2025_07_14_093642_alter_wallet_transactions_add_cashback_type', 1),
(57, '2025_07_14_093953_add_cashback_given_to_orders_table', 1),
(58, '2025_07_15_180036_add_source_to_wallet_transactions_table', 1),
(59, '2025_07_15_200002_add_member_id_to_wallet_transactions_table', 1),
(60, '2025_07_17_232934_add_cashback_amount_to_order_items_table', 2),
(69, '2024_01_29_add_created_by_to_products_table', 3),
(70, '2025_07_30_180255_create_device_tokens_table', 4),
(71, '2025_07_30_182526_create_sms_logs_table', 5),
(72, '2023_07_26_000000_add_payment_fields_to_loan_payments_table', 6),
(73, '2023_07_26_000001_add_approval_fields_to_loans_table', 6),
(74, '2025_07_25_123112_create_referral_configurations_table', 6),
(75, '2025_07_25_134817_add_cashback_configuration_to_products_table', 6),
(76, '2025_07_25_135543_add_level_and_product_id_to_cashback_logs_table', 6),
(77, '2025_07_25_160111_add_status_to_order_items_table', 6),
(78, '2025_07_25_162730_add_promo_fields_to_orders_table', 6),
(79, '2025_07_27_091821_add_image_to_categories_table', 6),
(80, '2025_07_31_000000_migrate_existing_members_assign_codes', 6),
(81, '2025_08_19_112427_create_membership_code_requests_table', 7),
(82, '2025_08_19_144744_add_reserved_columns_to_membership_codes_table', 8);

-- --------------------------------------------------------

--
-- Table structure for table `mobile_password_resets`
--

CREATE TABLE `mobile_password_resets` (
  `mobile_number` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `total_cashback` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `cashback_given` tinyint(1) NOT NULL DEFAULT 0,
  `promo_code` varchar(255) DEFAULT NULL,
  `promo_discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `delivery_type` varchar(255) DEFAULT NULL,
  `delivery_address` text DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `reference_image` varchar(255) DEFAULT NULL,
  `gcash_note` varchar(255) DEFAULT NULL,
  `bank_note` varchar(255) DEFAULT NULL,
  `amount_sent` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `cashback_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cashback` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `cashback_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cashback_max_level` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `cashback_level_bonuses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`cashback_level_bonuses`)),
  `discount_value` decimal(8,2) DEFAULT NULL,
  `discount_type` enum('flat','percent') DEFAULT NULL,
  `promo_code` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gallery`)),
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `cashback_amount`, `cashback_max_level`, `cashback_level_bonuses`, `discount_value`, `discount_type`, `promo_code`, `created_by`, `stock_quantity`, `image`, `active`, `created_at`, `updated_at`, `thumbnail`, `gallery`, `category_id`, `unit_id`, `attributes`) VALUES
(2, 'Turbo F08 USB Rechargeable Mini Handy Super 100 Wind Speed Function with LED Digital Display Fan', 'Turbo F08 USB Rechargeable Mini Handy Super 100 Wind Speed Function with LED Digital Display Fan', 100.00, 20.00, 3, '[]', 10.00, 'flat', 'PROMO10', 1, 2, NULL, 1, '2025-07-16 05:17:37', '2025-07-31 00:30:05', 'products/thumbnails/nKsl8gHOCEGAi3l1Z7ewcMacdTIEiNcSPr93v1Ve.jpg', '[\"products\\/gallery\\/P0RzduoshLgqJg0lh6xYzkUPJHvEYhKy3pQg45DB.jpg\",\"products\\/gallery\\/TGP5CWIQQCV0vxdr8bpmeBLjQyzLS7Sl7tBTejPN.jpg\",\"products\\/gallery\\/FKPfeOIVPAd17Td6tBuipUryqTKwBfyoGm7gNE9h.jpg\"]', 7, 10, NULL),
(3, 'Mini Fan USB Rechargeable Handheld Portable Fan 100 Speed Adjustment led Display battery level turbo Fan', 'Mini Fan USB Rechargeable Handheld Portable Fan 100 Speed Adjustment led Display battery level turbo Fan', 80.00, 10.00, 3, NULL, 10.00, 'flat', 'PROMO10', 1, 7, NULL, 1, '2025-07-17 02:12:40', '2025-07-22 01:26:01', 'products/thumbnails/TeM9teKlcqxjJvYXUqec3AiyVr2cZ81aqXbjpCgu.jpg', '[\"products\\/gallery\\/lIoqfFF9arNONAV3w8ehRbuhRyjBAdoAT9jpuOJZ.jpg\",\"products\\/gallery\\/my7ddCjSu9sPknD7ELallq0WfBNV6Odq8bXWFsws.jpg\",\"products\\/gallery\\/MtowV8d3uM44JXifZSbseFcuIm8kdHno0n0YJlN1.jpg\"]', 5, 1, NULL),
(4, 'Women Slim Strap Watch Square Dial Analog Quartz Wrist Watch Gift', 'Women Slim Strap Watch Square Dial Analog Quartz Wrist Watch Gift', 150.00, 10.00, 3, NULL, 10.00, 'flat', 'PROMO10', 1, 5, NULL, 1, '2025-07-17 02:14:42', '2025-07-17 20:44:57', 'products/thumbnails/tJq5irGJXFWgkXRIfk6tf4vWoIgGZQx9BUSjkuio.jpg', '[\"products\\/gallery\\/GG7HdbZ3BVaOs6CoNINqgEZf3GPqEXljiZiwkjin.jpg\",\"products\\/gallery\\/eVbFNhN7uIhB9kyw8NlFPfDCrSAEXoxuDi1AZFB9.jpg\",\"products\\/gallery\\/aqWQPCG1Bu2zpCSfIiIlWEbVesymF1HvBnNYuRx2.jpg\"]', 5, 1, NULL),
(5, 'Deep Cleansing Solid Green Tea Mask Stick Removal Oil Blackhead Moisturizing Facial Skin Care', 'Deep Cleansing Solid Green Tea Mask Stick Removal Oil Blackhead Moisturizing Facial Skin Care', 200.00, 10.00, 3, NULL, 10.00, 'flat', 'PROMO10', 1, 6, NULL, 1, '2025-07-17 02:16:44', '2025-07-19 15:11:03', 'products/thumbnails/ilYghDqfNdvMEFKnltFtthJ61ePwWJv3eCjmSd5x.jpg', '[\"products\\/gallery\\/gkY1LtZkhPjF9z68eMUACOY29OCuTqMxTPIrXI0N.jpg\",\"products\\/gallery\\/pkfwe75quiqIo7reLs4u2na4jRxfD1EPdZKFd91p.jpg\"]', 12, 2, NULL),
(6, 'Plain Summer Waffle Loose Casual Shorts For Men', 'Plain Summer Waffle Loose Casual Shorts For Men', 200.00, 20.00, 3, NULL, 10.00, 'flat', 'NEW25', 1, 5, NULL, 1, '2025-07-17 02:18:41', '2025-07-17 17:39:49', 'products/thumbnails/4lz3Naio9aK2GVHzwoOF8V5NFFph0fRYazmDXkYH.jpg', '[\"products\\/gallery\\/H28iTIqkJvwV5tcM0U4lCwXujbVJAoBwfTLjFFeN.jpg\",\"products\\/gallery\\/J00ueY14Ko0wLJ5oaUNLvOG4T5IxbPFAKt1lSK1P.jpg\",\"products\\/gallery\\/yHRu6o1wvIRoKG1I3aQ5jq0RHg3NfD00KjZKbHnE.jpg\"]', 4, 1, NULL),
(7, 'Original good quality Power Bank 10000mAh Mini Powerbank Built in Cables Portable fast charging', 'Original good quality Power Bank 10000mAh Mini Powerbank Built in Cables Portable fast charging', 150.00, 15.00, 3, NULL, 10.00, 'flat', 'PROMO10', 1, 8, NULL, 1, '2025-07-18 15:03:03', '2025-07-18 17:50:05', 'products/thumbnails/fxF2w4hWGijJ398CR51MrpydIc0AmaVT4NhFZKEt.jpg', '[\"products\\/gallery\\/mNFtHOQUf9qHQ39dYpx0dlXAq9JbF3JLJ9af31N9.jpg\",\"products\\/gallery\\/8XEHyEFgWzXhYVLXZiDqfxvANWv0BrzlStcqEzPY.jpg\",\"products\\/gallery\\/Ay04cGEeyz5eH0imcgRj9kEC1kfRqURRA27CdYl4.jpg\"]', 14, 1, NULL),
(8, 'Diamond Premium Long Grain Jasmine Rice (20kg/bag)', 'Jasmine Rice 20kg per sack\r\nDirect Import from Vietnam \r\n100% Organic', 850.00, 20.00, 3, NULL, NULL, NULL, 'NEW25', 1, 9, NULL, 1, '2025-07-22 05:38:33', '2025-07-28 23:15:49', 'products/thumbnails/1A2LN7WbWtJFlpfikLBWMx5Lrm3Z0cTZsX4b1dDs.jpg', '[\"products\\/gallery\\/4EJqe0XHRVGZY3QoK3xEKpDZLz4UjRXoNsZVwp3T.jpg\",\"products\\/gallery\\/HtybZsBENHqQ0Juk796CKgYI7f8ewPYRFKLQWc2f.jpg\",\"products\\/gallery\\/pJB2Z4uL1bZHN1MlxZIzYVJ4MvkzTFYafFTidyzl.jpg\"]', 3, 1, NULL),
(9, 'Canon Pixma MG2570S Printer (PG745/CL746)', 'Canon Pixma MG2570S Printer (PG745/CL746)\r\nCompact All-In-One for Low-Cost Printing\r\nAffordable All-In-One printer with basic printing, copying and scanning functions.\r\n\r\nPrint, Scan, Copy\r\nPrint Speed (A4): up to 8.0 / 4.0 ipm (mono/colour)\r\nUSB 2.0\r\nRecommended Monthly Print Volume: 10 - 80 pages\r\n\r\n\r\nNumber of Nozzles\r\n\r\nTotal 1,280 nozzles\r\n\r\nInk Cartridges (Type/Colours)\r\n\r\nPG-745S (Pigment Ink/Black), CL-746S (Dye-Based Ink/Colour)\r\n[Optional: PG-745, CL-746 / PG-745XL, CL-746XL]\r\n\r\nMaximum Print Resolution\r\n\r\n4,800 (horizontal)*1 x 600 (vertical) dpi\r\n\r\nPrint Speed*2 (Approx.)\r\n\r\nBased on ISO/IEC 24734\r\nClick here for summary report\r\nClick here for Document Print and Copy Speed Measurement Conditions\r\n\r\nDocument (ESAT/Simplex)\r\n\r\n8 / 4 ipm (mono/colour)\r\n\r\nPrint Width\r\n\r\nUp to 203.2 mm (8\")\r\n\r\nRecommended Printing Area\r\n\r\nTop margin: 31.6 mm\r\nBottom margin: 29.2 mm', 2998.00, 10.00, 3, NULL, NULL, NULL, NULL, 1, 10, NULL, 1, '2025-07-22 05:45:07', '2025-07-22 05:45:07', 'products/thumbnails/py7nxEfM22XqM5DdNYGgnzjUrLV73OHgc2WU0m70.jpg', '[\"products\\/gallery\\/qWOJLjVI5WHnHeHdgAN6aZy3sBw9knzD8u2E5KVV.jpg\",\"products\\/gallery\\/XhvGo7alJI4QmH4hvH18GX9UZDzcc6F51xpoZy6x.jpg\",\"products\\/gallery\\/tDrJQBDOGK7pfa63gI4OrWpKqnW0vgfIGBbC3fCt.jpg\",\"products\\/gallery\\/S5SILNahFy3zYYqTt9knluYKfAa8mLOsnqVAYSJj.jpg\"]', 13, 1, NULL),
(10, 'Brandnew 50\" NVISION Smart TV', 'Full HD Resolution: The Nvision N600-T43MA TV boasts a Full HD (1080p) resolution, providing crisp and detailed images with vibrant colors and sharp clarity. \r\nLED Backlighting: Equipped with LED backlighting technology, this TV delivers enhanced brightness and contrast levels while consuming less power compared to traditional LCD TVs. LED backlighting ensures energy efficiency and a more vibrant picture quality.\r\nMultiple Connectivity Options: The N600-T43MA TV features multiple connectivity options, including HDMI, USB, VGA, AV input, and RF input, allowing users to connect various devices such as gaming consoles, Blu-ray players, streaming devices, and more, expanding entertainment possibilities.\r\nBuilt-in Tuner: With its built-in tuner, this TV enables users to access over-the-air broadcast channels without the need for an external set-top box. Users can enjoy watching their favorite local channels with clear reception and minimal hassle.\r\nSlim Design: The Nvision N600-T43MA TV boasts a sleek and modern design that complements any living space.', 13000.00, 50.00, 3, NULL, NULL, NULL, NULL, 1, 10, NULL, 1, '2025-07-22 05:54:28', '2025-07-22 05:54:28', 'products/thumbnails/ZOYChy4AAJrZovOkmyxAtwfYmDS0R0paaVCqbmMg.jpg', '[\"products\\/gallery\\/wz4ZwOfEfZqpei1Y0Y4JLlADTFjWXIJbU6VnreqQ.jpg\",\"products\\/gallery\\/ar0HAxoDI7h0yhN44CO2QMCzLskLV3FEZWBsxW5n.jpg\",\"products\\/gallery\\/YGBVhK2ZKYMT8mBJJb8mlonfpxDnRKNBlgTIewWh.jpg\",\"products\\/gallery\\/UBWeruMWF6us9XzMFSreYFPNLQvTygUPFRQXipof.jpg\",\"products\\/gallery\\/COh9ctjbS2rgdfecJOpFy2MTDMk0U5ZUV6oGFS0s.jpg\"]', 3, 1, NULL),
(11, 'NVISION 55\" 4K UHD SMART ANDROID LED TV', 'Model: S800-55S1D\r\nDisplay Size: 55” LED\r\nResolution: 3840 x 2160\r\nWall-mount: 400mm x 300mm\r\nTV System: PAL, NTSC, SECAM\r\nSound System: I, D/K, B/G, M\r\nMusic Support: mp3, wma, m4a, aac\r\nPicture Support: jpg, jpeg, bmp, png, txt\r\nVideo Support: avi, mp4, ts/trp, mkv, mov, mpg, dat, vob, rm/rmvb\r\nInput Source: (1)RJ45, (1)VGA, (3)HDMI, (2)USB, AV in, RF in, Coaxial, MINI AV, MINI (YPbPr), Earphone in\r\nSmart System: Android 11.0, 1.5G + 8G\r\nPower Input: 100-240V ~ 50/60Hz\r\nConsumption: 70W\r\nGross Weight: 14.3Kg\r\nBox Size:1350mm x 150mm x 815mm', 21000.00, 100.00, 3, NULL, NULL, NULL, NULL, 1, 10, NULL, 1, '2025-07-22 05:59:04', '2025-07-22 05:59:04', 'products/thumbnails/G8QCyUvf7vqiUzTMxpZRq9ha58Cp9GfLdF6nBeze.jpg', '[\"products\\/gallery\\/4f1ktsamuSONtWSGH4LM8RrYDXqqcXpMxh8NyIQL.webp\",\"products\\/gallery\\/bylekX38ttNYPFtYaKeCYopXWMBCTm7mMOHPZDhy.jpg\",\"products\\/gallery\\/run4D7hp0gZrxRnLPRGlKtU0Bkf6qKVmfAr4LcCQ.jpg\"]', 3, 1, NULL),
(12, 'Pan/Tilt Home Security Wi-Fi Camera', 'High-Definition Video: The Tapo C200 features 1080p high-definition video, providing users with clear and detailed footage.\r\nPan and Tilt: The device offers 360° horizontal and 114° vertical range, enabling complete coverage of the area.\r\nNight Vision: With advanced night vision up to 30 feet, the Tapo C200 allows users to monitor their homes around the clock.\r\nMotion Detection and Alerts: The device uses smart motion detection technology to send instant notifications to your phone whenever movement is detected.\r\nTwo-Way Audio: The Tapo C200 comes equipped with a built-in microphone and speaker, allowing users to communicate with family, pets, or warn off intruders.\r\nLocal Storage: The device supports microSD cards up to 512GB for local storage, providing a secure and cost-effective way to store footage.\r\nPrivacy Mode: Users can enable Privacy Mode to stop recording and control when the camera is monitoring and when it\'s not.\r\nEasy Setup and Management: With the Tapo app, users can easily set up and manage their Tapo C200, and access live streaming and other controls.\r\nVoice Control: The Tapo C200 is compatible with Google Assistant and Amazon Alexa, offering hands-free control for users.\r\nSecure Encryption: The device uses advanced encryption and wireless protocols to ensure data privacy and secure communication between your phone and the device', 1450.00, 100.00, 3, NULL, NULL, NULL, NULL, 1, 10, NULL, 1, '2025-07-22 06:02:17', '2025-07-22 06:04:04', 'products/thumbnails/AKhZVCXR6JUS1QJ856ocud3JfYGIaS42x9Ny7IMX.jpg', '[\"products\\/gallery\\/fftkEyTaCcY3dXmKNGVEaegCPa4XPkZIvaSvgdtv.jpg\",\"products\\/gallery\\/fbbVr1byMQtgQy0844UJOVLtr25WO2zc7UCuFskD.jpg\",\"products\\/gallery\\/DiXquPu65SWNDbTF9kHX9Br1oWDNevGPE3MeLRJ5.jpg\",\"products\\/gallery\\/OdugxfRXRololc4Jc4aN1KPiqwhaz8MXp7kWEUgl.jpg\",\"products\\/gallery\\/LS1drhPmy0bCN4L7Iqkc97o4s7GrnAk3x9PQ3B7U.png\"]', 6, 1, NULL),
(13, 'Pan/Tilt AI Home Security Wi-Fi Camera', 'Seamless Privacy Control - Use the button on the product shell or Tapo app to easily open or close the privacy shield, giving you complete control over your private moments.\r\n\r\n2K QHD - When it comes to home security, details matter. With 2K QHD resolution, the Tapo C225 transcends beyond traditional FullHD 1080p quality to display finer details and incredibly clear videos.\r\n\r\nApple Homekit Supported - Along with Amazon Alexa and Google Assistant compatibility,Tapo C225 can also fully integrate into your Apple Home ecosystem for convenient hands-free operation.\r\n\r\nSmart Motion Tracking - With pan/tilt functionality and smart motion tracking technology with up to 120°/s rotating speed, precisely track and follow subjects, continuously keeping them within the camera’s field of view.\r\n\r\nColor Night Vision - The highly sensitive starlight sensor captures higher-quality images even in low-light conditions up to 30 ft.\r\n\r\nInvisible Infrared Mode - If the red IR LEDs prove to be a distraction while monitoring at night, switch to invisible IR mode to continue monitoring in low-light conditions without the disrupting red light, making it ideal for sleeping children and pets.\r\n\r\nLocal and Cloud Storage - Save recorded videos on a microSD Card (up to 512 GB, purchased separately) or use Tapo Care cloud storage services (subscribe separately).\r\n\r\nSharing Capabilities - Seamlessly forward videos you want to share to your social platforms.', 2950.00, 100.00, 3, NULL, NULL, NULL, NULL, 1, 10, NULL, 1, '2025-07-22 06:06:41', '2025-07-22 06:06:41', 'products/thumbnails/mRukDqYmAXzQ128TXbMOqQzCyN9DChT88lWcCjyj.jpg', '[\"products\\/gallery\\/aEHmPknyZtsa6BNRG33qjbdGOXDZZKSG5RHERJe0.jpg\",\"products\\/gallery\\/2TmFHqwCSIFP0y0Vg98g77i21NUbrgNsxYEAtunS.jpg\",\"products\\/gallery\\/6MZw8DfNOoHEl0s7MT6zLWAfgZilELpYc2nOOijC.jpg\"]', 6, 1, NULL),
(21, 'Berry Barley ( Sachet )', 'Ingredients:\r\nMaltodextrin, Dextrose, Strawberry Extract Powder, Raspberry Extract Powder, Acidulant ( Citric Acid ) Organic Barley Grass Powder, Stabilizer ( Xantan Gum )\r\nNatural and Artificial Flavor ( Strawberry and Raspberry), Sweetener ( Stevia)', 150.00, 15.00, 3, '[]', 20.00, 'flat', NULL, 1, 120, NULL, 1, '2025-08-03 06:56:34', '2025-08-03 20:08:58', 'products/thumbnails/dKMhBdDDFKnehmusc8M3BLvcs5aGAFFKZSTuCvZ1.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/gU0wGnSEe9Cx2eQ3TuJlOnH1WLi5Naw2Ut4ndiZW.jpg\\\"]\"', 5, 1, NULL),
(22, 'Berry Barley ( 1 Box )', 'Ingredients:\r\nMaltodextrin, Dextrose, Strawberry Extract Powder, Raspberry Extract Powder, Acidulant ( Citric Acid ) Organic Barley Grass Powder, Stabilizer ( Xantan Gum )\r\nNatural and Artificial Flavor ( Strawberry and Raspberry), Sweetener ( Stevia)', 1500.00, 100.00, 5, '[]', 100.00, 'flat', NULL, 1, 8, NULL, 1, '2025-08-03 07:01:51', '2025-08-03 19:36:29', 'products/thumbnails/NUlVRBWF0RTrJGWsHs9bhKCvDSvoitLX55nH964V.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/ZOFzOZEGHDz6yPYOclKX01SMbJdeJgk39m3HnmAW.jpg\\\"]\"', 5, 4, NULL),
(23, 'Holla Colla ( Box )', '180g ( 18g x 10 sachets )\r\nIngredients:\r\nDextrose Anhydrous, Pure Calamansi Extract  Powder, Cotric Acid ( Acidulant ), Ginger Extract Powder, Malunggay Extract Powder, Xanthan Gum ( Stabilizer) , Sweetener ( Steviol Glycosides ), Silicone Dioxide ( Anti Caking ), Collagen, L- Glutathione.', 450.00, 40.00, 4, '[]', 50.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-03 07:14:48', '2025-08-03 19:38:26', 'products/thumbnails/Xye5LAEZ0NDnGz6GIZzgjkzlCLoKuENnGkpMkRvE.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/UUTdR7hO1wrqdDL4RLIxESk1w0HXElaOBeOgpjRK.jpg\\\"]\"', 2, 4, NULL),
(24, 'Lip Gel Tint', 'Ingredients:\r\nAqua, Xantan Gum, Glycerine, FD&C Colorant, Castor Oil, Vitamin E, Phenoxyethanol, Sunflower Oil.', 120.00, 25.00, 4, '[]', 20.00, 'flat', NULL, 1, 100, NULL, 1, '2025-08-03 20:47:32', '2025-08-03 20:49:42', 'products/thumbnails/W3w9QgmqwoqdPWk7IuqFzUhVADyGpT1uX6WFkvCy.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/nuhGIXZQDd3LYkeqFrtXVNCM36AC1ofHtnuRDpFX.jpg\\\"]\"', 5, 1, NULL),
(25, 'Bleaching Collagen with Niacinamide', '1x70g\r\nBenefits: Minimize Dark Spots. Skin bleaching can reduce dark spots on the skin cause by sun damage aging and hormonal changes, reduce the appearance of acne. Even out skin tone.\r\n\r\nIngredients: Cocos Nucifera, Sodium Hydroxide, Glutathione, Glycolic Acid, Kojic Acid Depalmitate, Niacinamide, Fragrance, Tactics Acid, Collagen and Sunflower', 120.00, 25.00, 5, '[]', 20.00, 'flat', NULL, 1, 300, NULL, 1, '2025-08-03 20:53:19', '2025-08-03 20:58:53', 'products/thumbnails/MyIVM75QAqT9tudoaePy75lbtFmbL3FHSEAnQqQX.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/OUenFZKOwMSJIxpvx9cl7LTt5GKvJxBwFn8LzeaR.jpg\\\"]\"', 5, 1, NULL),
(26, 'Dragon Pattern Therapy fashion Bracelet', 'High quality stainless steel, fashionable and durable dragon pattern bracelet.\r\ncolor available: gold and silver/ gold/ silver/ black', 180.00, 25.00, 4, '[]', 30.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-10 17:34:13', '2025-08-10 18:33:30', 'products/thumbnails/LoAovsYsTKmrcHQo6HCdr6ETB8BFepVxkgTUgJwG.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/O5q22dsLQr1uyx98DcDPyrZXEwMLIygQu0ChAX1y.jpg\\\"]\"', 14, 1, NULL),
(27, 'Turkish Lucky Evil Eye Charm Bracelet', 'Evil eye charm bracelet is for good luck, blessings and protection. Crafted with exquisite detail and infused with ancient energies. It\'s more than just a jewelry. It\'s a statement of power and mystery.', 180.00, 30.00, 5, '[]', 30.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-10 17:45:21', '2025-08-10 18:34:12', 'products/thumbnails/KGFQXyMsV6WpKuorXdqLTTYLAK1qnEQc9Jwm2T5V.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/jsly9TdAd6vXpY6SbdlD85puScfIF8A0TDZieNVq.jpg\\\"]\"', 14, 1, NULL),
(28, 'Ziyang Lucky Bead Red String Bracelet', 'Unisex: Ziyang Lucky bead red string ceramic retro bracelet jewelry vintage. For good luck and protection and money magnet charm.', 130.00, 30.00, 5, '[]', 31.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 18:14:09', '2025-08-10 18:35:23', 'products/thumbnails/p4vn4hJJG4Zee3Z5uFgwVLrr8MoPoKKFJoEPkiwu.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/dJknpgwYRvBqITYjv9T5kTfgRfH7Ge2YU9E1W7WP.jpg\\\"]\"', 14, 1, NULL),
(29, 'Wealth and Safety Bracelet', '2025 is your year of wealth and health success. This bracelet brings wealth, safety and more success.', 190.00, 30.00, 5, '[]', 55.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 18:30:54', '2025-08-10 18:36:45', 'products/thumbnails/zqN5aZWNmjvdbT4XkTHsG5QEfoY0xKDeisWgucra.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/fNvzkizbnl422RsGfVb9qSZkE7mqNgMk5Nam0BmY.jpg\\\"]\"', 14, 1, NULL),
(30, 'Laptop Cover Bag with Thick Lining and Adjustable Straps 14/15.6 inches', 'Water proof laptop computer hand bag, shock proof bag 14/15.6 inches laptop bag. Comfortably spacious for 13.3 laptops.\r\nColor available: Black/Gray/Pink', 390.00, 50.00, 5, '[]', 55.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-10 18:50:49', '2025-08-10 18:51:55', 'products/thumbnails/8QSExogfHeoQoip5IeMn9phvukIqSNcNUMusmUt7.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/VzqVPaks0uCOISHG4DSdvvw3SRvdAQTICtXxAFPb.jpg\\\"]\"', 4, 1, NULL),
(31, 'Large Capacity Briefcase Folder Tote Bag', 'Material : Canvass ,Oxford cloth\r\nWaterproof, multi-function, expandable, Lightweight, Anti-theft, Scratchproof, Foldable, Multi-compartment, High-capacity handbag.\r\nMulti purpose work briefcase portable organizer hand bag. Large capacity briefcase folder tote bag. Storage handbag waterproof file handbag', 199.00, 25.00, 4, '[]', 50.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 19:03:51', '2025-08-10 19:04:57', 'products/thumbnails/1iQ6OZfY3TlR2T3qbHamlDz1VD13tQEtLlGSOnBH.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/EfUpuI7zj5abKxQgqRWc2Hhq2PcpcfhCbFuF3vwt.jpg\\\"]\"', 13, 1, NULL),
(32, 'Elegant Fashion Travel Shopping Bag', 'Leather, PU Leather, Lightweight, Scratchproof, Waterproof, Large capacity ELEGANT TOTE HANDBAG.\r\nColor available: Khaki/White. No Coffee Brown at the moment', 428.00, 40.00, 5, '[]', 50.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 19:16:12', '2025-08-10 19:18:57', 'products/thumbnails/laZPY2lp1WwpMFNuIJglG5kT7eYV3Dp3QTxp0z0w.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/aRvjioNwCzbdn82xVr7enAVPeQfDoshn4hLhlN8S.jpg\\\"]\"', 4, 1, NULL),
(33, 'Marikina Bags Document Laptop Bag Printed', 'Size: 16\" x 12\" x 4\"\r\nMaterial: High Quality Synthetic material for durability and style.\r\nInterior: Smooth black lining with a convenient inside pocket for organizing essentials. External pocket for extra storage.\r\n\r\nA perfect companion for professionals and best students alike.', 518.50, 50.00, 4, '[]', 70.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-10 19:43:20', '2025-08-10 19:45:25', 'products/thumbnails/lUlLNC9m8WhlkckCD1qsDvi44ctEOslG3W0MG56r.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/s7Hv45a5OJdKJx9a0veyKHHaI91TPKR4ewWl13Kc.jpg\\\"]\"', 4, 1, NULL),
(34, 'Korean Bomber Jacket Unisex', 'Size: L and XL available only\r\nKorean, chic, plain, casual long sleeve for all seasons. Pormang japorms.', 284.00, 40.00, 4, '[]', 45.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-10 20:12:24', '2025-08-10 20:15:37', 'products/thumbnails/O83E2QlqDee4Sw4YfUit3w71jxV3Dc6tTtyefV5Q.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/6QUxX7TeyUGdQDR6sYdxpTfBPfTjHR14dlhzwkKC.jpg\\\"]\"', 4, 1, NULL),
(35, 'Double Pixiu Cinnabar Purple Gold Sand Bracelet', 'Unisex Bracelet. The double Pixiu charms are believed to attract wealth and good fortune. This bracelet perfectly blends fashion with meaningful symbolism, making it an excellent accessory for any occassions or as a thoughtful gift. Elevate your accessorycollections with this enchanting piece.', 185.00, 25.00, 5, '[]', 40.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 20:37:47', '2025-08-10 20:41:04', 'products/thumbnails/GblHGfLUazjrRxlBdsj55zaNjJpV7MmwLzlW7HoJ.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/WKnrgw80IOd4mUVmCFpQG9PxYv7RA4EbaPQTS826.jpg\\\"]\"', 14, 1, NULL),
(36, 'Smart  Card Holder Cellphone Wallet', 'Size: 20cm x 11cm x 3 cm\r\nColor: Black coffee/Brown\r\nMade of HIGH QUALITY Leather. Main bag, Card holder and Large space. For casual, daily, travel, shopping, school, party and gifts.', 190.00, 25.00, 4, '[]', 30.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 21:00:32', '2025-08-10 21:01:49', 'products/thumbnails/hA68retCmFEydQk7RBOIaBAEdIv2p9YnD25ZoopI.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/EstETitsvnEDuHUxyLQUKOlR74RAK0YhwvyKSyMS.jpg\\\"]\"', 14, 1, NULL),
(37, '10 pairs Summer Breathable Ankle Socks', '10 pairs in pack. One color per pack. Black/White/Gray. For men and women comfortable, breathable and affordable ankle socks.', 178.00, 20.00, 4, '[]', 30.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 21:15:54', '2025-08-10 21:17:17', 'products/thumbnails/RcsM6CvG0i0LQiWvnX0Bl1pC5XCJNosVh06a7QEU.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/HGLh0yfhY9igZP1jkG54OwDJrs7vxAimG7STUfC4.jpg\\\"]\"', 4, 1, NULL),
(38, '6 in 1 Mini Size Transparent Strong Clear Souvenir Shot Glass', '1 Box = 6 pcs glass. \r\nSize: 6.5cm x 10ml\r\nThe glass cup is made of inorganic silicates, and does not contain organic chemicals during the firing process. Do not fill the glass with hot water immediately to prevent it from bursting.', 190.00, 20.00, 4, '[]', 45.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-10 21:55:33', '2025-08-11 02:13:37', 'products/thumbnails/gLE1z7elHTqkgw4e7p6BUKcnTrQbVZItpM2LZn1b.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/srZEeYZBU6klVMJFibVifxmPAigcFYJHFOQZ6Yif.jpg\\\"]\"', 3, 5, NULL),
(39, '60ml Amber Honey and Warm Vanilla Oil base perfume', 'Bursting with fresh citrus notes and a delicate woody finish.\r\nTop Notes: Pear, Orange Blossom\r\nHeart Notes: Honey, Marshmallow\r\nBase Notes: White musk, Amber\r\n\r\nAvailable: Amber Honey and Warm Vanilla', 200.00, 30.00, 4, '[]', 35.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-11 02:11:47', '2025-08-11 02:14:47', 'products/thumbnails/NmrH9sdikBx4vFYNVQtQawJUoXnhtED2e83hyLsq.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/u340hIXtM3wl0b1uM571F45Mw1yBIeuP4X8Dq6TH.jpg\\\"]\"', 5, 1, NULL),
(40, 'Skinny Beauty Coffee 9 in 1 Healthy Coffee', 'Ingredients: Garcinia Cambogia, L- Carnitin, Cayenne, Glutathione, Collagen, Mangosteen, Spirulina, Psyllium Husk, Turmeric, Moringa, Non-dairy Creamer, Stevia.\r\n. Helps improve skin health.\r\n. Anti-aging properties\r\n. Helps improved kidney\'s health.\r\n. Reduced oxidative stress.\r\n. Help in detoxifying our body.\r\n. Helps with fat loss\r\n. Lowers cholesterol level', 750.00, 50.00, 4, '[]', 200.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-11 04:42:33', '2025-08-13 21:47:05', 'products/thumbnails/nk5H42y4Yn65LMfPZcHAyYnh74maDrVa8CTfDzEG.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/QDnUMr5wngoPhL2VvUG5L4xkBsrZ8FJeiYXDRMoR.jpg\\\"]\"', 5, 1, NULL),
(41, 'Baskog Barley 10 in 1 Healthy Coffee', 'Destroy cancer cells, Builds immunity against diseases, Slimming toxin remover, Smoothens and whitens skin, Cures and prevents allergies, Lowers cholesterol, Prevents colds and flu, Slow ageing process, Improves blood circulation, Boosts energy, Prevents arthritis, Lowers blood sugar.\r\nIngredients: BARLEY, WHEATGRASS, MANGOSTEEN, LEMON GRASS, MORINGA, SPIRULINA, GRAPESEED, INSULIN HERBS, BANABA,PREMIUM COFFEE, NON-DAIRY CREAMER AND STEVIA', 750.00, 50.00, 4, '[]', 200.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-11 04:53:22', '2025-08-11 05:41:37', 'products/thumbnails/5v9LL6w7gcGG29XimjiNH5MmvSQEBQVczDrPOl50.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/AmTpVyunZR0pKcSIyfZQjsjIaJdopG30X0bMAx9E.jpg\\\"]\"', 5, 5, NULL),
(42, 'LING 9 IN 1 HEALTHY COFFEE', '21g x 10 sachets\r\nINGREDIENTS: GUYABANO, GRAPESEED, PINE BARK, TURMERIC, MANGOSTEEN, AGARICUS MUSHROOM, GOJI BERRY, ACAI BERRY, GANODERMA MUSHROOM, PREMIUM COFFEE BEANS, NON-DAIRY CREAMER and STEVIA.\r\nFights all kinds of infection, Improve kidney function and protects your liver, Reduced stress damage, Fights against cardiovascular diseases, Reduce high blood pressure, Anti-bacterial properties, Reduced cancer risk, Fights diabetes-related complications and Support brain functions.', 750.00, 50.00, 5, '[]', 200.00, 'flat', NULL, 1, 30, NULL, 1, '2025-08-11 05:04:38', '2025-08-11 05:42:06', 'products/thumbnails/4shFlHbcJCSJWdywtfoFTei4kp6xOTi8Tzdi971f.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/29VvJmM4lNuzcfkdGw6MCZ6SWv0gEUZCpwRkZSKr.jpg\\\"]\"', 5, 5, NULL),
(43, 'GOTONETO 7 IN 1 TONGKAT ALI HEALTHY COFFEE', '21g x 10 sachets\r\nINGREDIENTS: TONGKAT ALI, MACA ROOT POWDER, KOREAN GINSENG, HORNY GOAT WEED, MANGOSTEEN, GRAPESEED, AGARICUS MUSHROOM, ARABICA COFFEE BEAN, NON-DAIRY CREAMER and STEVIA.\r\nHealth Benefits: Stimulate male hormone secretion, Increases sperm production and quality. Enchances sexual performance, Improves sexual function, Boost LIBIDO, Strenghtens the immune system, Natural testosterone booster, Energises your body and Increases Endurance.', 750.00, 50.00, 5, '[]', 200.00, 'flat', NULL, 1, 30, NULL, 1, '2025-08-11 05:15:17', '2025-08-11 05:42:35', 'products/thumbnails/2bjrElVp88b1QfX77NLXJk3Ya178bL2Xd62Qrc45.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/kAy496blhS542KRiKigeLQ4IhrVPJG7Q0R2jJEGX.jpg\\\"]\"', 5, 5, NULL),
(44, 'BLUE-GREEN ALGAE SPIRULINA', '100 tablets per bottle\r\nSpirulina is like a superfood. \r\nTop 10 Health Benefits:\r\n1. Packed with Antioxidants: Spirulina\'s got antioxidants like crazy, helping protect cells from damage and reducing inflammation.\r\n2. Boosts Energy: It\'s like a natural energy drink, increasing endurance and reducing fatigue.\r\n3. Lowers Cholesterol: Spirulina\'s shown to help lower total cholesterol and LDL (\"bad\") cholesterol levels.\r\n4. Anti-Inflammatory: It\'s got anti-inflammatory properties, which can help with conditions like arthritis, allergies, and more.\r\n5. Supports Heart Health: By reducing blood pressure and cholesterol, spirulina supports overall heart health.\r\n6. Detoxifies Heavy Metals: Spirulina\'s believed to help remove heavy metals like lead and mercury from the body.\r\n7. Improves Digestion: It\'s rich in fiber, promoting regular bowel movements and a healthy gut.\r\n8. May Help with Weight Loss: Spirulina\'s protein and fiber content can help with satiety and weight management.\r\n9. Supports Immune System: It\'s got immunomodulatory effects, helping regulate the immune system and prevent illnesses.\r\n10. May Improve Muscle Strength: Some studies suggest spirulina can increase muscle strength and endurance.', 1500.00, 100.00, 5, '[]', 350.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-11 05:23:58', '2025-08-11 05:43:26', 'products/thumbnails/Hbp4ThY9RWB4dbREtuxWTLZPhbN22hupN258JdjO.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/7L5uNK6qJGGJbRgw5spOSATZpeBdxyqPFeWErMjZ.jpg\\\"]\"', 5, 1, NULL),
(45, 'ARISE EUDE PARFUM', '30% OIL BASE\r\nLONG LASTING FRAGRANCE, CREATES LOYALTY and HIGHLY CONSUMABLE', 450.00, 30.00, 4, '[]', 60.00, 'flat', NULL, 1, 50, NULL, 1, '2025-08-11 05:27:54', '2025-08-11 05:44:37', 'products/thumbnails/MCbeMeayGjgC3QAtbezYFaVESqzOwXL5SMqQOtkl.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/kBNs79IY5Yk7kehnzQ1og3Xwne90VJAiLhjz6ZKz.jpg\\\"]\"', 3, 1, NULL),
(46, 'WINMINT MAGNESIUM THERAPY OIL', '10ml roll-on type\r\nINGREDIENTS: MAGNESIUM, TRACE MINERALS, EUCALYPTUS OIL, PEPPERMINT, LEMON GRASS and CINNAMON', 250.00, 25.00, 4, '[]', 35.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-11 05:33:18', '2025-08-11 05:45:19', 'products/thumbnails/A3H5doTEe6cHuCkn3t1TBLMRzyUcRRetraZTKfcS.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/3phBax78rhb4HaeL4Y2EIFsG7CKdSD1MTibyvPzd.jpg\\\"]\"', 5, 1, NULL),
(47, 'AIR DISINFECTANT AND FRESHENER', '100ml spray type bottle\r\n99% kills bacteria and viruses cause by airborne and leaves the room refresh every 6 hours with auto immune agent.\r\n\r\nAVAILABLE SCENTS: STRAWBERRY MUSK and LAVANDER', 300.00, 30.00, 4, '[]', 30.00, 'flat', NULL, 1, 30, NULL, 1, '2025-08-11 05:38:18', '2025-08-11 05:45:57', 'products/thumbnails/tYuxPn6NxWdxAHg6N8O1ZEJGjX7xZubCAyYxvo3Y.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/NRWj6Jx5iLGWiUvkzu7qfQEw157wY94FqoFXuNeJ.jpg\\\"]\"', 5, 1, NULL),
(48, 'ELEGANT FASHION LEATHER LADY SLING BAG', 'Elegant looking fashion leather lady sling and hand bag for young successful professionals, and students. Leather materials shoulder bag or a sling bag.\r\nSize: 22cn x 11cm x 28cm\r\nAvailable colors: Black and Brown', 280.00, 30.00, 4, '[]', 30.00, 'flat', NULL, 1, 2, NULL, 1, '2025-08-12 03:55:13', '2025-08-12 03:57:46', 'products/thumbnails/Q3cp9IQdTtxUMaHXyGmsmZ5DtCdrBvmkPmw3ePYo.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/lpeRANbQNeLrF6MAT8AFqWMJFEvxz3UlKsFnczIo.jpg\\\"]\"', 4, 1, NULL),
(49, 'COLLAGEN CHIA COFFEE', '12g x10 sachets/ pack\r\nINGREDIENTS: GARCINIA CAMBOGIA, SAKURA FLOWER, GOJI BERRY, WHITE GRAPE, COLLAGEN, GLUTATHIONE, CHIA SEEDS, NON-DAIRY CREAMER and STEVIA LEAVES.\r\n. Effectively reduce skin aging, reduces wrinkles, improves skin elasticity and hydration.\r\n. Brightens skin and gives you energy everyday.', 289.00, 25.00, 4, '[]', 20.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 05:13:43', '2025-08-18 05:18:43', 'products/thumbnails/FyqY3BwidrpXVeC77By95R6h6zWnk0TFoVik5XHN.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/EPe3Zc2dLPrBkCj8A9AkEkbyc1j88l2GUaOr4Ban.jpg\\\"]\"', 5, 5, NULL),
(50, 'CORN COFFEE with Malunggay and Mangosteen', '100g per pack\r\nINGREDIENTS: CORN COFFEE, MORINGA POWDER AND MANGOSTEEN POWDER\r\n. Rich in antioxidants which can prevent cancer , heart disease and ageing.\r\n. Highly nutritious which can boost your immune system.\r\n. Anti-cholesterol which can lower blood pressure.\r\n. Anti-diabetes which can lower blood sugar.', 180.00, 20.00, 4, '[]', 15.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 05:29:48', '2025-08-18 05:33:04', 'products/thumbnails/8HRwQivv55Owe60EqiGUYZPeixxEAnlwtfnsac5S.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/NkJc5Pdk2suUB4Hz4CpipYFKUk6aI5iHxLJynHRH.jpg\\\"]\"', 5, 5, NULL),
(51, 'JIMM\'S COFFEE MIX 3in 1 with GANODERMA', 'JIMM\'S COFFEE MIX 3in 1 with GANODERMA\r\n20G X 12 SACHETS.\r\nGanoderma may help improve cardio health, protects liver, boost immune system, may reduce anxiety and depression. Provides fiber for better digestion and may lower choesterol.', 170.00, 20.00, 4, '[]', 15.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 05:44:18', '2025-08-18 05:45:50', 'products/thumbnails/kloIhqzUvFl6xWIWK5O4sgT7Kbiwmeo6MHJ0ycx3.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/fiPtJEsO4nEPnjs389DXY2DhcHqYjCXfougAb3OV.jpg\\\"]\"', 5, 5, NULL),
(52, 'CAFE PURO INSTANT COFFEE in 50g CUP', 'ALL NATURAL INSTANT COFFEE WITH THE SIGNATURE COLLECTIBLE REGENCY GLASS CUP.\r\nNO ADDITIVES, NO ARTIFICIAL AROMA AND NO ARTIFICIAL FLAVORINGS.', 140.00, 10.00, 4, '[]', 20.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 05:54:44', '2025-08-18 05:56:04', 'products/thumbnails/V3srJ9AKFwD1lFE2AYLWaxnoGANJele2EmFxG35V.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/VpttiSNiD5ZJxHZSmBFgIAF3UVrRqBz5uNoeGlAZ.jpg\\\"]\"', 2, 5, NULL),
(53, 'VITAMIN C + D and ZINC GUMMIES', '60 GUMMIES in ONE BOTTLE.\r\nBIYODE VITAMIN C GUMMIES MULTIVITAMINS. VITAMIN D, ZINC and CALCIUM WHITENING AND ANTI-AGING SKIN GLOWING VEGAN SUPPLEMENT.', 380.00, 25.00, 4, '[]', 30.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 06:04:35', '2025-08-18 06:06:31', 'products/thumbnails/1Oor497pLJK508PefGJY9DnHfnwCC7NdDukkAzHo.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/PhZTm6olC6U8XfQVML6d6OKhUA4KSll2hE8KjbTL.jpg\\\"]\"', 5, 5, NULL),
(54, 'GLUTATHIONE-NIACINAMIDE BODY LOTION', 'FDA APPROVED GLUTATHIONE, NIACINAMIDE BODY WHITENING LOTION. 500ml with SPF 50 PA++\r\n3X SKIN WHITENING, SKIN MOISTURIZER, and SKIN REVITALISE, BARE VANILLA SCENT MABANGO AND LONG LASTING.', 250.00, 20.00, 4, '[]', 52.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 06:14:38', '2025-08-18 06:16:30', 'products/thumbnails/Tw5KsQSWJlvac01j5iFWzPHNVZ2qYWovkS9U6PFZ.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/MMrbgszlDOYQBcSTwiNbnkCiq1PYIcdfFIz0jZH9.jpg\\\"]\"', 5, 1, NULL),
(55, 'KOJIC AND NIACINAMIDE WHITENING LOTION', '250ml  KOJIC AND NIACINAMIDE WHITENING BODY LOTIONwith SPF 30 PA++ BRIGHTENING AND MOISTURIZING SUNSCREEN, NOURISHING LIGHT AND NON- STICKY.', 170.00, 15.00, 4, '[]', 35.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 06:23:30', '2025-08-18 06:26:46', 'products/thumbnails/YdSsCGoJ7sJ7R30ZMRNJeVvQx6uXqFrEcKMj6G48.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/zSW51NmshMOEDHZtkvryxtQHXwxZAhSPMzPYwxSq.jpg\\\"]\"', 5, 1, NULL),
(56, 'ASCORBIC ACID- SODIUM ASCORBATE', 'SO-CEE ASCORBIC ACID X 30 CAPSULE\r\nEACH CAPSULE CONTAINS ASCORBIC ACID USP 500MG. EQUIVALENT TO SODIUM ASCORBATE 562.43MG\r\nASCORBIC ACID SO-CEE , CONTAINS SODIUM ASCORBATE OR MONOSODIUM L-ASCORBATE PROVIDING ASCORBIC ACID OR VITAMIN C.\r\nTHIS VITAMIN is used for the prevention and treatment of vitamin c deficiency symptoms like scurvy, characterized by capillary fragility bleeding of small blood vessels and gums, normocyticor macrocytic anaemia, lessions of cartilages and bones and slow healing of wounds. It is essential for the synthesis of collagen and intercellular materials.', 250.00, 30.00, 4, '[]', 55.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 06:53:09', '2025-08-18 06:54:32', 'products/thumbnails/bwBdNHjnflOGwfUhdJ1BVhSXrrBJ5aup4VrbU2dv.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/42vwsbKRQ4l35jZwki7TaYxFBJWuQBz6q8RCHClB.jpg\\\"]\"', 5, 4, NULL),
(57, 'WHITENING NIACINAMIDE AND VITAMIN E BODY LOTION 200G', '200g Moist Whitening Body lotion with active ingredients of Niacinamide and Vitamin E in Milk and Papaya Extract. \r\n\r\nAvailable: milk and papaya', 130.00, 15.00, 4, '{\"1\":5}', 20.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-18 16:14:58', '2025-08-18 16:15:43', 'products/thumbnails/WviJXQzgNkeB25FWBMTIErxRbroxC1Xsufoh2VMi.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/AhX9OvQzYJnyvXhlCsA6ue27aVvvMTiVWlsl88gV.jpg\\\"]\"', 5, 1, NULL),
(58, 'Bewell-C ASCORBIC ACID. NON-ACIDIC VITAMIN C', '500mg per caps. 30 capsules non-acidic Vitamin C Sodium Ascorbate. It is a gentle, well absorbed formula that supports immunity, reduces stomach irritation, lowers kidney stones risk, and provides added mineral benefits for long term use.\r\nBewell-C is a non-acidic Vitamin C that can be taken on an empty stomach without the risk of hyperacidity. It has a higher rate of absorption so fewr Vitamins are flushed out while most of it stays in the body to boost immune system.\r\n. Strengthens immune system \r\n. Acts as an antioxidant that can protect your body from free radicals which may cause heart disease and cancer.\r\n. Aids in producing collagen which keep your teeth, hair and bones strong and healthy.', 330.00, 30.00, 5, '{\"1\":10}', 35.00, 'flat', NULL, 1, 20, NULL, 1, '2025-08-18 16:51:14', '2025-08-18 16:55:55', 'products/thumbnails/6lomGF2XYEIDQ4gO94twoNvq65aayDX5ZsunfC3Y.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/EDkLr9R9NWo358LrwvFNwsmlAzpjzIdfI48QmBox.jpg\\\"]\"', 5, 5, NULL),
(59, 'MEMORY MAXX GINGKO BILOBA', '50 capsules Brain Booster Gingko Biloba.\r\nBoost your memory and sharpens your focus with MEMORY MAXX GINGKO BILOBA, PANAX GINSENG.\r\n\r\nGingko Biloba is know for its ability to enchance blood circulation in the brain. It improves memory, concentration and cognitive function. It helps combat age-related  memory decline and keeps your mind sharp and alert.\r\nPanax GINSENG: This ancient herb is celebrated for its adoptogenic properties, helping your body manage stress while boosting energy levels. It also supports memory recall and cognitive performance.', 290.00, 30.00, 4, '{\"1\":10}', 40.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-18 19:31:31', '2025-08-18 19:32:15', 'products/thumbnails/TBpACu4Lb0AJWX94UkSu6Yu2kSc0M75mRyvn2FMj.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/ryPn08WnoKW2pSBxeZdG3j2AViCFjw9taWT5LS7r.jpg\\\"]\"', 5, 5, NULL),
(60, 'Diabeta 17-in-1 Herbal Coffee', 'Diabeta 17-in-1 Herbal Coffee', 450.00, 50.00, 3, '[]', NULL, NULL, NULL, 1, 10, NULL, 1, '2025-08-19 02:02:58', '2025-08-19 02:33:41', 'products/thumbnails/8iY5YSkB21H4moHoE2Tyby4buLYv9TGSTd70G9vf.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/Ki5qTk49unyMFHZeqggZdUBFEMDDb45kPyGf0SHG.jpg\\\",\\\"products\\\\\\/gallery\\\\\\/6S4fGDuGDE6gzZwlguXefMjMG7t2kEOSGZPJmYLF.jpg\\\",\\\"products\\\\\\/gallery\\\\\\/e9eI6RIEtrZvFu5zqHDrBjDV1xqtPq4CnV5JcFAw.jpg\\\",\\\"products\\\\\\/gallery\\\\\\/EOswDKTCJkebrdAutoypQbOEDGwwc6Zti7HJu481.jpg\\\"]\"', 2, 4, NULL),
(62, 'Healing Wonder Drops- High Grade Alkaline and Ionized Mineral Liquid', 'Ingredients: \r\nD-a Tocopherol acetate (0.05%)\r\nVitamin B6 ( 0.01% )\r\nSampaguita Extract \r\nBilberry Extract \r\nHigh Grade Alkaline \r\nIonised Mineral Liquid\r\nFDA REGISTERED, SAFE AND EFFECTIVE', 230.00, 25.00, 4, '{\"1\":10}', 35.00, 'flat', NULL, 1, 10, NULL, 1, '2025-08-20 06:04:43', '2025-08-20 06:05:24', 'products/thumbnails/78VrQAGRzbQtx4ziKDSZRbTfgAYK1mgslLFTTrQ9.jpg', '\"[\\\"products\\\\\\/gallery\\\\\\/DepaBUx3mlHe4FTpIhGf99zrmGouWFMQ3kgmsxoy.jpg\\\",\\\"products\\\\\\/gallery\\\\\\/vSCSPy2QO1kBz2jBeZwKxFcIkXpxMOV2cm25owWS.jpg\\\",\\\"products\\\\\\/gallery\\\\\\/MjU7wp527a5YGQ1WriyFxDlLwlJSBlUM5AJOpsgz.jpg\\\"]\"', 5, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `referral_bonus_logs`
--

CREATE TABLE `referral_bonus_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `referred_member_id` bigint(20) UNSIGNED NOT NULL,
  `level` tinyint(4) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `referral_bonus_logs`
--

INSERT INTO `referral_bonus_logs` (`id`, `member_id`, `referred_member_id`, `level`, `amount`, `description`, `created_at`, `updated_at`) VALUES
(1, 4, 7, 1, 25.00, 'Direct referral bonus from Benje Malik', '2025-07-31 23:22:02', '2025-07-31 23:22:02'),
(2, 1, 7, 2, 15.00, '2nd level referral bonus from Benje Malik', '2025-07-31 23:22:02', '2025-07-31 23:22:02'),
(3, 4, 9, 1, 25.00, 'Direct referral bonus from Paul Allen', '2025-07-31 23:27:06', '2025-07-31 23:27:06'),
(4, 1, 9, 2, 15.00, '2nd level referral bonus from Paul Allen', '2025-07-31 23:27:06', '2025-07-31 23:27:06'),
(5, 9, 8, 1, 25.00, 'Direct referral bonus from Lu Cab', '2025-08-01 14:52:06', '2025-08-01 14:52:06'),
(6, 4, 8, 2, 15.00, '2nd level referral bonus from Lu Cab', '2025-08-01 14:52:06', '2025-08-01 14:52:06'),
(7, 1, 8, 3, 10.00, '3nd level referral bonus from Lu Cab', '2025-08-01 14:52:06', '2025-08-01 14:52:06'),
(8, 7, 10, 1, 25.00, 'Direct referral bonus from Macaria Opeńa', '2025-08-01 15:15:40', '2025-08-01 15:15:40'),
(9, 4, 10, 2, 15.00, '2nd level referral bonus from Macaria Opeńa', '2025-08-01 15:15:40', '2025-08-01 15:15:40'),
(10, 1, 10, 3, 10.00, '3nd level referral bonus from Macaria Opeńa', '2025-08-01 15:15:40', '2025-08-01 15:15:40'),
(11, 7, 11, 1, 25.00, 'Direct referral bonus from Marissa Labrador', '2025-08-01 15:19:08', '2025-08-01 15:19:08'),
(12, 4, 11, 2, 15.00, '2nd level referral bonus from Marissa Labrador', '2025-08-01 15:19:08', '2025-08-01 15:19:08'),
(13, 1, 11, 3, 10.00, '3nd level referral bonus from Marissa Labrador', '2025-08-01 15:19:08', '2025-08-01 15:19:08'),
(14, 7, 12, 1, 25.00, 'Direct referral bonus from Lorina Phuno', '2025-08-01 15:23:14', '2025-08-01 15:23:14'),
(15, 4, 12, 2, 15.00, '2nd level referral bonus from Lorina Phuno', '2025-08-01 15:23:14', '2025-08-01 15:23:14'),
(16, 1, 12, 3, 10.00, '3nd level referral bonus from Lorina Phuno', '2025-08-01 15:23:14', '2025-08-01 15:23:14'),
(17, 7, 13, 1, 25.00, 'Direct referral bonus from Perla Andio', '2025-08-01 15:28:12', '2025-08-01 15:28:12'),
(18, 4, 13, 2, 15.00, '2nd level referral bonus from Perla Andio', '2025-08-01 15:28:12', '2025-08-01 15:28:12'),
(19, 1, 13, 3, 10.00, '3nd level referral bonus from Perla Andio', '2025-08-01 15:28:12', '2025-08-01 15:28:12'),
(20, 7, 14, 1, 25.00, 'Direct referral bonus from Jericho Noveno', '2025-08-01 15:34:27', '2025-08-01 15:34:27'),
(21, 4, 14, 2, 15.00, '2nd level referral bonus from Jericho Noveno', '2025-08-01 15:34:27', '2025-08-01 15:34:27'),
(22, 1, 14, 3, 10.00, '3nd level referral bonus from Jericho Noveno', '2025-08-01 15:34:27', '2025-08-01 15:34:27'),
(23, 7, 15, 1, 25.00, 'Direct referral bonus from MTC\'s Fruits hakes and Foodhub', '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(24, 4, 15, 2, 15.00, '2nd level referral bonus from MTC\'s Fruits hakes and Foodhub', '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(25, 1, 15, 3, 10.00, '3nd level referral bonus from MTC\'s Fruits hakes and Foodhub', '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(26, 11, 16, 1, 25.00, 'Direct referral bonus from Ian Amiel Santidad', '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(27, 7, 16, 2, 15.00, '2nd level referral bonus from Ian Amiel Santidad', '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(28, 4, 16, 3, 10.00, '3nd level referral bonus from Ian Amiel Santidad', '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(29, 11, 17, 1, 25.00, 'Direct referral bonus from Rhona Morilla', '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(30, 7, 17, 2, 15.00, '2nd level referral bonus from Rhona Morilla', '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(31, 4, 17, 3, 10.00, '3nd level referral bonus from Rhona Morilla', '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(32, 11, 18, 1, 25.00, 'Direct referral bonus from Elvira Rutagines', '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(33, 7, 18, 2, 15.00, '2nd level referral bonus from Elvira Rutagines', '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(34, 4, 18, 3, 10.00, '3nd level referral bonus from Elvira Rutagines', '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(35, 10, 19, 1, 25.00, 'Direct referral bonus from jancel andrade', '2025-08-03 00:24:30', '2025-08-03 00:24:30'),
(36, 7, 19, 2, 15.00, '2nd level referral bonus from jancel andrade', '2025-08-03 00:24:30', '2025-08-03 00:24:30'),
(37, 4, 19, 3, 10.00, '3nd level referral bonus from jancel andrade', '2025-08-03 00:24:30', '2025-08-03 00:24:30'),
(38, 8, 20, 1, 25.00, 'Direct referral bonus from Renz Licarte', '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(39, 9, 20, 2, 15.00, '2nd level referral bonus from Renz Licarte', '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(40, 4, 20, 3, 5.00, '3nd level referral bonus from Renz Licarte', '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(41, 1, 20, 4, 5.00, '4nd level referral bonus from Renz Licarte', '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(42, 8, 22, 1, 25.00, 'Direct referral bonus from Nor Umpar', '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(43, 9, 22, 2, 15.00, '2nd level referral bonus from Nor Umpar', '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(44, 4, 22, 3, 5.00, '3nd level referral bonus from Nor Umpar', '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(45, 1, 22, 4, 5.00, '4nd level referral bonus from Nor Umpar', '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(46, 8, 21, 1, 25.00, 'Direct referral bonus from Mary ann Pagas', '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(47, 9, 21, 2, 15.00, '2nd level referral bonus from Mary ann Pagas', '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(48, 4, 21, 3, 5.00, '3nd level referral bonus from Mary ann Pagas', '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(49, 1, 21, 4, 5.00, '4nd level referral bonus from Mary ann Pagas', '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(50, 22, 23, 1, 25.00, 'Direct referral bonus from Ariel Capili', '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(51, 8, 23, 2, 15.00, '2nd level referral bonus from Ariel Capili', '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(52, 9, 23, 3, 5.00, '3nd level referral bonus from Ariel Capili', '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(53, 4, 23, 4, 5.00, '4nd level referral bonus from Ariel Capili', '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(54, 22, 24, 1, 25.00, 'Direct referral bonus from Melanie Guiday', '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(55, 8, 24, 2, 15.00, '2nd level referral bonus from Melanie Guiday', '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(56, 9, 24, 3, 5.00, '3nd level referral bonus from Melanie Guiday', '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(57, 4, 24, 4, 5.00, '4nd level referral bonus from Melanie Guiday', '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(58, 8, 26, 1, 25.00, 'Direct referral bonus from Margie Palacio', '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(59, 9, 26, 2, 15.00, '2nd level referral bonus from Margie Palacio', '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(60, 4, 26, 3, 5.00, '3nd level referral bonus from Margie Palacio', '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(61, 1, 26, 4, 5.00, '4nd level referral bonus from Margie Palacio', '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(62, 8, 25, 1, 25.00, 'Direct referral bonus from Bernie Baldesco', '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(63, 9, 25, 2, 15.00, '2nd level referral bonus from Bernie Baldesco', '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(64, 4, 25, 3, 5.00, '3nd level referral bonus from Bernie Baldesco', '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(65, 1, 25, 4, 5.00, '4nd level referral bonus from Bernie Baldesco', '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(66, 25, 27, 1, 25.00, 'Direct referral bonus from Cindy Bandao', '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(67, 8, 27, 2, 15.00, '2nd level referral bonus from Cindy Bandao', '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(68, 9, 27, 3, 5.00, '3nd level referral bonus from Cindy Bandao', '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(69, 4, 27, 4, 5.00, '4nd level referral bonus from Cindy Bandao', '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(70, 10, 28, 1, 25.00, 'Direct referral bonus from Ma theresa Garcia', '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(71, 7, 28, 2, 15.00, '2nd level referral bonus from Ma theresa Garcia', '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(72, 4, 28, 3, 5.00, '3nd level referral bonus from Ma theresa Garcia', '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(73, 1, 28, 4, 5.00, '4nd level referral bonus from Ma theresa Garcia', '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(74, 28, 29, 1, 25.00, 'Direct referral bonus from Melba Gruta', '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(75, 10, 29, 2, 15.00, '2nd level referral bonus from Melba Gruta', '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(76, 7, 29, 3, 5.00, '3nd level referral bonus from Melba Gruta', '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(77, 4, 29, 4, 5.00, '4nd level referral bonus from Melba Gruta', '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(78, 10, 30, 1, 25.00, 'Direct referral bonus from Sauda Nasirin', '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(79, 7, 30, 2, 15.00, '2nd level referral bonus from Sauda Nasirin', '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(80, 4, 30, 3, 5.00, '3nd level referral bonus from Sauda Nasirin', '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(81, 1, 30, 4, 5.00, '4nd level referral bonus from Sauda Nasirin', '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(82, 11, 32, 1, 25.00, 'Direct referral bonus from Jusel Ormenita', '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(83, 7, 32, 2, 15.00, '2nd level referral bonus from Jusel Ormenita', '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(84, 4, 32, 3, 5.00, '3nd level referral bonus from Jusel Ormenita', '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(85, 1, 32, 4, 5.00, '4nd level referral bonus from Jusel Ormenita', '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(86, 5, 33, 1, 25.00, 'Direct referral bonus from Infanta cafe-tea-ria ebili.online Cashless payment only', '2025-08-12 01:14:55', '2025-08-12 01:14:55'),
(87, 1, 33, 2, 15.00, '2nd level referral bonus from Infanta cafe-tea-ria ebili.online Cashless payment only', '2025-08-12 01:14:55', '2025-08-12 01:14:55'),
(88, 11, 35, 1, 1.00, 'Direct referral bonus from Ivana\'s food hub Merchant partner', '2025-08-12 20:29:55', '2025-08-12 20:29:55'),
(89, 7, 35, 2, 1.00, '2nd level referral bonus from Ivana\'s food hub Merchant partner', '2025-08-12 20:29:55', '2025-08-12 20:29:55'),
(90, 11, 36, 1, 1.00, 'Direct referral bonus from Nathalia Dazo', '2025-08-12 21:33:14', '2025-08-12 21:33:14'),
(91, 7, 36, 2, 1.00, '2nd level referral bonus from Nathalia Dazo', '2025-08-12 21:33:14', '2025-08-12 21:33:14'),
(92, 11, 37, 1, 1.00, 'Direct referral bonus from Francisco Gomba jr', '2025-08-13 04:11:58', '2025-08-13 04:11:58'),
(93, 7, 37, 2, 1.00, '2nd level referral bonus from Francisco Gomba jr', '2025-08-13 04:11:58', '2025-08-13 04:11:58'),
(94, 37, 38, 1, 1.00, 'Direct referral bonus from Celeste belle jane Gomba', '2025-08-13 04:16:43', '2025-08-13 04:16:43'),
(95, 11, 38, 2, 1.00, '2nd level referral bonus from Celeste belle jane Gomba', '2025-08-13 04:16:43', '2025-08-13 04:16:43'),
(96, 37, 39, 1, 1.00, 'Direct referral bonus from Maribel Gomba', '2025-08-13 04:18:01', '2025-08-13 04:18:01'),
(97, 11, 39, 2, 1.00, '2nd level referral bonus from Maribel Gomba', '2025-08-13 04:18:01', '2025-08-13 04:18:01'),
(98, 12, 40, 1, 1.00, 'Direct referral bonus from Carol Evangelista', '2025-08-13 18:57:20', '2025-08-13 18:57:20'),
(99, 7, 40, 2, 1.00, '2nd level referral bonus from Carol Evangelista', '2025-08-13 18:57:20', '2025-08-13 18:57:20'),
(100, 12, 41, 1, 1.00, 'Direct referral bonus from Jennelyn Devera', '2025-08-13 19:00:22', '2025-08-13 19:00:22'),
(101, 7, 41, 2, 1.00, '2nd level referral bonus from Jennelyn Devera', '2025-08-13 19:00:22', '2025-08-13 19:00:22'),
(102, 12, 42, 1, 1.00, 'Direct referral bonus from Sharon Culala', '2025-08-13 19:03:41', '2025-08-13 19:03:41'),
(103, 7, 42, 2, 1.00, '2nd level referral bonus from Sharon Culala', '2025-08-13 19:03:41', '2025-08-13 19:03:41'),
(104, 12, 43, 1, 25.00, 'Direct referral bonus from Mylene Pabillaran', '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(105, 7, 43, 2, 15.00, '2nd level referral bonus from Mylene Pabillaran', '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(106, 4, 43, 3, 5.00, '3nd level referral bonus from Mylene Pabillaran', '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(107, 1, 43, 4, 5.00, '4nd level referral bonus from Mylene Pabillaran', '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(108, 12, 44, 1, 25.00, 'Direct referral bonus from Jenny Masaganda', '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(109, 7, 44, 2, 15.00, '2nd level referral bonus from Jenny Masaganda', '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(110, 4, 44, 3, 5.00, '3nd level referral bonus from Jenny Masaganda', '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(111, 1, 44, 4, 5.00, '4nd level referral bonus from Jenny Masaganda', '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(112, 11, 45, 1, 25.00, 'Direct referral bonus from Lorena Caburnay', '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(113, 7, 45, 2, 15.00, '2nd level referral bonus from Lorena Caburnay', '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(114, 4, 45, 3, 5.00, '3nd level referral bonus from Lorena Caburnay', '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(115, 1, 45, 4, 5.00, '4nd level referral bonus from Lorena Caburnay', '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(116, 11, 46, 1, 25.00, 'Direct referral bonus from Jerry Turgo', '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(117, 7, 46, 2, 15.00, '2nd level referral bonus from Jerry Turgo', '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(118, 4, 46, 3, 5.00, '3nd level referral bonus from Jerry Turgo', '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(119, 1, 46, 4, 5.00, '4nd level referral bonus from Jerry Turgo', '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(120, 11, 47, 1, 25.00, 'Direct referral bonus from Mhara jhoy Penaverde', '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(121, 7, 47, 2, 15.00, '2nd level referral bonus from Mhara jhoy Penaverde', '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(122, 4, 47, 3, 5.00, '3nd level referral bonus from Mhara jhoy Penaverde', '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(123, 1, 47, 4, 5.00, '4nd level referral bonus from Mhara jhoy Penaverde', '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(124, 11, 48, 1, 25.00, 'Direct referral bonus from Lorna Cereneo', '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(125, 7, 48, 2, 15.00, '2nd level referral bonus from Lorna Cereneo', '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(126, 4, 48, 3, 5.00, '3nd level referral bonus from Lorna Cereneo', '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(127, 1, 48, 4, 5.00, '4nd level referral bonus from Lorna Cereneo', '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(128, 10, 49, 1, 25.00, 'Direct referral bonus from Janice Lam', '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(129, 7, 49, 2, 10.00, '2nd level referral bonus from Janice Lam', '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(130, 4, 49, 3, 5.00, '3nd level referral bonus from Janice Lam', '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(131, 1, 49, 4, 5.00, '4nd level referral bonus from Janice Lam', '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(132, 11, 50, 1, 25.00, 'Direct referral bonus from Jocelyn Gonzalez', '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(133, 7, 50, 2, 10.00, '2nd level referral bonus from Jocelyn Gonzalez', '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(134, 4, 50, 3, 5.00, '3nd level referral bonus from Jocelyn Gonzalez', '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(135, 1, 50, 4, 5.00, '4nd level referral bonus from Jocelyn Gonzalez', '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(136, 11, 51, 1, 25.00, 'Direct referral bonus from Denden Casucom', '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(137, 7, 51, 2, 10.00, '2nd level referral bonus from Denden Casucom', '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(138, 4, 51, 3, 5.00, '3nd level referral bonus from Denden Casucom', '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(139, 1, 51, 4, 5.00, '4nd level referral bonus from Denden Casucom', '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(140, 11, 52, 1, 25.00, 'Direct referral bonus from Liela Ponce', '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(141, 7, 52, 2, 10.00, '2nd level referral bonus from Liela Ponce', '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(142, 4, 52, 3, 5.00, '3nd level referral bonus from Liela Ponce', '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(143, 1, 52, 4, 5.00, '4nd level referral bonus from Liela Ponce', '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(144, 11, 53, 1, 25.00, 'Direct referral bonus from Kim Ponce', '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(145, 7, 53, 2, 10.00, '2nd level referral bonus from Kim Ponce', '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(146, 4, 53, 3, 5.00, '3nd level referral bonus from Kim Ponce', '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(147, 1, 53, 4, 5.00, '4nd level referral bonus from Kim Ponce', '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(148, 11, 54, 1, 25.00, 'Direct referral bonus from Hayde America', '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(149, 7, 54, 2, 10.00, '2nd level referral bonus from Hayde America', '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(150, 4, 54, 3, 5.00, '3nd level referral bonus from Hayde America', '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(151, 1, 54, 4, 5.00, '4nd level referral bonus from Hayde America', '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(152, 11, 55, 1, 25.00, 'Direct referral bonus from Rene Merana', '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(153, 7, 55, 2, 10.00, '2nd level referral bonus from Rene Merana', '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(154, 4, 55, 3, 5.00, '3nd level referral bonus from Rene Merana', '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(155, 1, 55, 4, 5.00, '4nd level referral bonus from Rene Merana', '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(156, 11, 56, 1, 25.00, 'Direct referral bonus from Ramil Superlativo', '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(157, 7, 56, 2, 10.00, '2nd level referral bonus from Ramil Superlativo', '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(158, 4, 56, 3, 5.00, '3nd level referral bonus from Ramil Superlativo', '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(159, 1, 56, 4, 5.00, '4nd level referral bonus from Ramil Superlativo', '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(160, 11, 57, 1, 25.00, 'Direct referral bonus from Marilou Galvez', '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(161, 7, 57, 2, 10.00, '2nd level referral bonus from Marilou Galvez', '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(162, 4, 57, 3, 5.00, '3nd level referral bonus from Marilou Galvez', '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(163, 1, 57, 4, 5.00, '4nd level referral bonus from Marilou Galvez', '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(164, 11, 58, 1, 25.00, 'Direct referral bonus from Rosalind Salinas', '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(165, 7, 58, 2, 10.00, '2nd level referral bonus from Rosalind Salinas', '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(166, 4, 58, 3, 5.00, '3nd level referral bonus from Rosalind Salinas', '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(167, 1, 58, 4, 5.00, '4nd level referral bonus from Rosalind Salinas', '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(168, 11, 59, 1, 25.00, 'Direct referral bonus from Christine Ocampo', '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(169, 7, 59, 2, 10.00, '2nd level referral bonus from Christine Ocampo', '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(170, 4, 59, 3, 5.00, '3nd level referral bonus from Christine Ocampo', '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(171, 1, 59, 4, 5.00, '4nd level referral bonus from Christine Ocampo', '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(172, 12, 60, 1, 25.00, 'Direct referral bonus from Ellanilsa Emita', '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(173, 7, 60, 2, 10.00, '2nd level referral bonus from Ellanilsa Emita', '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(174, 4, 60, 3, 5.00, '3nd level referral bonus from Ellanilsa Emita', '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(175, 1, 60, 4, 5.00, '4nd level referral bonus from Ellanilsa Emita', '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(176, 12, 61, 1, 25.00, 'Direct referral bonus from Erika Quiambao', '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(177, 7, 61, 2, 10.00, '2nd level referral bonus from Erika Quiambao', '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(178, 4, 61, 3, 5.00, '3nd level referral bonus from Erika Quiambao', '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(179, 1, 61, 4, 5.00, '4nd level referral bonus from Erika Quiambao', '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(180, 12, 62, 1, 25.00, 'Direct referral bonus from Creza Gallano', '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(181, 7, 62, 2, 10.00, '2nd level referral bonus from Creza Gallano', '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(182, 4, 62, 3, 5.00, '3nd level referral bonus from Creza Gallano', '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(183, 1, 62, 4, 5.00, '4nd level referral bonus from Creza Gallano', '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(184, 12, 63, 1, 25.00, 'Direct referral bonus from Joselito Puno', '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(185, 7, 63, 2, 10.00, '2nd level referral bonus from Joselito Puno', '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(186, 4, 63, 3, 5.00, '3nd level referral bonus from Joselito Puno', '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(187, 1, 63, 4, 5.00, '4nd level referral bonus from Joselito Puno', '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(188, 12, 64, 1, 25.00, 'Direct referral bonus from Alma Puno', '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(189, 7, 64, 2, 10.00, '2nd level referral bonus from Alma Puno', '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(190, 4, 64, 3, 5.00, '3nd level referral bonus from Alma Puno', '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(191, 1, 64, 4, 5.00, '4nd level referral bonus from Alma Puno', '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(192, 12, 65, 1, 25.00, 'Direct referral bonus from William Puno', '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(193, 7, 65, 2, 10.00, '2nd level referral bonus from William Puno', '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(194, 4, 65, 3, 5.00, '3nd level referral bonus from William Puno', '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(195, 1, 65, 4, 5.00, '4nd level referral bonus from William Puno', '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(196, 12, 66, 1, 25.00, 'Direct referral bonus from William Puno jr', '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(197, 7, 66, 2, 10.00, '2nd level referral bonus from William Puno jr', '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(198, 4, 66, 3, 5.00, '3nd level referral bonus from William Puno jr', '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(199, 1, 66, 4, 5.00, '4nd level referral bonus from William Puno jr', '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(200, 11, 67, 1, 25.00, 'Direct referral bonus from Christopher Combaliceo', '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(201, 7, 67, 2, 10.00, '2nd level referral bonus from Christopher Combaliceo', '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(202, 4, 67, 3, 5.00, '3nd level referral bonus from Christopher Combaliceo', '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(203, 1, 67, 4, 5.00, '4nd level referral bonus from Christopher Combaliceo', '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(204, 11, 68, 1, 25.00, 'Direct referral bonus from Diana Sanchez', '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(205, 7, 68, 2, 10.00, '2nd level referral bonus from Diana Sanchez', '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(206, 4, 68, 3, 5.00, '3nd level referral bonus from Diana Sanchez', '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(207, 1, 68, 4, 5.00, '4nd level referral bonus from Diana Sanchez', '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(208, 11, 69, 1, 25.00, 'Direct referral bonus from Roman Franquia', '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(209, 7, 69, 2, 10.00, '2nd level referral bonus from Roman Franquia', '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(210, 4, 69, 3, 5.00, '3nd level referral bonus from Roman Franquia', '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(211, 1, 69, 4, 5.00, '4nd level referral bonus from Roman Franquia', '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(212, 4, 70, 1, 25.00, 'Direct referral bonus from Armando Intrina', '2025-08-21 03:43:36', '2025-08-21 03:43:36'),
(213, 1, 70, 2, 10.00, '2nd level referral bonus from Armando Intrina', '2025-08-21 03:43:36', '2025-08-21 03:43:36');

-- --------------------------------------------------------

--
-- Table structure for table `referral_configurations`
--

CREATE TABLE `referral_configurations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_allocation` decimal(10,2) NOT NULL,
  `max_level` tinyint(3) UNSIGNED NOT NULL,
  `level_bonuses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`level_bonuses`)),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `referral_configurations`
--

INSERT INTO `referral_configurations` (`id`, `name`, `total_allocation`, `max_level`, `level_bonuses`, `is_active`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Default Configuration', 50.00, 6, '{\"1\":25,\"2\":10,\"3\":5,\"4\":5,\"5\":3,\"6\":2}', 1, 'This amount pina kaunang nasa concept for marketing', '2025-07-31 23:14:42', '2025-08-15 07:36:25');

-- --------------------------------------------------------

--
-- Table structure for table `reward_programs`
--

CREATE TABLE `reward_programs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `draw_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `winner_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reward_programs`
--

INSERT INTO `reward_programs` (`id`, `title`, `description`, `draw_date`, `created_at`, `updated_at`, `winner_id`) VALUES
(1, '5Kilos rice raffle program', '5 winners of 5 kilos rice each every month.', '2025-09-11', '2025-08-12 04:53:11', '2025-08-12 04:53:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reward_winners`
--

CREATE TABLE `reward_winners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reward_program_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `drawn_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `excluded_until` date NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('unclaimed','redeemed','expired') NOT NULL DEFAULT 'unclaimed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'shipping_fee', '60', '2025-08-01 15:24:32', '2025-08-15 07:40:33'),
(2, 'promo_note', NULL, '2025-08-01 15:24:32', '2025-08-01 15:24:32'),
(3, 'discount_rate', NULL, '2025-08-01 15:24:32', '2025-08-01 15:24:32'),
(4, 'wallet_transfer_fee', '10', '2025-08-01 15:24:32', '2025-08-15 07:40:33'),
(5, 'discount_values', '[\"10\",\"20\",\"50\"]', '2025-08-19 08:53:40', '2025-08-19 08:53:40'),
(6, 'promo_codes', '[\"PROMO10\",\"NEW25\"]', '2025-08-19 08:53:40', '2025-08-19 08:53:40'),
(7, 'available_sizes', '[\"S\",\"M\",\"L\",\"XL\"]', '2025-08-19 08:53:40', '2025-08-19 08:53:40'),
(8, 'available_colors', '[\"Red\",\"Blue\",\"Green\"]', '2025-08-19 08:53:40', '2025-08-19 08:53:40'),
(9, 'amount_per_code', '100', '2025-08-19 08:53:40', '2025-08-19 08:55:15');

-- --------------------------------------------------------

--
-- Table structure for table `sms_logs`
--

CREATE TABLE `sms_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sent_by` bigint(20) UNSIGNED DEFAULT NULL,
  `recipient_type` varchar(255) NOT NULL DEFAULT 'single',
  `recipients` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`recipients`)),
  `message` text NOT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `total_recipients` int(11) NOT NULL DEFAULT 1,
  `successful_sends` int(11) NOT NULL DEFAULT 0,
  `failed_sends` int(11) NOT NULL DEFAULT 0,
  `estimated_cost` decimal(10,2) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `semaphore_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`semaphore_response`)),
  `message_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`message_ids`)),
  `campaign_name` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` enum('pending','in_process','closed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `member_id`, `subject`, `message`, `status`, `created_at`, `updated_at`) VALUES
(1, 36, 'Hi', 'www.ebili.online', 'in_process', '2025-08-12 22:16:18', '2025-08-18 23:30:00'),
(2, 7, 'Bunos', 'Bigyan mo naman kami ng binos', 'pending', '2025-08-14 03:54:43', '2025-08-14 03:54:43');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_replies`
--

CREATE TABLE `ticket_replies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `replied_by` varchar(255) NOT NULL,
  `member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket_replies`
--

INSERT INTO `ticket_replies` (`id`, `ticket_id`, `message`, `replied_by`, `member_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 2, 'Wag na', 'Admin', NULL, 1, '2025-08-14 03:56:19', '2025-08-14 03:56:19');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Piece', NULL, NULL),
(2, 'Kilogram', NULL, NULL),
(3, 'Liter', NULL, NULL),
(4, 'Box', NULL, NULL),
(5, 'Pack', NULL, NULL),
(6, 'Dozen', NULL, NULL),
(7, 'Set', NULL, NULL),
(8, 'Meter', NULL, NULL),
(9, 'Gram', NULL, NULL),
(10, 'Milliliter', NULL, NULL),
(11, 'Yard', NULL, NULL),
(12, 'Foot', NULL, NULL),
(13, 'Inch', NULL, NULL),
(14, 'Pound', NULL, NULL),
(15, 'Ounce', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role` enum('Admin','Staff','Member') NOT NULL DEFAULT 'Member',
  `member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `mobile_number`, `email`, `role`, `member_id`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `status`) VALUES
(1, 'System Administrator', '09177260180', 'mrcabandez@gmail.com', 'Admin', 1, NULL, '$2y$10$c9/wYgAPE5qUZCf2a9CfK.L7pGspzr3XEnXrWk0izyDMPJ2.UvRZO', NULL, '2025-07-31 22:45:11', '2025-07-31 22:45:12', 'Active'),
(2, 'Chief Technology Officer', '09171234567', 'staff1@ebili.com', 'Staff', 2, NULL, '$2y$10$TFhKQwAbmPl6QsjesSVQRO1JwRVxbn7Q2ug3FBB9jJ/tdIzIoENum', NULL, '2025-07-31 22:45:11', '2025-07-31 23:41:02', 'Approved'),
(3, 'Chief Operating Officer', '09171234568', 'coo@ebili.com', 'Staff', 3, NULL, '$2y$10$Z2bAU8AKLERF15ImOuxUIe5y14rcRjpjuX7XIncObay/PsepWx4au', NULL, '2025-07-31 22:45:11', '2025-07-31 23:30:59', 'Active'),
(4, 'Chief Executive Officer', '09191111111', 'ceo@ebili.com', 'Member', 4, NULL, '$2y$10$HvdACYKivQuA5mdK5uUhJ.nC6zWhpxi6XK5NI4aIj4XXkHgC.CJGi', NULL, '2025-07-31 22:45:12', '2025-07-31 23:42:39', 'Approved'),
(5, 'Chief Marketing Officer', '09181234568', 'member2@ebili.com', 'Member', 5, NULL, '$2y$10$KLK.oZwUpGIAPdFKZTXnK.7l5L8vBhCmpd3dLa81zW6kR73ahszFK', NULL, '2025-07-31 22:45:12', '2025-07-31 23:43:01', 'Approved'),
(6, 'Chief Customer Service', '09181234569', 'member3@ebili.com', 'Member', 6, NULL, '$2y$10$.dTVgnhPYdlI/8WPUYDJeOXD.pCSY3RcbOUS4QwysOsahsnl/EqiK', NULL, '2025-07-31 22:45:12', '2025-07-31 23:41:30', 'Approved'),
(7, 'Benje e-bili', '09151836162', '09151836162@ebili.online', 'Member', 7, NULL, '$2y$10$50WBfo599VdsEIejJv3uP.aze2v.f7a7rGeIkj42QpzYkJf6SilHG', NULL, '2025-07-31 23:22:02', '2025-08-01 14:54:16', 'Approved'),
(8, 'Lu Cab', '09192222222', '09192222222@ebili.online', 'Member', 8, NULL, '$2y$10$Ccx8btHMCCMWoQHEDuarFe.Ylqe3/f4yLFQ0rw6Ia.XoohcKzy4y.', NULL, '2025-07-31 23:23:12', '2025-08-01 14:52:06', 'Approved'),
(9, 'Paul Allen', '09193333333', '09193333333@ebili.online', 'Member', 9, NULL, '$2y$10$ec96iL5F.HyLi0SqAUoDyekdtF0hlJI3U6V1WEinJIxA.ya41lxkO', NULL, '2025-07-31 23:27:06', '2025-08-09 22:17:57', 'Approved'),
(10, 'Macaria Opeńa', '09556778397', '09556778397@ebili.online', 'Member', 10, NULL, '$2y$10$e6Mvq78qBHIOemPCVPac4e9KVKHP4oK.nIlrIEqOfd6cDD36e77l6', NULL, '2025-08-01 15:15:40', '2025-08-01 15:15:40', 'Approved'),
(11, 'Marissa Labrador', '09109868673', '09109868673@ebili.online', 'Member', 11, NULL, '$2y$10$LcN0zp0JVZh49/URch2lOeMibxqnQc4Dt5pgX/OI1SLXjKhzVmfha', NULL, '2025-08-01 15:18:17', '2025-08-01 15:19:08', 'Approved'),
(12, 'Lorina Phuno', '09306730491', '09306730491@ebili.online', 'Member', 12, NULL, '$2y$10$mRc7CgvFZfXCc6eNSomckuci94PyiDKAwA6jYkUHmyT/FgXRxcVf2', NULL, '2025-08-01 15:22:29', '2025-08-01 15:23:14', 'Approved'),
(13, 'Perla Andio', '09701678140', '09701678140@ebili.online', 'Member', 13, NULL, '$2y$10$yGksZLqHBMR5No691R.5ve8twqQsOKuKsj6DRy3dLOeOUJiAgaFHK', NULL, '2025-08-01 15:27:33', '2025-08-01 15:28:12', 'Approved'),
(14, 'Jericho Noveno', '09273001094', '09273001094@ebili.online', 'Member', 14, NULL, '$2y$10$uGUok5KY/D.V6rN9UGrrn.w.z6R5KOob8cGVRo1eLXq1hMsy5dneC', NULL, '2025-08-01 15:34:27', '2025-08-01 15:34:27', 'Approved'),
(15, 'MTC\'s Fruits hakes and Foodhub', '09651233549', '09651233549@ebili.online', 'Member', 15, NULL, '$2y$10$4JautxYoLLnqgfVCA/76BukuC48Foqcrpt/LJ.saNi7Ol2p1ePGcC', NULL, '2025-08-01 15:38:22', '2025-08-01 15:38:22', 'Approved'),
(16, 'Ian Amiel Santidad', '09915508102', '09915508102@ebili.online', 'Member', 16, NULL, '$2y$10$ye5Mqn6oa0rAUuq0k33wE.71Bq0txefA5RmnHmY3PZ.hJH101V8.C', NULL, '2025-08-01 15:41:32', '2025-08-01 15:41:32', 'Approved'),
(17, 'Rhona Morilla', '09126748581', '09126748581@ebili.online', 'Member', 17, NULL, '$2y$10$XRaDgVN5GRuMlxXUELOoK.00SIxHzk9Tp6x2lX3Ty2xoDu3ANNFhy', NULL, '2025-08-01 15:42:44', '2025-08-01 15:42:44', 'Approved'),
(18, 'Elvira Rutagines', '09612019238', '09612019238@ebili.online', 'Member', 18, NULL, '$2y$10$KC18afpopEd173HD07jQ7OfnAyYENA32z/UrFTlDyoW2D1uC7cYqm', NULL, '2025-08-01 15:43:54', '2025-08-01 15:43:54', 'Approved'),
(19, 'Jancel Andrade', '09703100243', '09703100243@ebili.online', 'Member', 19, NULL, '$2y$10$cNb4lIUKjKk/34BJb/xOEOZXwWfiWiDwOEGsOK1frRRuIBlUbzm4q', NULL, '2025-08-03 00:22:16', '2025-08-03 19:35:24', 'Approved'),
(20, 'Renz Licarte', '09763632594', '09763632594@ebili.online', 'Member', 20, NULL, '$2y$10$oVGBo28qiLGaFxYkDNdWdeebLNVg4KUM3IiWjiCdfdK58CCh2ZUTC', NULL, '2025-08-03 19:37:14', '2025-08-03 19:37:14', 'Approved'),
(21, 'Mary ann Pagas', '09264663844', '09264663844@ebili.online', 'Member', 21, NULL, '$2y$10$5g/WAyGOWGJXDO4PAzlnXOfW79ofGDAn5pUyj568gKqtLrRqpatpC', NULL, '2025-08-03 19:39:36', '2025-08-03 19:44:28', 'Approved'),
(22, 'Nor Umpar', '09099200018', '09099200018@ebili.online', 'Member', 22, NULL, '$2y$10$aMFjuFypQL2J/ZlYJbJRm.bHgcKDItRr1wK8.3CmL/JBjwW9IPoRS', NULL, '2025-08-03 19:42:42', '2025-08-03 19:43:55', 'Approved'),
(23, 'Ariel Capili', '09171852313', '09171852313@ebili.online', 'Member', 23, NULL, '$2y$10$xjYiyu4owpTmdUGnIJq2iu.d6ek04JX57pO7uFytKd2.o2SDi4p5e', NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09', 'Approved'),
(24, 'Melanie Guiday', '09165210706', '09165210706@ebili.online', 'Member', 24, NULL, '$2y$10$t6nMEY/b0UH9mYlGN2yCouaZ3TeZd9R/rUqNYfaoM6iRVrpH0mkee', NULL, '2025-08-03 19:55:12', '2025-08-03 19:57:25', 'Approved'),
(25, 'Bernie Baldesco', '09465935416', '09465935416@ebili.online', 'Member', 25, NULL, '$2y$10$LvorRhIxJ2M..7oORyuvEOt8WrsbE8fsWolxx3ob1.9B9QYhBEUUi', NULL, '2025-08-04 03:30:15', '2025-08-06 19:43:21', 'Approved'),
(26, 'Margie Palacio', '09670891993', '09670891993@ebili.online', 'Member', 26, NULL, '$2y$10$FuvfDra.yjRe3QGOdDErM.OLHzUSAP/dR2H2m7hWzvj.iFm3Ku0cG', NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18', 'Approved'),
(27, 'Cindy Bandao', '09914528619', '09914528619@ebili.online', 'Member', 27, NULL, '$2y$10$nlenqFz0eINPKSl/yTqTEexNDmaBwIZlCWI6mn1TH67DKCt/lKxUG', NULL, '2025-08-04 04:13:08', '2025-08-06 19:42:56', 'Approved'),
(28, 'Ma theresa Garcia', '09519274739', '09519274739@ebili.online', 'Member', 28, NULL, '$2y$10$zx3lJnqQhgXiikHiqQnf2OEBjKERH5OuWAIal7JECTqtDfz8h7eoS', NULL, '2025-08-07 01:14:45', '2025-08-07 01:18:37', 'Approved'),
(29, 'Melba Gruta', '09946437107', '09946437107@ebili.online', 'Member', 29, NULL, '$2y$10$erBMGtSpqWJ3i6ZuOsV7uONNDog2YTGUjC4jTjxBLYxZaO5UDT2hS', NULL, '2025-08-07 01:25:45', '2025-08-07 01:27:49', 'Approved'),
(30, 'Sauda Nasirin', '09564907495', '09564907495@ebili.online', 'Member', 30, NULL, '$2y$10$7sgXUO0PANF41uDFTnHoN.MUc968G68b74913.AblW1So9Q/iR.TO', NULL, '2025-08-07 01:39:42', '2025-08-07 05:36:33', 'Approved'),
(31, 'Ejay Castro', '09945653049', '09945653049@ebili.online', 'Member', 31, NULL, '$2y$10$BDkcinykE.nKsSmyrkT0jOFcEOhrLPgF7JY804Xyo6wBUA/K6eHXe', NULL, '2025-08-08 20:16:24', '2025-08-08 20:16:24', 'Pending'),
(32, 'Jusel Ormenita', '09631248271', '09631248271@ebili.online', 'Member', 32, NULL, '$2y$10$GEeWfafVk70np/ZOGPYwQOHRKxnq.sUwGniuLujjjXKljj3vU12Ny', NULL, '2025-08-11 19:43:28', '2025-08-11 19:45:58', 'Approved'),
(33, 'Infanta cafe-tea-ria Cashless payment', '09151836163', '09151836163@ebili.online', 'Member', 33, NULL, '$2y$10$iOcJJP8kSuLPdbKYnMqUJ.8ULZCSmZjA5vRtoqBEJBnpoTtPxZJbC', NULL, '2025-08-12 01:10:35', '2025-08-12 22:38:05', 'Approved'),
(34, 'Chester Laroga', '09705759833', '09705759833@ebili.online', 'Member', 34, NULL, '$2y$10$/2uTZ/YIOg.TceZ6iIuYte/B3s97n8NUZ6eBOAif/usn9pDWZ.KI2', NULL, '2025-08-12 19:29:24', '2025-08-12 19:30:18', 'Approved'),
(35, 'Ivana Food hub', '09155874701', '09155874701@ebili.online', 'Member', 35, NULL, '$2y$10$atqpY0zIML3qW42ubopefu9OnR8PvtiWQ4uBtswCkIgphmtn.zjIi', NULL, '2025-08-12 20:29:55', '2025-08-12 22:36:38', 'Approved'),
(36, 'Nathalia Dazo', '09381651324', '09381651324@ebili.online', 'Member', 36, NULL, '$2y$10$6DFzxU0FI1o.TyGlASofWOUqqaLtdzSDAZRFhATLTPc/52mSq.Feu', NULL, '2025-08-12 21:33:14', '2025-08-12 21:33:14', 'Approved'),
(37, 'Francisco Gomba jr', '09923764121', '09923764121@ebili.online', 'Member', 37, NULL, '$2y$10$moW.A8dcmeoGUrybPpjj6.BPryGAie1KWEJ2kIAYg7vAYAjZAPrEq', NULL, '2025-08-13 04:11:58', '2025-08-13 04:11:58', 'Approved'),
(38, 'Celeste belle jane Gomba', '09203088948', '09203088948@ebili.online', 'Member', 38, NULL, '$2y$10$vsVtQ6NErSi9JCUoNhHm9utESlcUS0acre/mL8PnjSpD56oRtHvvG', NULL, '2025-08-13 04:16:43', '2025-08-13 04:16:43', 'Approved'),
(39, 'Maribel Gomba', '09098006375', '09098006375@ebili.online', 'Member', 39, NULL, '$2y$10$/QH/QxbwK.j8F5Ghy74cAeCIDo04ZHjbHHT6b4Udzw4/MOv4xZvO.', NULL, '2025-08-13 04:18:01', '2025-08-13 04:18:01', 'Approved'),
(40, 'Carol Evangelista', '09061207811', '09061207811@ebili.online', 'Member', 40, NULL, '$2y$10$yaQxdLG1sG.tqR0yZunnZ.bokZqI1o8Ut7tCLTo9hdFFzadKcQ1VC', NULL, '2025-08-13 18:57:20', '2025-08-13 18:57:20', 'Approved'),
(41, 'Jennelyn Devera', '09935589239', '09935589239@ebili.online', 'Member', 41, NULL, '$2y$10$7H91tjK87Qs7Xl856veEXOg9nU9./LTaWCPfofF8cmq2su6FNTRmq', NULL, '2025-08-13 19:00:22', '2025-08-13 19:00:22', 'Approved'),
(42, 'Sharon Culala', '09661772908', '09661772908@ebili.online', 'Member', 42, NULL, '$2y$10$Xi510uYt7rIJwSBNf8FmDOLGYp4o.qoxf..UHzvAsWFDfTxq6cMOm', NULL, '2025-08-13 19:03:41', '2025-08-13 19:03:41', 'Approved'),
(43, 'Mylene Pabillaran', '09515415343', '09515415343@ebili.online', 'Member', 43, NULL, '$2y$10$pC4hzwXZBBuvLCBV3ASiku/HJQa/Iw2XmcyR3.Kyqmetx9F7HstBO', NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04', 'Approved'),
(44, 'Jenny Masaganda', '09602444087', '09602444087@ebili.online', 'Member', 44, NULL, '$2y$10$v5TGX5jltC6J4kUt4KQKB.Z3hXZaCc1378IEFSshYoMT.ZRMM2hzO', NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34', 'Approved'),
(45, 'Lorena Caburnay', '09285452074', '09285452074@ebili.online', 'Member', 45, NULL, '$2y$10$tl.qfs1KhgSGhD7n62yWe.e7be3etgqdZYoh.cScFWPdMMZ7.qPI6', NULL, '2025-08-13 21:53:20', '2025-08-13 21:53:20', 'Approved'),
(46, 'Jerry Turgo', '09353011044', '09353011044@ebili.online', 'Member', 46, NULL, '$2y$10$mbWbmAs4E2mCmQ6LJoWUlewvzz1t0e7.VZeS1ug03XtDfT32PpVlC', NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29', 'Approved'),
(47, 'Mhara jhoy Penaverde', '09319060559', '09319060559@ebili.online', 'Member', 47, NULL, '$2y$10$f8.zMPvW5fdZCanUtBnrbe026HglUXCWkbzsVbWmcu8R2EjnxmIfW', NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02', 'Approved'),
(48, 'Lorna Cereneo', '09516970806', '09516970806@ebili.online', 'Member', 48, NULL, '$2y$10$CE/2mHFaqTaJXqP1ATc7nujl1bBfaxcVm4azSECII2WszgiW/5ZUi', NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16', 'Approved'),
(49, 'Janice Lam', '09778273389', '09778273389@ebili.online', 'Member', 49, NULL, '$2y$10$7CgZ5XUiYQhOlneesNDxP.QDrIS1AeHeAGx8W0puTv3NRw3UCu01q', NULL, '2025-08-15 19:24:50', '2025-08-15 19:27:19', 'Approved'),
(50, 'Jocelyn Gonzalez', '09105069453', '09105069453@ebili.online', 'Member', 50, NULL, '$2y$10$FIL.An0BKJNVX3QxlcT35O1RRDA8JcYOzA49qYHN41DI5YQ/XaPEq', NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13', 'Approved'),
(51, 'Denden Casucom', '09617086040', '09617086040@ebili.online', 'Member', 51, NULL, '$2y$10$dx3OB5P4Vl0XFMmLdE5mK.nTx0gfV2lD4fBJBCr8JpYM5Z9fL8J86', NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51', 'Approved'),
(52, 'Liela Ponce', '09198068020', '09198068020@ebili.online', 'Member', 52, NULL, '$2y$10$QQjZMQWxh2qxuOFGaZSos.xlyVCUsUS/O./.8t7VW.A822cF3ODk.', NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48', 'Approved'),
(53, 'Kim Ponce', '09851426349', '09851426349@ebili.online', 'Member', 53, NULL, '$2y$10$Eg8E8lLUyg1Rk3GHy9ST8e8u8xnnVkw6gQhxrcxIb0jXIimj/lliC', NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05', 'Approved'),
(54, 'Hayde America', '09693126050', '09693126050@ebili.online', 'Member', 54, NULL, '$2y$10$lfHN0rEcIQ46EzDXJ0A12eWzSe7ZS97MkobRfgcVKjruAuwNzVZtK', NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57', 'Approved'),
(55, 'Rene Merana', '09923764651', '09923764651@ebili.online', 'Member', 55, NULL, '$2y$10$PQM/P04JS49B.1r.MuaQD.Hdn305FQKDc02Di6n9ExgtL/1128QVa', NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19', 'Approved'),
(56, 'Ramil Superlativo', '09461950872', '09461950872@ebili.online', 'Member', 56, NULL, '$2y$10$bkKlS9Oo5fWwN2peejH3QeFkahMseCWvM1HfLNTb/qnDe5NttoLUm', NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13', 'Approved'),
(57, 'Marilou Galvez', '09516964321', '09516964321@ebili.online', 'Member', 57, NULL, '$2y$10$CpoGWdBNeMTS9mGiBdMNT.5KVsnNjWzpV40E98Gr0BTT83mW2pe1K', NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08', 'Approved'),
(58, 'Rosalind Salinas', '09355793825', '09355793825@ebili.online', 'Member', 58, NULL, '$2y$10$p9xwWg0CpqNcIXGqRVjw8e2bdAPTxpotiKMdOlWMcWYxLzcBHdIhm', NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58', 'Approved'),
(59, 'Christine Ocampo', '09204022876', '09204022876@ebili.online', 'Member', 59, NULL, '$2y$10$MjfSCup6ThVv2pB5YPEwq.RwsSQ9.69ujuFRSYTRaJ/uEerhRaYAS', NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42', 'Approved'),
(60, 'Ellanilsa Emita', '09661921448', '09661921448@ebili.online', 'Member', 60, NULL, '$2y$10$hfFcxy4SWeQ/GcawEQX0Gu6AEwtt44lFw4M3tPs08Aqlae/8Qv/5u', NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55', 'Approved'),
(61, 'Erika Quiambao', '09916055488', '09916055488@ebili.online', 'Member', 61, NULL, '$2y$10$bQiAoWmc.w9VECBzjUrtR.P6WAAugyBaFIm5wJXdbPhRHJ.z4oDg2', NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07', 'Approved'),
(62, 'Creza Gallano', '09434732727', '09434732727@ebili.online', 'Member', 62, NULL, '$2y$10$.rd.vN5SuWlvuw4voSTjpu94QztQG7bHun8gZdgigjF2gVAVG28x6', NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49', 'Approved'),
(63, 'Joselito Puno', '09128691010', '09128691010@ebili.online', 'Member', 63, NULL, '$2y$10$pW25/x6G/dTV8ULE7x6WAuzypaHzX.bUPXYmeVXPabEYNmdwg8sBS', NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33', 'Approved'),
(64, 'Alma Puno', '09568745175', '09568745175@ebili.online', 'Member', 64, NULL, '$2y$10$WXZgUtFKHOzdoOljJsFrL.fXo2ErmB1n55ME1Zk.kWNpdW54vvdtG', NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48', 'Approved'),
(65, 'William Puno', '09096093422', '09096093422@ebili.online', 'Member', 65, NULL, '$2y$10$ZeCFbYSqk0YvVNJ9NCwbee9RWrzFe9rZn0IIA.Ieg2IIzua4JSIRu', NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59', 'Approved'),
(66, 'William Puno jr', '09306614438', '09306614438@ebili.online', 'Member', 66, NULL, '$2y$10$znW5BgoVxA6YXsp.QwfPK.yTSRZtNPKUblSrPaO0aere.IczrtbDK', NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20', 'Approved'),
(67, 'Christopher Combaliceo', '095131229861', '095131229861@ebili.online', 'Member', 67, NULL, '$2y$10$mwZj//RshidnYie0QHn2SOjUyZEqnohEfh6HjcND.8VGwwVJdNDda', NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10', 'Approved'),
(68, 'Diana Sanchez', '09454987860', '09454987860@ebili.online', 'Member', 68, NULL, '$2y$10$nE3VKf4QL4jfZVunWBKuL.KDCcjSGDYUzCGC/zWCug9OshPS8E45S', NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21', 'Approved'),
(69, 'Roman Franquia', '09308925735', '09308925735@ebili.online', 'Member', 69, NULL, '$2y$10$4YyMTwf1Galnnif0qoYvtu3XpDSA7ciqFyr/tskXwo9uIeyPFw0RG', NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52', 'Approved'),
(70, 'Armando Intrina', '09399282386', '09399282386@ebili.online', 'Member', 70, NULL, '$2y$10$YhPaNwOM/dIQcPazmvAOeOZee0X0a7iWCj/5x8SKVW2w3HHO7nVC2', NULL, '2025-08-21 03:43:36', '2025-08-21 03:43:36', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `voters`
--

CREATE TABLE `voters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `First_name` varchar(255) NOT NULL,
  `Last_name` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Precinct` varchar(255) DEFAULT NULL,
  `Class` varchar(255) DEFAULT NULL,
  `Region` varchar(255) DEFAULT NULL,
  `Province` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Barangay` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'main',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `wallet_id`, `type`, `user_id`, `member_id`, `balance`, `created_at`, `updated_at`) VALUES
(1, 'WALLET-688BF1F8577D7', 'main', NULL, 1, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(2, 'WALLET-688BF1F8577DA', 'cashback', NULL, 1, 300.00, '2025-07-31 22:45:12', '2025-08-21 03:43:36'),
(3, 'WALLET-688BF1F86B92E', 'main', NULL, 2, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(4, 'WALLET-688BF1F86B930', 'cashback', NULL, 2, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(5, 'WALLET-688BF1F86D315', 'main', NULL, 3, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(6, 'WALLET-688BF1F86D319', 'cashback', NULL, 3, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(7, 'WALLET-688BF1F86EF0C', 'main', NULL, 4, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(8, 'WALLET-688BF1F86EF15', 'cashback', NULL, 4, 415.00, '2025-07-31 22:45:12', '2025-08-21 03:43:36'),
(9, 'WALLET-688BF1F8707FB', 'main', NULL, 5, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(10, 'WALLET-688BF1F8707FF', 'cashback', NULL, 5, 25.00, '2025-07-31 22:45:12', '2025-08-12 01:14:55'),
(11, 'WALLET-688BF1F871EBC', 'main', NULL, 6, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(12, 'WALLET-688BF1F871EBF', 'cashback', NULL, 6, 0.00, '2025-07-31 22:45:12', '2025-07-31 22:45:12'),
(13, 'WALLET-688BFA99F37D8', 'main', NULL, 7, 9895.00, '2025-07-31 23:22:01', '2025-08-14 02:32:43'),
(14, 'WALLET-688BFA99F37DC', 'cashback', NULL, 7, 356.00, '2025-07-31 23:22:02', '2025-08-19 02:28:52'),
(15, 'WALLET-688BFAE026C3E', 'main', NULL, 8, 0.00, '2025-07-31 23:23:12', '2025-07-31 23:23:12'),
(16, 'WALLET-688BFAE026C43', 'cashback', NULL, 8, 170.00, '2025-07-31 23:23:12', '2025-08-04 04:13:08'),
(17, 'WALLET-688BFBCA20D19', 'main', NULL, 9, 0.00, '2025-07-31 23:27:06', '2025-07-31 23:27:06'),
(18, 'WALLET-688BFBCA20D1D', 'cashback', NULL, 9, 115.00, '2025-07-31 23:27:06', '2025-08-04 04:13:08'),
(19, 'WALLET-688C072BE8B9D', 'main', NULL, 10, 0.00, '2025-08-01 15:15:39', '2025-08-01 15:15:39'),
(20, 'WALLET-688C072BE8BA1', 'cashback', NULL, 10, 115.00, '2025-08-01 15:15:39', '2025-08-15 19:27:19'),
(21, 'WALLET-688C07C989544', 'main', NULL, 11, 25.00, '2025-08-01 15:18:17', '2025-08-11 17:37:25'),
(22, 'WALLET-688C07C989547', 'cashback', NULL, 11, 530.00, '2025-08-01 15:18:17', '2025-08-19 02:28:52'),
(23, 'WALLET-688C08C51657F', 'main', NULL, 12, 75.00, '2025-08-01 15:22:29', '2025-08-13 19:22:42'),
(24, 'WALLET-688C08C516583', 'cashback', NULL, 12, 228.00, '2025-08-01 15:22:29', '2025-08-17 23:54:20'),
(25, 'WALLET-688C09F5371D9', 'main', NULL, 13, 0.00, '2025-08-01 15:27:33', '2025-08-01 15:27:33'),
(26, 'WALLET-688C09F5371EA', 'cashback', NULL, 13, 0.00, '2025-08-01 15:27:33', '2025-08-01 15:27:33'),
(27, 'WALLET-688C0B92F1162', 'main', NULL, 14, 0.00, '2025-08-01 15:34:26', '2025-08-01 15:34:26'),
(28, 'WALLET-688C0B92F1164', 'cashback', NULL, 14, 0.00, '2025-08-01 15:34:26', '2025-08-01 15:34:26'),
(29, 'WALLET-688C0C7E67B7E', 'main', NULL, 15, 100.00, '2025-08-01 15:38:22', '2025-08-04 23:38:16'),
(30, 'WALLET-688C0C7E67B81', 'cashback', NULL, 15, 0.00, '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(31, 'WALLET-688C0D3C5D798', 'main', NULL, 16, 100.00, '2025-08-01 15:41:32', '2025-08-14 03:00:51'),
(32, 'WALLET-688C0D3C5D79D', 'cashback', NULL, 16, 0.00, '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(33, 'WALLET-688C0D84C2726', 'main', NULL, 17, 0.00, '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(34, 'WALLET-688C0D84C272A', 'cashback', NULL, 17, 0.00, '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(35, 'WALLET-688C0DCA59920', 'main', NULL, 18, 0.00, '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(36, 'WALLET-688C0DCA59923', 'cashback', NULL, 18, 0.00, '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(37, 'WALLET-688DD8C821D3A', 'main', NULL, 19, 25.00, '2025-08-03 00:22:16', '2025-08-03 00:31:21'),
(38, 'WALLET-688DD8C821D3C', 'cashback', NULL, 19, 0.00, '2025-08-03 00:22:16', '2025-08-03 00:22:16'),
(39, 'WALLET-688EE779F0036', 'main', NULL, 20, 0.00, '2025-08-03 19:37:13', '2025-08-03 19:37:13'),
(40, 'WALLET-688EE779F0039', 'cashback', NULL, 20, 0.00, '2025-08-03 19:37:13', '2025-08-03 19:37:13'),
(41, 'WALLET-688EE8081130A', 'main', NULL, 21, 0.00, '2025-08-03 19:39:36', '2025-08-03 19:39:36'),
(42, 'WALLET-688EE8081130D', 'cashback', NULL, 21, 0.00, '2025-08-03 19:39:36', '2025-08-03 19:39:36'),
(43, 'WALLET-688EE8C27C4B8', 'main', NULL, 22, 0.00, '2025-08-03 19:42:42', '2025-08-03 19:42:42'),
(44, 'WALLET-688EE8C27C4BC', 'cashback', NULL, 22, 50.00, '2025-08-03 19:42:42', '2025-08-03 19:57:25'),
(45, 'WALLET-688EEA457710F', 'main', NULL, 23, 0.00, '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(46, 'WALLET-688EEA4577116', 'cashback', NULL, 23, 0.00, '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(47, 'WALLET-688EEBAFED8D0', 'main', NULL, 24, 0.00, '2025-08-03 19:55:11', '2025-08-03 19:55:11'),
(48, 'WALLET-688EEBAFED8D2', 'cashback', NULL, 24, 0.00, '2025-08-03 19:55:11', '2025-08-03 19:55:11'),
(49, 'WALLET-688F5657023A7', 'main', NULL, 25, 0.00, '2025-08-04 03:30:15', '2025-08-04 03:30:15'),
(50, 'WALLET-688F5657023AA', 'cashback', NULL, 25, 25.00, '2025-08-04 03:30:15', '2025-08-04 04:13:08'),
(51, 'WALLET-688F5F7E2EBDE', 'main', NULL, 26, 0.00, '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(52, 'WALLET-688F5F7E2EBE1', 'cashback', NULL, 26, 0.00, '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(53, 'WALLET-688F60646B096', 'main', NULL, 27, 0.00, '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(54, 'WALLET-688F60646B09A', 'cashback', NULL, 27, 0.00, '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(55, 'WALLET-68932B15052CA', 'main', NULL, 28, 0.00, '2025-08-07 01:14:45', '2025-08-07 01:14:45'),
(56, 'WALLET-68932B15052CE', 'cashback', NULL, 28, 25.00, '2025-08-07 01:14:45', '2025-08-07 01:27:49'),
(57, 'WALLET-68932DA9D6BAD', 'main', NULL, 29, 0.00, '2025-08-07 01:25:45', '2025-08-07 01:25:45'),
(58, 'WALLET-68932DA9D6BB2', 'cashback', NULL, 29, 0.00, '2025-08-07 01:25:45', '2025-08-07 01:25:45'),
(59, 'WALLET-689330EE65670', 'main', NULL, 30, 0.00, '2025-08-07 01:39:42', '2025-08-07 01:39:42'),
(60, 'WALLET-689330EE65672', 'cashback', NULL, 30, 0.00, '2025-08-07 01:39:42', '2025-08-07 01:39:42'),
(61, 'WALLET-689588284EFB7', 'main', NULL, 31, 0.00, '2025-08-08 20:16:24', '2025-08-08 20:16:24'),
(62, 'WALLET-689588284EFBC', 'cashback', NULL, 31, 0.00, '2025-08-08 20:16:24', '2025-08-08 20:16:24'),
(63, 'WALLET-689974F0101DA', 'main', NULL, 32, 0.00, '2025-08-11 19:43:28', '2025-08-11 19:43:28'),
(64, 'WALLET-689974F0101DD', 'cashback', NULL, 32, 0.00, '2025-08-11 19:43:28', '2025-08-11 19:43:28'),
(65, 'WALLET-6899C19BD27D8', 'main', NULL, 33, 0.00, '2025-08-12 01:10:35', '2025-08-12 01:10:35'),
(66, 'WALLET-6899C19BD27DB', 'cashback', NULL, 33, 0.00, '2025-08-12 01:10:35', '2025-08-12 01:10:35'),
(67, 'WALLET-689AC32425C8D', 'main', NULL, 34, 40.00, '2025-08-12 19:29:24', '2025-08-12 19:32:56'),
(68, 'WALLET-689AC32425C90', 'cashback', NULL, 34, 0.00, '2025-08-12 19:29:24', '2025-08-12 19:29:24'),
(69, 'WALLET-689AD153454DD', 'main', NULL, 35, 0.00, '2025-08-12 20:29:55', '2025-08-12 20:29:55'),
(70, 'WALLET-689AD153454DF', 'cashback', NULL, 35, 0.00, '2025-08-12 20:29:55', '2025-08-12 20:29:55'),
(71, 'WALLET-689AE02ABFEF1', 'main', NULL, 36, 0.00, '2025-08-12 21:33:14', '2025-08-12 21:33:14'),
(72, 'WALLET-689AE02ABFEF3', 'cashback', NULL, 36, 0.00, '2025-08-12 21:33:14', '2025-08-12 21:33:14'),
(73, 'WALLET-689B3D9EBFD63', 'main', NULL, 37, 50.00, '2025-08-13 04:11:58', '2025-08-13 04:24:58'),
(74, 'WALLET-689B3D9EBFD65', 'cashback', NULL, 37, 2.00, '2025-08-13 04:11:58', '2025-08-13 04:18:01'),
(75, 'WALLET-689B3EBB1AA3E', 'main', NULL, 38, 0.00, '2025-08-13 04:16:43', '2025-08-13 04:16:43'),
(76, 'WALLET-689B3EBB1AA41', 'cashback', NULL, 38, 0.00, '2025-08-13 04:16:43', '2025-08-13 04:16:43'),
(77, 'WALLET-689B3F08ED3B1', 'main', NULL, 39, 0.00, '2025-08-13 04:18:00', '2025-08-13 04:18:00'),
(78, 'WALLET-689B3F08ED3B9', 'cashback', NULL, 39, 0.00, '2025-08-13 04:18:00', '2025-08-13 04:18:00'),
(79, 'WALLET-689C0D206C96D', 'main', NULL, 40, 0.00, '2025-08-13 18:57:20', '2025-08-13 18:57:20'),
(80, 'WALLET-689C0D206C971', 'cashback', NULL, 40, 0.00, '2025-08-13 18:57:20', '2025-08-13 18:57:20'),
(81, 'WALLET-689C0DD5F4098', 'main', NULL, 41, 0.00, '2025-08-13 19:00:21', '2025-08-13 19:00:21'),
(82, 'WALLET-689C0DD5F409F', 'cashback', NULL, 41, 0.00, '2025-08-13 19:00:22', '2025-08-13 19:00:22'),
(83, 'WALLET-689C0E9D5A93F', 'main', NULL, 42, 0.00, '2025-08-13 19:03:41', '2025-08-13 19:03:41'),
(84, 'WALLET-689C0E9D5A942', 'cashback', NULL, 42, 0.00, '2025-08-13 19:03:41', '2025-08-13 19:03:41'),
(85, 'WALLET-689C0F6819A28', 'main', NULL, 43, 0.00, '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(86, 'WALLET-689C0F6819A2C', 'cashback', NULL, 43, 0.00, '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(87, 'WALLET-689C0FC221453', 'main', NULL, 44, 0.00, '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(88, 'WALLET-689C0FC221457', 'cashback', NULL, 44, 0.00, '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(89, 'WALLET-689C365FF3F0E', 'main', NULL, 45, 0.00, '2025-08-13 21:53:19', '2025-08-13 21:53:19'),
(90, 'WALLET-689C365FF3F12', 'cashback', NULL, 45, 0.00, '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(91, 'WALLET-689C36A5D3312', 'main', NULL, 46, 0.00, '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(92, 'WALLET-689C36A5D3314', 'cashback', NULL, 46, 0.00, '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(93, 'WALLET-689C37027FE27', 'main', NULL, 47, 0.00, '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(94, 'WALLET-689C37027FE2F', 'cashback', NULL, 47, 0.00, '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(95, 'WALLET-689C374CD0B68', 'main', NULL, 48, 0.00, '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(96, 'WALLET-689C374CD0B6D', 'cashback', NULL, 48, 0.00, '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(97, 'WALLET-689EB6921965D', 'main', NULL, 49, 0.00, '2025-08-15 19:24:50', '2025-08-15 19:24:50'),
(98, 'WALLET-689EB6921965F', 'cashback', NULL, 49, 0.00, '2025-08-15 19:24:50', '2025-08-15 19:24:50'),
(99, 'WALLET-689ED82DB4C76', 'main', NULL, 50, 0.00, '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(100, 'WALLET-689ED82DB4C7B', 'cashback', NULL, 50, 0.00, '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(101, 'WALLET-689ED88FAB1EC', 'main', NULL, 51, 0.00, '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(102, 'WALLET-689ED88FAB1EF', 'cashback', NULL, 51, 0.00, '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(103, 'WALLET-689ED8C81A816', 'main', NULL, 52, 0.00, '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(104, 'WALLET-689ED8C81A81D', 'cashback', NULL, 52, 0.00, '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(105, 'WALLET-689ED915731DE', 'main', NULL, 53, 0.00, '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(106, 'WALLET-689ED915731E5', 'cashback', NULL, 53, 0.00, '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(107, 'WALLET-689ED94921034', 'main', NULL, 54, 0.00, '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(108, 'WALLET-689ED9492103A', 'cashback', NULL, 54, 0.00, '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(109, 'WALLET-689ED99B62446', 'main', NULL, 55, 0.00, '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(110, 'WALLET-689ED99B62449', 'cashback', NULL, 55, 0.00, '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(111, 'WALLET-689ED9D14BE5A', 'main', NULL, 56, 0.00, '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(112, 'WALLET-689ED9D14BE5C', 'cashback', NULL, 56, 0.00, '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(113, 'WALLET-689EDA087CBD2', 'main', NULL, 57, 0.00, '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(114, 'WALLET-689EDA087CBD7', 'cashback', NULL, 57, 0.00, '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(115, 'WALLET-689EDA3A81CC4', 'main', NULL, 58, 0.00, '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(116, 'WALLET-689EDA3A81CC6', 'cashback', NULL, 58, 0.00, '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(117, 'WALLET-689EDA6632ED0', 'main', NULL, 59, 0.00, '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(118, 'WALLET-689EDA6632ED5', 'cashback', NULL, 59, 0.00, '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(119, 'WALLET-68A1964B5EC68', 'main', NULL, 60, 0.00, '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(120, 'WALLET-68A1964B5EC6B', 'cashback', NULL, 60, 0.00, '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(121, 'WALLET-68A1969318527', 'main', NULL, 61, 0.00, '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(122, 'WALLET-68A196931852C', 'cashback', NULL, 61, 0.00, '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(123, 'WALLET-68A197715C00A', 'main', NULL, 62, 0.00, '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(124, 'WALLET-68A197715C00F', 'cashback', NULL, 62, 0.00, '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(125, 'WALLET-68A197D9A2AE2', 'main', NULL, 63, 0.00, '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(126, 'WALLET-68A197D9A2AE6', 'cashback', NULL, 63, 0.00, '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(127, 'WALLET-68A19824D16E0', 'main', NULL, 64, 0.00, '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(128, 'WALLET-68A19824D16E7', 'cashback', NULL, 64, 0.00, '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(129, 'WALLET-68A1986B548E1', 'main', NULL, 65, 0.00, '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(130, 'WALLET-68A1986B548E6', 'cashback', NULL, 65, 0.00, '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(131, 'WALLET-68A198BC09B20', 'main', NULL, 66, 0.00, '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(132, 'WALLET-68A198BC09B24', 'cashback', NULL, 66, 0.00, '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(133, 'WALLET-68A30DD214950', 'main', NULL, 67, 0.00, '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(134, 'WALLET-68A30DD214953', 'cashback', NULL, 67, 0.00, '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(135, 'WALLET-68A30E1916294', 'main', NULL, 68, 0.00, '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(136, 'WALLET-68A30E1916298', 'cashback', NULL, 68, 0.00, '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(137, 'WALLET-68A30E747D492', 'main', NULL, 69, 0.00, '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(138, 'WALLET-68A30E747D498', 'cashback', NULL, 69, 0.00, '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(139, 'WALLET-68A5C2F891D3B', 'main', NULL, 70, 0.00, '2025-08-21 03:43:36', '2025-08-21 03:43:36'),
(140, 'WALLET-68A5C2F891D40', 'cashback', NULL, 70, 0.00, '2025-08-21 03:43:36', '2025-08-21 03:43:36');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('credit','debit','transfer','payment','cashback') DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  `related_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `wallet_id`, `member_id`, `type`, `amount`, `source`, `description`, `notes`, `related_member_id`, `created_at`, `updated_at`) VALUES
(1, 8, 4, 'credit', 25.00, NULL, 'Direct referral bonus from Benje Malik', NULL, NULL, '2025-07-31 23:22:02', '2025-07-31 23:22:02'),
(2, 2, 1, 'credit', 15.00, NULL, '2nd level referral bonus from Benje Malik', NULL, NULL, '2025-07-31 23:22:02', '2025-07-31 23:22:02'),
(3, 8, 4, 'credit', 25.00, NULL, 'Direct referral bonus from Paul Allen', NULL, NULL, '2025-07-31 23:27:06', '2025-07-31 23:27:06'),
(4, 2, 1, 'credit', 15.00, NULL, '2nd level referral bonus from Paul Allen', NULL, NULL, '2025-07-31 23:27:06', '2025-07-31 23:27:06'),
(5, 18, 9, 'credit', 25.00, NULL, 'Direct referral bonus from Lu Cab', NULL, NULL, '2025-08-01 14:52:06', '2025-08-01 14:52:06'),
(6, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from Lu Cab', NULL, NULL, '2025-08-01 14:52:06', '2025-08-01 14:52:06'),
(7, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from Lu Cab', NULL, NULL, '2025-08-01 14:52:06', '2025-08-01 14:52:06'),
(8, 14, 7, 'credit', 25.00, NULL, 'Direct referral bonus from Macaria Opeńa', NULL, NULL, '2025-08-01 15:15:40', '2025-08-01 15:15:40'),
(9, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from Macaria Opeńa', NULL, NULL, '2025-08-01 15:15:40', '2025-08-01 15:15:40'),
(10, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from Macaria Opeńa', NULL, NULL, '2025-08-01 15:15:40', '2025-08-01 15:15:40'),
(11, 14, 7, 'credit', 25.00, NULL, 'Direct referral bonus from Marissa Labrador', NULL, NULL, '2025-08-01 15:19:08', '2025-08-01 15:19:08'),
(12, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from Marissa Labrador', NULL, NULL, '2025-08-01 15:19:08', '2025-08-01 15:19:08'),
(13, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from Marissa Labrador', NULL, NULL, '2025-08-01 15:19:08', '2025-08-01 15:19:08'),
(14, 14, 7, 'credit', 25.00, NULL, 'Direct referral bonus from Lorina Phuno', NULL, NULL, '2025-08-01 15:23:14', '2025-08-01 15:23:14'),
(15, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from Lorina Phuno', NULL, NULL, '2025-08-01 15:23:14', '2025-08-01 15:23:14'),
(16, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from Lorina Phuno', NULL, NULL, '2025-08-01 15:23:14', '2025-08-01 15:23:14'),
(17, 14, 7, 'credit', 25.00, NULL, 'Direct referral bonus from Perla Andio', NULL, NULL, '2025-08-01 15:28:12', '2025-08-01 15:28:12'),
(18, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from Perla Andio', NULL, NULL, '2025-08-01 15:28:12', '2025-08-01 15:28:12'),
(19, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from Perla Andio', NULL, NULL, '2025-08-01 15:28:12', '2025-08-01 15:28:12'),
(20, 14, 7, NULL, -100.00, NULL, 'Transfer to main wallet (-₱0.00 fee)', NULL, NULL, '2025-08-01 15:29:54', '2025-08-01 15:29:54'),
(21, 13, 7, NULL, 100.00, NULL, 'Received from cashback wallet (₱100.00 - ₱0.00 fee)', NULL, NULL, '2025-08-01 15:29:54', '2025-08-01 15:29:54'),
(22, 14, 7, 'credit', 25.00, NULL, 'Direct referral bonus from Jericho Noveno', NULL, NULL, '2025-08-01 15:34:27', '2025-08-01 15:34:27'),
(23, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from Jericho Noveno', NULL, NULL, '2025-08-01 15:34:27', '2025-08-01 15:34:27'),
(24, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from Jericho Noveno', NULL, NULL, '2025-08-01 15:34:27', '2025-08-01 15:34:27'),
(25, 14, 7, 'credit', 25.00, NULL, 'Direct referral bonus from MTC\'s Fruits hakes and Foodhub', NULL, NULL, '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(26, 8, 4, 'credit', 15.00, NULL, '2nd level referral bonus from MTC\'s Fruits hakes and Foodhub', NULL, NULL, '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(27, 2, 1, 'credit', 10.00, NULL, '3nd level referral bonus from MTC\'s Fruits hakes and Foodhub', NULL, NULL, '2025-08-01 15:38:22', '2025-08-01 15:38:22'),
(28, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Ian Amiel Santidad', NULL, NULL, '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(29, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Ian Amiel Santidad', NULL, NULL, '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(30, 8, 4, 'credit', 10.00, NULL, '3nd level referral bonus from Ian Amiel Santidad', NULL, NULL, '2025-08-01 15:41:32', '2025-08-01 15:41:32'),
(31, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Rhona Morilla', NULL, NULL, '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(32, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Rhona Morilla', NULL, NULL, '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(33, 8, 4, 'credit', 10.00, NULL, '3nd level referral bonus from Rhona Morilla', NULL, NULL, '2025-08-01 15:42:44', '2025-08-01 15:42:44'),
(34, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Elvira Rutagines', NULL, NULL, '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(35, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Elvira Rutagines', NULL, NULL, '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(36, 8, 4, 'credit', 10.00, NULL, '3nd level referral bonus from Elvira Rutagines', NULL, NULL, '2025-08-01 15:43:54', '2025-08-01 15:43:54'),
(37, 20, 10, 'credit', 25.00, NULL, 'Direct referral bonus from jancel andrade', NULL, NULL, '2025-08-03 00:24:30', '2025-08-03 00:24:30'),
(38, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from jancel andrade', NULL, NULL, '2025-08-03 00:24:30', '2025-08-03 00:24:30'),
(39, 8, 4, 'credit', 10.00, NULL, '3nd level referral bonus from jancel andrade', NULL, NULL, '2025-08-03 00:24:30', '2025-08-03 00:24:30'),
(40, 13, 7, 'debit', 25.00, 'qr_payment', 'QR Payment to 09703100243', NULL, NULL, '2025-08-03 00:31:21', '2025-08-03 00:31:21'),
(41, 37, 19, 'credit', 25.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-03 00:31:21', '2025-08-03 00:31:21'),
(42, 16, 8, 'credit', 25.00, NULL, 'Direct referral bonus from Renz Licarte', NULL, NULL, '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(43, 18, 9, 'credit', 15.00, NULL, '2nd level referral bonus from Renz Licarte', NULL, NULL, '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(44, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Renz Licarte', NULL, NULL, '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(45, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Renz Licarte', NULL, NULL, '2025-08-03 19:37:14', '2025-08-03 19:37:14'),
(46, 16, 8, 'credit', 25.00, NULL, 'Direct referral bonus from Nor Umpar', NULL, NULL, '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(47, 18, 9, 'credit', 15.00, NULL, '2nd level referral bonus from Nor Umpar', NULL, NULL, '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(48, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Nor Umpar', NULL, NULL, '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(49, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Nor Umpar', NULL, NULL, '2025-08-03 19:43:55', '2025-08-03 19:43:55'),
(50, 16, 8, 'credit', 25.00, NULL, 'Direct referral bonus from Mary ann Pagas', NULL, NULL, '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(51, 18, 9, 'credit', 15.00, NULL, '2nd level referral bonus from Mary ann Pagas', NULL, NULL, '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(52, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Mary ann Pagas', NULL, NULL, '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(53, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Mary ann Pagas', NULL, NULL, '2025-08-03 19:44:28', '2025-08-03 19:44:28'),
(54, 44, 22, 'credit', 25.00, NULL, 'Direct referral bonus from Ariel Capili', NULL, NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(55, 16, 8, 'credit', 15.00, NULL, '2nd level referral bonus from Ariel Capili', NULL, NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(56, 18, 9, 'credit', 5.00, NULL, '3nd level referral bonus from Ariel Capili', NULL, NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(57, 8, 4, 'credit', 5.00, NULL, '4nd level referral bonus from Ariel Capili', NULL, NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09'),
(58, 44, 22, 'credit', 25.00, NULL, 'Direct referral bonus from Melanie Guiday', NULL, NULL, '2025-08-03 19:57:25', '2025-08-03 19:57:25'),
(59, 16, 8, 'credit', 15.00, NULL, '2nd level referral bonus from Melanie Guiday', NULL, NULL, '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(60, 18, 9, 'credit', 5.00, NULL, '3nd level referral bonus from Melanie Guiday', NULL, NULL, '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(61, 8, 4, 'credit', 5.00, NULL, '4nd level referral bonus from Melanie Guiday', NULL, NULL, '2025-08-03 19:57:26', '2025-08-03 19:57:26'),
(62, 16, 8, 'credit', 25.00, NULL, 'Direct referral bonus from Margie Palacio', NULL, NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(63, 18, 9, 'credit', 15.00, NULL, '2nd level referral bonus from Margie Palacio', NULL, NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(64, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Margie Palacio', NULL, NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(65, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Margie Palacio', NULL, NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18'),
(66, 16, 8, 'credit', 25.00, NULL, 'Direct referral bonus from Bernie Baldesco', NULL, NULL, '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(67, 18, 9, 'credit', 15.00, NULL, '2nd level referral bonus from Bernie Baldesco', NULL, NULL, '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(68, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Bernie Baldesco', NULL, NULL, '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(69, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Bernie Baldesco', NULL, NULL, '2025-08-04 04:12:17', '2025-08-04 04:12:17'),
(70, 50, 25, 'credit', 25.00, NULL, 'Direct referral bonus from Cindy Bandao', NULL, NULL, '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(71, 16, 8, 'credit', 15.00, NULL, '2nd level referral bonus from Cindy Bandao', NULL, NULL, '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(72, 18, 9, 'credit', 5.00, NULL, '3nd level referral bonus from Cindy Bandao', NULL, NULL, '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(73, 8, 4, 'credit', 5.00, NULL, '4nd level referral bonus from Cindy Bandao', NULL, NULL, '2025-08-04 04:13:08', '2025-08-04 04:13:08'),
(74, 14, 7, NULL, -110.00, NULL, 'Transfer to main wallet (-₱0.00 fee)', NULL, NULL, '2025-08-04 22:58:09', '2025-08-04 22:58:09'),
(75, 13, 7, NULL, 110.00, NULL, 'Received from cashback wallet (₱110.00 - ₱0.00 fee)', NULL, NULL, '2025-08-04 22:58:09', '2025-08-04 22:58:09'),
(76, 13, 7, 'debit', 100.00, 'qr_payment', 'QR Payment to 09651233549', NULL, NULL, '2025-08-04 23:38:16', '2025-08-04 23:38:16'),
(77, 29, 15, 'credit', 100.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-04 23:38:16', '2025-08-04 23:38:16'),
(78, 20, 10, 'credit', 25.00, NULL, 'Direct referral bonus from Ma theresa Garcia', NULL, NULL, '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(79, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Ma theresa Garcia', NULL, NULL, '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(80, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Ma theresa Garcia', NULL, NULL, '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(81, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Ma theresa Garcia', NULL, NULL, '2025-08-07 01:18:37', '2025-08-07 01:18:37'),
(82, 56, 28, 'credit', 25.00, NULL, 'Direct referral bonus from Melba Gruta', NULL, NULL, '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(83, 20, 10, 'credit', 15.00, NULL, '2nd level referral bonus from Melba Gruta', NULL, NULL, '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(84, 14, 7, 'credit', 5.00, NULL, '3nd level referral bonus from Melba Gruta', NULL, NULL, '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(85, 8, 4, 'credit', 5.00, NULL, '4nd level referral bonus from Melba Gruta', NULL, NULL, '2025-08-07 01:27:49', '2025-08-07 01:27:49'),
(86, 20, 10, 'credit', 25.00, NULL, 'Direct referral bonus from Sauda Nasirin', NULL, NULL, '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(87, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Sauda Nasirin', NULL, NULL, '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(88, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Sauda Nasirin', NULL, NULL, '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(89, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Sauda Nasirin', NULL, NULL, '2025-08-07 05:36:33', '2025-08-07 05:36:33'),
(90, 13, 7, 'debit', 25.00, 'qr_payment', 'QR Payment to 09109868673', NULL, NULL, '2025-08-11 17:37:25', '2025-08-11 17:37:25'),
(91, 21, 11, 'credit', 25.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-11 17:37:25', '2025-08-11 17:37:25'),
(92, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Jusel Ormenita', NULL, NULL, '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(93, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Jusel Ormenita', NULL, NULL, '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(94, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Jusel Ormenita', NULL, NULL, '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(95, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Jusel Ormenita', NULL, NULL, '2025-08-11 19:45:58', '2025-08-11 19:45:58'),
(96, 10, 5, 'credit', 25.00, NULL, 'Direct referral bonus from Infanta cafe-tea-ria ebili.online Cashless payment only', NULL, NULL, '2025-08-12 01:14:55', '2025-08-12 01:14:55'),
(97, 2, 1, 'credit', 15.00, NULL, '2nd level referral bonus from Infanta cafe-tea-ria ebili.online Cashless payment only', NULL, NULL, '2025-08-12 01:14:55', '2025-08-12 01:14:55'),
(98, 13, 7, 'debit', 40.00, 'qr_payment', 'QR Payment to 09705759833', NULL, NULL, '2025-08-12 19:32:56', '2025-08-12 19:32:56'),
(99, 67, 34, 'credit', 40.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-12 19:32:56', '2025-08-12 19:32:56'),
(100, 13, 7, 'credit', 10000.00, NULL, 'Topup by Admin - Marketing fund', NULL, NULL, '2025-08-12 20:09:16', '2025-08-12 20:09:16'),
(101, 22, 11, 'credit', 1.00, NULL, 'Direct referral bonus from Ivana\'s food hub Merchant partner', NULL, NULL, '2025-08-12 20:29:55', '2025-08-12 20:29:55'),
(102, 14, 7, 'credit', 1.00, NULL, '2nd level referral bonus from Ivana\'s food hub Merchant partner', NULL, NULL, '2025-08-12 20:29:55', '2025-08-12 20:29:55'),
(103, 22, 11, 'credit', 1.00, NULL, 'Direct referral bonus from Nathalia Dazo', NULL, NULL, '2025-08-12 21:33:14', '2025-08-12 21:33:14'),
(104, 14, 7, 'credit', 1.00, NULL, '2nd level referral bonus from Nathalia Dazo', NULL, NULL, '2025-08-12 21:33:14', '2025-08-12 21:33:14'),
(105, 22, 11, 'credit', 1.00, NULL, 'Direct referral bonus from Francisco Gomba jr', NULL, NULL, '2025-08-13 04:11:58', '2025-08-13 04:11:58'),
(106, 14, 7, 'credit', 1.00, NULL, '2nd level referral bonus from Francisco Gomba jr', NULL, NULL, '2025-08-13 04:11:58', '2025-08-13 04:11:58'),
(107, 74, 37, 'credit', 1.00, NULL, 'Direct referral bonus from Celeste belle jane Gomba', NULL, NULL, '2025-08-13 04:16:43', '2025-08-13 04:16:43'),
(108, 22, 11, 'credit', 1.00, NULL, '2nd level referral bonus from Celeste belle jane Gomba', NULL, NULL, '2025-08-13 04:16:43', '2025-08-13 04:16:43'),
(109, 74, 37, 'credit', 1.00, NULL, 'Direct referral bonus from Maribel Gomba', NULL, NULL, '2025-08-13 04:18:01', '2025-08-13 04:18:01'),
(110, 22, 11, 'credit', 1.00, NULL, '2nd level referral bonus from Maribel Gomba', NULL, NULL, '2025-08-13 04:18:01', '2025-08-13 04:18:01'),
(111, 13, 7, 'debit', 50.00, 'qr_payment', 'QR Payment to 09923764121', NULL, NULL, '2025-08-13 04:24:58', '2025-08-13 04:24:58'),
(112, 73, 37, 'credit', 50.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-13 04:24:58', '2025-08-13 04:24:58'),
(113, 24, 12, 'credit', 1.00, NULL, 'Direct referral bonus from Carol Evangelista', NULL, NULL, '2025-08-13 18:57:20', '2025-08-13 18:57:20'),
(114, 14, 7, 'credit', 1.00, NULL, '2nd level referral bonus from Carol Evangelista', NULL, NULL, '2025-08-13 18:57:20', '2025-08-13 18:57:20'),
(115, 24, 12, 'credit', 1.00, NULL, 'Direct referral bonus from Jennelyn Devera', NULL, NULL, '2025-08-13 19:00:22', '2025-08-13 19:00:22'),
(116, 14, 7, 'credit', 1.00, NULL, '2nd level referral bonus from Jennelyn Devera', NULL, NULL, '2025-08-13 19:00:22', '2025-08-13 19:00:22'),
(117, 24, 12, 'credit', 1.00, NULL, 'Direct referral bonus from Sharon Culala', NULL, NULL, '2025-08-13 19:03:41', '2025-08-13 19:03:41'),
(118, 14, 7, 'credit', 1.00, NULL, '2nd level referral bonus from Sharon Culala', NULL, NULL, '2025-08-13 19:03:41', '2025-08-13 19:03:41'),
(119, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Mylene Pabillaran', NULL, NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(120, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Mylene Pabillaran', NULL, NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(121, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Mylene Pabillaran', NULL, NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(122, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Mylene Pabillaran', NULL, NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04'),
(123, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Jenny Masaganda', NULL, NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(124, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Jenny Masaganda', NULL, NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(125, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Jenny Masaganda', NULL, NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(126, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Jenny Masaganda', NULL, NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34'),
(127, 13, 7, 'debit', 75.00, 'qr_payment', 'QR Payment to 09306730491', NULL, NULL, '2025-08-13 19:22:42', '2025-08-13 19:22:42'),
(128, 23, 12, 'credit', 75.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-13 19:22:42', '2025-08-13 19:22:42'),
(129, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Lorena Caburnay', NULL, NULL, '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(130, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Lorena Caburnay', NULL, NULL, '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(131, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Lorena Caburnay', NULL, NULL, '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(132, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Lorena Caburnay', NULL, NULL, '2025-08-13 21:53:20', '2025-08-13 21:53:20'),
(133, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Jerry Turgo', NULL, NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(134, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Jerry Turgo', NULL, NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(135, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Jerry Turgo', NULL, NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(136, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Jerry Turgo', NULL, NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29'),
(137, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Mhara jhoy Penaverde', NULL, NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(138, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Mhara jhoy Penaverde', NULL, NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(139, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Mhara jhoy Penaverde', NULL, NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(140, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Mhara jhoy Penaverde', NULL, NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02'),
(141, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Lorna Cereneo', NULL, NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(142, 14, 7, 'credit', 15.00, NULL, '2nd level referral bonus from Lorna Cereneo', NULL, NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(143, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Lorna Cereneo', NULL, NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(144, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Lorna Cereneo', NULL, NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16'),
(145, 13, 7, 'debit', 25.00, 'qr_payment', 'QR Payment to 09915508102', NULL, NULL, '2025-08-14 02:31:59', '2025-08-14 02:31:59'),
(146, 31, 16, 'credit', 25.00, 'qr_payment', 'QR Payment from 09151836162', NULL, NULL, '2025-08-14 02:31:59', '2025-08-14 02:31:59'),
(147, 31, 16, 'debit', 25.00, 'qr_payment', 'QR Payment to 09151836162', NULL, NULL, '2025-08-14 02:32:43', '2025-08-14 02:32:43'),
(148, 13, 7, 'credit', 25.00, 'qr_payment', 'QR Payment from 09915508102', NULL, NULL, '2025-08-14 02:32:43', '2025-08-14 02:32:43'),
(149, 31, 16, 'credit', 100.00, NULL, 'Topup by Admin - Testing', NULL, NULL, '2025-08-14 03:00:51', '2025-08-14 03:00:51'),
(150, 20, 10, 'credit', 25.00, NULL, 'Direct referral bonus from Janice Lam', NULL, NULL, '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(151, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Janice Lam', NULL, NULL, '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(152, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Janice Lam', NULL, NULL, '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(153, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Janice Lam', NULL, NULL, '2025-08-15 19:27:19', '2025-08-15 19:27:19'),
(154, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Jocelyn Gonzalez', NULL, NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(155, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Jocelyn Gonzalez', NULL, NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(156, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Jocelyn Gonzalez', NULL, NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(157, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Jocelyn Gonzalez', NULL, NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13'),
(158, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Denden Casucom', NULL, NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(159, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Denden Casucom', NULL, NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(160, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Denden Casucom', NULL, NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(161, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Denden Casucom', NULL, NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51'),
(162, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Liela Ponce', NULL, NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(163, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Liela Ponce', NULL, NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(164, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Liela Ponce', NULL, NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(165, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Liela Ponce', NULL, NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48'),
(166, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Kim Ponce', NULL, NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(167, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Kim Ponce', NULL, NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(168, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Kim Ponce', NULL, NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(169, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Kim Ponce', NULL, NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05'),
(170, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Hayde America', NULL, NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(171, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Hayde America', NULL, NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(172, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Hayde America', NULL, NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(173, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Hayde America', NULL, NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57'),
(174, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Rene Merana', NULL, NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(175, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Rene Merana', NULL, NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(176, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Rene Merana', NULL, NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(177, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Rene Merana', NULL, NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19'),
(178, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Ramil Superlativo', NULL, NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(179, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Ramil Superlativo', NULL, NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(180, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Ramil Superlativo', NULL, NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(181, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Ramil Superlativo', NULL, NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13'),
(182, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Marilou Galvez', NULL, NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(183, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Marilou Galvez', NULL, NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(184, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Marilou Galvez', NULL, NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(185, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Marilou Galvez', NULL, NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08'),
(186, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Rosalind Salinas', NULL, NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(187, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Rosalind Salinas', NULL, NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(188, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Rosalind Salinas', NULL, NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(189, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Rosalind Salinas', NULL, NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58'),
(190, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Christine Ocampo', NULL, NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(191, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Christine Ocampo', NULL, NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(192, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Christine Ocampo', NULL, NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(193, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Christine Ocampo', NULL, NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42'),
(194, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Ellanilsa Emita', NULL, NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(195, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Ellanilsa Emita', NULL, NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(196, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Ellanilsa Emita', NULL, NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(197, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Ellanilsa Emita', NULL, NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55'),
(198, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Erika Quiambao', NULL, NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(199, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Erika Quiambao', NULL, NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(200, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Erika Quiambao', NULL, NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(201, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Erika Quiambao', NULL, NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07'),
(202, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Creza Gallano', NULL, NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(203, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Creza Gallano', NULL, NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(204, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Creza Gallano', NULL, NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(205, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Creza Gallano', NULL, NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49'),
(206, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Joselito Puno', NULL, NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(207, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Joselito Puno', NULL, NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(208, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Joselito Puno', NULL, NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(209, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Joselito Puno', NULL, NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33'),
(210, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from Alma Puno', NULL, NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(211, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Alma Puno', NULL, NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(212, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Alma Puno', NULL, NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(213, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Alma Puno', NULL, NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48'),
(214, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from William Puno', NULL, NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(215, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from William Puno', NULL, NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(216, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from William Puno', NULL, NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(217, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from William Puno', NULL, NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59'),
(218, 24, 12, 'credit', 25.00, NULL, 'Direct referral bonus from William Puno jr', NULL, NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(219, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from William Puno jr', NULL, NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(220, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from William Puno jr', NULL, NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(221, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from William Puno jr', NULL, NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20'),
(222, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Christopher Combaliceo', NULL, NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(223, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Christopher Combaliceo', NULL, NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(224, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Christopher Combaliceo', NULL, NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(225, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Christopher Combaliceo', NULL, NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10'),
(226, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Diana Sanchez', NULL, NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(227, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Diana Sanchez', NULL, NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(228, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Diana Sanchez', NULL, NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(229, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Diana Sanchez', NULL, NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21'),
(230, 22, 11, 'credit', 25.00, NULL, 'Direct referral bonus from Roman Franquia', NULL, NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(231, 14, 7, 'credit', 10.00, NULL, '2nd level referral bonus from Roman Franquia', NULL, NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(232, 8, 4, 'credit', 5.00, NULL, '3nd level referral bonus from Roman Franquia', NULL, NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(233, 2, 1, 'credit', 5.00, NULL, '4nd level referral bonus from Roman Franquia', NULL, NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52'),
(234, 8, 4, 'credit', 25.00, NULL, 'Direct referral bonus from Armando Intrina', NULL, NULL, '2025-08-21 03:43:36', '2025-08-21 03:43:36'),
(235, 2, 1, 'credit', 10.00, NULL, '2nd level referral bonus from Armando Intrina', NULL, NULL, '2025-08-21 03:43:36', '2025-08-21 03:43:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `benefits`
--
ALTER TABLE `benefits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `benefit_member`
--
ALTER TABLE `benefit_member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `benefit_member_benefit_id_foreign` (`benefit_id`),
  ADD KEY `benefit_member_member_id_foreign` (`member_id`);

--
-- Indexes for table `cashback_logs`
--
ALTER TABLE `cashback_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cashback_logs_member_id_foreign` (`member_id`),
  ADD KEY `cashback_logs_order_id_foreign` (`order_id`),
  ADD KEY `cashback_logs_product_id_foreign` (`product_id`);

--
-- Indexes for table `cash_in_requests`
--
ALTER TABLE `cash_in_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_in_requests_member_id_foreign` (`member_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `device_tokens_user_id_device_token_unique` (`user_id`,`device_token`),
  ADD KEY `device_tokens_user_id_is_active_index` (`user_id`,`is_active`),
  ADD KEY `device_tokens_device_type_index` (`device_type`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loans_member_id_foreign` (`member_id`);

--
-- Indexes for table `loan_payments`
--
ALTER TABLE `loan_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loan_payments_loan_id_foreign` (`loan_id`),
  ADD KEY `loan_payments_verified_by_foreign` (`verified_by`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `members_mobile_number_unique` (`mobile_number`),
  ADD KEY `members_sponsor_id_index` (`sponsor_id`),
  ADD KEY `members_voter_id_index` (`voter_id`);

--
-- Indexes for table `membership_codes`
--
ALTER TABLE `membership_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `membership_codes_code_unique` (`code`),
  ADD KEY `membership_codes_used_by_foreign` (`used_by`),
  ADD KEY `membership_codes_reserved_by_foreign` (`reserved_by`);

--
-- Indexes for table `membership_code_requests`
--
ALTER TABLE `membership_code_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `membership_code_requests_member_id_foreign` (`member_id`);

--
-- Indexes for table `membership_code_request_codes`
--
ALTER TABLE `membership_code_request_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `membership_code_request_codes_membership_code_request_id_foreign` (`membership_code_request_id`),
  ADD KEY `membership_code_request_codes_membership_code_id_foreign` (`membership_code_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobile_password_resets`
--
ALTER TABLE `mobile_password_resets`
  ADD KEY `mobile_password_resets_mobile_number_index` (`mobile_number`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_member_id_foreign` (`member_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_unit_id_foreign` (`unit_id`),
  ADD KEY `products_created_by_foreign` (`created_by`);

--
-- Indexes for table `referral_bonus_logs`
--
ALTER TABLE `referral_bonus_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `referral_bonus_logs_member_id_foreign` (`member_id`),
  ADD KEY `referral_bonus_logs_referred_member_id_foreign` (`referred_member_id`);

--
-- Indexes for table `referral_configurations`
--
ALTER TABLE `referral_configurations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_programs`
--
ALTER TABLE `reward_programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reward_programs_winner_id_foreign` (`winner_id`);

--
-- Indexes for table `reward_winners`
--
ALTER TABLE `reward_winners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reward_winners_member_id_foreign` (`member_id`),
  ADD KEY `fk_rwinners_program` (`reward_program_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `sms_logs`
--
ALTER TABLE `sms_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sms_logs_recipient_type_status_index` (`recipient_type`,`status`),
  ADD KEY `sms_logs_sent_at_index` (`sent_at`),
  ADD KEY `sms_logs_sent_by_index` (`sent_by`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_member_id_foreign` (`member_id`);

--
-- Indexes for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_replies_ticket_id_foreign` (`ticket_id`),
  ADD KEY `ticket_replies_member_id_foreign` (`member_id`),
  ADD KEY `ticket_replies_user_id_foreign` (`user_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `units_name_unique` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_mobile_number_unique` (`mobile_number`),
  ADD KEY `users_member_id_index` (`member_id`);

--
-- Indexes for table `voters`
--
ALTER TABLE `voters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wallets_wallet_id_unique` (`wallet_id`),
  ADD KEY `wallets_member_id_foreign` (`member_id`),
  ADD KEY `wallets_user_id_foreign` (`user_id`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallet_transactions_member_id_foreign` (`member_id`),
  ADD KEY `wallet_transactions_related_member_id_foreign` (`related_member_id`),
  ADD KEY `wallet_transactions_wallet_id_foreign` (`wallet_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `benefits`
--
ALTER TABLE `benefits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `benefit_member`
--
ALTER TABLE `benefit_member`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cashback_logs`
--
ALTER TABLE `cashback_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_in_requests`
--
ALTER TABLE `cash_in_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `device_tokens`
--
ALTER TABLE `device_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_payments`
--
ALTER TABLE `loan_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `membership_codes`
--
ALTER TABLE `membership_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `membership_code_requests`
--
ALTER TABLE `membership_code_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `membership_code_request_codes`
--
ALTER TABLE `membership_code_request_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `referral_bonus_logs`
--
ALTER TABLE `referral_bonus_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=214;

--
-- AUTO_INCREMENT for table `referral_configurations`
--
ALTER TABLE `referral_configurations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reward_programs`
--
ALTER TABLE `reward_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reward_winners`
--
ALTER TABLE `reward_winners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sms_logs`
--
ALTER TABLE `sms_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `benefit_member`
--
ALTER TABLE `benefit_member`
  ADD CONSTRAINT `benefit_member_benefit_id_foreign` FOREIGN KEY (`benefit_id`) REFERENCES `benefits` (`id`),
  ADD CONSTRAINT `benefit_member_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `cashback_logs`
--
ALTER TABLE `cashback_logs`
  ADD CONSTRAINT `cashback_logs_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_logs_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cashback_logs_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `cash_in_requests`
--
ALTER TABLE `cash_in_requests`
  ADD CONSTRAINT `cash_in_requests_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD CONSTRAINT `device_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loan_payments`
--
ALTER TABLE `loan_payments`
  ADD CONSTRAINT `loan_payments_loan_id_foreign` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `loan_payments_verified_by_foreign` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_sponsor_id_foreign` FOREIGN KEY (`sponsor_id`) REFERENCES `members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `membership_codes`
--
ALTER TABLE `membership_codes`
  ADD CONSTRAINT `membership_codes_reserved_by_foreign` FOREIGN KEY (`reserved_by`) REFERENCES `membership_code_requests` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `membership_codes_used_by_foreign` FOREIGN KEY (`used_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `membership_code_requests`
--
ALTER TABLE `membership_code_requests`
  ADD CONSTRAINT `membership_code_requests_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `membership_code_request_codes`
--
ALTER TABLE `membership_code_request_codes`
  ADD CONSTRAINT `membership_code_request_codes_membership_code_id_foreign` FOREIGN KEY (`membership_code_id`) REFERENCES `membership_codes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `membership_code_request_codes_membership_code_request_id_foreign` FOREIGN KEY (`membership_code_request_id`) REFERENCES `membership_code_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
