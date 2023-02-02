-- MariaDB dump 10.19  Distrib 10.6.11-MariaDB, for Linux (aarch64)
--
-- Host: database    Database: global_technology
-- ------------------------------------------------------
-- Server version	10.10.2-MariaDB-1:10.10.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `global_technology`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `global_technology` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `global_technology`;

--
-- Table structure for table `clienti`
--

DROP TABLE IF EXISTS `clienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clienti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `ragione_sociale` varchar(255) NOT NULL DEFAULT '',
  `piva` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_clienti_ragione_sociale` (`ragione_sociale`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
INSERT INTO `clienti` VALUES (1,'N','2022-12-24 15:32:21','SYS','2023-01-13 00:01:20','SYS','obton','00000000002'),(2,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','blue elephant','00000000000'),(3,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','bayware','00000000000'),(4,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','hydrowatt','00000000000'),(5,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','lt','00000000000'),(6,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','fincantieri','00000000000'),(7,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','comun energ','00000000000'),(8,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','trina','00000000000'),(9,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','rpower','00000000000'),(10,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','valmont','00000000000'),(26,'N','2023-01-24 01:25:35','SYS','2023-01-24 01:25:35','SYS','prova','1234567890'),(27,'N','2023-02-01 23:38:05','SYS','2023-02-01 23:38:05','SYS','stefano guida','1234567898');
/*!40000 ALTER TABLE `clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratti`
--

DROP TABLE IF EXISTS `contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contratti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_cliente` int(11) NOT NULL,
  `id_progetto` int(11) NOT NULL,
  `data_accettazione` datetime DEFAULT NULL,
  `importo_contrattato` decimal(11,2) NOT NULL DEFAULT 0.00,
  `kw` decimal(11,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_contratti_id_progetto` (`id_progetto`),
  UNIQUE KEY `IDX_contratti_progetto` (`id_progetto`) USING BTREE,
  KEY `IDX_contratti_data_accettazione` (`data_accettazione`),
  CONSTRAINT `fk_contratti_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratti`
--

LOCK TABLES `contratti` WRITE;
/*!40000 ALTER TABLE `contratti` DISABLE KEYS */;
INSERT INTO `contratti` VALUES (53,'N','2023-01-29 22:34:28','SYS','2023-01-29 22:34:28','SYS',1,3,'2023-01-29 00:00:00',48000.00,998.76),(54,'N','2023-01-29 22:34:28','SYS','2023-01-29 22:34:28','SYS',1,1,'2023-01-28 00:00:00',259270.00,998.20),(55,'N','2023-01-29 22:34:28','SYS','2023-01-29 22:34:28','SYS',1,2,'2023-01-29 00:00:00',1000.00,997.00),(61,'N','2023-01-30 00:55:13','SYS','2023-01-30 00:55:13','SYS',1,4,'2023-01-30 00:00:00',15000.00,998.76),(66,'N','2023-01-30 23:26:32','SYS','2023-01-30 23:26:32','SYS',1,5,'2023-01-31 00:00:00',2000.00,998.00),(69,'N','2023-02-02 08:27:46','SYS','2023-02-02 08:27:46','SYS',27,59,'2023-02-02 00:00:00',80000.00,1000.00);
/*!40000 ALTER TABLE `contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_cliente` int(11) DEFAULT NULL,
  `id_progetto` int(11) DEFAULT NULL,
  `id_riferimento` int(11) NOT NULL,
  `tipo` enum('ordine','offerta','contratto','') NOT NULL DEFAULT '',
  `path` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `IDX_files_cliente` (`id_cliente`),
  KEY `IDX_files_tipo` (`tipo`),
  KEY `fk_files_progetti` (`id_progetto`),
  CONSTRAINT `fk_files_clienti` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`),
  CONSTRAINT `fk_files_progetti` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (4,'N','2023-02-01 22:11:36','SYS','2023-02-01 22:11:36','SYS',NULL,NULL,1,'offerta','storage/Preventivo Global Technology.pdf'),(5,'N','2023-02-01 23:06:57','SYS','2023-02-01 23:06:57','SYS',NULL,NULL,2,'offerta','storage/Preventivo Global Technology-20230202120657.pdf'),(6,'N','2023-02-01 23:08:53','SYS','2023-02-01 23:08:53','SYS',NULL,NULL,3,'offerta','storage/Preventivo Global Technology-20230202120853.pdf'),(7,'N','2023-02-01 23:11:43','SYS','2023-02-01 23:11:43','SYS',NULL,NULL,1,'offerta','storage/Preventivo Global Technology-20230202121143.pdf'),(8,'N','2023-02-01 23:13:53','SYS','2023-02-01 23:13:53','SYS',NULL,NULL,2,'offerta','storage/Preventivo Global Technology-20230202121353.pdf'),(9,'N','2023-02-01 23:14:14','SYS','2023-02-01 23:14:14','SYS',NULL,NULL,53,'contratto','storage/Preventivo Global Technology-20230202121414.pdf'),(10,'N','2023-02-02 22:57:47','SYS','2023-02-02 22:57:47','SYS',NULL,NULL,55,'contratto','storage/Preventivo Global Technology-20230202115747.pdf');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forniture`
--

DROP TABLE IF EXISTS `forniture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forniture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_servizi_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forniture`
--

LOCK TABLES `forniture` WRITE;
/*!40000 ALTER TABLE `forniture` DISABLE KEYS */;
INSERT INTO `forniture` VALUES (1,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','cavi','Cavi'),(2,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','pannelli','Pannelli'),(3,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','inverter','Inverter'),(4,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','trasformatori','Trasformatori'),(5,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','struttura','Struttura'),(6,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','cabinaconsegna','Cabina di consegna'),(7,'N','2023-01-17 14:32:29','SYS','2023-01-17 14:32:29','SYS','cabinautente','Cabina utente');
/*!40000 ALTER TABLE `forniture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forniture_contratti`
--

DROP TABLE IF EXISTS `forniture_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forniture_contratti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  KEY `IDX_servizi_contratti_servizio` (`id_servizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forniture_contratti`
--

LOCK TABLES `forniture_contratti` WRITE;
/*!40000 ALTER TABLE `forniture_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `forniture_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forniture_offerta`
--

DROP TABLE IF EXISTS `forniture_offerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forniture_offerta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  KEY `IDX_servizi_contratti_servizio` (`id_servizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forniture_offerta`
--

LOCK TABLES `forniture_offerta` WRITE;
/*!40000 ALTER TABLE `forniture_offerta` DISABLE KEYS */;
/*!40000 ALTER TABLE `forniture_offerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  `Note` text NOT NULL,
  `importo_percentuale` int(3) NOT NULL,
  `importo_valore` decimal(11,2) NOT NULL,
  `id_stato` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pagamenti_ordine_ordine` (`id_contratto`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones`
--

LOCK TABLES `milestones` WRITE;
/*!40000 ALTER TABLE `milestones` DISABLE KEYS */;
INSERT INTO `milestones` VALUES (1,'N','2023-02-01 00:49:34','SYS','2023-02-01 00:49:34','SYS',53,'SAL 1','10 %',10,4800.00,12),(2,'N','2023-02-01 00:49:34','SYS','2023-02-01 00:49:34','SYS',53,'SAL 2','90%',89,42720.00,12),(4,'N','2023-01-30 23:26:32','SYS','2023-01-30 23:26:32','SYS',66,'SAL 1','',100,2000.00,10),(5,'N','2023-02-01 00:49:34','SYS','2023-02-01 00:49:34','SYS',53,'SAL3','',1,480.00,12),(6,'N','2023-02-02 08:23:44','SYS','2023-02-02 08:23:44','SYS',67,'SAL 1','',100,1000000.00,10),(7,'N','2023-02-02 08:27:26','SYS','2023-02-02 08:27:26','SYS',0,'SAL 1','',100,48000.00,10),(8,'N','2023-02-02 08:27:46','SYS','2023-02-02 08:27:46','SYS',69,'SAL 1','',100,80000.00,10),(9,'N','2023-02-02 08:28:19','SYS','2023-02-02 08:28:19','SYS',0,'SAL 1','',100,80000.00,10),(10,'N','2023-02-02 08:28:26','SYS','2023-02-02 08:28:26','SYS',0,'SAL 1','',100,80000.00,10),(11,'N','2023-02-02 08:28:58','SYS','2023-02-02 08:28:58','SYS',0,'SAL 1','',100,85500.00,10),(12,'N','2023-02-02 22:57:23','SYS','2023-02-02 22:57:23','SYS',54,'SAL 1','sal inizio',10,25927.00,10);
/*!40000 ALTER TABLE `milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offerte`
--

DROP TABLE IF EXISTS `offerte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offerte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_cliente` int(11) DEFAULT NULL,
  `id_progetto` int(11) DEFAULT NULL,
  `id_tipo_progetto` int(11) NOT NULL,
  `data_offerta` date DEFAULT current_timestamp(),
  `data_accettazione` date DEFAULT NULL,
  `importo_offerto` decimal(11,2) DEFAULT NULL,
  `importo_contrattato` decimal(11,2) DEFAULT NULL,
  `kw` decimal(11,2) DEFAULT 0.00,
  `luogo` varchar(255) DEFAULT NULL,
  `impianto` varchar(255) DEFAULT NULL,
  `id_stato` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_contratti_stato` (`id_stato`),
  KEY `IDX_contratti_progetto` (`id_progetto`),
  KEY `IDX_contratti_data_offerta` (`data_offerta`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offerte`
--

LOCK TABLES `offerte` WRITE;
/*!40000 ALTER TABLE `offerte` DISABLE KEYS */;
INSERT INTO `offerte` VALUES (1,'N','2023-01-27 23:44:00','SYS','2023-01-29 22:01:20','SYS',1,3,2,'2022-06-24','2023-01-29',212798.00,48000.00,998.76,'Turi','sbm',2),(2,'N','2023-01-27 23:44:00','SYS','2023-01-30 00:51:46','SYS',1,4,2,'2022-06-24','2023-01-30',334357.00,15000.00,998.76,'Trinitapoli','trinitapoli',2),(3,'N','2023-01-27 23:44:00','SYS','2023-01-30 23:26:32','SYS',1,5,2,'2022-06-24','2023-01-31',210443.00,2000.00,998.00,'Turi','turi4',2),(4,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',1,6,2,'2022-06-24',NULL,198859.00,NULL,998.00,'Turi','turi6',1),(5,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',1,7,2,'2022-06-24',NULL,200247.00,NULL,998.00,'Turi','turi7',1),(6,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',2,8,2,'2022-07-24',NULL,202437.00,NULL,510.30,'Fossano (CN)','baligio',1),(7,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',2,9,2,'2022-07-24',NULL,225100.00,NULL,702.00,'Bosconero (TO)','bosconero',1),(8,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',2,10,2,'2022-07-24',NULL,202437.00,NULL,510.30,'Savigliano (CN)','castiglione',1),(9,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',2,11,2,'2022-07-24',NULL,223559.00,NULL,687.96,'Saluzzo (CN)','cascina valentino',1),(10,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',2,12,2,'2022-07-24',NULL,201954.00,NULL,510.30,'Fossano (CN)','santa lucia',1),(12,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',3,14,2,'2022-06-24',NULL,42000.00,NULL,388.00,'','1210 - ESAP',1),(13,'N','2023-01-27 23:44:00','SYS','2023-01-29 08:58:12','SYS',3,15,2,'2022-06-24',NULL,101148.70,NULL,642.00,'','1626 - COPA',1),(14,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',3,16,2,'2022-06-24',NULL,76245.80,NULL,522.00,'','1627 - COVO',1),(15,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',3,17,2,'2022-06-24',NULL,100313.42,NULL,716.00,'','1628 - COPR',1),(16,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',3,18,2,'2022-06-24',NULL,139097.50,NULL,1050.20,'','1629 - COCA',1),(17,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',3,19,2,'2022-06-24',NULL,320833.00,NULL,1996.90,'','1658 - LODO',1),(18,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',3,20,2,'2022-06-24',NULL,561892.00,NULL,3709.00,'','1772 - CAFE',1),(19,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,21,2,'2022-01-24',NULL,481000.00,NULL,811.89,'Marche','Cassino 1 ',1),(20,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,22,2,'2022-01-24',NULL,410212.60,NULL,999.39,'Lazio','Castiglione in Teverina',1),(21,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,23,2,'2022-01-24',NULL,369787.40,NULL,995.33,'Abruzzo','Grottazzolina',1),(22,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,24,2,'2022-01-24',NULL,472453.82,NULL,999.19,'Lazio','CappelleSulTavo',1),(23,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,25,2,'2022-01-24',NULL,481300.36,NULL,991.11,'Abruzzo','Isernia',1),(24,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,26,2,'2022-01-24',NULL,333280.32,NULL,811.25,'Abruzzo','Corvara',1),(25,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,27,2,'2022-01-24',NULL,368082.15,NULL,998.96,'Abruzzo','Filetto',1),(26,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,28,2,'2022-01-24',NULL,346173.96,NULL,996.38,'Lazio','Civitaquana',1),(27,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,29,2,'2022-01-24',NULL,495161.23,NULL,991.32,'Abruzzo','Cassino 2',1),(28,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',4,30,2,'2022-01-24',NULL,483588.64,NULL,996.15,'Marche','Mondavio',1),(29,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',5,31,2,'2022-10-24',NULL,1225000.00,NULL,12406.24,'deliceto','deliceto',1),(30,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',5,32,2,'2022-10-24',NULL,170000.00,NULL,963.00,'deliceto','iren',1),(31,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',6,33,2,'2022-10-24',NULL,1401172.00,NULL,4970.00,'monfalcone','monfalcone',1),(32,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',6,34,2,'2022-10-24',NULL,295268.00,NULL,523.00,'sestri ponente','sestri ponente',1),(33,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,35,2,'2022-10-24',NULL,1310000.00,NULL,8034.39,'Nardò','Nardò',1),(34,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,36,2,'2022-10-24',NULL,190000.00,NULL,997.92,'San Martino in Pensilis','San Martino in Pensilis',1),(35,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,37,2,'2022-10-24',NULL,190000.00,NULL,950.00,'Celleno','Celleno',1),(36,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,38,2,'2022-10-24',NULL,1250000.00,NULL,7630.00,'Lequile','Lequile',1),(37,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,39,2,'2022-11-24',NULL,1794000.00,NULL,3250.00,'Alessandria Piemonte','Quattordio',1),(38,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,40,2,'2022-11-24',NULL,2115816.00,NULL,3833.00,'Siracusa','Pachino',1),(39,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,41,2,'2022-11-24',NULL,4037040.00,NULL,7560.00,'Brindisi','Brindisi San Giorgio',1),(40,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,42,2,'2022-11-24',NULL,1583136.00,NULL,2868.00,'Viterbo','Viterbo',1),(41,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,43,2,'2022-11-24',NULL,2393664.00,NULL,4368.00,'Viterbo','Orani',1),(42,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,44,2,'2022-11-24',NULL,1344470.40,NULL,2462.40,'','Marino',1),(43,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,45,2,'2022-11-24',NULL,552944.70,NULL,999.90,'','Flycom',1),(44,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,46,2,'2022-11-24',NULL,572451.84,NULL,993.84,'','Bettona',1),(45,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,47,2,'2022-11-24',NULL,3731023.20,NULL,7258.80,'','Brizzarelli',1),(46,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,48,2,'2022-11-24',NULL,558489.60,NULL,969.60,'','Castiglione',1),(47,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,49,2,'2022-11-24',NULL,3065421.60,NULL,5906.40,'','Euroservice',1),(48,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,50,2,'2022-11-24',NULL,1556100.00,NULL,2850.00,'','Spoleto',1),(49,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,51,2,'2022-11-24',NULL,2127544.80,NULL,4060.20,'','Vasca',1),(50,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',7,52,2,'2022-11-24',NULL,518057.28,NULL,945.36,'','Villanova',1),(51,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:55:08','SYS',1,1,2,'2022-05-24','2023-01-28',259270.00,259270.00,998.20,'Andria','andria',2),(52,'N','2023-01-27 23:44:00','SYS','2023-01-29 21:57:01','SYS',1,2,2,'2022-06-24','2023-01-29',193905.00,1000.00,997.00,'Taranto','capitolicchio',2),(64,'N','2023-01-28 03:29:52','SYS','2023-01-29 08:58:12','SYS',NULL,15,2,'2023-01-28',NULL,123456789.00,NULL,112312.00,NULL,NULL,1),(65,'N','2023-01-28 03:31:09','SYS','2023-01-29 08:58:12','SYS',NULL,15,2,'2023-01-28',NULL,1000.00,NULL,10.00,NULL,NULL,1),(66,'N','2023-01-28 14:36:03','SYS','2023-01-29 08:58:12','SYS',NULL,15,2,'2023-01-28',NULL,10000.00,NULL,1800.00,NULL,NULL,1),(68,'N','2023-01-29 09:11:46','SYS','2023-01-29 09:11:46','SYS',NULL,NULL,2,'2023-01-29',NULL,12345678.00,NULL,123123.00,'napoli','napoli',1),(69,'N','2023-01-29 11:32:52','SYS','2023-01-29 11:32:52','SYS',3,58,2,'2023-01-29',NULL,1500000.00,NULL,190.00,'napoli','napoli',1),(70,'N','2023-02-01 23:38:31','SYS','2023-02-02 08:28:58','SYS',27,59,1,'2023-02-02','2023-02-02',1000000.00,85500.00,1000.00,'napoli','napoli',2);
/*!40000 ALTER TABLE `offerte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini`
--

DROP TABLE IF EXISTS `ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordini` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_progetto` int(11) NOT NULL,
  `id_stato` int(11) NOT NULL,
  `importo` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_ordini_progetto` (`id_progetto`),
  KEY `fk_ordini_stato` (`id_stato`),
  CONSTRAINT `fk_ordini_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (1,'N','2022-12-30 14:09:19','SYS','2023-01-27 08:25:44','SYS',1,8,1000);
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamenti_ordine`
--

DROP TABLE IF EXISTS `pagamenti_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagamenti_ordine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  `Note` text NOT NULL,
  `importo_percentuale` int(3) NOT NULL,
  `importo_valore` decimal(11,2) NOT NULL,
  `id_stato` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pagamenti_ordine_ordine` (`id_contratto`),
  CONSTRAINT `fk_pagamenti_ordine_ordine` FOREIGN KEY (`id_contratto`) REFERENCES `ordini` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamenti_ordine`
--

LOCK TABLES `pagamenti_ordine` WRITE;
/*!40000 ALTER TABLE `pagamenti_ordine` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamenti_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progetti`
--

DROP TABLE IF EXISTS `progetti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progetti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_cliente` int(11) DEFAULT NULL,
  `data_inizio` datetime DEFAULT NULL,
  `data_fine` datetime DEFAULT NULL,
  `impianto` varchar(255) DEFAULT '',
  `luogo` varchar(255) NOT NULL DEFAULT '',
  `id_stato` varchar(255) NOT NULL,
  `completamento` int(3) DEFAULT 0,
  `commenti` text DEFAULT NULL,
  `id_tipo_progetto` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_progetti_cliente` (`id_cliente`),
  KEY `fk_progetti_stato` (`id_stato`),
  KEY `IDX_progetti_data_inizio` (`data_inizio`),
  KEY `IDX_progetti_data_fine` (`data_fine`),
  KEY `IDX_progetti_luogo` (`luogo`),
  CONSTRAINT `fk_progetti_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progetti`
--

LOCK TABLES `progetti` WRITE;
/*!40000 ALTER TABLE `progetti` DISABLE KEYS */;
INSERT INTO `progetti` VALUES (1,'N','2022-12-24 15:32:21','SYS','2023-02-02 22:42:34','SYS',1,'2022-06-24 00:00:00','2023-06-24 00:00:00','andria','Andria','5',0,'',1),(2,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',1,'2022-07-24 00:00:00','2023-07-24 00:00:00','capitolicchio','Taranto','5',65,NULL,1),(3,'N','2022-12-24 15:32:21','SYS','2023-02-01 00:49:34','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','sbm','Turi','5',100,NULL,1),(4,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','trinitapoli','Trinitapoli','5',25,NULL,1),(5,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','turi4','Turi','5',25,NULL,1),(6,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','turi6','Turi','5',25,NULL,1),(7,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','turi7','Turi','5',25,NULL,1),(8,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','baligio','Fossano (CN)','5',20,NULL,1),(9,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','bosconero','Bosconero (TO)','5',20,NULL,1),(10,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','castiglione','Savigliano (CN)','5',20,NULL,1),(11,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','cascina valentino','Saluzzo (CN)','5',20,NULL,1),(12,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','santa lucia','Fossano (CN)','5',20,NULL,1),(13,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','bigreco','Busca (CN)','5',20,NULL,1),(14,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1210 - ESAP','','5',50,NULL,1),(15,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1626 - COPA','','5',50,NULL,1),(16,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1627 - COVO','','5',50,NULL,1),(17,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1628 - COPR','','5',50,NULL,1),(18,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1629 - COCA','','5',50,NULL,1),(19,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1658 - LODO','','5',50,NULL,1),(20,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1772 - CAFE','','5',50,NULL,1),(21,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Cassino 1 ','Marche','6',100,NULL,1),(22,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Castiglione in Teverina','Lazio','6',100,NULL,1),(23,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Grottazzolina','Abruzzo','6',100,NULL,1),(24,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','CappelleSulTavo','Lazio','6',100,NULL,1),(25,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Isernia','Abruzzo','6',100,NULL,1),(26,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Corvara','Abruzzo','6',100,NULL,1),(27,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Filetto','Abruzzo','6',100,NULL,1),(28,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Civitaquana','Lazio','6',100,NULL,1),(29,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Cassino 2','Abruzzo','6',100,NULL,1),(30,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Mondavio','Marche','6',100,NULL,1),(31,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',5,'2022-11-24 15:32:21','2023-08-24 15:32:21','deliceto','deliceto','4',0,NULL,1),(32,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',5,'2022-11-24 15:32:21','2023-08-24 15:32:21','iren','deliceto','4',0,NULL,1),(33,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',6,'2022-11-24 15:32:21','2023-08-24 15:32:21','monfalcone','monfalcone','4',0,NULL,1),(34,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',6,'2022-11-24 15:32:21','2023-08-24 15:32:21','sestri ponente','sestri ponente','4',0,NULL,1),(35,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Nardò','Nardò','4',0,NULL,1),(36,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','San Martino in Pensilis','San Martino in Pensilis','4',0,NULL,1),(37,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Celleno','Celleno','4',0,NULL,1),(38,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Lequile','Lequile','4',0,NULL,1),(39,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Quattordio','Alessandria Piemonte','4',0,NULL,1),(40,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Pachino','Siracusa','4',0,NULL,1),(41,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Brindisi San Giorgio','Brindisi','4',0,NULL,1),(42,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Viterbo','Viterbo','4',0,NULL,1),(43,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Orani','Viterbo','4',0,NULL,1),(44,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Marino','','4',0,NULL,1),(45,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Flycom','','4',0,NULL,1),(46,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Bettona','','4',0,NULL,1),(47,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Brizzarelli','','4',0,NULL,1),(48,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Castiglione','','4',0,NULL,1),(49,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Euroservice','','4',0,NULL,1),(50,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Spoleto','','4',0,NULL,1),(51,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Vasca','','4',0,NULL,1),(52,'N','2022-12-24 15:32:21','SYS','2023-01-29 08:30:22','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Villanova','','4',0,NULL,1),(58,'N','2023-01-29 11:32:52','SYS','2023-02-02 08:50:45','SYS',3,NULL,NULL,'napoli 1','napoli','13',0,NULL,2),(59,'N','2023-02-01 23:38:31','SYS','2023-02-02 08:50:48','SYS',27,NULL,NULL,'napoli 2','napoli','13',0,NULL,1);
/*!40000 ALTER TABLE `progetti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `righe_offerta`
--

DROP TABLE IF EXISTS `righe_offerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `righe_offerta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_offerta` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `importo_offerto` decimal(11,2) DEFAULT NULL,
  `importo_contrattato` decimal(11,2) DEFAULT NULL,
  `pagamento` tinyint(1) DEFAULT 0,
  `data_arrivo_merce` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_righe_ordine_ordine` (`id_offerta`),
  KEY `fk_righe_ordini_servizio` (`id_servizio`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `righe_offerta`
--

LOCK TABLES `righe_offerta` WRITE;
/*!40000 ALTER TABLE `righe_offerta` DISABLE KEYS */;
INSERT INTO `righe_offerta` VALUES (1,'N','2023-01-27 23:55:23','SYS','2023-01-29 17:02:14','SYS',1,1,NULL,NULL,1000.00,1000.00,0,NULL),(2,'N','2023-01-27 23:55:23','SYS','2023-01-29 17:02:14','SYS',1,10,NULL,NULL,3000.00,3000.00,0,NULL),(3,'N','2023-01-27 23:55:23','SYS','2023-01-29 17:02:14','SYS',1,11,NULL,NULL,4000.00,4000.00,0,NULL),(4,'N','2023-01-27 23:55:23','SYS','2023-01-30 00:45:15','SYS',2,14,NULL,NULL,1000.00,1000.00,0,NULL),(5,'N','2023-01-27 23:55:23','SYS','2023-01-30 00:45:15','SYS',2,15,NULL,NULL,1000.00,1000.00,0,NULL),(6,'N','2023-01-27 23:55:23','SYS','2023-01-30 00:45:15','SYS',2,16,NULL,NULL,1000.00,1000.00,0,NULL),(7,'N','2023-01-27 23:55:23','SYS','2023-01-30 23:26:32','SYS',3,1,NULL,NULL,1000.00,1000.00,0,NULL),(8,'N','2023-01-27 23:55:23','SYS','2023-01-30 23:26:32','SYS',3,14,NULL,NULL,1000.00,1000.00,0,NULL),(9,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',4,1,NULL,NULL,1000.00,NULL,0,NULL),(10,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',5,1,NULL,NULL,1000.00,NULL,0,NULL),(12,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',7,1,NULL,NULL,1000.00,NULL,0,NULL),(13,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',8,1,NULL,NULL,1000.00,NULL,0,NULL),(14,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',9,1,NULL,NULL,1000.00,NULL,0,NULL),(15,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',10,1,NULL,NULL,1000.00,NULL,0,NULL),(16,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',11,1,NULL,NULL,1000.00,NULL,0,NULL),(17,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',12,1,NULL,NULL,1000.00,NULL,0,NULL),(18,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',13,1,NULL,NULL,1000.00,NULL,0,NULL),(19,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',14,1,NULL,NULL,1000.00,NULL,0,NULL),(20,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',15,1,NULL,NULL,1000.00,NULL,0,NULL),(21,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',16,1,NULL,NULL,1000.00,NULL,0,NULL),(22,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',17,1,NULL,NULL,1000.00,NULL,0,NULL),(23,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',18,1,NULL,NULL,1000.00,NULL,0,NULL),(24,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',19,1,NULL,NULL,1000.00,NULL,0,NULL),(25,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',20,1,NULL,NULL,1000.00,NULL,0,NULL),(26,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',21,1,NULL,NULL,1000.00,NULL,0,NULL),(27,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',22,1,NULL,NULL,1000.00,NULL,0,NULL),(28,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',23,1,NULL,NULL,1000.00,NULL,0,NULL),(29,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',24,1,NULL,NULL,1000.00,NULL,0,NULL),(30,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',25,1,NULL,NULL,1000.00,NULL,0,NULL),(31,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',26,1,NULL,NULL,1000.00,NULL,0,NULL),(32,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',27,1,NULL,NULL,1000.00,NULL,0,NULL),(33,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',28,1,NULL,NULL,1000.00,NULL,0,NULL),(34,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',29,1,NULL,NULL,1000.00,NULL,0,NULL),(35,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',30,1,NULL,NULL,1000.00,NULL,0,NULL),(36,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',31,1,NULL,NULL,1000.00,NULL,0,NULL),(37,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',32,1,NULL,NULL,1000.00,NULL,0,NULL),(38,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',33,1,NULL,NULL,1000.00,NULL,0,NULL),(39,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',34,1,NULL,NULL,1000.00,NULL,0,NULL),(40,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',35,1,NULL,NULL,1000.00,NULL,0,NULL),(41,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',36,1,NULL,NULL,1000.00,NULL,0,NULL),(42,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',37,1,NULL,NULL,1000.00,NULL,0,NULL),(43,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',38,1,NULL,NULL,1000.00,NULL,0,NULL),(44,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',39,1,NULL,NULL,1000.00,NULL,0,NULL),(45,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',40,1,NULL,NULL,1000.00,NULL,0,NULL),(46,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',41,1,NULL,NULL,1000.00,NULL,0,NULL),(47,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',42,1,NULL,NULL,1000.00,NULL,0,NULL),(48,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',43,1,NULL,NULL,1000.00,NULL,0,NULL),(49,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',44,1,NULL,NULL,1000.00,NULL,0,NULL),(50,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',45,1,NULL,NULL,1000.00,NULL,0,NULL),(51,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',46,1,NULL,NULL,1000.00,NULL,0,NULL),(52,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',47,1,NULL,NULL,1000.00,NULL,0,NULL),(53,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',48,1,NULL,NULL,1000.00,NULL,0,NULL),(54,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',49,1,NULL,NULL,1000.00,NULL,0,NULL),(55,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',50,1,NULL,NULL,1000.00,NULL,0,NULL),(56,'N','2023-01-27 23:55:23','SYS','2023-01-28 02:43:27','SYS',51,1,NULL,NULL,1000.00,NULL,0,NULL),(57,'N','2023-01-27 23:55:23','SYS','2023-01-29 21:57:01','SYS',52,1,NULL,NULL,1000.00,1000.00,0,NULL),(58,'N','2023-01-28 02:20:45','SYS','2023-01-29 22:01:05','SYS',1,19,'sdasd ada sdas a','asd asd',40000.00,40000.00,0,NULL),(59,'N','2023-01-28 02:21:17','SYS','2023-01-30 00:51:46','SYS',2,17,'asfd asdas ',NULL,12000.00,12000.00,0,NULL),(60,'N','2023-01-28 02:21:57','SYS','2023-01-28 02:43:27','SYS',2,11,NULL,NULL,NULL,NULL,0,NULL),(61,'N','2023-01-29 15:24:37','SYS','2023-01-29 15:24:37','SYS',6,10,'prova','prova',1000.00,NULL,0,NULL),(62,'N','2023-02-02 08:24:21','SYS','2023-02-02 08:27:46','SYS',70,12,NULL,NULL,80000.00,80000.00,0,NULL),(63,'N','2023-02-02 08:28:49','SYS','2023-02-02 08:28:58','SYS',70,14,NULL,NULL,5500.00,5500.00,0,NULL);
/*!40000 ALTER TABLE `righe_offerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `righe_ordine`
--

DROP TABLE IF EXISTS `righe_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `righe_ordine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `pagamento` int(11) DEFAULT NULL,
  `data_arrivo_merce` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_righe_ordine_ordine` (`id_ordine`),
  KEY `fk_righe_ordini_servizio` (`id_servizio`),
  CONSTRAINT `fk_righe_ordine_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `righe_ordine`
--

LOCK TABLES `righe_ordine` WRITE;
/*!40000 ALTER TABLE `righe_ordine` DISABLE KEYS */;
INSERT INTO `righe_ordine` VALUES (1,'N','2022-12-30 14:30:58','SYS','2023-01-24 23:03:55','SYS',1,1,'','',0.00,0.00,0,'2023-01-25 00:00:00'),(2,'N','2022-12-30 14:30:58','SYS','2023-01-24 22:28:25','SYS',1,11,'','',0.00,0.00,0,NULL);
/*!40000 ALTER TABLE `righe_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servizi`
--

DROP TABLE IF EXISTS `servizi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servizi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `tipo` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_servizi_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizi`
--

LOCK TABLES `servizi` WRITE;
/*!40000 ALTER TABLE `servizi` DISABLE KEYS */;
INSERT INTO `servizi` VALUES (1,'N','2022-12-24 15:32:21','SYS','2023-01-27 23:49:32','SYS','ingegneria','Ingegneria','servizio'),(10,'N','2022-12-24 15:32:21','SYS','2023-01-27 23:49:47','SYS','installazioneelettrica','Installazione elettrica','servizio'),(11,'N','2022-12-24 15:32:21','SYS','2023-01-27 23:49:48','SYS','installazionemeccanica','Installazione meccanica','servizio'),(12,'N','2022-12-24 15:32:21','SYS','2023-01-27 23:49:49','SYS','lavoriedili','Lavori edili','servizio'),(13,'N','2023-01-13 00:02:17','SYS','2023-01-27 23:49:59','SYS','prova','Prova','servizio'),(14,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','cavi','Cavi','fornitura'),(15,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','pannelli','Pannelli','fornitura'),(16,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','inverter','Inverter','fornitura'),(17,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','trasformatori','Trasformatori','fornitura'),(18,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','struttura','Struttura','fornitura'),(19,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','cabinaconsegna','Cabina di consegna','fornitura'),(20,'N','2023-01-27 23:50:33','SYS','2023-01-27 23:50:33','SYS','cabinautente','Cabina utente','fornitura');
/*!40000 ALTER TABLE `servizi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servizi_contratti`
--

DROP TABLE IF EXISTS `servizi_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servizi_contratti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  KEY `IDX_servizi_contratti_servizio` (`id_servizio`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizi_contratti`
--

LOCK TABLES `servizi_contratti` WRITE;
/*!40000 ALTER TABLE `servizi_contratti` DISABLE KEYS */;
INSERT INTO `servizi_contratti` VALUES (1,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',1,1),(2,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',1,3),(3,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',1,4),(4,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',2,1),(5,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',2,2);
/*!40000 ALTER TABLE `servizi_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servizi_offeta`
--

DROP TABLE IF EXISTS `servizi_offeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servizi_offeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `id_contratto` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_servizi_contratti_contratto` (`id_contratto`),
  KEY `IDX_servizi_contratti_servizio` (`id_servizio`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizi_offeta`
--

LOCK TABLES `servizi_offeta` WRITE;
/*!40000 ALTER TABLE `servizi_offeta` DISABLE KEYS */;
INSERT INTO `servizi_offeta` VALUES (6,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',3,10),(7,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',3,12),(8,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',4,11),(9,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',4,12),(10,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',5,1),(11,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',5,12),(12,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',6,1),(13,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',7,1),(14,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',8,1),(15,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',9,1),(16,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS',10,1);
/*!40000 ALTER TABLE `servizi_offeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stati`
--

DROP TABLE IF EXISTS `stati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stati` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL,
  `entita` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_stati_contratto_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stati`
--

LOCK TABLES `stati` WRITE;
/*!40000 ALTER TABLE `stati` DISABLE KEYS */;
INSERT INTO `stati` VALUES (1,'N','2023-01-17 14:34:24','SYS','2023-01-17 15:24:12','SYS','offerta','offerta','Offerta'),(2,'N','2023-01-17 14:34:24','SYS','2023-01-28 02:45:53','SYS','contrattualizzato','offerta','Contrattualizzato'),(4,'N','2023-01-17 14:34:39','SYS','2023-01-17 14:34:39','SYS','accantieramento','progetto','Accantieramento'),(5,'N','2023-01-17 14:34:39','SYS','2023-01-17 14:34:39','SYS','lavorazione','progetto','Lavorazione'),(6,'N','2023-01-17 14:34:39','SYS','2023-01-17 14:34:39','SYS','conclusi','progetto','Conclusi'),(7,'N','2023-01-17 14:34:50','SYS','2023-01-17 14:34:50','SYS','da_ordinare','ordine','Da Ordinare'),(8,'N','2023-01-17 14:34:50','SYS','2023-01-17 14:34:50','SYS','ordinato','ordine','Ordinato'),(9,'N','2023-01-17 14:34:50','SYS','2023-01-17 14:34:50','SYS','saldato','ordine','Saldato'),(10,'N','2023-01-17 15:20:14','SYS','2023-01-29 22:36:34','SYS','da_fatturare','milestone','Da Fatturare'),(11,'N','2023-01-17 15:20:14','SYS','2023-01-29 22:36:38','SYS','fatturato','milestone','Fatturato'),(12,'N','2023-01-17 15:20:28','SYS','2023-01-29 22:36:42','SYS','pagato','milestone','Pagato'),(13,'N','2023-01-29 09:23:59','SYS','2023-01-29 09:23:59','SYS','creato','progetto','Creato');
/*!40000 ALTER TABLE `stati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipi_progetto`
--

DROP TABLE IF EXISTS `tipi_progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipi_progetto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_servizi_contratti_contratto` (`code`),
  KEY `IDX_servizi_contratti_servizio` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipi_progetto`
--

LOCK TABLES `tipi_progetto` WRITE;
/*!40000 ALTER TABLE `tipi_progetto` DISABLE KEYS */;
INSERT INTO `tipi_progetto` VALUES (1,'N','2023-01-29 08:25:26','SYS','2023-01-29 08:25:26','SYS','tetto','Tetto'),(2,'N','2023-01-29 08:25:26','SYS','2023-01-29 08:25:26','SYS','struttura_fissa','Struttura fissa'),(3,'N','2023-01-29 08:25:33','SYS','2023-01-29 08:25:33','SYS','traker','Traker');
/*!40000 ALTER TABLE `tipi_progetto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trec` enum('N','E') NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(255) NOT NULL DEFAULT 'SYS',
  `name` varchar(255) NOT NULL DEFAULT '',
  `surname` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_users_email` (`email`),
  KEY `IDX_users_name` (`name`),
  KEY `IDX_users_surname` (`surname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','stefano','guida','stefanoguida86@gmail.com','$2b$10$/dnjct3RSctpLz5Id7lHcuTo7IkFLcG4y4HGiZDk5ep47JTDn3TBK');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-03  0:00:00
