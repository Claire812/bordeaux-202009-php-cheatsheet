-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `creation_at` date DEFAULT NULL,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_user1_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  KEY `fk_post_has_user_user1_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'Python','On sait pas'),(2,'HTML','On sait pas2'),(3,'CSS','On sait pas3'),(4,'JS','On sait pas1'),(5,'PHP','On sait pas4'),(6,'SQL','On sait pas5');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `content` text NOT NULL,
  `creation_at` date NOT NULL,
  `popularity` int NOT NULL,
  `language_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'Print on terminal','print()','2020-09-10',5,1,1),(2,'While loop',' i = 1\\nwhile i < 6:\\n  print(i)\\n  i += 1','2020-09-11',6,1,1),(3,'Type of variable','type()','2020-10-20',5,1,1),(4,'Write a function','def my_function():\\n  print(\\\"Hello from a function\\\")','2020-10-13',2,1,1),(5,'For loop',' fruits = [\\\"apple\\\", \\\"banana\\\", \\\"cherry\\\"]\\nfor x in fruits:\\n  print(x)','2020-08-01',15,1,1),(6,'Paragraphs',' <p>This is a paragraph.</p>\n<p>This is another paragraph.</p> ','2020-09-01',3,2,4),(7,'Comments','<!-- Write your comments here -->','2020-08-31',2,2,2),(8,'Unordered list',' <ul>\n  <li>Coffee</li>\n  <li>Tea</li>\n  <li>Milk</li>\n</ul> ','2020-09-30',15,2,3),(9,'Ordered list',' <ol>\n  <li>Coffee</li>\n  <li>Tea</li>\n  <li>Milk</li>\n</ol> ','2020-10-01',23,2,5),(10,'Border style','p.dotted {border-style: dotted;}\np.dashed {border-style: dashed;}\np.solid {border-style: solid;}\np.double {border-style: double;}\np.groove {border-style: groove;}\np.ridge {border-style: ridge;}\np.inset {border-style: inset;}\np.outset {border-style: outset;}\np.none {border-style: none;}\np.hidden {border-style: hidden;}\np.mix {border-style: dotted dashed solid double;}','2020-09-10',20,3,4),(11,'Comments','/* This is a single-line comment */','2020-08-14',3,3,2),(12,'Margins','p {\n  margin-top: 100px;\n  margin-bottom: 100px;\n  margin-right: 150px;\n  margin-left: 80px;\n}','2020-10-01',25,3,1),(13,'While loop','while (condition) {\n  // code block to be executed\n}','2020-10-21',2,4,1),(14,'For loop','var i;\nfor (i = 0; i < cars.length; i++) {\n  text += cars[i] + \"<br>\";\n} ','2020-09-21',33,4,4),(15,'Break','for (i = 0; i < 10; i++) {\n  if (i === 3) { break; }\n  text += \"The number is \" + i + \"<br>\";\n} ','2020-09-01',1,4,5),(16,'Print',' <?php\necho \"<h2>PHP is Fun!</h2>\";\necho \"Hello world!<br>\";\necho \"I\'m about to learn PHP!<br>\";\necho \"This \", \"string \", \"was \", \"made \", \"with multiple parameters.\";\n?> ','2020-10-26',33,5,2),(17,'Comment','\n<?php\n// This is a single-line comment\n\n# This is also a single-line comment\n?>','2020-10-05',2,5,3),(18,'Create table','CREATE TABLE Persons (\n    PersonID int,\n    LastName varchar(255),\n    FirstName varchar(255),\n    Address varchar(255),\n    City varchar(255)\n);','2020-08-02',45,6,5),(19,'Create database','CREATE DATABASE databasename; ','2020-09-29',10,6,3);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'kozmarti','kozmarti@gmail.com','cheatsheet',1),(2,'benjamin','kozmarti@gmail.com','cheatsheet',1),(3,'fakuser','kozmarti@gmail.com','cheatsheet',0),(4,'vlad','kozmarti@gmail.com','cheatsheet',1),(5,'claire','kozmarti@gmail.com','cheatsheet',1),(6,'guillaume','kozmarti@gmail.com','cheatsheet',1),(7,'Marcel','kozmarti@gmail.com','cheatsheet',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-26 15:48:18