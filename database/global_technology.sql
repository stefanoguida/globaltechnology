CREATE DATABASE global_technology;
USE global_technology;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


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

CREATE TABLE `contratti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `progetto` int(11) NOT NULL,
  `data_offerta` datetime DEFAULT current_timestamp(),
  `data_accettazione` datetime DEFAULT NULL,
  `importo_richiesto` decimal(11,2) NOT NULL DEFAULT 0.00,
  `importo_accettato` decimal(11,2) DEFAULT NULL,
  `kw` decimal(11,2) DEFAULT 0.00,
  `stato` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `contratti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `progetto`, `data_offerta`, `data_accettazione`, `importo_richiesto`, `importo_accettato`, `kw`, `stato`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-09 23:05:24', 'SYS', 1, '2022-05-24 00:00:00', '2022-06-24 00:00:00', '259270.00', '259270.00', '998.20', 2),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-10 00:26:46', 'SYS', 2, '2022-06-24 00:00:00', '2022-07-24 00:00:00', '193905.00', '193905.00', '997.00', 2),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '212798.00', '212798.00', '998.76', 1),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '334357.00', '334357.00', '998.76', 1),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 5, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '210443.00', '210443.00', '998.00', 1),
(6, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 6, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '198859.00', '198859.00', '998.00', 1),
(7, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '200247.00', '200247.00', '998.00', 1),
(8, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 8, '2022-07-24 15:32:21', '2022-08-24 15:32:21', '202437.00', '202437.00', '510.30', 1),
(9, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 9, '2022-07-24 15:32:21', '2022-08-24 15:32:21', '225100.00', '225100.00', '702.00', 1),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 10, '2022-07-24 15:32:21', '2022-08-24 15:32:21', '202437.00', '202437.00', '510.30', 1),
(11, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 11, '2022-07-24 15:32:21', '2022-08-24 15:32:21', '223559.00', '223559.00', '687.96', 1),
(12, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 12, '2022-07-24 15:32:21', '2022-08-24 15:32:21', '201954.00', '201954.00', '510.30', 1),
(13, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 13, '2022-07-24 15:32:21', '2022-08-24 15:32:21', '360630.00', '360630.00', '996.84', 1),
(14, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 14, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '42000.00', '42000.00', '388.00', 1),
(15, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 15, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '101148.70', NULL, '642.00', 1),
(16, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 16, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '76245.80', '74770.00', '522.00', 1),
(17, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 17, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '100313.42', '190822.80', '716.00', 1),
(18, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 18, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '139097.50', NULL, '1050.20', 1),
(19, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 19, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '320833.00', '129177.30', '1996.90', 1),
(20, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 20, '2022-06-24 15:32:21', '2022-07-24 15:32:21', '561892.00', '500000.00', '3709.00', 1),
(21, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 21, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '481000.00', '481000.00', '811.89', 1),
(22, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 22, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '410212.60', '410212.60', '999.39', 1),
(23, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 23, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '369787.40', '369787.40', '995.33', 1),
(24, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 24, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '472453.82', '472453.82', '999.19', 1),
(25, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 25, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '481300.36', '481300.36', '991.11', 1),
(26, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 26, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '333280.32', '333280.32', '811.25', 1),
(27, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 27, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '368082.15', '368082.15', '998.96', 1),
(28, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 28, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '346173.96', '346173.96', '996.38', 1),
(29, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 29, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '495161.23', '495161.23', '991.32', 1),
(30, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 30, '2022-01-24 15:32:21', '2022-02-24 15:32:21', '483588.64', '483588.64', '996.15', 1),
(31, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 31, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '1225000.00', '1225000.00', '12406.24', 1),
(32, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 32, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '170000.00', '170000.00', '963.00', 1),
(33, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 33, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '1401172.00', '1401172.00', '4970.00', 1),
(34, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 34, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '295268.00', '295268.00', '523.00', 1),
(35, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 35, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '1310000.00', '1310000.00', '8034.39', 1),
(36, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 36, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '190000.00', '190000.00', '997.92', 1),
(37, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 37, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '190000.00', '190000.00', '950.00', 1),
(38, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 38, '2022-10-24 15:32:21', '2022-11-24 15:32:21', '1250000.00', '1250000.00', '7630.00', 1),
(39, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 39, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '1794000.00', NULL, '3250.00', 1),
(40, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 40, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '2115816.00', NULL, '3833.00', 1),
(41, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 41, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '4037040.00', NULL, '7560.00', 1),
(42, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 42, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '1583136.00', NULL, '2868.00', 1),
(43, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 43, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '2393664.00', NULL, '4368.00', 1),
(44, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 44, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '1344470.40', NULL, '2462.40', 1),
(45, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 45, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '552944.70', '590000.00', '999.90', 1),
(46, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 46, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '572451.84', '716000.00', '993.84', 1),
(47, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 47, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '3731023.20', '538000.00', '7258.80', 1),
(48, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 48, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '558489.60', '714000.00', '969.60', 1),
(49, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 49, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '3065421.60', '572000.00', '5906.40', 1),
(50, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 50, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '1556100.00', NULL, '2850.00', 1),
(51, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 51, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '2127544.80', '572000.00', '4060.20', 1),
(52, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 52, '2022-11-24 15:32:21', '2022-04-24 15:32:21', '518057.28', '733000.00', '945.36', 1);

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `cliente` int(11) NOT NULL,
  `progetto` int(11) NOT NULL,
  `tipo` enum('ordine','offerta','contratto','') NOT NULL DEFAULT '',
  `path` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `files` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `cliente`, `progetto`, `tipo`, `path`) VALUES
