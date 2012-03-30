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
-- Table structure for table `ctrls`
--

DROP TABLE IF EXISTS `ctrls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctrls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uc_tab` varchar(255) DEFAULT NULL,
  `lc_tab` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctrls`
--

LOCK TABLES `ctrls` WRITE;
/*!40000 ALTER TABLE `ctrls` DISABLE KEYS */;
/*!40000 ALTER TABLE `ctrls` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exposures`
--

LOCK TABLES `exposures` WRITE;
/*!40000 ALTER TABLE `exposures` DISABLE KEYS */;
INSERT INTO `exposures` VALUES (1,'All','0x00ff','2012-03-13 07:35:29','2012-03-13 07:40:55'),(2,'DB Only','0x0001','2012-03-13 07:39:15','2012-03-13 07:40:11'),(3,'GUI Short','0x0002','2012-03-13 07:39:28','2012-03-21 02:46:11'),(4,'GUI Long','0x0004','2012-03-21 02:46:33','2012-03-21 02:46:33'),(5,'None','0x0000','2012-03-13 07:40:47','2012-03-13 07:40:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (186,'name',NULL,NULL,39,'2012-03-19 07:10:18','2012-03-19 07:10:18','Name',NULL,3,3,NULL),(187,'name',NULL,NULL,40,'2012-03-19 07:10:30','2012-03-19 07:10:30','Name',NULL,3,3,NULL),(188,'size',NULL,NULL,40,'2012-03-19 07:11:10','2012-03-20 02:15:05','Size',NULL,2,3,NULL),(190,'positionx',NULL,NULL,40,'2012-03-19 07:12:24','2012-03-21 02:45:10','PositionX',NULL,2,1,NULL),(191,'numofplanets',NULL,NULL,40,'2012-03-19 07:15:54','2012-03-20 05:27:23','Number of Planets',NULL,5,3,NULL),(192,'name',NULL,NULL,41,'2012-03-19 07:18:23','2012-03-20 04:28:46','Name',NULL,3,1,NULL),(193,'size',NULL,NULL,41,'2012-03-19 07:18:40','2012-03-20 04:28:43','Size',NULL,3,1,NULL),(194,'sundistx',NULL,NULL,41,'2012-03-19 07:19:02','2012-03-20 04:45:18','Distance X From the Sun',NULL,3,2,NULL),(195,'sundisty',NULL,NULL,41,'2012-03-19 07:19:28','2012-03-20 17:47:09','Distance Y From the Sun',NULL,3,4,NULL),(196,'rotperiod',NULL,NULL,41,'2012-03-19 07:20:00','2012-03-20 17:47:15','Rotational Period',NULL,2,3,NULL),(197,'nbrofmoons',NULL,NULL,41,'2012-03-19 07:20:37','2012-03-20 02:59:22','Number of Moons',NULL,2,3,NULL),(198,'orbperiod',NULL,NULL,41,'2012-03-19 07:21:00','2012-03-21 02:48:14','Orbital Period',NULL,2,4,NULL),(199,'poistiony',NULL,NULL,40,'2012-03-21 02:44:52','2012-03-21 02:44:52','Position Y',NULL,2,1,NULL),(200,'',NULL,NULL,52,'2012-03-21 03:49:51','2012-03-21 03:49:51','',NULL,1,1,NULL),(201,'',NULL,NULL,52,'2012-03-21 03:49:51','2012-03-21 03:49:51','',NULL,1,1,NULL),(202,'',NULL,NULL,73,'2012-03-22 04:52:59','2012-03-22 04:52:59','',NULL,1,1,NULL),(203,'',NULL,NULL,73,'2012-03-22 04:53:05','2012-03-22 04:53:05','',NULL,1,1,NULL),(204,'',NULL,NULL,73,'2012-03-22 04:53:08','2012-03-22 04:53:08','',NULL,1,1,NULL),(205,'sd',NULL,NULL,113,'2012-03-22 21:05:55','2012-03-22 21:05:55','sd',NULL,1,3,NULL),(206,'asdf',NULL,NULL,113,'2012-03-22 21:06:14','2012-03-22 21:06:14','asdf',NULL,1,1,NULL),(207,'xcxcx',NULL,NULL,113,'2012-03-22 21:07:25','2012-03-22 21:07:25','cxc',NULL,1,4,NULL),(208,'tucfield',NULL,NULL,75,'2012-03-23 19:14:33','2012-03-23 19:14:33','Tucfield',NULL,1,1,NULL),(211,'type',NULL,NULL,39,'2012-03-26 00:55:21','2012-03-26 00:55:21','Type',NULL,1,1,NULL),(212,'positionZ',NULL,NULL,40,'2012-03-28 22:14:06','2012-03-28 22:14:06','Position Z',NULL,1,1,NULL),(213,'positionZ',NULL,NULL,40,'2012-03-28 22:14:09','2012-03-28 22:14:09','Position Z',NULL,1,1,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugs`
--

LOCK TABLES `plugs` WRITE;
/*!40000 ALTER TABLE `plugs` DISABLE KEYS */;
INSERT INTO `plugs` VALUES (38,'universe','0x000','2012-03-19 06:58:31','2012-03-19 06:58:31','Universe',0),(39,'galaxy','0','2012-03-19 07:06:42','2012-03-19 07:06:42','Galaxy',0),(40,'solarsys','0','2012-03-19 07:07:36','2012-03-26 05:29:33','Solar system',2),(41,'planet','0','2012-03-19 07:17:40','2012-03-19 07:17:40','Planet',0);
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
INSERT INTO `schema_migrations` VALUES ('20120307070330'),('20120307070417'),('20120307072443'),('20120307073413'),('20120307073549'),('20120307073613'),('20120307073749'),('20120307081231'),('20120307081254'),('20120307194647'),('20120307195047'),('20120307195350'),('20120308064301'),('20120308064511'),('20120309033247'),('20120309033909'),('20120309185916'),('20120311214439'),('20120312182159'),('20120312182642'),('20120313071011'),('20120313071157'),('20120313073042'),('20120313073227'),('20120315002420'),('20120321210841'),('20120324152324');
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

-- Dump completed on 2012-03-29  0:01:27
