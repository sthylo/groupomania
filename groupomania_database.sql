-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: groupomania_database
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `postId` int unsigned NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comContent` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_postId` (`postId`),
  KEY `fk_comments_userId` (`userId`),
  CONSTRAINT `fk_comments_postId` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (47,70,71,'2020-08-27 22:07:54','Mais oui C\'est trop bien !'),(48,41,72,'2020-08-27 22:12:47','Hello <3');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `postId` int unsigned NOT NULL,
  `userId` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `fk_like_postId` (`postId`),
  CONSTRAINT `fk_like_postId` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_like_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_postId` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (27,71,41),(29,70,42),(30,70,70),(31,72,70),(32,71,70),(33,70,41),(34,72,41);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL,
  `likes` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_userId` (`userId`),
  CONSTRAINT `fk_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (70,40,'Bienvenue sur le forum de Groupomania !','Bonjour à toutes et tous :)\nJ\'espère que ce nouvel outil vous plaira et que vous profiterez du forum pour échanger entre collègues !\nJe vous souhaite une bonne journée.\nChristelle','2020-08-27 19:25:25',3),(71,41,'C\'est super !!!!','Merci beaucoup pour ce nouvel outil :))))))','2020-08-27 19:30:35',2),(72,42,'Hello World ! ','Hello Hello everybody !\nI love you all <3','2020-08-27 19:35:03',2);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `lastName` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `moderation` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (40,'Guyot','Christelle','admin@groupomania.com','$2b$10$uVMGOY3GpNeV1J8xDNeg1.OgDLnFiNfn5sGa7pVGksErl6Se/l7QO',1),(41,'Sthylo','Olivier','olivier@groupomania.com','$2b$10$0PnpnmMz0okdFd4DnJp1guQtuqcaIYkgQXPYJn93ES6QKkEofOhvu',NULL),(42,'Lanote','Joe','joe@groupomania.com','$2b$10$zUdR9jpWdGVGDJMcJzEjfeybdlctMSmFTo/F8N43fGTCKGULu5vYC',NULL),(44,'Mori','Johan','johan@groupomania.com','$2b$10$VHJuI23uw7FZPbvnKdnjn.yxl0b0.LoqTbfDN6//GXOL2tfHvIWfy',NULL),(45,'Rathel','Roch','roch@groupomania.com','$2b$10$KjKoktbk.XVJce/8lRucMuaDfbVnJ6PGDxH40BLbDU6S1jDEBQjJS',NULL),(46,'Leclerc','Sylvie','sylvie@groupomania.com','$2b$10$friJZkuHBQ0HSKgu8ij0XOa3cspDzhPgjk6qg98HdqRixrPIAMfgO',NULL),(47,'Lackech','Florian','florian@groupomania.com','$2b$10$ZBEuZTB7LRb5287l/4b8gubOpfunaQ3rw/vNsk5S5XyC7WRB6CtTm',NULL),(48,'Lecat','Waloo','waloo@groupomania.com','$2b$10$gAL.P//BI9i.mg5buZSexuXMtq8x.gTb6bjOOUvO4zE6im/oGpmdS',NULL),(49,'Heron','Valentine','valentine@groupomania.com','$2b$10$gPZyb1OMEfOOwLTx5V/wB.6/ko76QPmC2a4OH4EFXcPJu2uJZpewi',NULL),(50,'Lachance','Fabienne','fabienne@groupomania.com','$2b$10$xtFIrsGFc2uMsOMrimLDw.nOGv2vUc3WAfC9xp0n.4TNudXgLMRrO',NULL),(51,'Sellier','Henri','henri@groupomania.com','$2b$10$sIMaHID/YlHSmy6svgQwr.qB8cbOK6yJmuI5nOsw7.YM8VpwgfO/S',NULL),(52,'Meche','Brigitte','brigitte@groupomania.com','$2b$10$KKgfHebEYnowDfqtjholPOWEFE6RQ6kdZi9iFO.xhVUf0dYggKgd2',NULL),(53,'Dumont','Albert','albert@groupomania.com','$2b$10$lI.ZvWF7iH8oBAKUS9dA/OAl32s3ewQdlem8y6jAKiMMqecN56iNu',NULL),(54,'Pfifer','Michel','michel@groupomania.com','$2b$10$/fM8H5sn12uF0ExU.tuyV.nokapZ6imYCt8iHDbhaffY3eYp7.a2S',NULL),(55,'Leval','Monique','monique@groupomania.com','$2b$10$tl/vs7F3/dZ.diRPp08SoONY/gsJhhtX9v.tJbyo5d8t7FOtGWBbq',NULL),(56,'Avril','Danièle','daniele@groupomania.com','$2b$10$cs4bu6h8mAWA5ZNSvY/y8.PZ3TwJrZeflhI7cUkAbkGVOQexlJ7we',NULL),(57,'Itaque','Dominique','dominique@groupomania.com','$2b$10$sc5cek9opuiJ0ZP8IGe49ulCZTNuz2QMJ6GnNMtH/D.KXOANc3BgG',NULL),(58,'Boubou','Tiphanie','tiphanie@groupomania.com','$2b$10$JnXSsxRQJEDXeTPzCjux1eh.oVGLBqyN6UB23Ol28pGRoHAZEtHJe',NULL),(59,'Fournier','Cyril','cyril@groupomania.com','$2b$10$/gvn.w62LMI6r00vD/1i2unnwIeh1..mH9QkaBVrcUr2lVxiyF6yq',NULL),(60,'Dombal','Ariel','ariel@groupomania.com','$2b$10$AkSIjBhItDKcLtmriqRTFeoh8wWROVr95x7gYnyycJeS.6tbqIDka',NULL),(61,'Spar','Jack','jack@groupomania.com','$2b$10$qhOQhOUyx5G63/IvTqt/J.0V6665lkypXoVFhXGS9AgEZACHMYcl6',NULL),(62,'Hamilton','Elisabeth','elisabeth@groupomania.com','$2b$10$kYDfb75aQUmbjTu2WQl1oODT87ku76lQtUPY2w5YObvXqY6J2jgGO',NULL),(63,'Portmann','Nathalie','nathalie@groupomania.com','$2b$10$lzC8mYAy5P6qXINyJx0nYu1HVObH9bQfvuHV3/yfQTWHmLlCwwkN2',NULL),(64,'Auge','Gaspard','gaspard@groupomania.com','$2b$10$auZP6rEgwzDuWz5CToTO6uEm.PvYW7Q0.fN4Hlw9TwQuFE4gryY6C',NULL),(65,'Arès','Philippe','philippe@groupomania.com','$2b$10$9l0iUYSIb8Mf644q.2szSOq8aWtSsN2.stDXceOZShUZGE9nDnbsu',NULL),(66,'Prevost','Martine','martine@groupomania.com','$2b$10$mWc7vJr8b/.M6eBh4tilOu7lprvPRqwJHTiHhIBebOyLHYD0XqdZa',NULL),(67,'Bousi','Carole','carole@groupomania.com','$2b$10$p3G.FSy59sxCFwajc4C1seLTEAsN1HWdA.YzSQqBCZlipfzESsSES',NULL),(68,'Zare','Jimmy','jimmy@groupomania.com','$2b$10$pUUzWlSppWk36MiTwK1XVO.Tyy/ojgPW4KsCOQ9Q5XqoKc4oToQMq',NULL),(69,'Michelis','Alexandra','alexandra@groupomania.com','$2b$10$00JU28XbtmQh788yVoEhq.wSfp01yV5N.J9omTuAyC28lc.T2bT8u',NULL),(70,'Lary','Nicolas','nicolas@groupomania.com','$2b$10$BzmAxeFYBa4no9lzyVVrYeV1cS47bXw.Jb1XCNtcHjwl42SKfHEky',NULL),(71,'Jout','Alix','alix@groupomania.com','$2b$10$jeQ0wYQOiKRvqW4i93AHWO5tshjod9zh/48kQTDG34.bT8hO3Mfhi',NULL);
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

-- Dump completed on 2020-08-27 22:36:26