(1, 'N', '2023-01-04 14:51:38', 'SYS', '2023-01-04 16:51:06', 'SYS', 1, 1, 'ordine', 'storage/obton/ordini/Preventivo Global Technology.pdf'),
(2, 'N', '2023-01-04 14:51:58', 'SYS', '2023-01-04 16:28:31', 'SYS', 1, 1, 'offerta', 'Preventivo Global Technology.pdf'),
(7, 'N', '2023-01-12 17:03:47', 'SYS', '2023-01-12 17:03:47', 'SYS', 1, 2, 'ordine', 'storage/Preventivo Global Technology.pdf'),
(23, 'N', '2023-01-12 23:41:49', 'SYS', '2023-01-12 23:41:49', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124149.pdf'),
(24, 'N', '2023-01-12 23:45:07', 'SYS', '2023-01-12 23:45:07', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124507.pdf'),
(25, 'N', '2023-01-12 23:46:50', 'SYS', '2023-01-12 23:46:50', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124650.pdf'),
(26, 'N', '2023-01-12 23:47:46', 'SYS', '2023-01-12 23:47:46', 'SYS', 1, 1, 'ordine', 'storage/Preventivo Global Technology-20230113124746.pdf');

CREATE TABLE `ordini` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `progetto` int(11) NOT NULL,
  `stato` int(11) NOT NULL,
  `data_consegna` datetime DEFAULT NULL,
  `importo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `ordini` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `progetto`, `stato`, `data_consegna`, `importo`) VALUES
(1, 'N', '2022-12-30 14:09:19', 'SYS', '2023-01-04 14:35:02', 'SYS', 1, 1, NULL, 1000),
(2, 'N', '2022-12-30 14:09:46', 'SYS', '2022-12-30 14:09:46', 'SYS', 2, 2, '2023-01-31 15:09:22', 1256);

CREATE TABLE `pagamenti_ordine` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `ordine` int(11) NOT NULL,
  `importo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `progetti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `cliente` int(11) NOT NULL,
  `data_inizio` datetime DEFAULT NULL,
  `data_fine` datetime DEFAULT NULL,
  `impianto` varchar(255) DEFAULT '',
  `luogo` varchar(255) NOT NULL DEFAULT '',
  `stato` varchar(255) NOT NULL,
  `completamento` int(3) DEFAULT 0,
  `commenti` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `progetti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `cliente`, `data_inizio`, `data_fine`, `impianto`, `luogo`, `stato`, `completamento`, `commenti`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-13 00:01:47', 'SYS', 1, '2022-06-24 00:00:00', '2023-06-24 00:00:00', 'andria', 'Andria', 'lavorazione', 75, ''),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2023-01-03 16:27:30', 'SYS', 1, '2022-07-24 00:00:00', '2023-07-24 00:00:00', 'capitolicchio', 'Taranto', 'lavorazione', 65, NULL),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'sbm', 'Turi', 'lavorazione', 25, NULL),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'trinitapoli', 'Trinitapoli', 'lavorazione', 25, NULL),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'turi4', 'Turi', 'lavorazione', 25, NULL),
