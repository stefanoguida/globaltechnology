CREATE DATABASE global_technology;
USE global_technology;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: database:3306
-- Creato il: Gen 17, 2023 alle 16:44
-- Versione del server: 10.10.2-MariaDB-1:10.10.2+maria~ubu2204
-- Versione PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `global_technology`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `clienti`
--

CREATE TABLE `clienti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `ragione_sociale` varchar(255) NOT NULL DEFAULT '',
  `piva` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `clienti`
--

INSERT INTO `clienti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `ragione_sociale`, `piva`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-13 00:01:20', 'SYS', 'obton', '00000000002'),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'blue elephant', '00000000000'),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'bayware', '00000000000'),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'hydrowatt', '00000000000'),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'lt', '00000000000'),
(6, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'fincantieri', '00000000000'),
(7, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'comun energ', '00000000000'),
(8, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'trina', '00000000000'),
(9, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'rpower', '00000000000'),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'valmont', '00000000000');

-- --------------------------------------------------------

--
-- Struttura della tabella `contratti`
--

CREATE TABLE `contratti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_progetto` int(11) NOT NULL,
  `data_accettazione` datetime DEFAULT NULL,
  `importo` decimal(11,2) NOT NULL DEFAULT 0.00,
  `kw` decimal(11,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `contratti`
--

INSERT INTO `contratti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_progetto`, `data_accettazione`, `importo`, `kw`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-09 23:05:24', 'SYS', 1, '2022-06-24 00:00:00', '259270.00', '998.20'),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-10 00:26:46', 'SYS', 2, '2022-07-24 00:00:00', '193905.00', '997.00');

-- --------------------------------------------------------

--
-- Struttura della tabella `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_cliente` int(11) NOT NULL,
  `id_progetto` int(11) NOT NULL,
  `tipo` enum('ordine','offerta','contratto','') NOT NULL DEFAULT '',
  `path` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `files`
--

INSERT INTO `files` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_cliente`, `id_progetto`, `tipo`, `path`) VALUES
(1, 'N', '2023-01-04 14:51:38', 'SYS', '2023-01-04 16:51:06', 'SYS', 1, 1, 'ordine', 'storage/obton/ordini/Preventivo Global Technology.pdf'),
(2, 'N', '2023-01-04 14:51:58', 'SYS', '2023-01-04 16:28:31', 'SYS', 1, 1, 'offerta', 'Preventivo Global Technology.pdf'),
(7, 'N', '2023-01-12 17:03:47', 'SYS', '2023-01-12 17:03:47', 'SYS', 1, 2, 'ordine', 'storage/Preventivo Global Technology.pdf'),
(23, 'N', '2023-01-12 23:41:49', 'SYS', '2023-01-12 23:41:49', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124149.pdf'),
(24, 'N', '2023-01-12 23:45:07', 'SYS', '2023-01-12 23:45:07', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124507.pdf'),
(25, 'N', '2023-01-12 23:46:50', 'SYS', '2023-01-12 23:46:50', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124650.pdf'),
(26, 'N', '2023-01-12 23:47:46', 'SYS', '2023-01-12 23:47:46', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124746.pdf');

-- --------------------------------------------------------

--
-- Struttura della tabella `forniture`
--

CREATE TABLE `forniture` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `forniture`
--

INSERT INTO `forniture` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `name`) VALUES
(1, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'cavi', 'Cavi'),
(2, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'pannelli', 'Pannelli'),
(3, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'inverter', 'Inverter'),
(4, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'trasformatori', 'Trasformatori'),
(5, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'struttura', 'Struttura'),
(6, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'cabinaconsegna', 'Cabina di consegna'),
(7, 'N', '2023-01-17 14:32:29', 'SYS', '2023-01-17 14:32:29', 'SYS', 'cabinautente', 'Cabina utente');

-- --------------------------------------------------------

--
-- Struttura della tabella `forniture_contratti`
--

CREATE TABLE `forniture_contratti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `forniture_offerta`
--

CREATE TABLE `forniture_offerta` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `offerte`
--

