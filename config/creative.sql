-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.creativenet/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 02, 2022 at 07:08 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `creative`
--

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_bank`
--

CREATE TABLE `smartphone_bank` (
  `creative.smartphone_bank` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_bank_invoices`
--

CREATE TABLE `smartphone_bank_invoices` (
  `id` bigint(20) NOT NULL,
  `payee_id` int(11) NOT NULL,
  `payer_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL DEFAULT '',
  `value` int(11) NOT NULL,
  `paid` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_blocks`
--

CREATE TABLE `smartphone_blocks` (
  `user_id` int(11) NOT NULL,
  `phone` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_calls`
--

CREATE TABLE `smartphone_calls` (
  `id` bigint(20) NOT NULL,
  `initiator` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL,
  `video` tinyint(4) NOT NULL DEFAULT 0,
  `anonymous` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_contacts`
--

CREATE TABLE `smartphone_contacts` (
  `id` bigint(20) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_gallery`
--

CREATE TABLE `smartphone_gallery` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `folder` varchar(255) NOT NULL DEFAULT '/',
  `url` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_ifood_orders`
--

CREATE TABLE `smartphone_ifood_orders` (
  `id` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `rate` tinyint(4) DEFAULT 0,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_instagram`
--

CREATE TABLE `smartphone_instagram` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `bio` varchar(255) NOT NULL,
  `avatarURL` varchar(255) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_instagram_followers`
--

CREATE TABLE `smartphone_instagram_followers` (
  `follower_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_instagram_likes`
--

CREATE TABLE `smartphone_instagram_likes` (
  `post_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_instagram_notifications`
--

CREATE TABLE `smartphone_instagram_notifications` (
  `id` bigint(20) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `content` varchar(512) NOT NULL,
  `saw` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_instagram_posts`
--

CREATE TABLE `smartphone_instagram_posts` (
  `id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_olx`
--

CREATE TABLE `smartphone_olx` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `images` varchar(1024) NOT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_paypal_transactions`
--

CREATE TABLE `smartphone_paypal_transactions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `target` bigint(20) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'payment',
  `description` varchar(255) DEFAULT NULL,
  `value` bigint(20) NOT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_tinder`
--

CREATE TABLE `smartphone_tinder` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `bio` varchar(1024) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `show_gender` tinyint(4) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `show_tags` tinyint(4) NOT NULL,
  `target` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_tinder_messages`
--

CREATE TABLE `smartphone_tinder_messages` (
  `id` bigint(20) NOT NULL,
  `sender` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `liked` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_tinder_rating`
--

CREATE TABLE `smartphone_tinder_rating` (
  `profile_id` int(11) NOT NULL,
  `rated_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_tor_messages`
--

CREATE TABLE `smartphone_tor_messages` (
  `id` bigint(20) NOT NULL,
  `channel` varchar(24) NOT NULL DEFAULT 'geral',
  `sender` varchar(255) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_tor_payments`
--

CREATE TABLE `smartphone_tor_payments` (
  `id` bigint(20) NOT NULL,
  `sender` bigint(20) NOT NULL,
  `target` bigint(20) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_twitter_followers`
--

CREATE TABLE `smartphone_twitter_followers` (
  `follower_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_twitter_likes`
--

CREATE TABLE `smartphone_twitter_likes` (
  `tweet_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_twitter_profiles`
--

CREATE TABLE `smartphone_twitter_profiles` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `avatarURL` varchar(255) NOT NULL,
  `bannerURL` varchar(255) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_twitter_tweets`
--

CREATE TABLE `smartphone_twitter_tweets` (
  `id` bigint(20) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `tweet_id` bigint(20) DEFAULT NULL,
  `content` varchar(280) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_uber_trips`
--

CREATE TABLE `smartphone_uber_trips` (
  `id` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `user_rate` tinyint(4) DEFAULT 0,
  `driver_rate` tinyint(4) DEFAULT 0,
  `created_at` int(11) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_whatsapp`
--

CREATE TABLE `smartphone_whatsapp` (
  `owner` varchar(32) NOT NULL,
  `avatarURL` varchar(255) DEFAULT NULL,
  `read_receipts` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_whatsapp_channels`
--

CREATE TABLE `smartphone_whatsapp_channels` (
  `id` bigint(20) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_whatsapp_groups`
--

CREATE TABLE `smartphone_whatsapp_groups` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `avatarURL` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `members` varchar(2048) NOT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_whatsapp_messages`
--

CREATE TABLE `smartphone_whatsapp_messages` (
  `id` bigint(20) NOT NULL,
  `channel_id` bigint(20) UNSIGNED NOT NULL,
  `sender` varchar(50) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `deleted_by` varchar(255) DEFAULT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT 0,
  `saw_at` bigint(20) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `smartphone_zipzap_messages`
--

CREATE TABLE `smartphone_zipzap_messages` (
  `created_at` varchar(255) DEFAULT NULL,
  `creative.smartphone_zipzap_messages` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `chars` int(10) NOT NULL DEFAULT 1,
  `gems` int(20) NOT NULL DEFAULT 0,
  `premium` int(20) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `steam` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id` int(11) NOT NULL,
  `user_id` int(20) NOT NULL DEFAULT 0,
  `value` int(20) NOT NULL DEFAULT 0,
  `mode` varchar(50) DEFAULT 'Private',
  `owner` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `banneds`
--

CREATE TABLE `banneds` (
  `id` int(11) NOT NULL,
  `steam` varchar(50) NOT NULL,
  `time` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `serial` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `blood` int(1) NOT NULL DEFAULT 1,
  `fines` int(20) NOT NULL DEFAULT 0,
  `garage` int(3) NOT NULL DEFAULT 3,
  `prison` int(11) NOT NULL DEFAULT 0,
  `port` int(1) NOT NULL DEFAULT 0,
  `deleted` int(1) NOT NULL DEFAULT 0,
  `paypal` int(11) DEFAULT 0,
  `bank` int(11) DEFAULT 30000
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `chests`
--

CREATE TABLE `chests` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chests`
--

INSERT INTO `chests` (`id`, `name`, `weight`, `perm`, `logs`) VALUES
(1, 'Liderbloods', 1000, 'Liderbloods', 1),
(2, 'Membrobloods', 1000, 'Membrobloods', 1),
(3, 'Lidercrips', 1000, 'Lidercrips', 1),
(4, 'Membrocrips', 1000, 'Membrocrips', 1),
(5, 'Liderverdes', 1000, 'Liderverdes', 1),
(6, 'Membroverdes', 1000, 'Membroverdes', 1),
(7, 'Liderroxos', 1000, 'Liderroxos', 1),
(8, 'Membroroxos', 1000, 'Membroroxos', 1),
(9, 'Lideramarelos', 1000, 'Lideramarelos', 1),
(10, 'Membroamarelos', 1000, 'Membroamarelos', 1),
(11, 'Lidervermelhos', 1000, 'Lidervermelhos', 1),
(12, 'Membrovermelhos', 1000, 'Membrovermelhos', 1),
(13, 'Liderazul', 1000, 'Liderazul', 1),
(14, 'Membroazul', 1000, 'Membroazul', 1),
(15, 'Liderballas', 1000, 'Liderballas', 1),
(16, 'Membroballas', 1000, 'Membroballas', 1),
(17, 'Lidervagos', 1000, 'Lidervagos', 1),
(18, 'Membrovagos', 1000, 'Membrovagos', 1),
(19, 'Membromafiavinhedo', 1000, 'Membromafiavinhedo', 1),
(20, 'Lidermafiavinhedo', 1000, 'Lidermafiavinhedo', 1),
(21, 'Lidermafiafazenda', 1000, 'Lidermafiafazenda', 1),
(22, 'Membromafiafazenda', 1000, 'Membromafiafazenda', 1),
(23, 'Lidermotoclub', 1000, 'Lidermotoclub', 1),
(24, 'Membromotoclub', 1000, 'Membromotoclub', 1),
(25, 'Lideryakuza', 1000, 'Lideryakuza', 1),
(26, 'Membroyakuza', 1000, 'Membroyakuza', 1),
(27, 'Lspd', 1000, 'Lspd', 1),
(28, 'Mechanic', 1000, 'Mechanic', 1),
(29, 'Donouwucafe', 1000, 'donouwucafe', 1),
(30, 'Funcionariouwucafe', 1000, 'Funcionariouwucafe', 1),
(31, 'Liderjapao', 1000, 'Liderjapao', 1),
(32, 'Membrojapao', 1000, 'Membrojapao', 1),
(33, 'Lidervanilla', 1000, 'Lidervanilla', 1),
(34, 'MembroVanilla', 1000, 'MembroVanilla', 1),
(35, 'Membrogalaxy', 1000, 'Membrogalaxy', 1),
(36, 'Lidergalaxy', 1000, 'Lidergalaxy', 1),
(37, 'Liderdriftking', 1000, 'Liderdriftking', 1),
(38, 'Membrodriftking', 1000, 'Membrodriftking', 1),
(39, 'Paramedic', 1000, 'Paramedic', 1);

-- --------------------------------------------------------

--
-- Table structure for table `entitydata`
--

CREATE TABLE `entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fidentity`
--

CREATE TABLE `fidentity` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `name2` varchar(50) NOT NULL DEFAULT '',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `port` int(1) NOT NULL DEFAULT 1,
  `blood` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `playerdata`
--

CREATE TABLE `playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prison`
--

CREATE TABLE `prison` (
  `id` int(11) NOT NULL,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(20) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `propertys`
--

CREATE TABLE `propertys` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'Homes0001',
  `interior` varchar(50) NOT NULL DEFAULT 'Middle',
  `tax` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` int(20) NOT NULL DEFAULT 0,
  `residents` int(1) NOT NULL DEFAULT 1,
  `vault` int(10) NOT NULL DEFAULT 1,
  `fridge` int(10) NOT NULL DEFAULT 1,
  `owner` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `races`
--

CREATE TABLE `races` (
  `id` int(11) NOT NULL,
  `raceid` int(3) NOT NULL DEFAULT 0,
  `user_id` int(5) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
  `vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
  `points` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT 0,
  `plate` varchar(20) DEFAULT NULL,
  `rental` int(20) NOT NULL DEFAULT 0,
  `rendays` int(11) NOT NULL DEFAULT 0,
  `arrest` int(20) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `nitro` int(3) NOT NULL DEFAULT 0,
  `work` varchar(5) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `smartphone_bank_invoices`
--
ALTER TABLE `smartphone_bank_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smartphone_blocks`
--
ALTER TABLE `smartphone_blocks`
  ADD PRIMARY KEY (`user_id`,`phone`);

--
-- Indexes for table `smartphone_calls`
--
ALTER TABLE `smartphone_calls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `initiator_index` (`initiator`),
  ADD KEY `target_index` (`target`);

--
-- Indexes for table `smartphone_contacts`
--
ALTER TABLE `smartphone_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_index` (`owner`);

--
-- Indexes for table `smartphone_gallery`
--
ALTER TABLE `smartphone_gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `smartphone_ifood_orders`
--
ALTER TABLE `smartphone_ifood_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smartphone_instagram`
--
ALTER TABLE `smartphone_instagram`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `smartphone_instagram_followers`
--
ALTER TABLE `smartphone_instagram_followers`
  ADD PRIMARY KEY (`follower_id`,`profile_id`);

--
-- Indexes for table `smartphone_instagram_likes`
--
ALTER TABLE `smartphone_instagram_likes`
  ADD PRIMARY KEY (`post_id`,`profile_id`);

--
-- Indexes for table `smartphone_instagram_notifications`
--
ALTER TABLE `smartphone_instagram_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_id_index` (`profile_id`);

--
-- Indexes for table `smartphone_instagram_posts`
--
ALTER TABLE `smartphone_instagram_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_id_index` (`profile_id`),
  ADD KEY `post_id_index` (`post_id`);

--
-- Indexes for table `smartphone_olx`
--
ALTER TABLE `smartphone_olx`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `smartphone_paypal_transactions`
--
ALTER TABLE `smartphone_paypal_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`),
  ADD KEY `target_index` (`target`);

--
-- Indexes for table `smartphone_tinder`
--
ALTER TABLE `smartphone_tinder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`),
  ADD KEY `gender_index` (`gender`),
  ADD KEY `target_index` (`target`);

--
-- Indexes for table `smartphone_tinder_messages`
--
ALTER TABLE `smartphone_tinder_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_index` (`sender`),
  ADD KEY `target_index` (`target`);

--
-- Indexes for table `smartphone_tinder_rating`
--
ALTER TABLE `smartphone_tinder_rating`
  ADD PRIMARY KEY (`profile_id`,`rated_id`);

--
-- Indexes for table `smartphone_tor_messages`
--
ALTER TABLE `smartphone_tor_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_index` (`channel`),
  ADD KEY `sender_index` (`sender`);

--
-- Indexes for table `smartphone_tor_payments`
--
ALTER TABLE `smartphone_tor_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_index` (`sender`),
  ADD KEY `target_index` (`target`);

--
-- Indexes for table `smartphone_twitter_followers`
--
ALTER TABLE `smartphone_twitter_followers`
  ADD KEY `profile_id_index` (`profile_id`);

--
-- Indexes for table `smartphone_twitter_likes`
--
ALTER TABLE `smartphone_twitter_likes`
  ADD KEY `tweet_id_index` (`tweet_id`);

--
-- Indexes for table `smartphone_twitter_profiles`
--
ALTER TABLE `smartphone_twitter_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `smartphone_twitter_tweets`
--
ALTER TABLE `smartphone_twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_id_index` (`profile_id`),
  ADD KEY `tweet_id_index` (`tweet_id`);

--
-- Indexes for table `smartphone_uber_trips`
--
ALTER TABLE `smartphone_uber_trips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smartphone_whatsapp`
--
ALTER TABLE `smartphone_whatsapp`
  ADD PRIMARY KEY (`owner`);

--
-- Indexes for table `smartphone_whatsapp_channels`
--
ALTER TABLE `smartphone_whatsapp_channels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_index` (`sender`),
  ADD KEY `target_index` (`target`);

--
-- Indexes for table `smartphone_whatsapp_groups`
--
ALTER TABLE `smartphone_whatsapp_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smartphone_whatsapp_messages`
--
ALTER TABLE `smartphone_whatsapp_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_index` (`sender`),
  ADD KEY `channel_id_index` (`channel_id`);

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`steam`) USING BTREE,
  ADD KEY `steam` (`steam`) USING BTREE;

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `banneds`
--
ALTER TABLE `banneds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `chests`
--
ALTER TABLE `chests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `entitydata`
--
ALTER TABLE `entitydata`
  ADD PRIMARY KEY (`dkey`),
  ADD KEY `dkey` (`dkey`);

--
-- Indexes for table `fidentity`
--
ALTER TABLE `fidentity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `playerdata`
--
ALTER TABLE `playerdata`
  ADD PRIMARY KEY (`user_id`,`dkey`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `dkey` (`dkey`);

--
-- Indexes for table `prison`
--
ALTER TABLE `prison`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `propertys`
--
ALTER TABLE `propertys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `races`
--
ALTER TABLE `races`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`user_id`,`vehicle`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vehicle` (`vehicle`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `smartphone_bank_invoices`
--
ALTER TABLE `smartphone_bank_invoices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_calls`
--
ALTER TABLE `smartphone_calls`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `smartphone_contacts`
--
ALTER TABLE `smartphone_contacts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `smartphone_gallery`
--
ALTER TABLE `smartphone_gallery`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `smartphone_instagram`
--
ALTER TABLE `smartphone_instagram`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `smartphone_instagram_notifications`
--
ALTER TABLE `smartphone_instagram_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `smartphone_instagram_posts`
--
ALTER TABLE `smartphone_instagram_posts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `smartphone_olx`
--
ALTER TABLE `smartphone_olx`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_paypal_transactions`
--
ALTER TABLE `smartphone_paypal_transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_tinder`
--
ALTER TABLE `smartphone_tinder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_tinder_messages`
--
ALTER TABLE `smartphone_tinder_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_tor_messages`
--
ALTER TABLE `smartphone_tor_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_tor_payments`
--
ALTER TABLE `smartphone_tor_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_twitter_profiles`
--
ALTER TABLE `smartphone_twitter_profiles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_twitter_tweets`
--
ALTER TABLE `smartphone_twitter_tweets`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smartphone_whatsapp_channels`
--
ALTER TABLE `smartphone_whatsapp_channels`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `smartphone_whatsapp_groups`
--
ALTER TABLE `smartphone_whatsapp_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `smartphone_whatsapp_messages`
--
ALTER TABLE `smartphone_whatsapp_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `banneds`
--
ALTER TABLE `banneds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chests`
--
ALTER TABLE `chests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `fidentity`
--
ALTER TABLE `fidentity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prison`
--
ALTER TABLE `prison`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `propertys`
--
ALTER TABLE `propertys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `races`
--
ALTER TABLE `races`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
