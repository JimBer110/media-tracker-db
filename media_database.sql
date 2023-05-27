-- MariaDB dump 10.19  Distrib 10.11.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: mysql_media_manager
-- ------------------------------------------------------
-- Server version	10.11.2-MariaDB

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
-- Table structure for table `Genre`
--

DROP TABLE IF EXISTS `Genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Genre` (
  `GenreID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` text DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`GenreID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Genre`
--

LOCK TABLES `Genre` WRITE;
/*!40000 ALTER TABLE `Genre` DISABLE KEYS */;
INSERT INTO `Genre` VALUES
(1,'An action story is similar to adventure, and the protagonist usually takes a risky turn, which leads to desperate situations (including explosions, fight scenes, daring escapes, etc.). Action and adventure are usually categorized together (sometimes even as \"action-adventure\") because they have much in common, and many stories fall under both genres simultaneously (for instance, the James Bond series can be classified as both).','Action'),
(2,'An adventure story is about a protagonist who journeys to epic or distant places to accomplish something. It can have many other genre elements included within it, because it is a very open genre. The protagonist has a mission and faces obstacles to get to their destination. Also, adventure stories usually include unknown settings and characters with prized properties or features.','Adventure'),
(3,'Any show that is animated, that is to say doesn\'t star real actors.','Animation'),
(4,'Comedy is a story that tells about a series of funny, or comical events, intended to make the audience laugh. It is a very open genre, and thus crosses over with many other genres on a frequent basis.','Comedy'),
(5,'Drama is the specific mode of fiction represented in performance: a play, opera, mime, ballet, etc., performed in a theatre, or on radio or television. Considered as a genre of poetry in general, the dramatic mode has been contrasted with the epic and the lyrical modes ever since Aristotle\'s Poetics—the earliest work of dramatic theory.','Drama'),
(6,'The term romance has multiple meanings, for example, historical romances like those of Walter Scott would use the term to mean \"a fictitious narrative in prose or verse, the interest of which turns upon marvellous and uncommon incidents\".','Romance');
/*!40000 ALTER TABLE `Genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Media`
--

DROP TABLE IF EXISTS `Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Media` (
  `MediaID` int(11) NOT NULL AUTO_INCREMENT,
  `Episodes` int(11) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Title` text DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  PRIMARY KEY (`MediaID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Media`
--

LOCK TABLES `Media` WRITE;
/*!40000 ALTER TABLE `Media` DISABLE KEYS */;
INSERT INTO `Media` VALUES
(1,234,'Follows the personal and professional lives of six twenty to thirty year-old friends living in the Manhattan borough of New York City.','Friends',1994),
(2,10,'After a global pandemic destroys civilization, a hardened survivor takes charge of a 14-year-old girl who may be humanity\'s last hope.','The Last of Us',2023),
(3,73,'Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for millennia.','Game of Thrones',2011),
(4,14879,'A chronicle of the lives, loves, trials and tribulations of the citizens of the fictional city of Salem.','Days of Our Lives',1965),
(5,25,'Toradora tells the tale of Ryuji (dragon) and Taiga (tiger) helping each other confess to their crushes.','Toradora!',2008);
/*!40000 ALTER TABLE `Media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MediaGenre`
--

DROP TABLE IF EXISTS `MediaGenre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MediaGenre` (
  `MediaGenreID` int(11) NOT NULL AUTO_INCREMENT,
  `MediaID` int(11) DEFAULT NULL,
  `GenreID` int(11) DEFAULT NULL,
  PRIMARY KEY (`MediaGenreID`),
  KEY `MediaID` (`MediaID`),
  KEY `GenreID` (`GenreID`),
  CONSTRAINT `MediaGenre_ibfk_1` FOREIGN KEY (`MediaID`) REFERENCES `Media` (`MediaID`),
  CONSTRAINT `MediaGenre_ibfk_2` FOREIGN KEY (`GenreID`) REFERENCES `Genre` (`GenreID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MediaGenre`
--

LOCK TABLES `MediaGenre` WRITE;
/*!40000 ALTER TABLE `MediaGenre` DISABLE KEYS */;
INSERT INTO `MediaGenre` VALUES
(1,1,4),
(2,1,6),
(3,2,1),
(4,2,2),
(5,2,5),
(6,3,1),
(7,3,2),
(8,3,5),
(9,4,5),
(10,4,6),
(11,5,3),
(12,5,4),
(13,5,5);
/*!40000 ALTER TABLE `MediaGenre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(25) DEFAULT NULL,
  `Email` text DEFAULT NULL,
  `Password` varchar(128) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `UUID_tmp` varchar(32) DEFAULT NULL,
  `UUID_expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES
(1,'Jimmy','jimmy_berglund@hotmail.com','1a8f5e69d0f6fc148d46b9d1b48bdf80396015dda3bedfa7027fb8bc3139866cbc2309e62307f8d60c6800d53f3eb9dea6bb0d628e004d35e57ce2cd2e88b22e','2023-05-04','8401676363bb455ab22932c1167715b9','2023-05-27 20:07:49'),
(2,'Jimmy2','jimmy1_berglund@hotmail.com','1f40fc92da241694750979ee6cf582f2d5d7d28e18335de05abc54d0560e0f5302860c652bf08d560252aa5e74210546f369fbbbce8c12cfc7957b2652fe9a75','2023-05-04','66aaa9d5486f44d5b84612e77b212f47','2023-05-27 20:10:12');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UsersMedia`
--

DROP TABLE IF EXISTS `UsersMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UsersMedia` (
  `UsersMediaID` int(11) NOT NULL AUTO_INCREMENT,
  `MediaID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Status` tinyint(4) DEFAULT NULL,
  `CurrentEp` int(11) DEFAULT NULL,
  `Rating` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`UsersMediaID`),
  KEY `MediaID` (`MediaID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UsersMedia_ibfk_1` FOREIGN KEY (`MediaID`) REFERENCES `Media` (`MediaID`),
  CONSTRAINT `UsersMedia_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsersMedia`
--

LOCK TABLES `UsersMedia` WRITE;
/*!40000 ALTER TABLE `UsersMedia` DISABLE KEYS */;
INSERT INTO `UsersMedia` VALUES
(1,1,1,1,5,2),
(2,1,2,0,NULL,5),
(3,2,2,0,0,NULL),
(4,4,2,0,NULL,3);
/*!40000 ALTER TABLE `UsersMedia` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`media_admin`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS trigger_status_insert
BEFORE INSERT
ON UsersMedia
FOR EACH ROW
BEGIN
DECLARE last_episode INT;
SELECT Episodes INTO last_episode FROM Media WHERE MediaID = NEW.mediaID;
IF NEW.CurrentEp = last_episode THEN
SET NEW.Status = 2;
ELSEIF NEW.CurrentEp = 0 OR NEW.CurrentEp IS NULL THEN
SET NEW.Status = 0;
ELSE
SET NEW.Status = 1;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`media_admin`@`localhost`*/ /*!50003 TRIGGER IF NOT EXISTS trigger_status
BEFORE UPDATE
ON UsersMedia
FOR EACH ROW
BEGIN
DECLARE last_episode INT;
SELECT Episodes INTO last_episode FROM Media WHERE MediaID = NEW.mediaID;
IF NEW.CurrentEp = last_episode THEN
SET NEW.Status = 2;
ELSEIF NEW.CurrentEp = 0 THEN
SET NEW.Status = 0;
ELSE
SET NEW.Status = 1;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-27 20:34:20