CREATE TABLE `offerte` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_progetto` int(11) NOT NULL,
  `data_offerta` datetime DEFAULT current_timestamp(),
  `importo` decimal(11,2) DEFAULT NULL,
  `kw` decimal(11,2) DEFAULT 0.00,
  `id_stato` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `offerte`
--

INSERT INTO `offerte` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_progetto`, `data_offerta`, `importo`, `kw`, `id_stato`) VALUES
(1, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:26:30', 'SYS', 3, '2022-06-24 00:00:00', '212798.00', '998.76', 1),
(2, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 4, '2022-06-24 15:32:21', '334357.00', '998.76', 1),
(3, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 5, '2022-06-24 15:32:21', '210443.00', '998.00', 1),
(4, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 6, '2022-06-24 15:32:21', '198859.00', '998.00', 1),
(5, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 7, '2022-06-24 15:32:21', '200247.00', '998.00', 1),
(6, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 8, '2022-07-24 15:32:21', '202437.00', '510.30', 1),
(7, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 9, '2022-07-24 15:32:21', '225100.00', '702.00', 1),
(8, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 10, '2022-07-24 15:32:21', '202437.00', '510.30', 1),
(9, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 11, '2022-07-24 15:32:21', '223559.00', '687.96', 1),
(10, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 12, '2022-07-24 15:32:21', '201954.00', '510.30', 1),
(11, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 13, '2022-07-24 15:32:21', '360630.00', '996.84', 1),
(12, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 14, '2022-06-24 15:32:21', '42000.00', '388.00', 1),
(13, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 15, '2022-06-24 15:32:21', '101148.70', '642.00', 1),
(14, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 16, '2022-06-24 15:32:21', '76245.80', '522.00', 1),
(15, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 17, '2022-06-24 15:32:21', '100313.42', '716.00', 1),
(16, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 18, '2022-06-24 15:32:21', '139097.50', '1050.20', 1),
(17, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 19, '2022-06-24 15:32:21', '320833.00', '1996.90', 1),
(18, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 20, '2022-06-24 15:32:21', '561892.00', '3709.00', 1),
(19, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 21, '2022-01-24 15:32:21', '481000.00', '811.89', 1),
(20, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 22, '2022-01-24 15:32:21', '410212.60', '999.39', 1),
(21, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 23, '2022-01-24 15:32:21', '369787.40', '995.33', 1),
(22, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 24, '2022-01-24 15:32:21', '472453.82', '999.19', 1),
(23, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 25, '2022-01-24 15:32:21', '481300.36', '991.11', 1),
(24, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 26, '2022-01-24 15:32:21', '333280.32', '811.25', 1),
(25, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 27, '2022-01-24 15:32:21', '368082.15', '998.96', 1),
(26, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 28, '2022-01-24 15:32:21', '346173.96', '996.38', 1),
(27, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 29, '2022-01-24 15:32:21', '495161.23', '991.32', 1),
(28, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 30, '2022-01-24 15:32:21', '483588.64', '996.15', 1),
(29, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 31, '2022-10-24 15:32:21', '1225000.00', '12406.24', 1),
(30, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 32, '2022-10-24 15:32:21', '170000.00', '963.00', 1),
(31, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 33, '2022-10-24 15:32:21', '1401172.00', '4970.00', 1),
(32, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 34, '2022-10-24 15:32:21', '295268.00', '523.00', 1),
(33, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 35, '2022-10-24 15:32:21', '1310000.00', '8034.39', 1),
(34, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 36, '2022-10-24 15:32:21', '190000.00', '997.92', 1),
(35, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 37, '2022-10-24 15:32:21', '190000.00', '950.00', 1),
(36, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 38, '2022-10-24 15:32:21', '1250000.00', '7630.00', 1),
(37, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 39, '2022-11-24 15:32:21', '1794000.00', '3250.00', 1),
(38, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 40, '2022-11-24 15:32:21', '2115816.00', '3833.00', 1),
(39, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 41, '2022-11-24 15:32:21', '4037040.00', '7560.00', 1),
(40, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 42, '2022-11-24 15:32:21', '1583136.00', '2868.00', 1),
(41, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 43, '2022-11-24 15:32:21', '2393664.00', '4368.00', 1),
(42, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 44, '2022-11-24 15:32:21', '1344470.40', '2462.40', 1),
(43, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 45, '2022-11-24 15:32:21', '552944.70', '999.90', 1),
(44, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 46, '2022-11-24 15:32:21', '572451.84', '993.84', 1),
(45, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 47, '2022-11-24 15:32:21', '3731023.20', '7258.80', 1),
(46, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 48, '2022-11-24 15:32:21', '558489.60', '969.60', 1),
(47, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 49, '2022-11-24 15:32:21', '3065421.60', '5906.40', 1),
(48, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 50, '2022-11-24 15:32:21', '1556100.00', '2850.00', 1),
(49, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 51, '2022-11-24 15:32:21', '2127544.80', '4060.20', 1),
(50, 'N', '2023-01-17 15:08:32', 'SYS', '2023-01-17 15:08:32', 'SYS', 52, '2022-11-24 15:32:21', '518057.28', '945.36', 1),
(64, 'N', '2023-01-17 15:28:15', 'SYS', '2023-01-17 15:28:15', 'SYS', 1, '2022-05-24 00:00:00', '259270.00', '998.20', 2),
(65, 'N', '2023-01-17 15:28:15', 'SYS', '2023-01-17 15:28:15', 'SYS', 2, '2022-06-24 00:00:00', '193905.00', '997.00', 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordini`
--

CREATE TABLE `ordini` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_progetto` int(11) NOT NULL,
  `id_stato` int(11) NOT NULL,
  `data_consegna` datetime DEFAULT NULL,
  `importo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ordini`
--

INSERT INTO `ordini` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_progetto`, `id_stato`, `data_consegna`, `importo`) VALUES
(1, 'N', '2022-12-30 14:09:19', 'SYS', '2023-01-04 14:35:02', 'SYS', 1, 1, NULL, 1000),
(2, 'N', '2022-12-30 14:09:46', 'SYS', '2022-12-30 14:09:46', 'SYS', 2, 2, '2023-01-31 15:09:22', 1256);

-- --------------------------------------------------------

--
-- Struttura della tabella `pagamenti_ordine`
--

CREATE TABLE `pagamenti_ordine` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_ordine` int(11) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  `Note` text NOT NULL,
  `importo_percentuale` int(3) NOT NULL,
  `importo_valore` decimal(11,2) NOT NULL,
  `id_stato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `progetti`
--

CREATE TABLE `progetti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_cliente` int(11) NOT NULL,
  `data_inizio` datetime DEFAULT NULL,
  `data_fine` datetime DEFAULT NULL,
  `impianto` varchar(255) DEFAULT '',
  `luogo` varchar(255) NOT NULL DEFAULT '',
  `id_stato` varchar(255) NOT NULL,
  `completamento` int(3) DEFAULT 0,
  `commenti` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `progetti`
--

INSERT INTO `progetti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_cliente`, `data_inizio`, `data_fine`, `impianto`, `luogo`, `id_stato`, `completamento`, `commenti`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:23:13', 'SYS', 1, '2022-06-24 00:00:00', '2023-06-24 00:00:00', 'andria', 'Andria', '5', 85, ''),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 1, '2022-07-24 00:00:00', '2023-07-24 00:00:00', 'capitolicchio', 'Taranto', '5', 65, NULL),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'sbm', 'Turi', '5', 25, NULL),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'trinitapoli', 'Trinitapoli', '5', 25, NULL),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'turi4', 'Turi', '5', 25, NULL),
(6, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'turi6', 'Turi', '5', 25, NULL),
(7, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'turi7', 'Turi', '5', 25, NULL),
(8, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'baligio', 'Fossano (CN)', '5', 20, NULL),
(9, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'bosconero', 'Bosconero (TO)', '5', 20, NULL),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'castiglione', 'Savigliano (CN)', '5', 20, NULL),
(11, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'cascina valentino', 'Saluzzo (CN)', '5', 20, NULL),
(12, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'santa lucia', 'Fossano (CN)', '5', 20, NULL),
(13, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'bigreco', 'Busca (CN)', '5', 20, NULL),
(14, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1210 - ESAP', '', '5', 50, NULL),
(15, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1626 - COPA', '', '5', 50, NULL),
(16, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1627 - COVO', '', '5', 50, NULL),
(17, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1628 - COPR', '', '5', 50, NULL),
(18, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1629 - COCA', '', '5', 50, NULL),
(19, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1658 - LODO', '', '5', 50, NULL),
(20, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:05', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1772 - CAFE', '', '5', 50, NULL),
(21, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Cassino 1 ', 'Marche', '6', 100, NULL),
(22, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Castiglione in Teverina', 'Lazio', '6', 100, NULL),
(23, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Grottazzolina', 'Abruzzo', '6', 100, NULL),
(24, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'CappelleSulTavo', 'Lazio', '6', 100, NULL),
(25, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Isernia', 'Abruzzo', '6', 100, NULL),
(26, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Corvara', 'Abruzzo', '6', 100, NULL),
(27, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Filetto', 'Abruzzo', '6', 100, NULL),
(28, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Civitaquana', 'Lazio', '6', 100, NULL),
(29, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Cassino 2', 'Abruzzo', '6', 100, NULL),
(30, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:17:03', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Mondavio', 'Marche', '6', 100, NULL),
(31, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 5, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'deliceto', 'deliceto', '4', 0, NULL),
(32, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 5, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'iren', 'deliceto', '4', 0, NULL),
(33, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 6, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'monfalcone', 'monfalcone', '4', 0, NULL),
(34, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 6, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'sestri ponente', 'sestri ponente', '4', 0, NULL),
(35, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Nardò', 'Nardò', '4', 0, NULL),
(36, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'San Martino in Pensilis', 'San Martino in Pensilis', '4', 0, NULL),
(37, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Celleno', 'Celleno', '4', 0, NULL),
(38, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Lequile', 'Lequile', '4', 0, NULL),
(39, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Quattordio', 'Alessandria Piemonte', '4', 0, NULL),
(40, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Pachino', 'Siracusa', '4', 0, NULL),
(41, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Brindisi San Giorgio', 'Brindisi', '4', 0, NULL),
(42, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Viterbo', 'Viterbo', '4', 0, NULL),
(43, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Orani', 'Viterbo', '4', 0, NULL),
(44, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Marino', '', '4', 0, NULL),
(45, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Flycom', '', '4', 0, NULL),
(46, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Bettona', '', '4', 0, NULL),
(47, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Brizzarelli', '', '4', 0, NULL),
(48, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Castiglione', '', '4', 0, NULL),
(49, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Euroservice', '', '4', 0, NULL),
(50, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Spoleto', '', '4', 0, NULL),
(51, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Vasca', '', '4', 0, NULL),
(52, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-17 15:16:38', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Villanova', '', '4', 0, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `righe_ordine`
--

CREATE TABLE `righe_ordine` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_ordine` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  `descrizione` text NOT NULL,
  `brand` varchar(255) NOT NULL,
  `costo` decimal(11,2) NOT NULL,
  `costo_spedizione` decimal(11,2) NOT NULL,
  `pagamento` int(11) NOT NULL,
  `data_arrivo_merce` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `righe_ordine`
--

INSERT INTO `righe_ordine` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_ordine`, `id_servizio`, `descrizione`, `brand`, `costo`, `costo_spedizione`, `pagamento`, `data_arrivo_merce`) VALUES
(1, 'N', '2022-12-30 14:30:58', 'SYS', '2022-12-30 14:30:58', 'SYS', 1, 1, '', '', '0.00', '0.00', 0, '0000-00-00 00:00:00'),
(2, 'N', '2022-12-30 14:30:58', 'SYS', '2022-12-30 14:30:58', 'SYS', 1, 11, '', '', '0.00', '0.00', 0, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `servizi`
--

CREATE TABLE `servizi` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `servizi`
--

INSERT INTO `servizi` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `name`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'ingegneria', 'Ingegneria'),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'forniture', 'Forniture'),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'installazioneelettrica', 'Installazione elettrica'),
(11, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'installazionemeccanica', 'Installazione meccanica'),
(12, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'lavoriedili', 'Lavori edili'),
(13, 'N', '2023-01-13 00:02:17', 'SYS', '2023-01-13 00:02:17', 'SYS', 'prova', 'Prova');

-- --------------------------------------------------------

--
-- Struttura della tabella `servizi_contratti`
--

CREATE TABLE `servizi_contratti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `servizi_contratti`
--

INSERT INTO `servizi_contratti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_contratto`, `id_servizio`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, 1),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, 3),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, 4),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, 1),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `servizi_offeta`
--

