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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
INSERT INTO `clienti` VALUES (1,'N','2022-12-24 15:32:21','SYS','2023-01-13 00:01:20','SYS','obton','00000000002'),(2,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','blue elephant','00000000000'),(3,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','bayware','00000000000'),(4,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','hydrowatt','00000000000'),(5,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','lt','00000000000'),(6,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','fincantieri','00000000000'),(7,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','comun energ','00000000000'),(8,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','trina','00000000000'),(9,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','rpower','00000000000'),(10,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','valmont','00000000000'),(26,'N','2023-01-24 01:25:35','SYS','2023-01-24 01:25:35','SYS','prova','1234567890');
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
  `id_progetto` int(11) NOT NULL,
  `data_accettazione` datetime DEFAULT NULL,
  `importo` decimal(11,2) NOT NULL DEFAULT 0.00,
  `kw` decimal(11,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `IDX_contratti_progetto` (`id_progetto`),
  KEY `IDX_contratti_data_accettazione` (`data_accettazione`),
  CONSTRAINT `fk_contratti_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratti`
--

LOCK TABLES `contratti` WRITE;
/*!40000 ALTER TABLE `contratti` DISABLE KEYS */;
INSERT INTO `contratti` VALUES (1,'N','2022-12-24 15:32:21','SYS','2023-01-09 23:05:24','SYS',1,'2022-06-24 00:00:00',259270.00,998.20),(2,'N','2022-12-24 15:32:21','SYS','2023-01-10 00:26:46','SYS',2,'2022-07-24 00:00:00',193905.00,997.00);
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
  `id_cliente` int(11) NOT NULL,
  `id_progetto` int(11) NOT NULL,
  `id_riferimento` int(11) NOT NULL,
  `tipo` enum('ordine','offerta','contratto','') NOT NULL DEFAULT '',
  `path` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `IDX_files_cliente` (`id_cliente`),
  KEY `IDX_files_tipo` (`tipo`),
  KEY `fk_files_progetti` (`id_progetto`),
  CONSTRAINT `fk_files_clienti` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`),
  CONSTRAINT `fk_files_progetti` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (2,'N','2023-01-04 14:51:58','SYS','2023-01-25 21:56:08','SYS',1,1,64,'offerta','storage/Preventivo Global Technology.pdf'),(37,'N','2023-01-25 17:04:58','SYS','2023-01-25 17:04:58','SYS',1,1,1,'ordine','storage/Preventivo Global Technology-20230125060458.pdf'),(39,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',1,2,1,'ordine','storage/Business_Case_Atida.txt'),(40,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',1,3,1,'ordine','storage/Business_Case_Atida.txt'),(41,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',1,4,1,'ordine','storage/Business_Case_Atida.txt'),(42,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',1,5,1,'ordine','storage/Business_Case_Atida.txt'),(43,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',1,6,1,'ordine','storage/Business_Case_Atida.txt'),(44,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',1,7,1,'ordine','storage/Business_Case_Atida.txt'),(45,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',2,8,1,'ordine','storage/Business_Case_Atida.txt'),(46,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',2,9,1,'ordine','storage/Business_Case_Atida.txt'),(47,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',2,10,1,'ordine','storage/Business_Case_Atida.txt'),(48,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',2,11,1,'ordine','storage/Business_Case_Atida.txt'),(49,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',2,12,1,'ordine','storage/Business_Case_Atida.txt'),(50,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',2,13,1,'ordine','storage/Business_Case_Atida.txt'),(51,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,14,1,'ordine','storage/Business_Case_Atida.txt'),(52,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,15,1,'ordine','storage/Business_Case_Atida.txt'),(53,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,16,1,'ordine','storage/Business_Case_Atida.txt'),(54,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,17,1,'ordine','storage/Business_Case_Atida.txt'),(55,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,18,1,'ordine','storage/Business_Case_Atida.txt'),(56,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,19,1,'ordine','storage/Business_Case_Atida.txt'),(57,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',3,20,1,'ordine','storage/Business_Case_Atida.txt'),(58,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,21,1,'ordine','storage/Business_Case_Atida.txt'),(59,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,22,1,'ordine','storage/Business_Case_Atida.txt'),(60,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,23,1,'ordine','storage/Business_Case_Atida.txt'),(61,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,24,1,'ordine','storage/Business_Case_Atida.txt'),(62,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,25,1,'ordine','storage/Business_Case_Atida.txt'),(63,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,26,1,'ordine','storage/Business_Case_Atida.txt'),(64,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,27,1,'ordine','storage/Business_Case_Atida.txt'),(65,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,28,1,'ordine','storage/Business_Case_Atida.txt'),(66,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,29,1,'ordine','storage/Business_Case_Atida.txt'),(67,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',4,30,1,'ordine','storage/Business_Case_Atida.txt'),(68,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',5,31,1,'ordine','storage/Business_Case_Atida.txt'),(69,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',5,32,1,'ordine','storage/Business_Case_Atida.txt'),(70,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',6,33,1,'ordine','storage/Business_Case_Atida.txt'),(71,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',6,34,1,'ordine','storage/Business_Case_Atida.txt'),(72,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,35,1,'ordine','storage/Business_Case_Atida.txt'),(73,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,36,1,'ordine','storage/Business_Case_Atida.txt'),(74,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,37,1,'ordine','storage/Business_Case_Atida.txt'),(75,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,38,1,'ordine','storage/Business_Case_Atida.txt'),(76,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,39,1,'ordine','storage/Business_Case_Atida.txt'),(77,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,40,1,'ordine','storage/Business_Case_Atida.txt'),(78,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,41,1,'ordine','storage/Business_Case_Atida.txt'),(79,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,42,1,'ordine','storage/Business_Case_Atida.txt'),(80,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,43,1,'ordine','storage/Business_Case_Atida.txt'),(81,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,44,1,'ordine','storage/Business_Case_Atida.txt'),(82,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,45,1,'ordine','storage/Business_Case_Atida.txt'),(83,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,46,1,'ordine','storage/Business_Case_Atida.txt'),(84,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,47,1,'ordine','storage/Business_Case_Atida.txt'),(85,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,48,1,'ordine','storage/Business_Case_Atida.txt'),(86,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,49,1,'ordine','storage/Business_Case_Atida.txt'),(87,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,50,1,'ordine','storage/Business_Case_Atida.txt'),(88,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,51,1,'ordine','storage/Business_Case_Atida.txt'),(89,'N','2023-01-25 22:02:13','SYS','2023-01-25 22:02:13','SYS',7,52,1,'ordine','storage/Business_Case_Atida.txt'),(102,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',1,2,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(103,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',1,3,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(104,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',1,4,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(105,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',1,5,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(106,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',1,6,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(107,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',1,7,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(108,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',2,8,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(109,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',2,9,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(110,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',2,10,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(111,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',2,11,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(112,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',2,12,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(113,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',2,13,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(114,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,14,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(115,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,15,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(116,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,16,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(117,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,17,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(118,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,18,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(119,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,19,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(120,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',3,20,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(121,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,21,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(122,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,22,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(123,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,23,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(124,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,24,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(125,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,25,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(126,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,26,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(127,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,27,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(128,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,28,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(129,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,29,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(130,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',4,30,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(131,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',5,31,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(132,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',5,32,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(133,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',6,33,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(134,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',6,34,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(135,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,35,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(136,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,36,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(137,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,37,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(138,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,38,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(139,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,39,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(140,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,40,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(141,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,41,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(142,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,42,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(143,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,43,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(144,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,44,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(145,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,45,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(146,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,46,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(147,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,47,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(148,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,48,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(149,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,49,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(150,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,50,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(151,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,51,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf'),(152,'N','2023-01-25 22:02:48','SYS','2023-01-25 22:02:48','SYS',7,52,1,'ordine','storage/Descizione problema AMAN-230103-20230125110248.pdf');
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
  `id_progetto` int(11) NOT NULL,
  `data_offerta` datetime DEFAULT current_timestamp(),
  `importo` decimal(11,2) DEFAULT NULL,
  `kw` decimal(11,2) DEFAULT 0.00,
  `id_stato` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_contratti_stato` (`id_stato`),
  KEY `IDX_contratti_progetto` (`id_progetto`),
  KEY `IDX_contratti_data_offerta` (`data_offerta`),
  CONSTRAINT `fk_offerte_progetto` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`),
  CONSTRAINT `fk_offerte_stato` FOREIGN KEY (`id_stato`) REFERENCES `stati` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offerte`
--

LOCK TABLES `offerte` WRITE;
/*!40000 ALTER TABLE `offerte` DISABLE KEYS */;
INSERT INTO `offerte` VALUES (1,'N','2023-01-17 15:08:32','SYS','2023-01-23 21:14:17','SYS',3,'2022-06-24 00:00:00',212798.00,998.76,1),(2,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',4,'2022-06-24 15:32:21',334357.00,998.76,1),(3,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',5,'2022-06-24 15:32:21',210443.00,998.00,1),(4,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',6,'2022-06-24 15:32:21',198859.00,998.00,1),(5,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',7,'2022-06-24 15:32:21',200247.00,998.00,1),(6,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',8,'2022-07-24 15:32:21',202437.00,510.30,1),(7,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',9,'2022-07-24 15:32:21',225100.00,702.00,1),(8,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',10,'2022-07-24 15:32:21',202437.00,510.30,1),(9,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',11,'2022-07-24 15:32:21',223559.00,687.96,1),(10,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',12,'2022-07-24 15:32:21',201954.00,510.30,1),(11,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',13,'2022-07-24 15:32:21',360630.00,996.84,1),(12,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',14,'2022-06-24 15:32:21',42000.00,388.00,1),(13,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',15,'2022-06-24 15:32:21',101148.70,642.00,1),(14,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',16,'2022-06-24 15:32:21',76245.80,522.00,1),(15,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',17,'2022-06-24 15:32:21',100313.42,716.00,1),(16,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',18,'2022-06-24 15:32:21',139097.50,1050.20,1),(17,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',19,'2022-06-24 15:32:21',320833.00,1996.90,1),(18,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',20,'2022-06-24 15:32:21',561892.00,3709.00,1),(19,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',21,'2022-01-24 15:32:21',481000.00,811.89,1),(20,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',22,'2022-01-24 15:32:21',410212.60,999.39,1),(21,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',23,'2022-01-24 15:32:21',369787.40,995.33,1),(22,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',24,'2022-01-24 15:32:21',472453.82,999.19,1),(23,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',25,'2022-01-24 15:32:21',481300.36,991.11,1),(24,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',26,'2022-01-24 15:32:21',333280.32,811.25,1),(25,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',27,'2022-01-24 15:32:21',368082.15,998.96,1),(26,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',28,'2022-01-24 15:32:21',346173.96,996.38,1),(27,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',29,'2022-01-24 15:32:21',495161.23,991.32,1),(28,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',30,'2022-01-24 15:32:21',483588.64,996.15,1),(29,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',31,'2022-10-24 15:32:21',1225000.00,12406.24,1),(30,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',32,'2022-10-24 15:32:21',170000.00,963.00,1),(31,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',33,'2022-10-24 15:32:21',1401172.00,4970.00,1),(32,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',34,'2022-10-24 15:32:21',295268.00,523.00,1),(33,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',35,'2022-10-24 15:32:21',1310000.00,8034.39,1),(34,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',36,'2022-10-24 15:32:21',190000.00,997.92,1),(35,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',37,'2022-10-24 15:32:21',190000.00,950.00,1),(36,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',38,'2022-10-24 15:32:21',1250000.00,7630.00,1),(37,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',39,'2022-11-24 15:32:21',1794000.00,3250.00,1),(38,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',40,'2022-11-24 15:32:21',2115816.00,3833.00,1),(39,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',41,'2022-11-24 15:32:21',4037040.00,7560.00,1),(40,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',42,'2022-11-24 15:32:21',1583136.00,2868.00,1),(41,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',43,'2022-11-24 15:32:21',2393664.00,4368.00,1),(42,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',44,'2022-11-24 15:32:21',1344470.40,2462.40,1),(43,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',45,'2022-11-24 15:32:21',552944.70,999.90,1),(44,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',46,'2022-11-24 15:32:21',572451.84,993.84,1),(45,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',47,'2022-11-24 15:32:21',3731023.20,7258.80,1),(46,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',48,'2022-11-24 15:32:21',558489.60,969.60,1),(47,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',49,'2022-11-24 15:32:21',3065421.60,5906.40,1),(48,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',50,'2022-11-24 15:32:21',1556100.00,2850.00,1),(49,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',51,'2022-11-24 15:32:21',2127544.80,4060.20,1),(50,'N','2023-01-17 15:08:32','SYS','2023-01-17 15:08:32','SYS',52,'2022-11-24 15:32:21',518057.28,945.36,1),(64,'N','2023-01-17 15:28:15','SYS','2023-01-17 15:28:15','SYS',1,'2022-05-24 00:00:00',259270.00,998.20,2),(65,'N','2023-01-17 15:28:15','SYS','2023-01-17 15:28:15','SYS',2,'2022-06-24 00:00:00',193905.00,997.00,2);
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
INSERT INTO `ordini` VALUES (1,'N','2022-12-30 14:09:19','SYS','2023-01-23 21:42:13','SYS',1,8,1000);
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
  `id_cliente` int(11) NOT NULL,
  `data_inizio` datetime DEFAULT NULL,
  `data_fine` datetime DEFAULT NULL,
  `impianto` varchar(255) DEFAULT '',
  `luogo` varchar(255) NOT NULL DEFAULT '',
  `id_stato` varchar(255) NOT NULL,
  `completamento` int(3) DEFAULT 0,
  `commenti` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_progetti_cliente` (`id_cliente`),
  KEY `fk_progetti_stato` (`id_stato`),
  KEY `IDX_progetti_data_inizio` (`data_inizio`),
  KEY `IDX_progetti_data_fine` (`data_fine`),
  KEY `IDX_progetti_luogo` (`luogo`),
  CONSTRAINT `fk_progetti_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progetti`
--

LOCK TABLES `progetti` WRITE;
/*!40000 ALTER TABLE `progetti` DISABLE KEYS */;
INSERT INTO `progetti` VALUES (1,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:23:13','SYS',1,'2022-06-24 00:00:00','2023-06-24 00:00:00','andria','Andria','5',85,''),(2,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',1,'2022-07-24 00:00:00','2023-07-24 00:00:00','capitolicchio','Taranto','5',65,NULL),(3,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','sbm','Turi','5',25,NULL),(4,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','trinitapoli','Trinitapoli','5',25,NULL),(5,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','turi4','Turi','5',25,NULL),(6,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','turi6','Turi','5',25,NULL),(7,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',1,'2022-07-24 15:32:21','2023-07-24 15:32:21','turi7','Turi','5',25,NULL),(8,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','baligio','Fossano (CN)','5',20,NULL),(9,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','bosconero','Bosconero (TO)','5',20,NULL),(10,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','castiglione','Savigliano (CN)','5',20,NULL),(11,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','cascina valentino','Saluzzo (CN)','5',20,NULL),(12,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','santa lucia','Fossano (CN)','5',20,NULL),(13,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',2,'2022-08-24 15:32:21','2023-08-24 15:32:21','bigreco','Busca (CN)','5',20,NULL),(14,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1210 - ESAP','','5',50,NULL),(15,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1626 - COPA','','5',50,NULL),(16,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1627 - COVO','','5',50,NULL),(17,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1628 - COPR','','5',50,NULL),(18,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1629 - COCA','','5',50,NULL),(19,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1658 - LODO','','5',50,NULL),(20,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:05','SYS',3,'2022-07-24 15:32:21','2023-05-24 15:32:21','1772 - CAFE','','5',50,NULL),(21,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Cassino 1 ','Marche','6',100,NULL),(22,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Castiglione in Teverina','Lazio','6',100,NULL),(23,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Grottazzolina','Abruzzo','6',100,NULL),(24,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','CappelleSulTavo','Lazio','6',100,NULL),(25,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Isernia','Abruzzo','6',100,NULL),(26,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Corvara','Abruzzo','6',100,NULL),(27,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Filetto','Abruzzo','6',100,NULL),(28,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Civitaquana','Lazio','6',100,NULL),(29,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Cassino 2','Abruzzo','6',100,NULL),(30,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:17:03','SYS',4,'2022-02-24 15:32:21','2022-11-24 15:32:21','Mondavio','Marche','6',100,NULL),(31,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',5,'2022-11-24 15:32:21','2023-08-24 15:32:21','deliceto','deliceto','4',0,NULL),(32,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',5,'2022-11-24 15:32:21','2023-08-24 15:32:21','iren','deliceto','4',0,NULL),(33,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',6,'2022-11-24 15:32:21','2023-08-24 15:32:21','monfalcone','monfalcone','4',0,NULL),(34,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',6,'2022-11-24 15:32:21','2023-08-24 15:32:21','sestri ponente','sestri ponente','4',0,NULL),(35,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Nardò','Nardò','4',0,NULL),(36,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','San Martino in Pensilis','San Martino in Pensilis','4',0,NULL),(37,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Celleno','Celleno','4',0,NULL),(38,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Lequile','Lequile','4',0,NULL),(39,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Quattordio','Alessandria Piemonte','4',0,NULL),(40,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Pachino','Siracusa','4',0,NULL),(41,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Brindisi San Giorgio','Brindisi','4',0,NULL),(42,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Viterbo','Viterbo','4',0,NULL),(43,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Orani','Viterbo','4',0,NULL),(44,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Marino','','4',0,NULL),(45,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Flycom','','4',0,NULL),(46,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Bettona','','4',0,NULL),(47,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Brizzarelli','','4',0,NULL),(48,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Castiglione','','4',0,NULL),(49,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Euroservice','','4',0,NULL),(50,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Spoleto','','4',0,NULL),(51,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Vasca','','4',0,NULL),(52,'N','2022-12-24 15:32:21','SYS','2023-01-17 15:16:38','SYS',7,'2022-11-24 15:32:21','2023-08-24 15:32:21','Villanova','','4',0,NULL);
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
  `descrizione` text NOT NULL,
  `brand` varchar(255) NOT NULL,
  `costo` decimal(11,2) NOT NULL,
  `costo_spedizione` decimal(11,2) NOT NULL,
  `pagamento` int(11) DEFAULT NULL,
  `data_arrivo_merce` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_righe_ordine_ordine` (`id_offerta`),
  KEY `fk_righe_ordini_servizio` (`id_servizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `righe_offerta`
--

LOCK TABLES `righe_offerta` WRITE;
/*!40000 ALTER TABLE `righe_offerta` DISABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UIDX_servizi_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizi`
--

LOCK TABLES `servizi` WRITE;
/*!40000 ALTER TABLE `servizi` DISABLE KEYS */;
INSERT INTO `servizi` VALUES (1,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','ingegneria','Ingegneria'),(2,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','forniture','Forniture'),(10,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','installazioneelettrica','Installazione elettrica'),(11,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','installazionemeccanica','Installazione meccanica'),(12,'N','2022-12-24 15:32:21','SYS','2022-12-24 15:32:21','SYS','lavoriedili','Lavori edili'),(13,'N','2023-01-13 00:02:17','SYS','2023-01-13 00:02:17','SYS','prova','Prova');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stati`
--

LOCK TABLES `stati` WRITE;
/*!40000 ALTER TABLE `stati` DISABLE KEYS */;
INSERT INTO `stati` VALUES (1,'N','2023-01-17 14:34:24','SYS','2023-01-17 15:24:12','SYS','offerta','offerta','Offerta'),(2,'N','2023-01-17 14:34:24','SYS','2023-01-17 15:24:15','SYS','contrattualizzati','offerta','Contrattualizzati'),(4,'N','2023-01-17 14:34:39','SYS','2023-01-17 14:34:39','SYS','accantieramento','progetto','Accantieramento'),(5,'N','2023-01-17 14:34:39','SYS','2023-01-17 14:34:39','SYS','lavorazione','progetto','Lavorazione'),(6,'N','2023-01-17 14:34:39','SYS','2023-01-17 14:34:39','SYS','conclusi','progetto','Conclusi'),(7,'N','2023-01-17 14:34:50','SYS','2023-01-17 14:34:50','SYS','da_ordinare','ordine','Da Ordinare'),(8,'N','2023-01-17 14:34:50','SYS','2023-01-17 14:34:50','SYS','ordinato','ordine','Ordinato'),(9,'N','2023-01-17 14:34:50','SYS','2023-01-17 14:34:50','SYS','saldato','ordine','Saldato'),(10,'N','2023-01-17 15:20:14','SYS','2023-01-17 15:20:14','SYS','da_fatturare','pagamenti','Da Fatturare'),(11,'N','2023-01-17 15:20:14','SYS','2023-01-17 15:20:14','SYS','fatturato','pagamenti','Fatturato'),(12,'N','2023-01-17 15:20:28','SYS','2023-01-17 15:20:28','SYS','pagato','pagamenti','Pagato');
/*!40000 ALTER TABLE `stati` ENABLE KEYS */;
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

-- Dump completed on 2023-01-26  1:50:23
