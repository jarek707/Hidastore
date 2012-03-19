-- MySQL dump 10.13  Distrib 5.5.15, for osx10.6 (i386)
--
-- Host: localhost    Database: hs
-- ------------------------------------------------------
-- Server version	5.5.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `elmtypes`
--

DROP TABLE IF EXISTS `elmtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elmtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elmtypes`
--

LOCK TABLES `elmtypes` WRITE;
/*!40000 ALTER TABLE `elmtypes` DISABLE KEYS */;
INSERT INTO `elmtypes` VALUES (1,'0x0001','String','2012-03-13 07:13:58','2012-03-13 09:24:55'),(2,'0x0002','Integer','2012-03-13 07:13:26','2012-03-13 09:25:04'),(3,'0x0004','Text','2012-03-13 07:14:22','2012-03-13 07:14:22'),(4,'0x0008','Url','2012-03-13 07:14:43','2012-03-13 07:14:58'),(5,'0x0010','Select','2012-03-13 07:15:27','2012-03-13 07:15:27'),(6,'0x0020','Radio','2012-03-13 07:15:40','2012-03-13 07:15:40'),(7,'0x0040','Checkbox','2012-03-13 07:16:04','2012-03-13 07:16:04'),(8,'0x0100','Hex Integer','2012-03-13 07:24:42','2012-03-13 07:24:42');
/*!40000 ALTER TABLE `elmtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exposures`
--

DROP TABLE IF EXISTS `exposures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exposures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exposures`
--

LOCK TABLES `exposures` WRITE;
/*!40000 ALTER TABLE `exposures` DISABLE KEYS */;
INSERT INTO `exposures` VALUES (1,'All','0x00ff','2012-03-13 07:35:29','2012-03-13 07:40:55'),(2,'DB Only','0x0001','2012-03-13 07:39:15','2012-03-13 07:40:11'),(3,'GUI Only','0x0002','2012-03-13 07:39:28','2012-03-13 07:39:28'),(4,'None','0x0000','2012-03-13 07:40:47','2012-03-13 07:40:47');
/*!40000 ALTER TABLE `exposures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dom` varchar(255) DEFAULT NULL,
  `flags` varchar(32) DEFAULT NULL,
  `xml` varchar(255) DEFAULT NULL,
  `plug_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `vflag` int(11) DEFAULT NULL,
  `elmtype_id` int(11) DEFAULT NULL,
  `exposure_id` int(11) DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fields_on_plug_id` (`plug_id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (29,'label','0x0288','label',17,'2012-03-12 00:04:37','2012-03-14 04:04:30','Label',NULL,6,3,NULL),(33,'name','0x0004','name',22,'2012-03-12 01:53:46','2012-03-12 01:53:46','Name',NULL,2,1,NULL),(34,'size','0x0004','size',22,'2012-03-12 01:59:54','2012-03-12 01:59:54','Size',NULL,2,1,NULL),(35,'dom_id','0x0000','dom_id',17,'2012-03-12 03:20:00','2012-03-14 04:21:40','Dom Id',NULL,6,3,NULL),(36,'flags','0x0004','flags',17,'2012-03-12 03:20:20','2012-03-14 06:32:33','Flags',NULL,2,1,NULL),(37,'xml','0x0000','xml',17,'2012-03-12 03:20:32','2012-03-14 07:09:10','Xml',NULL,2,4,NULL),(38,'sys_num','0x0000','sys_num',22,'2012-03-12 04:29:09','2012-03-13 09:44:31','Number of Systems',NULL,1,1,NULL),(39,'name','0x0000','name',23,'2012-03-12 04:29:59','2012-03-12 04:29:59','Name',NULL,2,1,NULL),(40,'position','0x0000','position',23,'2012-03-12 04:30:19','2012-03-12 04:30:19','Position',NULL,2,1,NULL),(41,'name','0x0000','name',24,'2012-03-12 04:32:31','2012-03-13 19:48:49','Name',NULL,1,1,NULL),(42,'size','0x0000','size',24,'2012-03-12 04:32:54','2012-03-13 19:49:04','Size',NULL,1,1,NULL),(43,'number_moons','0x0000','number_moons',24,'2012-03-12 04:33:18','2012-03-13 19:48:59','Number of Moons',NULL,1,1,NULL),(44,'year_length','0x0000','year_length',24,'2012-03-12 04:33:39','2012-03-13 23:26:12','Year Length',NULL,2,4,NULL),(45,'radius_x','0x0000','orbit_x',24,'2012-03-12 04:34:23','2012-03-13 19:49:37','Radius X',NULL,2,2,NULL),(46,'radius_y','0x0000','orbit-y',24,'2012-03-12 04:34:36','2012-03-13 19:49:42','Radius Y',NULL,2,2,NULL),(47,'name','0x0000','name',25,'2012-03-12 04:36:08','2012-03-12 04:36:08','Name',NULL,2,1,NULL),(48,'distance','0x0000','distance',25,'2012-03-12 04:36:21','2012-03-12 04:36:21','Distance',NULL,2,1,NULL),(49,'radius','0x0000','radius',25,'2012-03-12 04:36:33','2012-03-19 04:28:56','Radius',NULL,0,0,NULL),(50,'rot_period','0x0002','rot_period',25,'2012-03-12 04:36:52','2012-03-12 04:42:07','Rotational Period',NULL,2,1,NULL),(51,'label','0x0000','label',18,'2012-03-12 18:16:31','2012-03-13 09:25:19','Label',NULL,1,1,NULL),(52,'dom_id','0x0000','dom_id',18,'2012-03-12 18:16:43','2012-03-13 09:25:23','Dom Id',NULL,1,1,NULL),(53,'flags','0x0044','flags',18,'2012-03-12 18:17:06','2012-03-13 07:24:54','Flags',NULL,8,1,NULL),(54,'xml','0x0000','xml',18,'2012-03-12 18:17:14','2012-03-13 18:38:56','XML',NULL,1,1,NULL),(55,'elm_type','0x0000','elm_type',18,'2012-03-13 07:07:07','2012-03-13 09:19:54','Element Type',NULL,1,1,NULL),(56,'caption',NULL,'caption',18,'2012-03-13 07:28:59','2012-03-13 09:48:38','Caption',NULL,1,1,NULL),(57,'exposure',NULL,'exposure',18,'2012-03-13 07:29:41','2012-03-13 19:11:30','Exposure',NULL,8,3,NULL),(61,'data_source',NULL,NULL,23,'2012-03-14 00:37:01','2012-03-14 00:37:01','Data Source',NULL,4,1,NULL),(184,'frequency',NULL,NULL,37,'2012-03-19 05:18:48','2012-03-19 05:18:48','Frequency',NULL,0,4,NULL);
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descr` varchar(255) DEFAULT NULL,
  `hex_val` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (3,'Admin','0x0000','2012-03-07 08:22:56','2012-03-07 08:22:56'),(4,'Manager','0x0001','2012-03-07 08:23:13','2012-03-07 08:23:13'),(5,'User','0x0002','2012-03-07 08:23:37','2012-03-07 08:23:37'),(6,'Guest','0x0004','2012-03-07 08:23:48','2012-03-07 08:23:48');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugs`
--

DROP TABLE IF EXISTS `plugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tab_name` varchar(255) DEFAULT NULL,
  `flags` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `legend` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugs`
--

LOCK TABLES `plugs` WRITE;
/*!40000 ALTER TABLE `plugs` DISABLE KEYS */;
INSERT INTO `plugs` VALUES (16,'root_no_tab','sad','2012-03-11 22:55:46','2012-03-15 04:56:02','Root',0),(17,'plugins','0x0000','2012-03-11 22:56:15','2012-03-11 22:56:15','Plugins',16),(18,'fields','0x0000','2012-03-11 22:56:31','2012-03-11 22:56:31','Fields',17),(19,'uni','0x0000','2012-03-12 01:49:01','2012-03-12 01:49:01','Universe',16),(22,'galaxy','0x0004','2012-03-12 01:51:05','2012-03-12 01:51:05','Galaxy',19),(23,'plsystem','0x0004','2012-03-12 01:51:27','2012-03-12 01:51:27','Planetary System',22),(24,'planets','0x0004','2012-03-12 01:52:10','2012-03-12 01:52:10','Planets',23),(25,'moons','0x0004','2012-03-12 01:52:49','2012-03-12 01:52:49','Moons',24),(37,'meteor','0x000','2012-03-19 05:18:07','2012-03-19 05:18:07','Meteor',0);
/*!40000 ALTER TABLE `plugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20120307070330'),('20120307070417'),('20120307072443'),('20120307073413'),('20120307073549'),('20120307073613'),('20120307073749'),('20120307081231'),('20120307081254'),('20120307194647'),('20120307195047'),('20120307195350'),('20120308064301'),('20120308064511'),('20120309033247'),('20120309033909'),('20120309185916'),('20120311214439'),('20120312182159'),('20120312182642'),('20120313071011'),('20120313071157'),('20120313073042'),('20120313073227'),('20120315002420');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first` varchar(255) DEFAULT NULL,
  `last` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Tuc','Kowski','jarek707@gmail.com','123-456-7890',3,'2012-03-07 08:24:23','2012-03-07 08:24:23'),(2,'Jo','Blo','jo@blo.com','123-456-7890',4,'2012-03-07 08:51:49','2012-03-07 08:51:49');
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

-- Dump completed on 2012-03-19  2:57:22