CREATE TABLE `servizi_offeta` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `servizi_offeta`
--

INSERT INTO `servizi_offeta` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `id_contratto`, `id_servizio`) VALUES
(6, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, 10),
(7, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, 12),
(8, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, 11),
(9, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, 12),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 5, 1),
(11, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 5, 12),
(12, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 6, 1),
(13, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, 1),
(14, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 8, 1),
(15, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 9, 1),
(16, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 10, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `stati`
--

CREATE TABLE `stati` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL,
  `entita` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `stati`
--

INSERT INTO `stati` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `entita`, `name`) VALUES
(1, 'N', '2023-01-17 14:34:24', 'SYS', '2023-01-17 15:24:12', 'SYS', 'offerta', 'offerta', 'Offerta'),
(2, 'N', '2023-01-17 14:34:24', 'SYS', '2023-01-17 15:24:15', 'SYS', 'contrattualizzati', 'offerta', 'Contrattualizzati'),
(4, 'N', '2023-01-17 14:34:39', 'SYS', '2023-01-17 14:34:39', 'SYS', 'accantieramento', 'progetto', 'Accantieramento'),
(5, 'N', '2023-01-17 14:34:39', 'SYS', '2023-01-17 14:34:39', 'SYS', 'lavorazione', 'progetto', 'Lavorazione'),
(6, 'N', '2023-01-17 14:34:39', 'SYS', '2023-01-17 14:34:39', 'SYS', 'conclusi', 'progetto', 'Conclusi'),
(7, 'N', '2023-01-17 14:34:50', 'SYS', '2023-01-17 14:34:50', 'SYS', 'da_ordinare', 'ordine', 'Da Ordinare'),
(8, 'N', '2023-01-17 14:34:50', 'SYS', '2023-01-17 14:34:50', 'SYS', 'ordinato', 'ordine', 'Ordinato'),
(9, 'N', '2023-01-17 14:34:50', 'SYS', '2023-01-17 14:34:50', 'SYS', 'saldato', 'ordine', 'Saldato'),
(10, 'N', '2023-01-17 15:20:14', 'SYS', '2023-01-17 15:20:14', 'SYS', 'da_fatturare', 'pagamenti', 'Da Fatturare'),
(11, 'N', '2023-01-17 15:20:14', 'SYS', '2023-01-17 15:20:14', 'SYS', 'fatturato', 'pagamenti', 'Fatturato'),
(12, 'N', '2023-01-17 15:20:28', 'SYS', '2023-01-17 15:20:28', 'SYS', 'pagato', 'pagamenti', 'Pagato');

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `name` varchar(255) NOT NULL DEFAULT '',
  `surname` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `name`, `surname`, `email`, `password`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'stefano', 'guida', 'stefanoguida86@gmail.com', '$2b$10$/dnjct3RSctpLz5Id7lHcuTo7IkFLcG4y4HGiZDk5ep47JTDn3TBK');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `clienti`
