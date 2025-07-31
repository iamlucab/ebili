-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 30, 2025 at 03:37 PM
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
(1, 10036, 1, 1, 1.00, NULL, 'Cashback from Order #1 - UGREEN 19*12cm Pouch Bag for Power Bank TWS Bluetooth Earbuds Flannel Bag Mobile Phone Accessories Portable Waterproof Drawstring Protection Bag', NULL, '2025-07-30 16:54:00', '2025-07-30 16:54:00');

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

--
-- Dumping data for table `cash_in_requests`
--

INSERT INTO `cash_in_requests` (`id`, `member_id`, `amount`, `payment_method`, `note`, `proof_path`, `status`, `created_at`, `updated_at`) VALUES
(2, 10034, 100.00, 'GCash', NULL, 'proofs/NnYNGX7kLhJ9ieWp3Ofcw4KqWl0XJDcSfJrQrQbG.jpg', 'Pending', '2025-07-29 06:14:29', '2025-07-29 06:14:29'),
(3, 10034, 100.00, 'GCash', NULL, 'proofs/4QJvF5Yz3KolhSqKEDuKEemZ7QgkGuyUHkkOumh5.jpg', 'Pending', '2025-07-29 06:14:29', '2025-07-29 06:14:29');

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
(1, 'Merchant', 'Type', 'Account', '1990-01-01', '09191111111', 'Merchant for Products', 'Davao City', '688a158c921e2.png', 'Staff', 16, NULL, '2025-07-28 23:41:03', '2025-07-31 03:52:28', 1, 'Approved'),
(16, 'Systems', 'Web', 'Developer', '1982-06-13', '09192222222', 'Accountant', 'Door C Alpha 11 Building, Rizal Extension Street, Davao City', NULL, 'Admin', NULL, NULL, '2025-07-15 06:32:02', '2025-07-29 22:31:28', 1, 'Approved'),
(10026, 'Bernie', 'Paraguya', 'Baldesco', '1980-04-04', '09465935416', 'Businessman', NULL, NULL, 'Member', 16, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10027, 'Cindy', 'Polison', 'Bandao', '1998-02-23', '09914528619', 'Saleswoman', NULL, NULL, 'Member', 10026, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10028, 'Nor', 'U', 'Umpar', '1982-04-04', '09099200018', 'Lawyer', NULL, NULL, 'Member', 16, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10029, 'Ariel', 'Besmar', 'Capili', '1967-10-19', '09171852313', NULL, NULL, NULL, 'Member', 10028, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10030, 'Mary Ann', 'Pagas', 'Olbez', '1982-10-25', '09264663844', NULL, NULL, NULL, 'Member', 16, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10031, 'Renz', 'Lim', 'Licarte', '1988-05-11', '09763632594', 'Engineer', NULL, NULL, 'Member', 16, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10032, 'Margie', 'Navea', 'Palacio', '1993-07-12', '09670891993', 'Business owner', NULL, NULL, 'Member', 16, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10033, 'Leah', 'Maldepeña', 'Perez', '1989-01-21', '09198649321', 'Supervisor', NULL, NULL, 'Member', 10032, NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 0, 'Approved'),
(10034, 'Melanie', 'Moran', 'Guiday', '1988-12-01', '09165210706', 'Real Estate Salesperson', NULL, NULL, 'Member', 10028, NULL, '2025-07-29 06:14:28', '2025-07-29 22:31:48', 0, 'Approved'),
(10035, 'e-bili', NULL, 'online', '2025-07-29', '09151836163', 'Merchant admin wallet', NULL, NULL, 'Member', NULL, NULL, '2025-07-29 23:29:16', '2025-07-30 06:04:48', 0, 'Approved'),
(10036, 'Benje.ebili', NULL, 'Online', '2025-07-29', '09151836162', 'Billionaire', 'earth', NULL, 'Member', 10038, NULL, '2025-07-29 23:30:29', '2025-07-31 04:41:17', 1, 'Approved'),
(10037, 'Marissa', NULL, 'Labrador', '2025-07-29', '09109868673', 'Negosyante', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:10:05', '2025-07-30 00:10:05', 0, 'Approved'),
(10038, 'Macaria', NULL, 'Opeńa', '2025-07-29', '09556778397', 'Negosyante', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:12:29', '2025-07-30 00:12:29', 0, 'Approved'),
(10039, 'Lorina', NULL, 'Phuno', '2025-07-29', '09306730491', 'Billionaire', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:14:51', '2025-07-30 00:14:51', 0, 'Approved'),
(10040, 'Perla', NULL, 'Andio', '2025-07-29', '09701678140', 'Negosyante', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:23:46', '2025-07-30 00:23:46', 0, 'Approved'),
(10041, 'MTC\'s Fruitshakes &', NULL, 'Foodhub', '2025-07-29', '09651233549', 'Merchant', 'Hacienda Tejeros', NULL, 'Member', NULL, NULL, '2025-07-30 04:13:38', '2025-07-30 06:02:49', 0, 'Approved'),
(10042, 'Ruben', NULL, 'Ranoco', '2025-07-30', '09151836164', 'Negosyante', NULL, NULL, 'Member', 10038, NULL, '2025-07-30 07:53:11', '2025-07-30 07:53:11', 0, 'Approved'),
(10043, 'Ben', 'O', 'Ma', '2025-07-30', '09151836165', NULL, NULL, NULL, 'Member', 10028, NULL, '2025-07-30 21:27:17', '2025-07-30 21:27:17', 0, 'Pending'),
(10044, 'Jericho', NULL, 'Noveno', '2003-03-24', '09273001094', 'Leader', 'Epza', 'photos/IG0X3r5WDssmsrQgQb6QufdtDKoYKj35Xv64bvEo.jpg', 'Member', 10036, NULL, '2025-07-31 00:58:34', '2025-07-31 01:10:13', 0, 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `membership_codes`
--

CREATE TABLE `membership_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(8) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `used_by` bigint(20) UNSIGNED DEFAULT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `membership_codes`
--

INSERT INTO `membership_codes` (`id`, `code`, `used`, `used_by`, `used_at`, `created_at`, `updated_at`) VALUES
(1, 'SKUMQFU2', 1, 2, '2025-07-29 22:25:25', '2025-07-29 22:24:23', '2025-07-29 22:25:25'),
(2, 'SMAQHNIT', 1, 10, '2025-07-29 22:31:28', '2025-07-29 22:24:23', '2025-07-29 22:31:28'),
(3, 'Y6VO0PR0', 1, 11053, '2025-07-29 22:31:48', '2025-07-29 22:24:23', '2025-07-29 22:31:48'),
(4, 'HCTTHCZN', 1, 11060, '2025-07-30 05:04:24', '2025-07-29 22:24:23', '2025-07-30 05:04:24'),
(5, 'ZYCNUNKA', 1, 11059, '2025-07-30 00:23:46', '2025-07-29 22:24:23', '2025-07-30 00:23:46'),
(6, 'IUIZJL3I', 1, 11058, '2025-07-30 00:14:51', '2025-07-29 22:24:23', '2025-07-30 00:14:51'),
(7, 'WBNLA2KN', 1, 11057, '2025-07-30 00:12:29', '2025-07-29 22:24:23', '2025-07-30 00:12:29'),
(8, 'VSMFBVH1', 1, 11056, '2025-07-30 00:10:05', '2025-07-29 22:24:23', '2025-07-30 00:10:05'),
(9, 'BDZ41E6B', 1, 11054, '2025-07-29 23:33:31', '2025-07-29 22:24:23', '2025-07-29 23:33:31'),
(10, 'Q0AKUQSI', 1, 11055, '2025-07-29 23:32:59', '2025-07-29 22:24:23', '2025-07-29 23:32:59'),
(11, 'UVF7YZ9M', 1, 11063, '2025-07-31 01:10:13', '2025-07-30 07:51:10', '2025-07-31 01:10:13'),
(12, 'A51XNTY7', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(13, '6ARYRATF', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(14, 'HJJJRYZC', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(15, 'VOH2VNHP', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(16, 'G2HW6VUV', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(17, 'UPHFWQJG', 1, 11061, '2025-07-30 07:53:11', '2025-07-30 07:51:10', '2025-07-30 07:53:11'),
(18, 'ONLGJ6RT', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(19, 'EVCK3YEJ', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(20, 'POOALSN9', 0, NULL, NULL, '2025-07-30 07:51:10', '2025-07-30 07:51:10'),
(21, '8SCTA8DL', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(22, 'HJQYUOBN', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(23, 'WADP4KYU', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(24, 'SUGACWHJ', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(25, 'EMVEF2SZ', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(26, 'SWCPZZQ7', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(27, 'RLRRM84R', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(28, '4OJ66RMG', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(29, 'EOVZ0CRA', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45'),
(30, 'YF8UEFJZ', 0, NULL, NULL, '2025-07-30 20:44:45', '2025-07-30 20:44:45');

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
(69, '2024_01_29_add_created_by_to_products_table', 3);

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

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `member_id`, `total_amount`, `total_cashback`, `status`, `cashback_given`, `promo_code`, `promo_discount`, `created_at`, `updated_at`, `payment_method`, `delivery_type`, `delivery_address`, `contact_number`, `reference_image`, `gcash_note`, `bank_note`, `amount_sent`) VALUES
(1, 10036, 0.00, 0.00, 'Delivered', 0, NULL, 0.00, '2025-07-30 16:50:40', '2025-07-30 16:54:00', 'Wallet', 'pickup', NULL, '09151836162', NULL, NULL, NULL, NULL);

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

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `status`, `cashback_amount`, `cashback`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 75.00, 'Delivered', 0.00, 1.00, '2025-07-30 16:50:40', '2025-07-30 16:54:00');

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
(1, 'UGREEN 19*12cm Pouch Bag for Power Bank TWS Bluetooth Earbuds Flannel Bag Mobile Phone Accessories Portable Waterproof Drawstring Protection Bag', 'UGREEN 19*12cm Pouch Bag for Power Bank TWS Bluetooth Earbuds Flannel Bag Mobile Phone Accessories Portable Waterproof Drawstring Protection Bag', 85.00, 1.00, 3, NULL, 10.00, 'flat', 'PROMO10', 1, 2, NULL, 1, '2025-07-16 05:16:35', '2025-07-30 16:50:40', 'products/thumbnails/E7FpFtypLVdUsY6oiNLYoPKSfj53ed9gX5PqRTjD.jpg', '[\"products\\/gallery\\/WmOGnOKHu8nbRX4DYnFKIMxqknqHYHImPMPKVlT5.jpg\",\"products\\/gallery\\/tlTL7MlI1QzxwmQeSrMl9CVGrfwEAsRDDblZxlTu.jpg\",\"products\\/gallery\\/4p8NfRU81TjawoP7HC3DvFB0dqF1fgFg0BEdIR1e.jpg\",\"products\\/gallery\\/W05Lp2jV84aPXTqoZF5eMJpKAIiwiIbaZYBdydyJ.jpg\",\"products\\/gallery\\/avIQwHFVPgoLWRA1oHclbUu2VD0eJTRVFPdBdLJX.jpg\"]', 8, 1, NULL),
(2, 'Turbo F08 USB Rechargeable Mini Handy Super 100 Wind Speed Function with LED Digital Display Fan', 'Turbo F08 USB Rechargeable Mini Handy Super 100 Wind Speed Function with LED Digital Display Fan', 100.00, 20.00, 3, NULL, 10.00, 'flat', 'PROMO10', 1, 0, NULL, 1, '2025-07-16 05:17:37', '2025-07-17 07:10:15', 'products/thumbnails/nKsl8gHOCEGAi3l1Z7ewcMacdTIEiNcSPr93v1Ve.jpg', '[\"products\\/gallery\\/P0RzduoshLgqJg0lh6xYzkUPJHvEYhKy3pQg45DB.jpg\",\"products\\/gallery\\/TGP5CWIQQCV0vxdr8bpmeBLjQyzLS7Sl7tBTejPN.jpg\",\"products\\/gallery\\/FKPfeOIVPAd17Td6tBuipUryqTKwBfyoGm7gNE9h.jpg\"]', 7, 10, NULL),
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
(13, 'Pan/Tilt AI Home Security Wi-Fi Camera', 'Seamless Privacy Control - Use the button on the product shell or Tapo app to easily open or close the privacy shield, giving you complete control over your private moments.\r\n\r\n2K QHD - When it comes to home security, details matter. With 2K QHD resolution, the Tapo C225 transcends beyond traditional FullHD 1080p quality to display finer details and incredibly clear videos.\r\n\r\nApple Homekit Supported - Along with Amazon Alexa and Google Assistant compatibility,Tapo C225 can also fully integrate into your Apple Home ecosystem for convenient hands-free operation.\r\n\r\nSmart Motion Tracking - With pan/tilt functionality and smart motion tracking technology with up to 120°/s rotating speed, precisely track and follow subjects, continuously keeping them within the camera’s field of view.\r\n\r\nColor Night Vision - The highly sensitive starlight sensor captures higher-quality images even in low-light conditions up to 30 ft.\r\n\r\nInvisible Infrared Mode - If the red IR LEDs prove to be a distraction while monitoring at night, switch to invisible IR mode to continue monitoring in low-light conditions without the disrupting red light, making it ideal for sleeping children and pets.\r\n\r\nLocal and Cloud Storage - Save recorded videos on a microSD Card (up to 512 GB, purchased separately) or use Tapo Care cloud storage services (subscribe separately).\r\n\r\nSharing Capabilities - Seamlessly forward videos you want to share to your social platforms.', 2950.00, 100.00, 3, NULL, NULL, NULL, NULL, 1, 10, NULL, 1, '2025-07-22 06:06:41', '2025-07-22 06:06:41', 'products/thumbnails/mRukDqYmAXzQ128TXbMOqQzCyN9DChT88lWcCjyj.jpg', '[\"products\\/gallery\\/aEHmPknyZtsa6BNRG33qjbdGOXDZZKSG5RHERJe0.jpg\",\"products\\/gallery\\/2TmFHqwCSIFP0y0Vg98g77i21NUbrgNsxYEAtunS.jpg\",\"products\\/gallery\\/6MZw8DfNOoHEl0s7MT6zLWAfgZilELpYc2nOOijC.jpg\"]', 6, 1, NULL);

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
(1, 10036, 10037, 1, 25.00, 'Direct referral bonus from Marissa Labrador', '2025-07-30 00:10:05', '2025-07-30 00:10:05'),
(2, 10036, 10038, 1, 25.00, 'Direct referral bonus from Macaria Opeńa', '2025-07-30 00:12:29', '2025-07-30 00:12:29'),
(3, 10036, 10039, 1, 25.00, 'Direct referral bonus from Lorina Phuno', '2025-07-30 00:14:51', '2025-07-30 00:14:51'),
(4, 10036, 10040, 1, 25.00, 'Direct referral bonus from Perla Andio', '2025-07-30 00:23:46', '2025-07-30 00:23:46'),
(5, 10038, 10042, 1, 25.00, 'Direct referral bonus from Ruben Ranoco', '2025-07-30 07:53:11', '2025-07-30 07:53:11'),
(6, 10036, 10042, 2, 15.00, '2nd level referral bonus from Ruben Ranoco', '2025-07-30 07:53:11', '2025-07-30 07:53:11'),
(7, 10028, 10043, 1, 25.00, 'Direct referral bonus from Ben Ma', '2025-07-30 21:27:17', '2025-07-30 21:27:17'),
(8, 16, 10043, 2, 15.00, '2nd level referral bonus from Ben Ma', '2025-07-30 21:27:17', '2025-07-30 21:27:17'),
(9, 10036, 10044, 1, 25.00, 'Direct referral bonus from Jericho Noveno', '2025-07-31 00:58:34', '2025-07-31 00:58:34'),
(10, 10036, 10044, 1, 25.00, 'Direct referral bonus from Jericho Noveno', '2025-07-31 01:10:13', '2025-07-31 01:10:13');

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
(1, 'raffle', '10 bags x 5kilos', '2025-08-29', '2025-07-29 23:46:43', '2025-07-29 23:46:43', NULL),
(2, 'raffle', '5 bags of 5 kilo rice per month', '2025-08-29', '2025-07-30 06:06:52', '2025-07-30 06:06:52', NULL);

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
(1, 'discount_values', '[\"10\",\"20\",\"50\"]', '2025-07-15 05:25:32', '2025-07-15 05:25:32'),
(2, 'promo_codes', '[\"PROMO10\",\"NEW25\"]', '2025-07-15 05:25:32', '2025-07-15 05:25:32'),
(3, 'available_sizes', '[\"S\",\"M\",\"L\",\"XL\"]', '2025-07-15 05:25:32', '2025-07-15 05:25:32'),
(4, 'available_colors', '[\"Red\",\"Blue\",\"Green\"]', '2025-07-15 05:25:32', '2025-07-15 05:25:32'),
(5, 'shipping_fee', '0', '2025-07-22 05:25:01', '2025-07-30 05:23:49'),
(6, 'promo_note', '10% OFF Month of July', '2025-07-22 05:25:01', '2025-07-22 05:25:01'),
(7, 'discount_rate', '2', '2025-07-22 05:25:01', '2025-07-22 05:25:01'),
(9, 'app_name', 'Ebili', NULL, '2025-07-28 23:41:03'),
(10, 'app_description', 'Multi-Level Marketing Platform', NULL, '2025-07-28 23:41:03'),
(11, 'contact_email', 'support@ebili.online', NULL, '2025-07-28 23:41:03'),
(12, 'contact_phone', '09177260180', NULL, '2025-07-28 23:41:03'),
(13, 'company_address', 'Philippines', NULL, '2025-07-28 23:41:03'),
(14, 'maintenance_mode', '0', NULL, '2025-07-28 23:41:03'),
(15, 'registration_enabled', '1', NULL, '2025-07-28 23:41:03'),
(16, 'referral_bonus_enabled', '1', NULL, '2025-07-28 23:41:03'),
(17, 'cashback_enabled', '1', NULL, '2025-07-28 23:41:03'),
(18, 'wallet_transfer_fee', '0', '2025-07-30 05:23:49', '2025-07-30 05:23:49');

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
(1, 'System Administrator', '09177260180', 'admin@ebili.online', 'Admin', NULL, '2025-07-28 23:41:03', '$2y$10$c.Mx4VLj4YEvtyfywy3s3eg7ZAtA44zWbT1H9MuxrwHNVbwaxQcv2', NULL, '2025-07-28 23:41:03', '2025-07-28 23:41:03', 'active'),
(2, 'Merchant Account', '09191111111', 'member@ebili.online', 'Staff', 1, '2025-07-28 23:41:03', '$2y$10$9hYrz7Jl9WDC9mRsg5WikudE3DP4Jb3A5HoEK617QkT9LHNHZl9mC', NULL, '2025-07-28 23:41:03', '2025-07-29 22:25:25', 'Approved'),
(10, 'Systems Developer', '09192222222', '09192222222@coop.local', 'Admin', 16, NULL, '$2y$10$rmLCFTeFBXnrW6pl50qLyurlkV8XT6EyaOy7gazial45BHANiAdTi', NULL, '2025-07-15 06:32:02', '2025-07-29 22:32:30', 'Approved'),
(11045, 'Bernie Baldesco', '09465935416', '09465935416@coop.local', 'Member', 10026, NULL, '$2y$10$VHYrjHP2/gJ31bRVp7Tihehc2NZu2RFiyIAYq5xX.cho0Bg5/1VPu', NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 'Approved'),
(11046, 'Cindy Bandao', '09914528619', '09914528619@coop.local', 'Member', 10027, NULL, '$2y$10$22ZWuDfj3YoVPDEVkL2lHu3tp0p4fP9U6kKsCpXX9s19peInmccCa', NULL, '2025-07-29 06:14:28', '2025-07-29 06:14:28', 'Approved'),
(11047, 'Nor Umpar', '09099200018', '09099200018@ebili.online', 'Member', 10028, NULL, '$2y$10$x0.1Y/BJUNO8cVkTwEH7OORvkqK3oHI3sHitXqz.QIxrahAIlnppC', NULL, '2025-07-29 06:14:28', '2025-07-30 04:51:18', 'Approved'),
(11048, 'Ariel Capili', '09171852313', '09171852313@coop.local', 'Member', 10029, NULL, '$2y$10$lxE52BIf.WECESM8u8Ugg.vWpaCowotV0AHrJxOjZK5XqNXG0HAaS', NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29', 'Approved'),
(11049, 'Mary Ann Olbez', '09264663844', '09264663844@coop.local', 'Member', 10030, NULL, '$2y$10$KSqRrbqpYxnE99lbTwrIlODydrxqVSsgbdDEzgxTQ3CGp/LiswYG6', NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29', 'Approved'),
(11050, 'Renz Licarte', '09763632594', '09763632594@coop.local', 'Member', 10031, NULL, '$2y$10$LLy39ksUmD3nXivo/GK09u4c9wrPJYg4iWcURczpzEw/6SVntyuxe', NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29', 'Approved'),
(11051, 'Margie Palacio', '09670891993', '09670891993@coop.local', 'Member', 10032, NULL, '$2y$10$kt2EF8/gLq6qQogCBnyYIOoENWmHyBxFx0clpdr7Y1O8bqWnh.RQ6', NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29', 'Approved'),
(11052, 'Leah Perez', '09198649321', '09198649321@coop.local', 'Member', 10033, NULL, '$2y$10$R7.2fI5wTgf3AUSh7axNXeeyrfme8zkqZimbLPfh1JBzsb9IfBscG', NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29', 'Approved'),
(11053, 'Melanie Guiday', '09165210706', '09165210706@coop.local', 'Member', 10034, NULL, '$2y$10$YK87isLrSwqDEdqh8pPXoOwS73zuKfinAbi6jlHNEfN0PYkombdES', NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29', 'Approved'),
(11054, 'e-bili online', '09151836163', '09151836163@ebili.online', 'Member', 10035, NULL, '$2y$10$6g2pP94zRelFps1lmMaTSeVHpvwfiseOa.0st5mP7Y6ePR3fOtSZm', NULL, '2025-07-29 23:29:16', '2025-07-30 06:04:48', 'Approved'),
(11055, 'Benje.ebili Online', '09151836162', '09151836162@ebili.online', 'Member', 10036, NULL, '$2y$10$jkaJe3/jH2BXE5RN3Bz6IeK.hiLBRGWJzPcg4GeVTbWZ7ov68pqWC', NULL, '2025-07-29 23:30:29', '2025-07-29 23:32:59', 'Approved'),
(11056, 'Marissa Labrador', '09109868673', '09109868673@ebili.online', 'Member', 10037, NULL, '$2y$10$Y/04slLDxeqz1CDtSAJ83uUyAkCjJOASX9sHtCzB0UMujl5VgpNH.', NULL, '2025-07-30 00:10:05', '2025-07-30 00:10:05', 'Approved'),
(11057, 'Macaria Opeńa', '09556778397', '09556778397@ebili.online', 'Member', 10038, NULL, '$2y$10$XDBt8iKrPwJ8j0dtehQo..5QK60qAXxDBP2ID6kb3ayur4GlHgiKi', NULL, '2025-07-30 00:12:29', '2025-07-30 00:12:29', 'Approved'),
(11058, 'Lorina Phuno', '09306730491', '09306730491@ebili.online', 'Member', 10039, NULL, '$2y$10$O0KNTUiM3TrnBCEiH2c9Z.bHc79N/zXantnCmlPgDi5ujFOGhs7iG', NULL, '2025-07-30 00:14:51', '2025-07-30 00:14:51', 'Approved'),
(11059, 'Perla Andio', '09701678140', '09701678140@ebili.online', 'Member', 10040, NULL, '$2y$10$u.D74Gv9y4FhPQLEgDjdxuZ/ao5GBqFA5ovivu1paQSFLUwc.MoVq', NULL, '2025-07-30 00:23:46', '2025-07-30 00:23:46', 'Approved'),
(11060, 'MTC\'s Fruitshakes & Foodhub', '09651233549', '09651233549@ebili.online', 'Member', 10041, NULL, '$2y$10$v75KWncMA9y5BVBgK4O7KO4oZ9Y.kp.Y0FEVT7xZjxjdX1AbHoGgm', NULL, '2025-07-30 04:13:38', '2025-07-30 07:02:22', 'Approved'),
(11061, 'Ruben Ranoco', '09151836164', '09151836164@ebili.online', 'Member', 10042, NULL, '$2y$10$qjlUcDAynB8BNFdaBQqxCOg/6Pn/UKdLb13.buf/s4nELJ79ci6EG', NULL, '2025-07-30 07:53:11', '2025-07-30 07:53:11', 'Approved'),
(11062, 'Ben Ma', '09151836165', '09151836165@ebili.online', 'Member', 10043, NULL, '$2y$10$5oPChsisHLB2Ls7I.o4HtOSy0JvWudR7IiLHN7Lfw0i/howvX92Qa', NULL, '2025-07-30 21:27:17', '2025-07-30 21:27:17', 'Pending'),
(11063, 'Jericho Noveno', '09273001094', '09273001094@ebili.online', 'Member', 10044, NULL, '$2y$10$gJnhiEoiI/XFU0zo6Qdqh.Idhn1IjPUI5LBgWUP.UztJKNb2ugPgq', NULL, '2025-07-31 00:58:34', '2025-07-31 01:10:13', 'Approved');

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
(3, 'WALLET-687898B80F2B2', 'main', 1, 1, 95312.50, '2025-07-16 22:31:20', '2025-07-28 23:54:34'),
(7, 'WALLET-GHLMWHWT1PQGR', 'main', 1, 1, 0.00, '2025-07-17 00:28:27', '2025-07-17 00:28:27'),
(8, 'WALLET-FSTPTYJ5DZIKX', 'main', 10, 16, 11000.00, '2025-07-17 00:28:27', '2025-07-28 23:54:34'),
(19, 'WALLET-687C24A452BF1', 'cashback', NULL, 1, 65.00, '2025-07-19 15:05:08', '2025-07-21 23:13:36'),
(20, 'WALLET-687C24A455371', 'cashback', NULL, 1, 35.00, '2025-07-19 15:05:08', '2025-07-23 04:19:27'),
(21, 'WALLET-687C24A455BB1', 'cashback', NULL, 16, 210.00, '2025-07-19 15:05:08', '2025-07-30 21:27:17'),
(22, 'WALLET-687C24A456082', 'main', NULL, 1, 0.00, '2025-07-19 15:05:08', '2025-07-19 15:05:08'),
(23, 'WALLET-687C24A456642', 'cashback', NULL, 1, 25.00, '2025-07-19 15:05:08', '2025-07-29 00:52:50'),
(26, 'WALLET-687F388ED45A0', 'main', NULL, 10026, 0.00, '2025-07-21 23:06:54', '2025-07-29 06:14:29'),
(27, 'WALLET-687F388ED45A2', 'cashback', NULL, 10026, 25.00, '2025-07-21 23:06:54', '2025-07-29 06:14:29'),
(28, 'WALLET-687F38D835794', 'main', NULL, 10027, 0.00, '2025-07-21 23:08:08', '2025-07-29 06:14:29'),
(29, 'WALLET-687F38D835797', 'cashback', NULL, 10027, 0.00, '2025-07-21 23:08:08', '2025-07-29 06:14:29'),
(30, 'WALLET-687F393B42C13', 'main', NULL, 10028, 0.00, '2025-07-21 23:09:47', '2025-07-29 06:14:29'),
(31, 'WALLET-687F393B42C16', 'cashback', NULL, 10028, 75.00, '2025-07-21 23:09:47', '2025-07-30 21:27:17'),
(32, 'WALLET-687F3974D5BA1', 'main', NULL, 10029, 0.00, '2025-07-21 23:10:44', '2025-07-29 06:14:29'),
(33, 'WALLET-687F3974D5BA4', 'cashback', NULL, 10029, 0.00, '2025-07-21 23:10:44', '2025-07-29 06:14:29'),
(34, 'WALLET-687F39B119356', 'main', NULL, 10030, 0.00, '2025-07-21 23:11:45', '2025-07-29 06:14:29'),
(35, 'WALLET-687F39B119359', 'cashback', NULL, 10030, 0.00, '2025-07-21 23:11:45', '2025-07-29 06:14:29'),
(36, 'WALLET-687F39EB801AE', 'main', NULL, 10031, 0.00, '2025-07-21 23:12:43', '2025-07-29 06:14:29'),
(37, 'WALLET-687F39EB801B0', 'cashback', NULL, 10031, 0.00, '2025-07-21 23:12:43', '2025-07-29 06:14:29'),
(38, 'WALLET-687F3A208CD7A', 'main', NULL, 10032, 0.00, '2025-07-21 23:13:36', '2025-07-29 06:14:29'),
(39, 'WALLET-687F3A208CD7D', 'cashback', NULL, 10032, 25.00, '2025-07-21 23:13:36', '2025-07-29 06:14:29'),
(40, 'WALLET-687F3ACFC7BFA', 'main', NULL, 10033, 0.00, '2025-07-21 23:16:31', '2025-07-29 06:14:29'),
(41, 'WALLET-687F3ACFC7C01', 'cashback', NULL, 10033, 0.00, '2025-07-21 23:16:31', '2025-07-29 06:14:29'),
(42, 'WALLET-6880005F782C9', 'main', NULL, 10034, 0.00, '2025-07-23 04:19:27', '2025-07-29 06:14:29'),
(43, 'WALLET-6880005F782CC', 'cashback', NULL, 10034, 0.00, '2025-07-23 04:19:27', '2025-07-29 06:14:29'),
(83, 'WALLET-68881B62C9536', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(84, 'WALLET-68881B62C9539', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(85, 'WALLET-68881B62CE4B2', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(86, 'WALLET-68881B62CE4B6', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(87, 'WALLET-68881B62D08BA', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(88, 'WALLET-68881B62D08BC', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(89, 'WALLET-68881B62D1DE4', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(90, 'WALLET-68881B62D1DEC', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(91, 'WALLET-68881B62D2F31', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(92, 'WALLET-68881B62D2F34', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(93, 'WALLET-68881B62D3F5B', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(94, 'WALLET-68881B62D3F5E', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(95, 'WALLET-6886336C3EF24', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(96, 'WALLET-6886336C3EF2B', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(97, 'WALLET-6886C50AAD7E4', 'main', NULL, 1, 688.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(98, 'WALLET-6886C50AAD7E7', 'cashback', NULL, 1, 115.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(99, 'WALLET-6886D97B044FE', 'main', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(100, 'WALLET-6886D97B04501', 'cashback', NULL, 1, 0.00, '2025-07-29 00:52:50', '2025-07-29 00:52:50'),
(101, 'WALLET-68885F2DCBFD2', 'main', 2, 1, 0.00, '2025-07-29 05:42:05', '2025-07-29 05:42:05'),
(103, 'WALLET-6888865C3FD86', 'main', NULL, 10035, 0.00, '2025-07-29 23:29:16', '2025-07-29 23:29:16'),
(104, 'WALLET-6888865C3FD89', 'cashback', NULL, 10035, 0.00, '2025-07-29 23:29:16', '2025-07-29 23:29:16'),
(105, 'WALLET-688886A593EDB', 'main', NULL, 10036, 55.00, '2025-07-29 23:30:29', '2025-07-31 01:10:13'),
(106, 'WALLET-688886A593EE1', 'cashback', NULL, 10036, 26.00, '2025-07-29 23:30:29', '2025-07-31 00:58:34'),
(107, 'WALLET-68888FED9D0DD', 'main', NULL, 10037, 0.00, '2025-07-30 00:10:05', '2025-07-30 00:10:05'),
(108, 'WALLET-68888FED9D0E1', 'cashback', NULL, 10037, 0.00, '2025-07-30 00:10:05', '2025-07-30 00:10:05'),
(109, 'WALLET-6888907D6F740', 'main', NULL, 10038, 0.00, '2025-07-30 00:12:29', '2025-07-30 00:12:29'),
(110, 'WALLET-6888907D6F745', 'cashback', NULL, 10038, 25.00, '2025-07-30 00:12:29', '2025-07-30 07:53:11'),
(111, 'WALLET-6888910B0BE7D', 'main', NULL, 10039, 0.00, '2025-07-30 00:14:51', '2025-07-30 00:14:51'),
(112, 'WALLET-6888910B0BE7F', 'cashback', NULL, 10039, 0.00, '2025-07-30 00:14:51', '2025-07-30 00:14:51'),
(113, 'WALLET-68889322BE620', 'main', NULL, 10040, 0.00, '2025-07-30 00:23:46', '2025-07-30 00:23:46'),
(114, 'WALLET-68889322BE624', 'cashback', NULL, 10040, 0.00, '2025-07-30 00:23:46', '2025-07-30 00:23:46'),
(115, 'WALLET-6888C902C34D2', 'main', NULL, 10041, 0.00, '2025-07-30 04:13:38', '2025-07-30 04:13:38'),
(116, 'WALLET-6888C902C34D4', 'cashback', NULL, 10041, 0.00, '2025-07-30 04:13:38', '2025-07-30 04:13:38'),
(117, 'WALLET-6888FC776BEC9', 'main', NULL, 10042, 0.00, '2025-07-30 07:53:11', '2025-07-30 07:53:11'),
(118, 'WALLET-6888FC776BECC', 'cashback', NULL, 10042, 0.00, '2025-07-30 07:53:11', '2025-07-30 07:53:11'),
(119, 'WALLET-6889BB4532A01', 'main', NULL, 10043, 0.00, '2025-07-30 21:27:17', '2025-07-30 21:27:17'),
(120, 'WALLET-6889BB4532A04', 'cashback', NULL, 10043, 0.00, '2025-07-30 21:27:17', '2025-07-30 21:27:17'),
(121, 'WALLET-6889ECCA47FD5', 'main', NULL, 10044, 0.00, '2025-07-31 00:58:34', '2025-07-31 00:58:34'),
(122, 'WALLET-6889ECCA47FD8', 'cashback', NULL, 10044, 0.00, '2025-07-31 00:58:34', '2025-07-31 00:58:34');

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
(19, 27, 10026, 'credit', 25.00, NULL, 'Direct referral bonus from Cindy Bandao', NULL, NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29'),
(25, 31, 10028, 'credit', 25.00, NULL, 'Direct referral bonus from Ariel Capili', NULL, NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29'),
(37, 39, 10032, 'credit', 25.00, NULL, 'Direct referral bonus from Leah Perez', NULL, NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29'),
(44, 31, 10028, 'credit', 25.00, NULL, 'Direct referral bonus from MELANIE GUIDAY', NULL, NULL, '2025-07-29 06:14:29', '2025-07-29 06:14:29'),
(45, 106, 10036, 'credit', 25.00, NULL, 'Direct referral bonus from Marissa Labrador', NULL, NULL, '2025-07-30 00:10:05', '2025-07-30 00:10:05'),
(46, 106, 10036, 'credit', 25.00, NULL, 'Direct referral bonus from Macaria Opeńa', NULL, NULL, '2025-07-30 00:12:29', '2025-07-30 00:12:29'),
(47, 106, 10036, 'credit', 25.00, NULL, 'Direct referral bonus from Lorina Phuno', NULL, NULL, '2025-07-30 00:14:51', '2025-07-30 00:14:51'),
(48, 106, 10036, 'credit', 25.00, NULL, 'Direct referral bonus from Perla Andio', NULL, NULL, '2025-07-30 00:23:46', '2025-07-30 00:23:46'),
(49, 106, 10036, NULL, -100.00, NULL, 'Transfer to main wallet (-₱10.00 fee)', NULL, NULL, '2025-07-30 03:51:29', '2025-07-30 03:51:29'),
(50, 105, 10036, NULL, 90.00, NULL, 'Received from cashback wallet (₱100.00 - ₱10.00 fee)', NULL, NULL, '2025-07-30 03:51:29', '2025-07-30 03:51:29'),
(51, 110, 10038, 'credit', 25.00, NULL, 'Direct referral bonus from Ruben Ranoco', NULL, NULL, '2025-07-30 07:53:11', '2025-07-30 07:53:11'),
(52, 106, 10036, 'credit', 15.00, NULL, '2nd level referral bonus from Ruben Ranoco', NULL, NULL, '2025-07-30 07:53:11', '2025-07-30 07:53:11'),
(53, 106, 10036, NULL, -15.00, NULL, 'Transfer to main wallet (-₱0.00 fee)', NULL, NULL, '2025-07-30 16:48:56', '2025-07-30 16:48:56'),
(54, 105, 10036, NULL, 15.00, NULL, 'Received from cashback wallet (₱15.00 - ₱0.00 fee)', NULL, NULL, '2025-07-30 16:48:56', '2025-07-30 16:48:56'),
(55, 105, 10036, 'payment', -75.00, NULL, NULL, 'Order paid via wallet at checkout', NULL, '2025-07-30 16:50:40', '2025-07-30 16:50:40'),
(56, 106, 10036, 'cashback', 1.00, 'product_cashback', 'Cashback earned from purchase of UGREEN 19*12cm Pouch Bag for Power Bank TWS Bluetooth Earbuds Flannel Bag Mobile Phone Accessories Portable Waterproof Drawstring Protection Bag', NULL, NULL, '2025-07-30 16:54:00', '2025-07-30 16:54:00'),
(57, 31, 10028, 'credit', 25.00, NULL, 'Direct referral bonus from Ben Ma', NULL, NULL, '2025-07-30 21:27:17', '2025-07-30 21:27:17'),
(58, 21, 16, 'credit', 15.00, NULL, '2nd level referral bonus from Ben Ma', NULL, NULL, '2025-07-30 21:27:17', '2025-07-30 21:27:17'),
(59, 106, 10036, 'credit', 25.00, NULL, 'Direct referral bonus from Jericho Noveno', NULL, NULL, '2025-07-31 00:58:34', '2025-07-31 00:58:34'),
(60, 105, 10036, 'credit', 25.00, NULL, 'Direct referral bonus from Jericho Noveno', NULL, NULL, '2025-07-31 01:10:13', '2025-07-31 01:10:13');

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
  ADD KEY `membership_codes_used_by_foreign` (`used_by`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cash_in_requests`
--
ALTER TABLE `cash_in_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10045;

--
-- AUTO_INCREMENT for table `membership_codes`
--
ALTER TABLE `membership_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `referral_bonus_logs`
--
ALTER TABLE `referral_bonus_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `referral_configurations`
--
ALTER TABLE `referral_configurations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_programs`
--
ALTER TABLE `reward_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reward_winners`
--
ALTER TABLE `reward_winners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11064;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

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
  ADD CONSTRAINT `membership_codes_used_by_foreign` FOREIGN KEY (`used_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

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

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `referral_bonus_logs`
--
ALTER TABLE `referral_bonus_logs`
  ADD CONSTRAINT `referral_bonus_logs_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  ADD CONSTRAINT `referral_bonus_logs_referred_member_id_foreign` FOREIGN KEY (`referred_member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `reward_programs`
--
ALTER TABLE `reward_programs`
  ADD CONSTRAINT `reward_programs_winner_id_foreign` FOREIGN KEY (`winner_id`) REFERENCES `reward_winners` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `reward_winners`
--
ALTER TABLE `reward_winners`
  ADD CONSTRAINT `fk_rwinners_program` FOREIGN KEY (`reward_program_id`) REFERENCES `reward_programs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reward_winners_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reward_winners_reward_program_id_foreign` FOREIGN KEY (`reward_program_id`) REFERENCES `reward_programs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD CONSTRAINT `ticket_replies_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_replies_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD CONSTRAINT `wallet_transactions_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wallet_transactions_related_member_id_foreign` FOREIGN KEY (`related_member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `wallet_transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