(6, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'turi6', 'Turi', 'lavorazione', 25, NULL),
(7, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, '2022-07-24 15:32:21', '2023-07-24 15:32:21', 'turi7', 'Turi', 'lavorazione', 25, NULL),
(8, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'baligio', 'Fossano (CN)', 'lavorazione', 20, NULL),
(9, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'bosconero', 'Bosconero (TO)', 'lavorazione', 20, NULL),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'castiglione', 'Savigliano (CN)', 'lavorazione', 20, NULL),
(11, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'cascina valentino', 'Saluzzo (CN)', 'lavorazione', 20, NULL),
(12, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'santa lucia', 'Fossano (CN)', 'lavorazione', 20, NULL),
(13, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, '2022-08-24 15:32:21', '2023-08-24 15:32:21', 'bigreco', 'Busca (CN)', 'lavorazione', 20, NULL),
(14, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1210 - ESAP', '', 'lavorazione', 50, NULL),
(15, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1626 - COPA', '', 'lavorazione', 50, NULL),
(16, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1627 - COVO', '', 'lavorazione', 50, NULL),
(17, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1628 - COPR', '', 'lavorazione', 50, NULL),
(18, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1629 - COCA', '', 'lavorazione', 50, NULL),
(19, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1658 - LODO', '', 'lavorazione', 50, NULL),
(20, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 3, '2022-07-24 15:32:21', '2023-05-24 15:32:21', '1772 - CAFE', '', 'lavorazione', 50, NULL),
(21, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Cassino 1 ', 'Marche', 'conclusi', 100, NULL),
(22, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Castiglione in Teverina', 'Lazio', 'conclusi', 100, NULL),
(23, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Grottazzolina', 'Abruzzo', 'conclusi', 100, NULL),
(24, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'CappelleSulTavo', 'Lazio', 'conclusi', 100, NULL),
(25, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Isernia', 'Abruzzo', 'conclusi', 100, NULL),
(26, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Corvara', 'Abruzzo', 'conclusi', 100, NULL),
(27, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Filetto', 'Abruzzo', 'conclusi', 100, NULL),
(28, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Civitaquana', 'Lazio', 'conclusi', 100, NULL),
(29, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Cassino 2', 'Abruzzo', 'conclusi', 100, NULL),
(30, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 4, '2022-02-24 15:32:21', '2022-11-24 15:32:21', 'Mondavio', 'Marche', 'conclusi', 100, NULL),
(31, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 5, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'deliceto', 'deliceto', 'accantieramento', 0, NULL),
(32, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 5, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'iren', 'deliceto', 'accantieramento', 0, NULL),
(33, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 6, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'monfalcone', 'monfalcone', 'accantieramento', 0, NULL),
(34, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 6, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'sestri ponente', 'sestri ponente', 'accantieramento', 0, NULL),
(35, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Nardò', 'Nardò', 'accantieramento', 0, NULL),
(36, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'San Martino in Pensilis', 'San Martino in Pensilis', 'accantieramento', 0, NULL),
(37, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Celleno', 'Celleno', 'accantieramento', 0, NULL),
(38, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Lequile', 'Lequile', 'accantieramento', 0, NULL),
(39, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Quattordio', 'Alessandria Piemonte', 'accantieramento', 0, NULL),
(40, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Pachino', 'Siracusa', 'accantieramento', 0, NULL),
(41, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Brindisi San Giorgio', 'Brindisi', 'accantieramento', 0, NULL),
(42, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Viterbo', 'Viterbo', 'accantieramento', 0, NULL),
(43, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Orani', 'Viterbo', 'accantieramento', 0, NULL),
(44, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Marino', '', 'accantieramento', 0, NULL),
(45, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Flycom', '', 'accantieramento', 0, NULL),
(46, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Bettona', '', 'accantieramento', 0, NULL),
(47, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Brizzarelli', '', 'accantieramento', 0, NULL),
(48, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Castiglione', '', 'accantieramento', 0, NULL),
(49, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Euroservice', '', 'accantieramento', 0, NULL),
(50, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Spoleto', '', 'accantieramento', 0, NULL),
(51, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Vasca', '', 'accantieramento', 0, NULL),
(52, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 7, '2022-11-24 15:32:21', '2023-08-24 15:32:21', 'Villanova', '', 'accantieramento', 0, NULL);

CREATE TABLE `righe_ordine` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `ordine` int(11) NOT NULL,
  `servizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `righe_ordine` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `ordine`, `servizio`) VALUES
(1, 'N', '2022-12-30 14:30:58', 'SYS', '2022-12-30 14:30:58', 'SYS', 1, 1),
(2, 'N', '2022-12-30 14:30:58', 'SYS', '2022-12-30 14:30:58', 'SYS', 1, 11);

CREATE TABLE `servizi` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL DEFAULT '',
  `parent_code` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `servizi` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `parent_code`, `name`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'ingegneria', NULL, 'Ingegneria'),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'forniture', NULL, 'Forniture'),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'cavi', 'forniture', 'Cavi'),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'pannelli', 'forniture', 'Pannelli'),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'inverter', 'forniture', 'Inverter'),
(6, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'trasformatori', 'forniture', 'Trasformatori'),
(7, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'struttura', 'forniture', 'Struttura'),
(8, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'cabinaconsegna', 'forniture', 'Cabina di consegna'),
(9, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'cabinautente', 'forniture', 'Cabina utente'),
(10, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'installazioneelettrica', NULL, 'Installazione elettrica'),
(11, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'installazionemeccanica', NULL, 'Installazione meccanica'),
(12, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'lavoriedili', NULL, 'Lavori edili'),
(13, 'N', '2023-01-13 00:02:17', 'SYS', '2023-01-13 00:02:17', 'SYS', 'prova', NULL, 'Prova');

CREATE TABLE `servizi_contratti` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `contratto` int(11) NOT NULL,
  `servizio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `servizi_contratti` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `contratto`, `servizio`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, 1),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, 3),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 1, 4),
(4, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, 1),
(5, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 2, 2),
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

CREATE TABLE `stati_contratto` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `stati_contratto` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `name`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'offerta', 'Offerta'),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'contrattualizzati', 'Contrattualizzati');

CREATE TABLE `stati_ordine` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `stati_ordine` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `name`) VALUES
(1, 'N', '2022-12-30 11:26:33', 'SYS', '2022-12-30 11:26:33', 'SYS', 'da_ordinare', 'Da Ordinare'),
(2, 'N', '2022-12-30 11:26:33', 'SYS', '2022-12-30 11:26:33', 'SYS', 'ordinato', 'Ordinato'),
(3, 'N', '2022-12-30 11:26:33', 'SYS', '2022-12-30 11:26:33', 'SYS', 'saldato', 'Saldato');

CREATE TABLE `stati_progetto` (
  `id` int(11) NOT NULL,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `stati_progetto` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `code`, `name`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'accantieramento', 'Accantieramento'),
(2, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'lavorazione', 'Lavorazione'),
(3, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'conclusi', 'Conclusi');

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

INSERT INTO `users` (`id`, `trec`, `created_at`, `created_by`, `updated_at`, `updated_by`, `name`, `surname`, `email`, `password`) VALUES
(1, 'N', '2022-12-24 15:32:21', 'SYS', '2022-12-24 15:32:21', 'SYS', 'stefano', 'guida', 'stefanoguida86@gmail.com', '$2b$10$/dnjct3RSctpLz5Id7lHcuTo7IkFLcG4y4HGiZDk5ep47JTDn3TBK');


ALTER TABLE `clienti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_clienti_ragione_sociale` (`ragione_sociale`);

ALTER TABLE `contratti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contratti_stato` (`stato`),
  ADD KEY `IDX_contratti_progetto` (`progetto`),
  ADD KEY `IDX_contratti_data_offerta` (`data_offerta`),
  ADD KEY `IDX_contratti_data_accettazione` (`data_accettazione`);

ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_files_cliente` (`cliente`),
  ADD KEY `IDX_files_tipo` (`tipo`),
  ADD KEY `fk_files_progetti` (`progetto`);

ALTER TABLE `ordini`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ordini_progetto` (`progetto`),
  ADD KEY `fk_ordini_stato` (`stato`);

ALTER TABLE `pagamenti_ordine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pagamenti_ordine_ordine` (`ordine`);

ALTER TABLE `progetti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_progetti_cliente` (`cliente`),
  ADD KEY `fk_progetti_stato` (`stato`),
  ADD KEY `IDX_progetti_data_inizio` (`data_inizio`),
  ADD KEY `IDX_progetti_data_fine` (`data_fine`),
  ADD KEY `IDX_progetti_luogo` (`luogo`);

ALTER TABLE `righe_ordine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_righe_ordine_ordine` (`ordine`),
  ADD KEY `fk_righe_ordini_servizio` (`servizio`);

ALTER TABLE `servizi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_servizi_code` (`code`);

ALTER TABLE `servizi_contratti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_servizi_contratti_contratto` (`contratto`),
  ADD KEY `IDX_servizi_contratti_servizio` (`servizio`);

ALTER TABLE `stati_contratto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_stati_contratto_code` (`code`);

ALTER TABLE `stati_ordine`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_stati_ordine_code` (`code`);

ALTER TABLE `stati_progetto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_stati_progetto_code` (`code`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UIDX_users_email` (`email`),
  ADD KEY `IDX_users_name` (`name`),
  ADD KEY `IDX_users_surname` (`surname`);


ALTER TABLE `clienti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

ALTER TABLE `contratti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

ALTER TABLE `ordini`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `pagamenti_ordine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `progetti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

ALTER TABLE `righe_ordine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `servizi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `servizi_contratti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

ALTER TABLE `stati_contratto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `stati_ordine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `stati_progetto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;


ALTER TABLE `contratti`
  ADD CONSTRAINT `fk_contratti_impianto` FOREIGN KEY (`progetto`) REFERENCES `progetti` (`id`),
  ADD CONSTRAINT `fk_contratti_stato` FOREIGN KEY (`stato`) REFERENCES `stati_contratto` (`id`);

ALTER TABLE `files`
  ADD CONSTRAINT `fk_files_clienti` FOREIGN KEY (`cliente`) REFERENCES `clienti` (`id`),
  ADD CONSTRAINT `fk_files_progetti` FOREIGN KEY (`progetto`) REFERENCES `progetti` (`id`);

ALTER TABLE `ordini`
  ADD CONSTRAINT `fk_ordini_progetto` FOREIGN KEY (`progetto`) REFERENCES `progetti` (`id`),
  ADD CONSTRAINT `fk_ordini_stato` FOREIGN KEY (`stato`) REFERENCES `stati_ordine` (`id`);

ALTER TABLE `pagamenti_ordine`
  ADD CONSTRAINT `fk_pagamenti_ordine_ordine` FOREIGN KEY (`ordine`) REFERENCES `ordini` (`id`);

ALTER TABLE `progetti`
  ADD CONSTRAINT `fk_progetti_cliente` FOREIGN KEY (`cliente`) REFERENCES `clienti` (`id`),
  ADD CONSTRAINT `fk_progetti_stato` FOREIGN KEY (`stato`) REFERENCES `stati_progetto` (`code`);

ALTER TABLE `righe_ordine`
  ADD CONSTRAINT `fk_righe_ordine_ordine` FOREIGN KEY (`ordine`) REFERENCES `ordini` (`id`),
  ADD CONSTRAINT `fk_righe_ordini_servizio` FOREIGN KEY (`servizio`) REFERENCES `servizi` (`id`);

ALTER TABLE `servizi_contratti`
  ADD CONSTRAINT `fk_servizi_contratti_contratto` FOREIGN KEY (`contratto`) REFERENCES `contratti` (`id`),
  ADD CONSTRAINT `fk_servizi_contratti_servizio` FOREIGN KEY (`servizio`) REFERENCES `servizi` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
