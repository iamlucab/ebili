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

--
-- Dumping data for table `cashback_logs`
--

INSERT INTO `cashback_logs` (`id`, `member_id`, `order_id`, `product_id`, `amount`, `level`, `description`, `source`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 60, 50.00, NULL, 'Cashback from Order #1 - Diabeta 17-in-1 Herbal Coffee', NULL, '2025-08-20 00:39:11', '2025-08-20 00:39:11'),
(2, 1, 1, 60, 16.67, 1, 'Direct product cashback from Chief Executive Officer\'s purchase', NULL, '2025-08-20 00:39:11', '2025-08-20 00:39:11'),
(3, 4, 2, 59, 30.00, NULL, 'Cashback from Order #2 - MEMORY MAXX GINGKO BILOBA', NULL, '2025-08-20 01:35:12', '2025-08-20 01:35:12'),
(4, 1, 2, 59, 10.00, 1, 'Direct product cashback from Chief Executive Officer\'s purchase', NULL, '2025-08-20 01:35:12', '2025-08-20 01:35:12');

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
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `payment_proof` varchar(255) DEFAULT NULL,
  `payment_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `payment_option` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `first_name`, `middle_name`, `last_name`, `birthday`, `mobile_number`, `occupation`, `address`, `photo`, `role`, `sponsor_id`, `voter_id`, `created_at`, `updated_at`, `loan_eligible`, `status`, `payment_proof`, `payment_status`, `payment_option`, `payment_method`) VALUES
(1, 'System', NULL, 'Administrator', '1990-01-01', '09177260180', 'The Actor', 'Tony Stark Tower 2, Hongkong, HK', '68a5a0602e02e.png', 'Admin', NULL, NULL, '2025-07-31 22:45:12', '2025-08-21 01:16:00', 0, 'Active', NULL, 'Pending', NULL, NULL),
(2, 'Chief', 'T', 'Technology Officer', '1990-01-01', '09171234567', 'Not Specified', 'Default Address', NULL, 'Staff', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:41:02', 1, 'Active', NULL, 'Pending', NULL, NULL),
(3, 'Chief', 'O', 'Operating Officer', '1990-01-01', '09171234568', 'COO', 'Tony Stark Tower 2, Hongkong, HK', NULL, 'Staff', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:30:59', 1, 'Active', NULL, 'Pending', NULL, NULL),
(4, 'Chief', 'E', 'Executive Officer', '1990-01-01', '09191111111', 'Chief Executive Officer', 'Tony Stark Tower 2, Hongkong, HK', NULL, 'Member', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:42:39', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(5, 'Chief', 'M', 'Marketing Officer', '1990-01-01', '09181234568', 'Not Specified', 'Tony Stark Tower, Hongkong', NULL, 'Member', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:43:01', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(6, 'Chief', 'Branding', 'Customer Service', '1990-01-01', '09181234569', 'Not Specified', 'Tony Stark Tower 2, HK', NULL, 'Member', 1, NULL, '2025-07-31 22:45:12', '2025-07-31 23:41:30', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(7, 'Benje', NULL, 'e-bili', '1975-02-01', '09151836162', 'Chief Marketing Officer', NULL, NULL, 'Member', 4, NULL, '2025-07-31 23:22:01', '2025-08-01 14:54:16', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(8, 'Lu', 'Naong', 'Cab', '1980-01-25', '09192222222', 'Atty-in-General', 'SpaceX Tower 100th Floor Mars Planet', NULL, 'Member', 9, NULL, '2025-07-31 23:23:12', '2025-08-01 14:52:06', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(9, 'Paul', 'James', 'Allen', '1980-02-01', '09193333333', 'Chief technology officer', NULL, NULL, 'Member', 4, NULL, '2025-07-31 23:27:06', '2025-08-09 22:17:57', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(10, 'Macaria', NULL, 'Opeńa', '2025-08-01', '09556778397', 'Negosyante', NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:15:39', '2025-08-01 15:15:39', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(11, 'Marissa', NULL, 'Labrador', '2025-08-01', '09109868673', NULL, NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:18:17', '2025-08-01 15:19:08', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(12, 'Lorina', NULL, 'Phuno', '2025-08-01', '09306730491', NULL, NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:22:29', '2025-08-01 15:23:14', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(13, 'Perla', NULL, 'Andio', '2025-08-01', '09701678140', NULL, NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:27:33', '2025-08-01 15:28:12', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(14, 'Jericho', NULL, 'Noveno', '2025-08-01', '09273001094', 'Leader', NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:34:26', '2025-08-01 15:34:26', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(15, 'MTC\'s Fruits hakes and', NULL, 'Foodhub', '2025-08-01', '09651233549', 'Merchant', NULL, NULL, 'Member', 7, NULL, '2025-08-01 15:38:22', '2025-08-01 15:38:22', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(16, 'Ian Amiel', NULL, 'Santidad', '2025-08-01', '09915508102', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-01 15:41:32', '2025-08-01 15:41:32', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(17, 'Rhona', NULL, 'Morilla', '2025-08-01', '09126748581', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-01 15:42:44', '2025-08-01 15:42:44', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(18, 'Elvira', NULL, 'Rutagines', '2025-08-01', '09612019238', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-01 15:43:54', '2025-08-01 15:43:54', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(19, 'Jancel', 'Rivera', 'Andrade', '2007-12-09', '09703100243', NULL, NULL, NULL, 'Member', 10, NULL, '2025-08-03 00:22:16', '2025-08-03 19:35:24', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(20, 'Renz', 'Lim', 'Licarte', '1998-09-09', '09763632594', 'Businessman', NULL, NULL, 'Member', 8, NULL, '2025-08-03 19:37:13', '2025-08-03 19:37:13', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(21, 'Mary ann', 'Olbez', 'Pagas', '1982-10-25', '09264663844', NULL, NULL, NULL, 'Member', 8, NULL, '2025-08-03 19:39:36', '2025-08-03 19:44:28', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(22, 'Nor', 'U', 'Umpar', '1982-04-04', '09099200018', NULL, NULL, NULL, 'Member', 8, NULL, '2025-08-03 19:42:42', '2025-08-03 19:43:55', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(23, 'Ariel', 'Bismar', 'Capili', '1967-10-19', '09171852313', NULL, NULL, NULL, 'Member', 22, NULL, '2025-08-03 19:49:09', '2025-08-03 19:49:09', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(24, 'Melanie', 'Moran', 'Guiday', '1988-12-01', '09165210706', NULL, NULL, NULL, 'Member', 22, NULL, '2025-08-03 19:55:11', '2025-08-03 19:57:25', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(25, 'Bernie', 'Paraguya', 'Baldesco', '1980-04-04', '09465935416', NULL, NULL, NULL, 'Member', 8, NULL, '2025-08-04 03:30:15', '2025-08-04 04:12:17', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(26, 'Margie', 'Navea', 'Palacio', '1993-07-12', '09670891993', 'Business owner', NULL, NULL, 'Member', 8, NULL, '2025-08-04 04:09:18', '2025-08-04 04:09:18', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(27, 'Cindy', 'Polison', 'Bandao', '1998-01-23', '09914528619', 'Saleswoman', NULL, NULL, 'Member', 25, NULL, '2025-08-04 04:13:08', '2025-08-06 19:42:56', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(28, 'Ma theresa', 'Molina', 'Garcia', '1994-09-05', '09519274739', NULL, NULL, 'photos/I2ZzbvgZa5hGExGSBgAH5moqdfpLZ6EV2B8u8PMC.jpg', NULL, 'Member', 10, NULL, '2025-08-07 01:14:45', '2025-08-07 01:18:37', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(29, 'Melba', NULL, 'Gruta', '2025-08-06', '09946437107', NULL, NULL, NULL, 'Member', 28, NULL, '2025-08-07 01:25:45', '2025-08-07 01:27:49', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(30, 'Sauda', 'Ajani', 'Nasirin', '1989-12-25', '09564907495', NULL, NULL, NULL, 'Member', 10, NULL, '2025-08-07 01:39:42', '2025-08-07 05:36:33', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(31, 'Ejay', 'L', 'Castro', '2002-12-06', '09945653049', NULL, NULL, 'photos/zbPr7EhWgPXk3KIyFO5M7I5SUT166RBQ53kCFx29.jpg', NULL, 'Member', 7, NULL, '2025-08-08 20:16:24', '2025-08-08 20:16:24', 0, 'Pending', NULL, 'Pending', NULL, NULL),
(32, 'Jusel', 'Dela cruz', 'Ormenita', '2025-08-11', '09631248271', 'Negosyante', 'Infanta', NULL, 'Member', 11, NULL, '2025-08-11 19:43:28', '2025-08-11 19:45:58', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(33, 'Infanta cafe-tea-ria', NULL, 'Cashless payment', '2025-08-11', '09151836163', 'Mechant', 'Infanta quezon', NULL, 'Member', 5, NULL, '2025-08-12 01:10:35', '2025-08-12 22:38:05', 1, 'Approved', NULL, 'Pending', NULL, NULL),
(34, 'Chester', NULL, 'Laroga', '2002-11-17', '09705759833', NULL, NULL, NULL, 'Member', 11, NULL, '2025-08-12 19:29:24', '2025-08-12 19:30:18', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(35, 'Ivana', NULL, 'Food hub', '2025-08-12', '09155874701', 'Merchant', NULL, NULL, 'Member', 11, NULL, '2025-08-12 20:29:55', '2025-08-12 22:36:38', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(36, 'Nathalia', 'Romantico', 'Dazo', '2006-11-28', '09381651324', NULL, NULL, NULL, 'Member', 11, NULL, '2025-08-12 21:33:14', '2025-08-12 21:33:14', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(37, 'Francisco', 'Platon', 'Gomba jr', '2025-09-17', '09923764121', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-13 04:11:58', '2025-08-13 04:11:58', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(38, 'Celeste belle jane', 'Dela torre', 'Gomba', '2025-08-12', '09203088948', 'Student', NULL, NULL, 'Member', 37, NULL, '2025-08-13 04:16:43', '2025-08-13 04:16:43', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(39, 'Maribel', 'Dela torre', 'Gomba', '2025-08-12', '09098006375', 'Leader', NULL, NULL, 'Member', 37, NULL, '2025-08-13 04:18:00', '2025-08-13 04:18:00', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(40, 'Carol', NULL, 'Evangelista', '2025-08-13', '09061207811', 'Billionaire', NULL, NULL, 'Member', 12, NULL, '2025-08-13 18:57:20', '2025-08-13 18:57:20', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(41, 'Jennelyn', NULL, 'Devera', '2025-08-13', '09935589239', 'Leader', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:00:21', '2025-08-13 19:00:21', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(42, 'Sharon', NULL, 'Culala', '2025-08-13', '09661772908', 'Negosyante', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:03:41', '2025-08-13 19:03:41', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(43, 'Mylene', NULL, 'Pabillaran', '2025-08-13', '09515415343', 'Leader', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:07:04', '2025-08-13 19:07:04', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(44, 'Jenny', NULL, 'Masaganda', '2025-08-13', '09602444087', 'Negosyante', NULL, NULL, 'Member', 12, NULL, '2025-08-13 19:08:34', '2025-08-13 19:08:34', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(45, 'Lorena', NULL, 'Caburnay', '2025-08-13', '09285452074', 'Member', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:53:19', '2025-08-13 21:53:19', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(46, 'Jerry', NULL, 'Turgo', '2025-08-13', '09353011044', 'Member', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:54:29', '2025-08-13 21:54:29', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(47, 'Mhara jhoy', NULL, 'Penaverde', '2025-08-13', '09319060559', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:56:02', '2025-08-13 21:56:02', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(48, 'Lorna', NULL, 'Cereneo', '2025-08-13', '09516970806', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-13 21:57:16', '2025-08-13 21:57:16', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(49, 'Janice', 'King', 'Lam', '1980-01-31', '09778273389', 'Negosyante', NULL, NULL, 'Member', 10, NULL, '2025-08-15 19:24:50', '2025-08-15 19:27:19', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(50, 'Jocelyn', NULL, 'Gonzalez', '2025-08-15', '09105069453', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:48:13', '2025-08-15 21:48:13', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(51, 'Denden', NULL, 'Casucom', '2025-08-15', '09617086040', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:49:51', '2025-08-15 21:49:51', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(52, 'Liela', NULL, 'Ponce', '2025-08-15', '09198068020', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:50:48', '2025-08-15 21:50:48', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(53, 'Kim', NULL, 'Ponce', '2025-08-15', '09851426349', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:52:05', '2025-08-15 21:52:05', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(54, 'Hayde', NULL, 'America', '2025-08-15', '09693126050', 'Negosyante', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:52:57', '2025-08-15 21:52:57', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(55, 'Rene', NULL, 'Merana', '2025-08-15', '09923764651', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:54:19', '2025-08-15 21:54:19', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(56, 'Ramil', NULL, 'Superlativo', '2025-08-15', '09461950872', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:55:13', '2025-08-15 21:55:13', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(57, 'Marilou', NULL, 'Galvez', '2025-08-15', '09516964321', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:56:08', '2025-08-15 21:56:08', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(58, 'Rosalind', NULL, 'Salinas', '2025-08-15', '09355793825', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:56:58', '2025-08-15 21:56:58', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(59, 'Christine', NULL, 'Ocampo', '2025-08-15', '09204022876', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-15 21:57:42', '2025-08-15 21:57:42', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(60, 'Ellanilsa', NULL, 'Emita', '2025-08-17', '09661921448', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:43:55', '2025-08-17 23:43:55', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(61, 'Erika', NULL, 'Quiambao', '2025-08-17', '09916055488', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:45:07', '2025-08-17 23:45:07', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(62, 'Creza', NULL, 'Gallano', '2025-08-17', '09434732727', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:48:49', '2025-08-17 23:48:49', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(63, 'Joselito', NULL, 'Puno', '2025-08-17', '09128691010', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:50:33', '2025-08-17 23:50:33', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(64, 'Alma', NULL, 'Puno', '2025-08-17', '09568745175', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:51:48', '2025-08-17 23:51:48', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(65, 'William', NULL, 'Puno', '2025-08-17', '09096093422', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:52:59', '2025-08-17 23:52:59', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(66, 'William', NULL, 'Puno jr', '2025-08-17', '09306614438', 'Member', NULL, NULL, 'Member', 12, NULL, '2025-08-17 23:54:20', '2025-08-17 23:54:20', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(67, 'Christopher', NULL, 'Combaliceo', '2025-08-18', '095131229861', 'Member', NULL, NULL, 'Member', 11, NULL, '2025-08-19 02:26:10', '2025-08-19 02:26:10', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(68, 'Diana', NULL, 'Sanchez', '2025-08-18', '09454987860', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-19 02:27:21', '2025-08-19 02:27:21', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(69, 'Roman', NULL, 'Franquia', '2025-08-18', '09308925735', 'Leader', NULL, NULL, 'Member', 11, NULL, '2025-08-19 02:28:52', '2025-08-19 02:28:52', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(70, 'Chery', 'Maning', 'Maning', '2025-08-19', '09196666666', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-19 14:12:28', '2025-08-19 14:12:28', 0, 'Pending', NULL, 'Pending', NULL, NULL),
(71, 'Sharie', 'Dmaculangan', 'De guzman', '2025-08-19', '09399282386', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-19 14:37:12', '2025-08-19 14:37:12', 0, 'Pending', NULL, 'Pending', NULL, NULL),
(72, 'Sharie', 'De guzman', 'Maning', '2025-08-19', '09171111111', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-19 14:44:46', '2025-08-19 14:44:46', 0, 'Pending', NULL, 'Pending', NULL, NULL),
(73, 'Jessa', 'Sanchez', 'Maning', '2025-08-20', '09177123454', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 08:50:15', '2025-08-20 08:50:15', 0, 'Pending', NULL, 'Pending', NULL, NULL),
(74, 'Matutina', 'Lumpia', 'Maning', '2025-08-20', '09198888888', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 09:03:16', '2025-08-20 09:03:16', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(75, 'Blissy', 'Cabandez', 'Maning', '2025-08-20', '09197777777', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 22:35:40', '2025-08-20 22:35:40', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(76, 'Pator', 'Patriko', 'Maning', '2025-08-20', '09178888888', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 22:47:58', '2025-08-20 22:47:58', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(77, 'Pastor', 'Motorjack', 'Maning', '2025-08-20', '1111111111111111111', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 22:56:47', '2025-08-20 22:56:47', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(78, 'Hello', 'Child', 'Maning', '2025-08-20', '11111', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 22:59:54', '2025-08-20 22:59:54', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(79, 'One', 'Miles', 'Maning', '2025-08-20', '09122223334', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 23:03:01', '2025-08-20 23:03:01', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(80, 'Dave', 'Danny', 'Maning', '2025-08-20', '12345678911', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-20 23:24:04', '2025-08-20 23:24:04', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(81, 'This', 'is letter a', 'B', '2025-08-21', '123456790', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-21 01:10:58', '2025-08-21 01:10:58', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(82, 'This', 'is letter c', 'Letter c', '2025-08-21', '01234567812', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-21 01:14:45', '2025-08-21 01:14:45', 0, 'Approved', NULL, 'Pending', NULL, NULL),
(83, 'This', 'is letter d', 'Letter d', '2025-08-21', '09180000000', 'Businesswoman', 'Infanta, Quezon', NULL, 'Member', 11, NULL, '2025-08-21 01:17:21', '2025-08-21 01:17:21', 0, 'Approved', NULL, 'Pending', NULL, NULL);

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
(1, '3G0JKSYU', 1, 0, NULL, 7, '2025-07-31 23:22:02', '2025-07-31 23:12:50
