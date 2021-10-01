-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lecture
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `ID` varchar(100) NOT NULL,
  `PWD` varchar(100) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `GENDER` enum('M','F') DEFAULT NULL,
  `BIRTHDAY` char(10) DEFAULT NULL,
  `PHONE` char(13) DEFAULT NULL,
  `REGDATE` timestamp NULL DEFAULT NULL,
  `EMAIL` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('hhm12345','1234','하헌민','M','1993-11-26','010-7254-7761',NULL,'hhm12345@naver.com'),('hong01','1234','홍길동','M','2021-09-03','010-1234-5678','2021-09-02 15:00:00','hong01@gmail.com'),('hye02','6789','혜지','F','19971215','010-7367-3317',NULL,'pridemon@naver.com'),('jun51','1234','원준','M','18990116','010-5117-5627',NULL,'adfljhaj@afjklasdjf.com'),('lim02','6789',NULL,NULL,NULL,NULL,NULL,NULL),('moonhy7','****','문하윤','F','1996-06-01','010-4964-3169',NULL,'moonhy7@naver.com'),('qkrwlsgud','1234','박진형','M','1994-08-14','010-2374-1566','2021-09-08 15:00:00','qkrwlsgud890@gmail.com'),('yh.thomas.lee','nflpatriot','이영호','M','1987-05-07','010-4111-7971','2021-09-08 15:00:00','yh.thomas.lee@gmail.com'),('yj971020','1234','김예진','F','19971020','010-3705-1938',NULL,'yj971020@gmail.com'),('ykjung','1111','정용관','F','19701023','010-2753-0885',NULL,'lim02@naver.com'),('군만두','1234','김시범','M','2021-09-03','010-4725-4324','2021-09-02 15:00:00','godua7@naver.com'),('금문도','123',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-09 18:26:11
