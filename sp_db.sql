CREATE DATABASE IF NOT EXISTS sp_db;
USE sp_db;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: sp_db
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `guest_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `guest_id` (`guest_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`guest_id`) REFERENCES `guest` (`guest_id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest`
--

DROP TABLE IF EXISTS `guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest` (
  `guest_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `preferences` varchar(255) DEFAULT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`guest_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest`
--

LOCK TABLES `guest` WRITE;
/*!40000 ALTER TABLE `guest` DISABLE KEYS */;
/*!40000 ALTER TABLE `guest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `room_id` int DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `image_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,1,'https://hotelroyalsignature.com/wp-content/uploads/2023/08/deluxe-room-deluxe-queen-with-sofa-bed-1.jpg','Elegant Deluxe Room with modern interiors, ideal for couples and business travelers.'),(2,2,'https://storage.kempinski.com/cdn-cgi/image/w=1920,f=auto,g=auto,fit=scale-down/ki-cms-prod/images/1/7/0/1/81071-1-eng-GB/2967e783598f-73660765_4K.jpg','Spacious Deluxe Room with garden view, offering comfort and premium amenities.'),(3,3,'https://storage.amari.com/property/huahin/hotel-photos/stay/deluxe-ocean-facing/deluxe-ocean-facing-1.jpg','Deluxe Room with ocean-facing balcony, perfect for a relaxing stay.'),(4,4,'https://www.cleopatraluxuryhotels.com/wp-content/uploads/sites/55/2023/10/Untitled-design-4.jpg','Pool-view Deluxe Room with twin beds, designed for families and friends.'),(5,5,'https://tse2.mm.bing.net/th/id/OIP.yNTE0xkDygruQ7eXpgILLgHaE7?pid=Api&h=220&P=0','Luxury Suite with ocean view and lounge access, combining comfort and sophistication.'),(6,6,'https://img.cruisecritic.net/cms-sb/f/1005231/8640x5760/41287cae31/msc23015165.jpg?auto=format&fit=crop&crop=entropy&q=25&w=2048&ixlib=react-9.8.1','Premium Suite with private balcony and jacuzzi, offering ultimate relaxation.'),(7,7,'https://palmgardenresort.com.vn/uploads/photos/full-1703518660_2874_7ba8bf9d7a0990a310c9671ab9d4f2e0.jpg','Garden-view Suite with spacious living area, ideal for extended stays.'),(8,8,'https://tse3.mm.bing.net/th/id/OIP.sZtf-dZAGoYxa5vawf9wPQHaE7?pid=Api&h=220&P=0','Private Villa with garden view and outdoor dining, perfect for family vacations.'),(9,9,'https://paltino.com/wp-content/uploads/2025/02/bc207d4ethumbnail.jpeg','Luxury Villa with infinity pool and private chef service, offering exclusive experiences.'),(10,10,'https://tse2.mm.bing.net/th/id/OIP.H4hoDofqQN3ivR7mhp7y3gHaEK?pid=Api&h=220&P=0','Ocean-view Villa with three bedrooms and butler service, designed for elite guests.');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(10) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `availability` tinyint(1) DEFAULT '1',
  `amenities` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_number` (`room_number`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'R401','Deluxe Room',6000.00,1,'King Bed, Wi-Fi, Smart TV, Mini Bar','Elegant Deluxe Room with modern interiors, ideal for couples and business travelers.'),(2,'R402','Deluxe Room',6200.00,1,'King Bed, Wi-Fi, Smart TV, Mini Bar','Spacious Deluxe Room with garden view, offering comfort and premium amenities.'),(3,'R403','Deluxe Room',6500.00,1,'King Bed, Wi-Fi, Smart TV, Mini Bar','Deluxe Room with ocean-facing balcony, perfect for a relaxing stay.'),(4,'R404','Deluxe Room',6400.00,1,'King Bed, Wi-Fi, Smart TV, Mini Bar','Pool-view Deluxe Room with twin beds, designed for families and friends.'),(5,'R405','Suite',9000.00,1,'King Bed, Living Area, Ocean View, Lounge Access','Luxury Suite with ocean view and lounge access, combining comfort and sophistication.'),(6,'R406','Suite',9500.00,1,'King Bed, Living Area, Ocean View, Lounge Access','Premium Suite with private balcony and jacuzzi, offering ultimate relaxation.'),(7,'R407','Suite',9200.00,1,'King Bed, Living Area, Ocean View, Lounge Access','Garden-view Suite with spacious living area, ideal for extended stays.'),(8,'R408','Villa',18000.00,1,'2 Bedrooms, Private Pool, Garden View, Outdoor Dining','Private Villa with garden view and outdoor dining, perfect for family vacations.'),(9,'R409','Villa',20000.00,1,'2 Bedrooms, Private Pool, Garden View, Outdoor Dining','Luxury Villa with infinity pool and private chef service, offering exclusive experiences.'),(10,'R410','Villa',25000.00,1,'2 Bedrooms, Private Pool, Garden View, Outdoor Dining','Ocean-view Villa with three bedrooms and butler service, designed for elite guests.');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `url` (
  `ROOM_NO` varchar(30) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` VALUES ('R401','https://hotelroyalsignature.com/wp-content/uploads/2023/08/deluxe-room-deluxe-queen-with-sofa-bed-1.jpg'),('R402','https://storage.kempinski.com/cdn-cgi/image/w=1920,f=auto,g=auto,fit=scale-down/ki-cms-prod/images/1/7/0/1/81071-1-eng-GB/2967e783598f-73660765_4K.jpg'),('R403','https://storage.amari.com/property/huahin/hotel-photos/stay/deluxe-ocean-facing/deluxe-ocean-facing-1.jpg'),('R404','https://www.cleopatraluxuryhotels.com/wp-content/uploads/sites/55/2023/10/Untitled-design-4.jpg'),('R405','https://tse2.mm.bing.net/th/id/OIP.yNTE0xkDygruQ7eXpgILLgHaE7?pid=Api&h=220&P=0'),('R406','https://img.cruisecritic.net/cms-sb/f/1005231/8640x5760/41287cae31/msc23015165.jpg?auto=format&fit=crop&crop=entropy&q=25&w=2048&ixlib=react-9.8.1'),('R407','https://palmgardenresort.com.vn/uploads/photos/full-1703518660_2874_7ba8bf9d7a0990a310c9671ab9d4f2e0.jpg'),('R408','https://tse3.mm.bing.net/th/id/OIP.sZtf-dZAGoYxa5vawf9wPQHaE7?pid=Api&h=220&P=0'),('R409','https://paltino.com/wp-content/uploads/2025/02/bc207d4ethumbnail.jpeg'),('R410','https://tse2.mm.bing.net/th/id/OIP.H4hoDofqQN3ivR7mhp7y3gHaEK?pid=Api&h=220&P=0');
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-03 11:39:31
