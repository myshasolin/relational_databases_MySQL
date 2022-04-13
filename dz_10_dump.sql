-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: lesson_10_ki
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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица с категориями товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Пишущие инструменты'),(2,'Ножи Victorinox'),(3,'Рюкзаки, сумки, дорожные аксессуары,'),(4,'Зажигалки'),(5,'Outdoor');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `description`
--

DROP TABLE IF EXISTS `description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `description` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` text COMMENT 'Описание',
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `description_ibfk_1` FOREIGN KEY (`id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='описание товара';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `description`
--

LOCK TABLES `description` WRITE;
/*!40000 ALTER TABLE `description` DISABLE KEYS */;
INSERT INTO `description` VALUES (1,'СИМВОЛ ПРЕВОСХОДСТВА\r\n	С 1921 Duofold является символом поразительного мастерства фирмы PARKER.\r\n	Покрытая дорогим полимером, Duofold обеспечивает исключительно удобное и роскошное письмо благодаря твердому золотому перу. \r\n	Duofold – эталон перьевых ручек.\r\n	Глубокий красный\r\n	Возрождение Глубокого красного во всем своем смелом великолепии и роскоши. Возвращение неустаревающего цвета, сейчас модного как никогда. Подходит для покупателей обоих полов, желающих выразить свою индивидуальность с помощью этой яркой ручки.'),(2,'Выгравированный логотип PARKER на декоративном хромированном кольце'),(3,'Символ профессионализма и престижа, ручка Parker Premier отличается смелым и изысканным современным дизайном, сводя воедино разные направления наследия Parker. Каждый штрих, написанный элегантной ручкой, дает представление об удобстве и истинном наслаждении от пользования ею.\r\n	Soft Brown\r\n	Корпус покрыт мягким на ощупь матовым лаком коричневого цвета с эффектом резиновой поверхности. Дизайн дополнен декоративными элементами с покрытием из розового золота. Ручка упакована в изысканную подарочную коробку Parker.'),(4,'Современный дизайн и безусловный престиж \r\n	Символ профессионализма и престижа, ручка Parker Premier отличается смелым и изысканным современным дизайном, сводя воедино разные направления наследия Parker. Каждый штрих, написанный элегантной ручкой с пером из чистого 18-каратного золота, дает представление об удобстве и истинном наслаждении от пользования ею.'),(5,'Leman Grand Bleu, союз между ветром и волнами\r\n	Caran d’Ache использует свой уникальный опыт в области цвета и тончайшей гравировки для того чтобы расширить и обогатить цветную палитру коллекции ручек Leman. \r\n	Искупанные в свете и ветре, волны оживают вместе с новой коллекцией Leman Grand Bleu. Изящно выгравированный фон создает впечатление размеренной ряби волн на поверхности воды. Слой прозрачного лака, напоминающего об интенсивном синем цвете океанских глубин, раскрывает эти волнообразные отражения на изысканном корпусе пишущих инструментов Leman Grand Bleu.\r\n	Убаюканные волнами и песней ласкающего ветерка, приверженцы пишущих инструментов класса Премиум нырнут с головой в волнующую одиссею с новой коллекцией ручек Leman Grand Bleu.\r\n	Пожизненная международная гарантия\r\n	Изготовлено в Швейцарии.'),(6,'Эта ручка сравнима с деловым костюмом от Кутюр, начиная с тактильных ощущений и заканчивая уверенностью, которую она придает своему владельцу. Идеальный баланс четкой формы корпуса и классических пропорций с элегантными покрытиями делают ее совершенно особенным аксессуаром. Вдохновение и традиционная романтичность ручки Apogee - это вершина совершенства дизайна 21 века.\r\n	- Утяжеленная и сбалансированная форма корпуса для непринужденного письма.\r\n	- Пружинный клип.\r\n	- Пулевидная форма корпуса.\r\n	- Пожизненная гарантия на механическую часть.\r\n	- Элегантная подарочная коробка.'),(7,'Ручка для широкой аудитории.\r\n	Надежный инструмент на любой вкус. Коллекция Aventura сделает Вашу повседневную жизнь особенной. Легкая и удобная ручка с традиционной формой корпуса и хромированными элементами подарит Вам ощущение классики в повседневных делах. \r\n	- Утонченная форма корпуса.\r\n	- Центральный ободок в современном стиле.\r\n	- Пожизненная гарантия на механическую часть.'),(8,'Используя оригинальные расходные материалы СROSS Вы получаете безупречное качество письма.'),(9,'Используя оригинальные расходные материалы СROSS Вы получаете безупречное качество письма.'),(10,'CROSS X\r\n	Представляем вам самый современный силуэт Cross в обновленном дизайне, подчеркивающем новый образ бренда Cross и самые популярные корпоративные подарочные цвета. \r\n	Особенности:\r\n	- Новый гладкий, утонченный, современный силуэт;\r\n	- Новый образ бренда Cross;\r\n	- Тот же популярный, запатентованный раздвижной открывающий механизм, что и в серии Cross® Edge;\r\n	- Идеальные отделки для корпоративных подарков;\r\n	- Возможность необычного декорирования.'),(11,'Классика с кнопкой.\r\n	Наиболее известная форма Cross теперь с кнопкой. Включите ручку одним кликом! Ручка Cross Click позволяет писать также ровно, как и стройный гриф коллекции Classic Century®, но в отличие от своего предшественника не имеет поворотного механизма, вместо него имеется кнопка. Нужно всего лишь нажать на кнопку и писать с удовольствием.\r\n	- Современная версия классики.\r\n	- Легкий в использовании нажимной кнопочный механизм, первая ручка Cross такого рода.\r\n	- Стильные популярные цвета.\r\n	- Пожизненная гарантия на механическую часть.\r\n	- Упакована в премиальную подарочную коробку.'),(12,NULL),(13,'Перьевая ручка Pierre Cardin, ESPACE');
/*!40000 ALTER TABLE `description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `general_view`
--

DROP TABLE IF EXISTS `general_view`;
/*!50001 DROP VIEW IF EXISTS `general_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `general_view` AS SELECT 
 1 AS `order_number`,
 1 AS `buyer_number`,
 1 AS `buyers_name`,
 1 AS `item_number`,
 1 AS `name`,
 1 AS `number_of_goods`,
 1 AS `sale_price`,
 1 AS `purchase_price`,
 1 AS `supplier`,
 1 AS `warehouse_number`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `international_article` varchar(100) DEFAULT NULL COMMENT 'международный артикул',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название',
  `characteristics_goods` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания товара',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления товара',
  PRIMARY KEY (`id`),
  UNIQUE KEY `international_article` (`international_article`),
  KEY `title_idx` (`title`),
  KEY `international_article_idx` (`international_article`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,'1907192','Ручка шариковая Parker Duofold (1907192) Big Red GT M черные чернила','{\"Тип\": \"Ручка шариковая\", \"Вид упаковки\": \"коробка подарочная\", \"Наличие клипа\": \"ДА\", \"Срок гарантии\": \"24 мес.\", \"Коллекция(серия)\": \"Duofold\", \"Материал корпуса\": \"акрил литой\", \"Наличие колпачка\": \"без колпачка\", \"Размер пишущего узла\": \"средний (M)\", \"Цвет чернил в стержне\": \"черный\", \"Оригинальный цвет корпуса\": \"Big Red GT\", \"Механизм выдвижения стержня\": \"поворотный\"}','2022-04-10 01:52:00',NULL),(2,'1906779','Ручка шариковая Parker IM Premium (1906779) Brown Shadow M коричневый жемчуг','{\"Тип\": \"Ручка шариковая\", \"Клип\": \"сталь\", \"Цвет\": \"коричневый жемчуг\", \"Отделка\": \"хром\", \"Вид упаковки\": \"коробка подарочная\", \"Наличие клипа\": \"ДА\", \"Срок гарантии\": \"24 мес.\", \"Коллекция(серия)\": \"IM\", \"Материал корпуса\": \"окрашенный алюминий с гравировкой\", \"Наличие колпачка\": \"без колпачка\", \"Размер пишущего узла\": \"средний (M)\", \"Цвет чернил в стержне\": \"синий\", \"Механизм выдвижения стержня\": \"нажимной\"}','2022-04-10 01:52:00',NULL),(3,'1931408','Ручка шариковая Parker Premier Lacque (1931408) Brown PGT M черные чернила','{\"Тип\": \"Ручка шариковая\", \"Вид упаковки\": \"коробка подарочная\", \"Наличие клипа\": \"ДА\", \"Срок гарантии\": \"24 мес.\", \"Отделка деталей\": \"позолота розовая\", \"Коллекция(серия)\": \"Premier\", \"Материал корпуса\": \"латунь лакированная\", \"Наличие колпачка\": \"без колпачка\", \"Размер пишущего узла\": \"средний (M)\", \"Цвет чернил в стержне\": \"черный\", \"Оригинальный цвет корпуса\": \"Brown PGT\", \"Механизм выдвижения стержня\": \"поворотный\"}','2022-04-10 01:52:00',NULL),(4,'1931431','Ручка перьевая Parker Premier Monochrome Black (1931431) F перо золото 18K','{\"Тип пера\": \"открытое\", \"Размер пера\": \"F\", \"Вид упаковки\": \"коробка подарочная\", \"Материал пера\": \"золото 18K\", \"Срок гарантии\": \"24 мес.\", \"Отделка деталей\": \"покрытие PDV\", \"Коллекция(серия)\": \"Premier\", \"Материал корпуса\": \"латунь ювелирная\", \"Система заправки\": \"конвертор/картриджи\", \"Оригинальный цвет корпуса\": \"Monochrome Black\", \"Дополнительная комплектация\": \"картридж 2 шт. с черными чернилами/конвертер Deluxe\"}','2022-04-10 01:52:00',NULL),(5,'4779.168','Ручка роллер Carandache Leman Grand Blue SP (4779.168) F черные чернила','{\"Колпачок\": \"завинчивающийся. Торец колпачка оснащен новым идентификатором Caran d’Ache (темно-синий лакированный шестигранник)\", \"В комплекте\": \"стержень роллер Carandache (артикул стержня 8228.009) (F) черные чернила 1 шт.\", \"Вид упаковки\": \"коробка подарочная\", \"Отделка корпуса\": \"посеребрение с родиевым покрытием\", \"Материал корпуса\": \"латунь лакированная, прозрачный темно-синий лак, гильоше волны\"}','2022-04-10 01:52:00',NULL),(6,'886-3FS','Ручка перьевая Cross ATX (886-3FS) матовая черная с серебристой отделкой','{\"Перо\": \"сталь, тонкое\", \"Цвет\": \"серебристый\", \"Корпус\": \"латунь и хромовое покрытие\", \"Отделка и детали дизайна\": \"хром\"}','2022-04-10 01:52:00',NULL),(7,'AT0156-1MS','Ручка перьевая Cross Aventura (AT0156-1MS) черная','{\"Перо\": \"сталь, родий, толщина средняя\", \"Цвет\": \"черный\", \"Корпус\": \"латунь и лакированное покрытие\", \"Отделка и детали дизайна\": \"хром\"}','2022-04-10 01:52:00',NULL),(8,'8945S-1 blue','Флакон с чернилами Cross (8945S-1 blue) для перьевой ручки, синий, 62,5 мл','{\"Цвет\": \"синий\", \"Объем флакона\": \"62,5 мл\"}','2022-04-10 01:52:00',NULL),(9,'8945S-2 black','Флакон с чернилами Cross (8945S-2 black) для перьевой ручки, черный, 62,5 мл','{\"Цвет\": \"черный\", \"Объем флакона\": \"62,5 мл\"}','2022-04-10 01:52:00',NULL),(10,'AT0725-3','Ручка роллер Cross X без колпачка (AT0725-3) красная','{\"Цвет\": \"красный\", \"Корпус\": \"латунь и эпоксидная смола\"}','2022-04-10 01:52:00',NULL),(11,'AT0622-101','Шариковая ручка Cross Click Lustrous Chrome (AT0622-101) зеркальный хром','{\"цвет\": \"зеркальный хром\", \"материал корпуса\": \"латунь\", \"механизм выдвижения стержня\": \"нажимной\"}','2022-04-10 01:52:00',NULL),(12,'S0911450','Ручка шариковая Parker Urban Premium (S0911450) Pearl Metal Chiselled M синие чернила','{\"Тип\": \"Шарикова ручка\", \"Цвет\": \"Pearl Metal Chiselled\", \"Корпус\": \"Латунь\", \"Отделка\": \"Лаковое покрытие, оригинальная гравировка, хромированные детали\", \"Упаковка\": \"Подарочная коробка\", \"Цвет стержня\": \"Синий\", \"Комплектация\": \"1 стержень, в ручке\", \"Толщина пишущего узла\": \"Средний (М)\"}','2022-04-10 01:52:00',NULL),(13,'806251','Ручка перьевая Pelikan Office Twist P457 (806251) Girly Rose M перо сталь нержавеющая','{\"Размер пера\": \"M\", \"Вид упаковки\": \"коробка подарочная\", \"Материал пера\": \"сталь нержавеющая\", \"Срок гарантии\": \"36 мес.\", \"Коллекция/Серия\": \"Office\", \"Материал корпуса\": \"пластик\", \"Оригинальный цвет корпуса\": \"Girly Rose\"}','2022-04-10 01:52:00',NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_category`
--

DROP TABLE IF EXISTS `goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_category` (
  `id_category` bigint unsigned NOT NULL,
  `id_goods` bigint unsigned NOT NULL,
  KEY `id_category` (`id_category`),
  KEY `id_goods` (`id_goods`),
  CONSTRAINT `goods_category_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_category_ibfk_2` FOREIGN KEY (`id_goods`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для привязки товара к категории';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_category`
--

LOCK TABLES `goods_category` WRITE;
/*!40000 ALTER TABLE `goods_category` DISABLE KEYS */;
INSERT INTO `goods_category` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13);
/*!40000 ALTER TABLE `goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goods_suppliers`
--

DROP TABLE IF EXISTS `goods_goods_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_goods_suppliers` (
  `goods_suppliers` bigint unsigned NOT NULL,
  `goods` bigint unsigned NOT NULL,
  KEY `goods_suppliers` (`goods_suppliers`),
  KEY `goods` (`goods`),
  CONSTRAINT `goods_goods_suppliers_ibfk_1` FOREIGN KEY (`goods_suppliers`) REFERENCES `goods_suppliers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_goods_suppliers_ibfk_2` FOREIGN KEY (`goods`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для привязки товаров к поставщикам';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goods_suppliers`
--

LOCK TABLES `goods_goods_suppliers` WRITE;
/*!40000 ALTER TABLE `goods_goods_suppliers` DISABLE KEYS */;
INSERT INTO `goods_goods_suppliers` VALUES (1,1),(1,2),(2,3),(1,4),(2,4),(1,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(1,12),(2,12),(1,13);
/*!40000 ALTER TABLE `goods_goods_suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_storehouse`
--

DROP TABLE IF EXISTS `goods_storehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_storehouse` (
  `id_storehouse` bigint unsigned NOT NULL,
  `id_goods` bigint unsigned NOT NULL,
  `id_goods_suppliers` bigint unsigned NOT NULL COMMENT 'от какого поставщика',
  `quantity_of_goods` bigint DEFAULT NULL COMMENT 'количество товаров на складе',
  KEY `id_storehouse` (`id_storehouse`),
  KEY `id_goods` (`id_goods`),
  KEY `id_goods_suppliers` (`id_goods_suppliers`),
  CONSTRAINT `goods_storehouse_ibfk_1` FOREIGN KEY (`id_storehouse`) REFERENCES `storehouse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_storehouse_ibfk_2` FOREIGN KEY (`id_goods`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_storehouse_ibfk_3` FOREIGN KEY (`id_goods_suppliers`) REFERENCES `purchase_price` (`id_goods_suppliers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для привязки склада и товара';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_storehouse`
--

LOCK TABLES `goods_storehouse` WRITE;
/*!40000 ALTER TABLE `goods_storehouse` DISABLE KEYS */;
INSERT INTO `goods_storehouse` VALUES (1,1,1,3),(2,1,1,2),(1,2,1,1),(2,2,1,1),(1,3,2,1),(2,3,2,0),(1,4,2,0),(2,4,2,1),(1,5,1,1),(2,5,1,0),(1,6,2,1),(2,6,2,1),(1,7,2,0),(2,7,2,1),(1,8,2,5),(2,8,2,3),(1,9,2,4),(2,9,2,2),(1,10,2,1),(2,10,2,0),(1,11,2,1),(2,11,2,0),(1,12,2,1),(2,12,2,0),(1,13,1,3),(2,13,1,2);
/*!40000 ALTER TABLE `goods_storehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_storehouse_orders`
--

DROP TABLE IF EXISTS `goods_storehouse_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_storehouse_orders` (
  `id_orders` bigint unsigned NOT NULL,
  `id_goods` bigint unsigned NOT NULL,
  `quantity_of_goods` bigint unsigned NOT NULL,
  `id_goods_suppliers` bigint unsigned NOT NULL,
  `id_storehouse` bigint unsigned NOT NULL,
  KEY `id_goods` (`id_goods`),
  KEY `id_storehouse` (`id_storehouse`),
  KEY `id_orders` (`id_orders`),
  KEY `id_goods_suppliers` (`id_goods_suppliers`),
  CONSTRAINT `goods_storehouse_orders_ibfk_1` FOREIGN KEY (`id_goods`) REFERENCES `goods_storehouse` (`id_goods`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_storehouse_orders_ibfk_2` FOREIGN KEY (`id_storehouse`) REFERENCES `goods_storehouse` (`id_storehouse`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_storehouse_orders_ibfk_3` FOREIGN KEY (`id_orders`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_storehouse_orders_ibfk_4` FOREIGN KEY (`id_goods_suppliers`) REFERENCES `purchase_price` (`id_goods_suppliers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для привязки товаров к заказу (так как в заказе может быть несколько товаров)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_storehouse_orders`
--

LOCK TABLES `goods_storehouse_orders` WRITE;
/*!40000 ALTER TABLE `goods_storehouse_orders` DISABLE KEYS */;
INSERT INTO `goods_storehouse_orders` VALUES (1,1,2,1,2),(2,2,1,1,1),(3,4,1,2,1),(4,5,1,1,1),(5,6,2,2,2),(5,7,1,2,2),(5,9,1,2,2),(5,8,1,2,2),(6,10,1,2,1),(7,11,1,2,1),(8,12,2,1,1),(9,13,1,1,1);
/*!40000 ALTER TABLE `goods_storehouse_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_suppliers`
--

DROP TABLE IF EXISTS `goods_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT 'Название',
  `description` varchar(250) DEFAULT NULL COMMENT 'Описание',
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `phone` char(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `personal_manager` json DEFAULT NULL,
  `comment` varchar(250) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `goods_suppliers_chk_1` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{11}$')),
  CONSTRAINT `goods_suppliers_chk_2` CHECK (regexp_like(`email`,_utf8mb4'^((([0-9A-Za-z]{1}[-0-9A-z.]{0,30}[0-9A-Za-z]?)|([0-9А-Яа-я]{1}[-0-9А-я.]{0,30}[0-9А-Яа-я]?))@([-A-Za-z]{1,}.){1,}[-A-Za-z]{2,})$'))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='поставщики';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_suppliers`
--

LOCK TABLES `goods_suppliers` WRITE;
/*!40000 ALTER TABLE `goods_suppliers` DISABLE KEYS */;
INSERT INTO `goods_suppliers` VALUES (1,'MERLION','ножи, пишущие','Россия','Красногорск','б-р Строителей, 4','74959818484','info@merlion.com','{\"имя\": \"Иванов Иван\", \"почта\": \"ivanovivan@merlion.com\", \"телефон\": \"доб. 1552\"}','менеджер тупит','2022-04-10 01:52:01',NULL),(2,'ГАЛСЭР','Pierre Cardin, Cross, багажка','Россия','Москва','ул. Вятская, д.27, корпус 5','74957877147','galser@galser.ru','{\"имя\": \"Ксения\", \"почта\": \"ks@galser.ru\", \"телефон\": \"доб. 12\"}',NULL,'2022-04-10 01:52:01',NULL);
/*!40000 ALTER TABLE `goods_suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_suppliers_category`
--

DROP TABLE IF EXISTS `goods_suppliers_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_suppliers_category` (
  `id_goods_suppliers` bigint unsigned NOT NULL,
  `id_category` bigint unsigned NOT NULL,
  KEY `id_goods_suppliers` (`id_goods_suppliers`),
  KEY `id_category` (`id_category`),
  CONSTRAINT `goods_suppliers_category_ibfk_1` FOREIGN KEY (`id_goods_suppliers`) REFERENCES `goods_suppliers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_suppliers_category_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для привязки поставщика к категории';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_suppliers_category`
--

LOCK TABLES `goods_suppliers_category` WRITE;
/*!40000 ALTER TABLE `goods_suppliers_category` DISABLE KEYS */;
INSERT INTO `goods_suppliers_category` VALUES (1,1),(1,2),(1,5),(2,1),(2,2),(2,3),(2,4);
/*!40000 ALTER TABLE `goods_suppliers_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id_order` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('новый','в работе','завершён','отменён') DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  CONSTRAINT `order_status_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='статус заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'завершён'),(2,'завершён'),(3,'в работе'),(4,'завершён'),(5,'завершён'),(6,'завершён'),(7,'отменён'),(8,'завершён'),(9,'завершён');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_shopper` bigint unsigned NOT NULL,
  `methods_logistics` enum('склад-склад','склад-дверь','дверь-склад','дверь-дверь','иное') DEFAULT NULL,
  `payment_methods` bigint unsigned NOT NULL,
  `comments` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата оформления заказа',
  PRIMARY KEY (`id`),
  KEY `id_shopper` (`id_shopper`),
  KEY `payment_methods` (`payment_methods`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_shopper`) REFERENCES `shopper` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_methods`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'склад-дверь',2,'позвонить за час','2022-04-10 01:52:01'),(2,1,'склад-дверь',2,'позвонить за час','2022-04-10 01:52:01'),(3,2,'склад-склад',1,'решение о покупке при вручении на месте','2022-04-10 01:52:01'),(4,3,'склад-дверь',3,NULL,'2022-04-10 01:52:01'),(5,4,'склад-дверь',4,NULL,'2022-04-10 01:52:01'),(6,5,'иное',1,'позвонить за час','2022-04-10 01:52:01'),(7,6,'склад-склад',3,'Доставка ПЭК','2022-04-10 01:52:01'),(8,7,'склад-дверь',1,NULL,'2022-04-10 01:52:01'),(9,8,'склад-дверь',3,'позвонить за час','2022-04-10 01:52:01');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='способы оплаты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,'наличными при получении заказа'),(2,'картой при получении заказа'),(3,'онлайн'),(4,'рассрочка');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `id_photo` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `format_photos` enum('jpg','png','pdf','psd') DEFAULT NULL,
  UNIQUE KEY `id_photo` (`id_photo`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица-хранилище с фото';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,'1907192-1','jpg'),(2,'1907192-2','jpg'),(3,'1907192-3','jpg'),(4,'1907192-4','jpg'),(5,'1907192-5','jpg'),(6,'1907193-1','jpg'),(7,'1907193-2','jpg'),(8,'1907193-3','jpg'),(9,'1907193-4','jpg'),(10,'1907193-5','jpg'),(11,'1907193-6','jpg'),(12,'1931408-1','jpg'),(13,'1931408-2','jpg'),(14,'1931408-3','jpg'),(15,'1931408-4','jpg'),(16,'1931408-5','jpg'),(17,'1931431-1','jpg'),(18,'1931431-2','jpg'),(19,'1931431-3','jpg'),(20,'1931431-4','jpg'),(21,'1931431-5','jpg'),(22,'1931431-6','jpg'),(23,'1931431-7','jpg'),(24,'4779.168-1','png'),(25,'4779.168-2','png'),(26,'4779.168-3','png'),(27,'4779.168-4','png'),(28,'4779.168-5','png'),(29,'4779.168-6','png'),(30,'886-3FS-1','jpg'),(31,'886-3FS-2','jpg'),(32,'886-3FS-3','jpg'),(33,'886-3FS-4','jpg'),(34,'AT0156-1MS-1','jpg'),(35,'AT0156-1MS-2','jpg'),(36,'AT0156-1MS-3','jpg'),(37,'AT0156-1MS-4','jpg'),(38,'AT0156-1MS-5','jpg'),(39,'AT0156-1MS-6','jpg'),(40,'8945S-1_blue-1','jpg'),(41,'8945S-1_blue-2','jpg'),(42,'8945S-2_black-1','jpg'),(43,'8945S-2_black-2','jpg'),(44,'AT0725-3-1','jpg'),(45,'AT0725-3-2','jpg'),(46,'AT0725-3-3','jpg'),(47,'AT0725-3-4','jpg'),(48,'AT0725-3-5','jpg'),(49,'AT0725-3-6','jpg'),(50,'AT0725-3-7','jpg'),(51,'AT0622-101-1','jpg'),(52,'AT0622-101-2','jpg'),(53,'AT0622-101-3','jpg'),(54,'AT0622-101-4','jpg'),(55,'AT0622-101-5','jpg'),(56,'AT0622-101-6','jpg'),(57,'AT0622-101-7','jpg'),(58,'AT0622-101-8','jpg'),(59,'S0911450-1','jpg'),(60,'S0911450-2','jpg'),(61,'S0911450-3','jpg'),(62,'S0911450-4','jpg'),(63,'806251-1','jpg'),(64,'806251-2','jpg'),(65,'806251-3','jpg');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos_goods`
--

DROP TABLE IF EXISTS `photos_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos_goods` (
  `id_photos` bigint unsigned NOT NULL,
  `id_goods` bigint unsigned NOT NULL,
  KEY `id_photos` (`id_photos`),
  KEY `id_goods` (`id_goods`),
  CONSTRAINT `photos_goods_ibfk_1` FOREIGN KEY (`id_photos`) REFERENCES `photos` (`id_photo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photos_goods_ibfk_2` FOREIGN KEY (`id_goods`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='таблица для привязки фото к товару';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos_goods`
--

LOCK TABLES `photos_goods` WRITE;
/*!40000 ALTER TABLE `photos_goods` DISABLE KEYS */;
INSERT INTO `photos_goods` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,3),(13,3),(14,3),(15,3),(16,3),(17,4),(18,4),(19,4),(20,4),(21,4),(22,4),(23,4),(24,5),(25,5),(26,5),(27,5),(28,5),(29,5),(30,6),(31,6),(32,6),(33,6),(34,7),(35,7),(36,7),(37,7),(38,7),(39,7),(40,8),(41,8),(42,9),(43,9),(44,10),(45,10),(46,10),(47,10),(48,10),(49,10),(50,10),(51,11),(52,11),(53,11),(54,11),(55,11),(56,11),(57,11),(58,11),(59,12),(60,12),(61,12),(62,12),(63,13),(64,13),(65,13);
/*!40000 ALTER TABLE `photos_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_price`
--

DROP TABLE IF EXISTS `purchase_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_price` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_goods_suppliers` bigint unsigned NOT NULL COMMENT 'id поставщика',
  `international_article` varchar(100) DEFAULT NULL COMMENT 'международный артикул',
  `price` decimal(10,2) NOT NULL COMMENT 'цена',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания цены',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления цены',
  PRIMARY KEY (`id`),
  KEY `international_article` (`international_article`),
  KEY `id_goods_suppliers` (`id_goods_suppliers`),
  CONSTRAINT `purchase_price_ibfk_1` FOREIGN KEY (`international_article`) REFERENCES `goods` (`international_article`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `purchase_price_ibfk_2` FOREIGN KEY (`id_goods_suppliers`) REFERENCES `goods_suppliers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='цена закупки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_price`
--

LOCK TABLES `purchase_price` WRITE;
/*!40000 ALTER TABLE `purchase_price` DISABLE KEYS */;
INSERT INTO `purchase_price` VALUES (1,1,'1907192',14225.00,'2022-04-10 01:52:01',NULL),(2,1,'1906779',1555.00,'2022-04-10 01:52:01',NULL),(3,2,'1931408',12350.00,'2022-04-10 01:52:01',NULL),(4,1,'1931431',26142.50,'2022-04-10 01:52:01',NULL),(5,2,'1931431',33985.25,'2022-04-10 01:52:01',NULL),(6,1,'4779.168',18600.00,'2022-04-10 01:52:01',NULL),(7,2,'886-3FS',8400.00,'2022-04-10 01:52:01',NULL),(8,2,'AT0156-1MS',2589.00,'2022-04-10 01:52:01',NULL),(9,2,'8945S-1 blue',1884.00,'2022-04-10 01:52:01',NULL),(10,2,'8945S-2 black',1884.00,'2022-04-10 01:52:01',NULL),(11,2,'AT0725-3',2190.00,'2022-04-10 01:52:01',NULL),(12,2,'AT0622-101',3000.00,'2022-04-10 01:52:01',NULL),(13,1,'S0911450',2577.00,'2022-04-10 01:52:01',NULL),(14,2,'S0911450',2577.00,'2022-04-10 01:52:01',NULL),(15,1,'806251',700.00,'2022-04-10 01:52:01',NULL);
/*!40000 ALTER TABLE `purchase_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата заказа',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='отзывы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'ручка щикаарная, всем рекомендую','2022-04-10 01:52:01'),(2,'оригинал, быстрая доставка, рекомендую','2022-04-10 01:52:01'),(3,'ответили на все вопросы, быстро доставили, рекомендую.','2022-04-10 01:52:01'),(4,'оперативная доставка, товар оригинал','2022-04-10 01:52:01'),(5,'заказ не пришел','2022-04-10 01:52:01'),(6,'рекомендую','2022-04-10 01:52:01'),(7,'отлично ставит почерк','2022-04-10 01:52:01');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_goods_shopper`
--

DROP TABLE IF EXISTS `reviews_goods_shopper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews_goods_shopper` (
  `id_reviews` bigint unsigned NOT NULL,
  `id_goods` bigint unsigned NOT NULL,
  `id_shopper` bigint unsigned NOT NULL,
  KEY `id_reviews` (`id_reviews`),
  KEY `id_goods` (`id_goods`),
  KEY `id_shopper` (`id_shopper`),
  CONSTRAINT `reviews_goods_shopper_ibfk_1` FOREIGN KEY (`id_reviews`) REFERENCES `reviews` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_goods_shopper_ibfk_2` FOREIGN KEY (`id_goods`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_goods_shopper_ibfk_3` FOREIGN KEY (`id_shopper`) REFERENCES `shopper` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='отзывы - 1) id отзыва, 2) на что и 3) от кого';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_goods_shopper`
--

LOCK TABLES `reviews_goods_shopper` WRITE;
/*!40000 ALTER TABLE `reviews_goods_shopper` DISABLE KEYS */;
INSERT INTO `reviews_goods_shopper` VALUES (1,1,1),(2,4,2),(3,5,3),(4,6,4),(4,7,4),(4,9,4),(4,8,4),(5,11,6),(6,12,7),(7,13,8);
/*!40000 ALTER TABLE `reviews_goods_shopper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selling_price`
--

DROP TABLE IF EXISTS `selling_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selling_price` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL COMMENT 'цена',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания цены',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления цены',
  PRIMARY KEY (`id`),
  CONSTRAINT `selling_price_ibfk_1` FOREIGN KEY (`id`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='цена продажи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selling_price`
--

LOCK TABLES `selling_price` WRITE;
/*!40000 ALTER TABLE `selling_price` DISABLE KEYS */;
INSERT INTO `selling_price` VALUES (1,28450.00,'2022-04-10 01:52:01',NULL),(2,3110.00,'2022-04-10 01:52:01',NULL),(3,24700.00,'2022-04-10 01:52:01',NULL),(4,52285.00,'2022-04-10 01:52:01',NULL),(5,37200.00,'2022-04-10 01:52:01',NULL),(6,14000.00,'2022-04-10 01:52:01',NULL),(7,4315.00,'2022-04-10 01:52:01',NULL),(8,3140.00,'2022-04-10 01:52:01',NULL),(9,3140.00,'2022-04-10 01:52:01',NULL),(10,3650.00,'2022-04-10 01:52:01',NULL),(11,5000.00,'2022-04-10 01:52:01',NULL),(12,4295.00,'2022-04-10 01:52:01',NULL),(13,1400.00,'2022-04-10 01:52:01',NULL);
/*!40000 ALTER TABLE `selling_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopper`
--

DROP TABLE IF EXISTS `shopper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopper` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `phone` bigint unsigned NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(256) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `house` char(10) DEFAULT NULL,
  `building_or_letter` varchar(100) DEFAULT NULL COMMENT 'корпус или литера',
  `apartment` varchar(100) DEFAULT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата регистрации покупателя',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата изменения данных о покупателе',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `shopper_chk_1` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{11}$')),
  CONSTRAINT `shopper_chk_2` CHECK (regexp_like(`email`,_utf8mb4'^((([0-9A-Za-z]{1}[-0-9A-z.]{0,30}[0-9A-Za-z]?)|([0-9А-Яа-я]{1}[-0-9А-я.]{0,30}[0-9А-Яа-я]?))@([-A-Za-z]{1,}.){1,}[-A-Za-z]{2,})$'))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='покупатели, пользовательские данные';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopper`
--

LOCK TABLES `shopper` WRITE;
/*!40000 ALTER TABLE `shopper` DISABLE KEYS */;
INSERT INTO `shopper` VALUES (1,'Екатерина','Каленова',79035555555,'gygygy@yandex.ru','1ccc0f1ecd201e2b71200cdb2e59f1126de19356','Москва','Трёхпудный проезд','11','4',NULL,NULL,'2022-04-10 01:52:01',NULL),(2,'Николай','Чернявский',79156667777,'bybyby@mail.ru','a0487eb31b1c3d82398ddc220e70348d661dcdf1','Санкт-Петербург','Ленинский пр-т','2','лит.6','помещение 88',NULL,'2022-04-10 01:52:01',NULL),(3,'Ирина','Иванова',79855555555,'tratata@tratata.ta','92c33360fe4291cde541ee8a0947fd23931351d5','Москва','пр-кт Маршала Жукова','75','корп. 2',NULL,'есть вопросы по доставке','2022-04-10 01:52:01',NULL),(4,'Сергей','Кузнецов',75556662211,'lalala@topolya.lya','f4f6075660f96a4ea9b7338418df2016c82155b4','Москва','7-я Паврковая ул','12',NULL,'3',NULL,'2022-04-10 01:52:01',NULL),(5,'Антон','Модин',79156669988,'huhuhu@hohoho.ho','db3522f2ee904b606b0191dd362e19ec09fd8f16','Москва','Таллинская','2','3','22','Подъезд 2, этаж 9, домофон 22','2022-04-10 01:52:01',NULL),(6,'Дарья','С',78005556644,'dyk@dyk.dy','ecaf8bdcc8c2a37329e199920ead4e995c78238c','Хабаровск','Промышленная','22',NULL,NULL,'офис 2','2022-04-10 01:52:01',NULL),(7,'Анастасия','Довлатова',75553336699,'bum@bubum.bum','8479d8314d8a5f43e45faae5f853ccc13136d390','Люберцы','Митрофанова','11','2','31','Подъезд 5, этаж 6','2022-04-10 01:52:01',NULL),(8,'Сергей','',79996665522,'tt@yy.oo','95bc8877a611704b51d3a24eada62cb6fa760d1e','Москва','Космодамианская наб.','50/8',NULL,NULL,NULL,'2022-04-10 01:52:01',NULL);
/*!40000 ALTER TABLE `shopper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouse`
--

DROP TABLE IF EXISTS `storehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouse` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT 'Название',
  `city` varchar(100) DEFAULT NULL,
  `phone` char(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `storehouse_chk_1` CHECK (regexp_like(`phone`,_utf8mb4'^[0-9]{11}$')),
  CONSTRAINT `storehouse_chk_2` CHECK (regexp_like(`email`,_utf8mb4'^((([0-9A-Za-z]{1}[-0-9A-z.]{0,30}[0-9A-Za-z]?)|([0-9А-Яа-я]{1}[-0-9А-я.]{0,30}[0-9А-Яа-я]?))@([-A-Za-z]{1,}.){1,}[-A-Za-z]{2,})$'))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='склад';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouse`
--

LOCK TABLES `storehouse` WRITE;
/*!40000 ALTER TABLE `storehouse` DISABLE KEYS */;
INSERT INTO `storehouse` VALUES (1,'На Дубровке','Москва','74952741001','info@apfy.ru'),(2,'Перекладной','Балашиха','74962223344','solin@apfy.ru');
/*!40000 ALTER TABLE `storehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `general_view`
--

/*!50001 DROP VIEW IF EXISTS `general_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `general_view` AS select `o`.`id` AS `order_number`,`o`.`id_shopper` AS `buyer_number`,concat(`sh`.`firstname`,' ',`sh`.`lastname`) AS `buyers_name`,`g`.`international_article` AS `item_number`,`g`.`title` AS `name`,`gso`.`quantity_of_goods` AS `number_of_goods`,`sp`.`price` AS `sale_price`,`pp`.`price` AS `purchase_price`,`gs`.`name` AS `supplier`,`s`.`name` AS `warehouse_number` from ((((((((`orders` `o` join `shopper` `sh`) join `goods_storehouse_orders` `gso`) join `goods` `g`) join `selling_price` `sp`) join `goods_goods_suppliers` `ggs`) join `goods_suppliers` `gs`) join `storehouse` `s`) join `purchase_price` `pp` on(((`o`.`id_shopper` = `sh`.`id`) and (`gso`.`id_orders` = `o`.`id`) and (`gso`.`id_goods_suppliers` = `ggs`.`goods_suppliers`) and (`g`.`id` = `gso`.`id_goods`) and (`sp`.`id` = `g`.`id`) and (`ggs`.`goods` = `g`.`id`) and (`gs`.`id` = `ggs`.`goods_suppliers`) and (`s`.`id` = `gso`.`id_storehouse`) and (`pp`.`international_article` = `g`.`international_article`) and (`pp`.`id_goods_suppliers` = `gs`.`id`)))) order by `o`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-10  2:05:09