--
ALTER TABLE `clienti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_clienti_ragione_sociale` (`ragione_sociale`);

--
-- Indici per le tabelle `contratti`
--
ALTER TABLE `contratti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_contratti_progetto` (`id_progetto`),
  ADD KEY `IDX_contratti_data_accettazione` (`data_accettazione`);

--
-- Indici per le tabelle `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_files_cliente` (`id_cliente`),
  ADD KEY `IDX_files_tipo` (`tipo`),
  ADD KEY `fk_files_progetti` (`id_progetto`);

--
-- Indici per le tabelle `forniture`
--
ALTER TABLE `forniture`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_servizi_code` (`code`);

--
-- Indici per le tabelle `forniture_contratti`
--
ALTER TABLE `forniture_contratti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  ADD KEY `IDX_servizi_contratti_servizio` (`id_servizio`);

--
-- Indici per le tabelle `forniture_offerta`
--
ALTER TABLE `forniture_offerta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  ADD KEY `IDX_servizi_contratti_servizio` (`id_servizio`);

--
-- Indici per le tabelle `offerte`
--
ALTER TABLE `offerte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contratti_stato` (`id_stato`),
  ADD KEY `IDX_contratti_progetto` (`id_progetto`),
  ADD KEY `IDX_contratti_data_offerta` (`data_offerta`);

--
-- Indici per le tabelle `ordini`
--
ALTER TABLE `ordini`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ordini_progetto` (`id_progetto`),
  ADD KEY `fk_ordini_stato` (`id_stato`);

