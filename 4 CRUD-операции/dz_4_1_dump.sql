-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: vk
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL COMMENT 'название сообщества',
  `admin_user_id` bigint unsigned NOT NULL COMMENT 'админ сообщества',
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_index` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'lorem ipsum dolor sit',6),(2,'sit amet aliquam id',2),(3,'blandit turpis cursus in',1),(4,'rutrum quisque non tellus',4),(5,'faucibus nisl tincidunt eget',5),(6,'a cras semper auctor',2),(7,'aliquet nec ullamcorper sit',12),(8,'a diam maecenas sed',13),(9,'proin nibh nisl condimentum',3),(10,'urna neque viverra justo',5);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint unsigned NOT NULL COMMENT 'кто отправил заявку',
  `target_user_id` bigint unsigned NOT NULL COMMENT 'кому отправили заявку',
  `status` enum('requested','approved','declined','unfriended') DEFAULT 'requested' COMMENT 'статус заявки',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания заявки (когда)',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления заявки',
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_chk_1` CHECK ((`initiator_user_id` <> `target_user_id`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица заявок в друзья';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,2,'approved','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,3,'approved','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,4,'approved','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,5,'declined','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,6,'declined','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,7,'declined','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,8,'unfriended','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,9,'unfriended','2022-02-26 23:40:31','2022-02-26 23:40:31'),(1,10,'unfriended','2022-02-26 23:40:31','2022-02-26 23:40:31');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifts`
--

DROP TABLE IF EXISTS `gifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gifts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gifts_type_id` bigint unsigned NOT NULL COMMENT 'категория',
  `from_user_id` bigint unsigned NOT NULL COMMENT 'отправитель',
  `to_user_id` bigint unsigned NOT NULL COMMENT 'получатель',
  `body` varchar(200) DEFAULT '' COMMENT 'текст сообщения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата отправки подарка',
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  KEY `gifts_type_id` (`gifts_type_id`),
  CONSTRAINT `gifts_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `gifts_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `gifts_ibfk_3` FOREIGN KEY (`gifts_type_id`) REFERENCES `gifts_types` (`id`),
  CONSTRAINT `gifts_chk_1` CHECK ((`from_user_id` <> `to_user_id`))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts`
--

LOCK TABLES `gifts` WRITE;
/*!40000 ALTER TABLE `gifts` DISABLE KEYS */;
INSERT INTO `gifts` VALUES (1,4,1,2,'leo integer malesuada nunc','2022-02-26 23:56:07'),(2,2,2,1,'aliquet eget sit amet','2022-02-26 23:56:07'),(3,1,15,1,'velit scelerisque in dictum non consectetur','2022-02-26 23:56:07'),(4,2,14,5,'erat velit','2022-02-26 23:56:07'),(5,3,9,7,'tristique risus nec feugiat','2022-02-26 23:56:07'),(6,1,7,8,'ipsum dolor sit amet','2022-02-26 23:56:07'),(7,1,1,2,'nam','2022-02-26 23:56:07'),(8,4,12,3,'nascetur ridiculus mus mauris','2022-02-26 23:56:07'),(9,1,5,2,'vulputate mi','2022-02-26 23:56:07'),(10,1,8,10,'feugiat nibh sed pulvinar proin gravida','2022-02-26 23:56:07'),(11,1,3,4,'placerat','2022-02-26 23:56:07');
/*!40000 ALTER TABLE `gifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifts_types`
--

DROP TABLE IF EXISTS `gifts_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gifts_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gift_category` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для сегментирования подарков на категории';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts_types`
--

LOCK TABLES `gifts_types` WRITE;
/*!40000 ALTER TABLE `gifts_types` DISABLE KEYS */;
INSERT INTO `gifts_types` VALUES (1,'economy'),(2,'average'),(3,'expensive'),(4,'vip');
/*!40000 ALTER TABLE `gifts_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'от кого',
  `media_id` bigint unsigned NOT NULL COMMENT 'на какую запись',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания лайка',
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица лайков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,3,9,'2022-02-26 23:40:31'),(2,5,4,'2022-02-26 23:40:31'),(3,3,2,'2022-02-26 23:40:31'),(4,14,10,'2022-02-26 23:40:31'),(5,9,1,'2022-02-26 23:40:31');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `media_type_id` bigint unsigned NOT NULL,
  `body` varchar(255) DEFAULT NULL COMMENT 'текст поста',
  `filename` varchar(255) DEFAULT NULL COMMENT 'название файла',
  `metadata` json DEFAULT NULL COMMENT 'для хранения всякой доп.информации',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания записи',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления записи',
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,3,2,'eget velit aliquet sagittis id consectetur','congue',NULL,'2022-02-26 23:40:31',NULL),(2,5,1,'purus sit amet luctus venenatis lectus magna','fringilla ut',NULL,'2022-02-26 23:40:31',NULL),(3,1,4,'nulla facilisi cras fermentum odio eu feugiat','velit',NULL,'2022-02-26 23:40:31',NULL),(4,8,1,'turpis nunc eget lorem dolor sed viverra','fermentum',NULL,'2022-02-26 23:40:31',NULL),(5,4,4,'fermentum leo vel orci porta non pulvinar','diam donec',NULL,'2022-02-26 23:40:31',NULL),(6,8,4,'faucibus vitae aliquet nec ullamcorper sit amet','arcu',NULL,'2022-02-26 23:40:31',NULL),(7,15,3,'aliquam eleifend mi in nulla posuere sollicitudin','viverra',NULL,'2022-02-26 23:40:31',NULL),(8,11,1,'ipsum a arcu cursus vitae congue mauris','ultrices',NULL,'2022-02-26 23:40:31',NULL),(9,9,4,'sollicitudin aliquam ultrices sagittis orci a scelerisque','leo integer malesuada',NULL,'2022-02-26 23:40:31',NULL),(10,2,2,'sem nulla pharetra diam sit amet nisl','eget',NULL,'2022-02-26 23:40:31',NULL),(11,2,1,'ut tristique et egestas quis ipsum suspendisse','pharetra',NULL,'2022-02-26 23:40:31',NULL),(12,6,3,'risus nullam eget felis eget nunc lobortis','bibendum',NULL,'2022-02-26 23:40:31',NULL),(13,13,4,'integer malesuada nunc vel risus commodo viverra','sem nulla',NULL,'2022-02-26 23:40:31',NULL),(14,11,4,'in egestas erat imperdiet sed euismod nisi','ultrices',NULL,'2022-02-26 23:40:31',NULL),(15,1,1,'magna fringilla urna porttitor rhoncus dolor purus','enim',NULL,'2022-02-26 23:40:31',NULL),(16,7,1,'eros in cursus turpis massa tincidunt dui','pulvinar',NULL,'2022-02-26 23:40:31',NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания записи',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления записи',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'text','2022-02-26 23:40:31',NULL),(2,'video','2022-02-26 23:40:31',NULL),(3,'music','2022-02-26 23:40:31',NULL),(4,'image','2022-02-26 23:40:31',NULL);
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint unsigned NOT NULL COMMENT 'отправитель',
  `to_user_id` bigint unsigned NOT NULL COMMENT 'получатель',
  `body` text COMMENT 'текст сообщения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания сообщения',
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица сообщений';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,2,'lobortis mattis aliquam faucibus purus in massa tempor nec feugiat nisl pretium fusce id velit','2022-02-26 23:40:31'),(2,1,3,'nullam ac tortor vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra tellus in','2022-02-26 23:40:31'),(3,3,2,'placerat duis ultricies lacus sed turpis tincidunt id aliquet risus feugiat in ante metus dictum','2022-02-26 23:40:31'),(4,2,3,'pulvinar sapien et ligula ullamcorper malesuada proin libero nunc consequat interdum varius sit amet mattis','2022-02-26 23:40:31'),(5,6,10,'convallis aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius','2022-02-26 23:40:31'),(6,11,12,'suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra','2022-02-26 23:40:31'),(7,14,1,'tellus in hac habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt','2022-02-26 23:40:31'),(8,15,8,'magna fermentum iaculis eu non diam phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet','2022-02-26 23:40:31'),(9,1,12,'elit dignissim sodales ut eu sem integer vitae justo eget magna fermentum iaculis eu non','2022-02-26 23:40:31'),(10,3,5,'sapien pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas sed','2022-02-26 23:40:31'),(11,2,1,'etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus in ornare quam viverra orci','2022-02-26 23:40:31');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo_albums` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'donec et odio pellentesque',2),(2,'condimentum id venenatis a',1),(3,'scelerisque mauris pellentesque pulvinar',15),(4,'faucibus turpis in eu',2),(5,'in pellentesque massa placerat',4),(6,'mattis enim ut tellus',6),(7,'eget mi proin sed',10),(8,'non consectetur a erat',13),(9,'sed turpis tincidunt id',1),(10,'natoque penatibus et magnis',9),(11,'quis imperdiet massa tincidunt',7),(12,'vulputate sapien nec sagittis',14),(13,'aliquet lectus proin nibh',8),(14,'aliquam ultrices sagittis orci',5),(15,'porta lorem mollis aliquam',11);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_id` bigint unsigned NOT NULL,
  `album_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `media_id` (`media_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,3,1),(2,5,5),(3,6,7),(4,9,9),(5,13,11),(6,14,14);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `user_id` bigint unsigned NOT NULL,
  `gender` char(1) DEFAULT NULL COMMENT 'пол',
  `birthday` date DEFAULT NULL,
  `photo_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания записи',
  `hometown` varchar(100) DEFAULT NULL COMMENT 'город',
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица профилей, связана с таблицей пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'m','2007-03-25',1,'2022-02-26 23:40:31','Idellaland'),(2,'m','2012-11-18',2,'2022-02-26 23:40:31','East Emilefort'),(3,'w','2017-01-30',3,'2022-02-26 23:40:31','Gutkowskiview'),(4,'w','2008-08-25',4,'2022-02-26 23:40:31','Estellton'),(5,'w','1989-04-26',5,'2022-02-26 23:40:31','Cadeville'),(6,'w','1984-08-12',6,'2022-02-26 23:40:31','Davisport'),(7,'m','1973-10-16',7,'2022-02-26 23:40:31','Considineport'),(8,'m','2011-12-03',8,'2022-02-26 23:40:31','Port Elishaview'),(9,'m','2000-06-05',9,'2022-02-26 23:40:31','Port Hailey'),(10,'w','1988-01-21',10,'2022-02-26 23:40:31','Leschville'),(11,'m','1981-05-20',11,'2022-02-26 23:40:31','South Colleen'),(12,'m','1979-03-30',12,'2022-02-26 23:40:31','Caylafort'),(13,'w','1975-08-20',13,'2022-02-26 23:40:31','Monicaburgh'),(14,'m','1998-06-22',14,'2022-02-26 23:40:31','Port Jessycahaven'),(15,'m','1999-08-07',15,'2022-02-26 23:40:31','North Eleonore');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL COMMENT 'Имя',
  `lastname` varchar(100) DEFAULT NULL COMMENT 'Фамилия',
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(256) DEFAULT NULL,
  `phone` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='юзеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Xzavier','Parker','miller.samantha@example.net',NULL,88393234398),(2,'Everett','Ullrich','anais.rosenbaum@example.org',NULL,88475506329),(3,'Vena','Zieme','chance.jacobs@example.com',NULL,88718300049),(4,'Iva','Bahringer','veichmann@example.net',NULL,88721753505),(5,'Rosemary','Wilderman','curt.walsh@example.net',NULL,88568094428),(6,'Margaret','Adams','donnie04@example.com',NULL,88184155888),(7,'Diamond','Kiehn','faye.leuschke@example.com',NULL,88987559120),(8,'Reece','Doyle','aubree.schmidt@example.org',NULL,88111663623),(9,'Rigoberto','Herzog','darion15@example.org',NULL,88860018181),(10,'Rosetta','Simonis','lockman.jammie@example.org',NULL,88481096292),(11,'Norval','Dickinson','pouros.lenore@example.org',NULL,88287616787),(12,'Rodger','Botsford','karolann.torp@example.net',NULL,88833146069),(13,'Helena','Kutch','orlo62@example.org',NULL,88175181419),(14,'Cristopher','O\'Kon','jermey.emmerich@example.net',NULL,88814853822),(15,'Verdie','Schimmel','mann.aliza@example.com',NULL,88929546650);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_communities` (
  `user_id` bigint unsigned NOT NULL,
  `community_id` bigint unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (6,1),(2,2),(1,3),(4,4),(5,5),(2,6),(12,7),(13,8),(3,9),(5,10);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_sympathy`
--

DROP TABLE IF EXISTS `users_sympathy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_sympathy` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_which_user_id` bigint unsigned NOT NULL COMMENT 'от какого пользователя',
  `for_which_user` bigint unsigned NOT NULL COMMENT 'какому пользователю',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания оценки',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата изменения оценки',
  `sympathy` enum('exellent','very_good','good','satisfactory','fail') DEFAULT NULL COMMENT 'вид оценки',
  `body` varchar(255) DEFAULT NULL COMMENT 'текст поста',
  PRIMARY KEY (`from_which_user_id`,`for_which_user`),
  UNIQUE KEY `id` (`id`),
  KEY `for_which_user` (`for_which_user`),
  CONSTRAINT `users_sympathy_ibfk_1` FOREIGN KEY (`from_which_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_sympathy_ibfk_2` FOREIGN KEY (`for_which_user`) REFERENCES `users` (`id`),
  CONSTRAINT `users_sympathy_chk_1` CHECK ((`from_which_user_id` <> `for_which_user`))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица симпатий пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_sympathy`
--

LOCK TABLES `users_sympathy` WRITE;
/*!40000 ALTER TABLE `users_sympathy` DISABLE KEYS */;
INSERT INTO `users_sympathy` VALUES (2,1,2,'2022-02-26 23:40:31',NULL,'good','facilisi cras fermentum odio'),(1,2,1,'2022-02-26 23:40:31',NULL,'exellent','convallis posuere morbi leo'),(10,2,13,'2022-02-26 23:40:31',NULL,'very_good','tincidunt augue interdum'),(4,5,1,'2022-02-26 23:40:31',NULL,'good','fusce ut placerat orci nulla pellentesque'),(3,5,7,'2022-02-26 23:40:31',NULL,'very_good','vitae purus'),(8,6,2,'2022-02-26 23:40:31',NULL,'very_good','vulputate odio'),(9,8,10,'2022-02-26 23:40:31',NULL,'fail','ac tortor vitae purus'),(5,8,11,'2022-02-26 23:40:31',NULL,'very_good','turpis'),(7,12,14,'2022-02-26 23:40:31',NULL,'exellent','tortor dignissim'),(6,15,3,'2022-02-26 23:40:31',NULL,'exellent','vestibulum morbi blandit cursus risus at');
/*!40000 ALTER TABLE `users_sympathy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_tiktok_style`
--

DROP TABLE IF EXISTS `video_tiktok_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_tiktok_style` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `video_name` varchar(255) DEFAULT NULL COMMENT 'название',
  `metadata` json DEFAULT NULL COMMENT 'всякая доп.инфа',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания записи',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления записи',
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `video_tiktok_style_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_tiktok_style`
--

LOCK TABLES `video_tiktok_style` WRITE;
/*!40000 ALTER TABLE `video_tiktok_style` DISABLE KEYS */;
INSERT INTO `video_tiktok_style` VALUES (1,3,'duis ut diam',NULL,'2022-02-26 23:48:46',NULL),(2,4,'sit amet luctus venenatis',NULL,'2022-02-26 23:48:46',NULL),(3,9,'risus quis',NULL,'2022-02-26 23:48:46',NULL),(4,11,'rhoncus est',NULL,'2022-02-26 23:48:46',NULL),(5,8,'quam viverra orci sagittis',NULL,'2022-02-26 23:48:46',NULL),(6,1,'pellentesque',NULL,'2022-02-26 23:48:46',NULL),(7,3,'duis ut diam',NULL,'2022-02-26 23:48:46',NULL),(8,14,'mauris vitae',NULL,'2022-02-26 23:48:46',NULL),(9,3,'tellus',NULL,'2022-02-26 23:48:46',NULL),(10,2,'cursus sit amet',NULL,'2022-02-26 23:48:46',NULL),(11,14,'nunc vel risus',NULL,'2022-02-26 23:48:46',NULL),(12,7,'porta lorem mollis aliquam ut',NULL,'2022-02-26 23:48:46',NULL),(13,5,'sollicitudin',NULL,'2022-02-26 23:48:46',NULL),(14,10,'integer',NULL,'2022-02-26 23:48:46',NULL),(15,2,'metus vulputate',NULL,'2022-02-26 23:48:46',NULL),(16,6,'elit eget',NULL,'2022-02-26 23:48:46',NULL),(17,5,'viverra accumsan in nisl',NULL,'2022-02-26 23:48:46',NULL);
/*!40000 ALTER TABLE `video_tiktok_style` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-27  0:03:13