--
-- Indici per le tabelle `pagamenti_ordine`
--
ALTER TABLE `pagamenti_ordine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pagamenti_ordine_ordine` (`id_ordine`);

--
-- Indici per le tabelle `progetti`
--
ALTER TABLE `progetti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_progetti_cliente` (`id_cliente`),
  ADD KEY `fk_progetti_stato` (`id_stato`),
  ADD KEY `IDX_progetti_data_inizio` (`data_inizio`),
  ADD KEY `IDX_progetti_data_fine` (`data_fine`),
  ADD KEY `IDX_progetti_luogo` (`luogo`);

--
-- Indici per le tabelle `righe_ordine`
--
ALTER TABLE `righe_ordine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_righe_ordine_ordine` (`id_ordine`),
  ADD KEY `fk_righe_ordini_servizio` (`id_servizio`);

--
-- Indici per le tabelle `servizi`
--
ALTER TABLE `servizi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_servizi_code` (`code`);

--
-- Indici per le tabelle `servizi_contratti`
--
ALTER TABLE `servizi_contratti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  ADD KEY `IDX_servizi_contratti_servizio` (`id_servizio`);

--
-- Indici per le tabelle `servizi_offeta`
--
ALTER TABLE `servizi_offeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  ADD KEY `IDX_servizi_contratti_servizio` (`id_servizio`);

--
-- Indici per le tabelle `stati`
--
ALTER TABLE `stati`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_stati_contratto_code` (`code`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_users_email` (`email`),
  ADD KEY `IDX_users_name` (`name`),
  ADD KEY `IDX_users_surname` (`surname`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `clienti`
--
ALTER TABLE `clienti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT per la tabella `contratti`
--
ALTER TABLE `contratti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT per la tabella `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT per la tabella `forniture`
--
ALTER TABLE `forniture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la tabella `forniture_contratti`
--
ALTER TABLE `forniture_contratti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `forniture_offerta`
--
ALTER TABLE `forniture_offerta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `offerte`
--
ALTER TABLE `offerte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT per la tabella `ordini`
--
ALTER TABLE `ordini`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `pagamenti_ordine`
--
ALTER TABLE `pagamenti_ordine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `progetti`
--
ALTER TABLE `progetti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT per la tabella `righe_ordine`
--
ALTER TABLE `righe_ordine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `servizi`
--
ALTER TABLE `servizi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT per la tabella `servizi_contratti`
--
ALTER TABLE `servizi_contratti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT per la tabella `servizi_offeta`
--
ALTER TABLE `servizi_offeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT per la tabella `stati`
--
ALTER TABLE `stati`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `contratti`
--
ALTER TABLE `contratti`
  ADD CONSTRAINT `fk_contratti_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`);

--
-- Limiti per la tabella `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `fk_files_clienti` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`),
  ADD CONSTRAINT `fk_files_progetti` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`);

--
-- Limiti per la tabella `offerte`
--
ALTER TABLE `offerte`
  ADD CONSTRAINT `fk_offerte_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`),
  ADD CONSTRAINT `fk_offerte_stato` FOREIGN KEY (`id_stato`) REFERENCES `stati` (`id`);

--
-- Limiti per la tabella `ordini`
--
ALTER TABLE `ordini`
  ADD CONSTRAINT `fk_ordini_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`);

--
-- Limiti per la tabella `pagamenti_ordine`
--
ALTER TABLE `pagamenti_ordine`
  ADD CONSTRAINT `fk_pagamenti_ordine_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id`);

--
-- Limiti per la tabella `progetti`
--
ALTER TABLE `progetti`
  ADD CONSTRAINT `fk_progetti_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`);

--
-- Limiti per la tabella `righe_ordine`
--
ALTER TABLE `righe_ordine`
  ADD CONSTRAINT `fk_righe_ordine_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
