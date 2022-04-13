-- (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

CREATE DATABASE IF NOT EXISTS lesson_9_sample;
USE lesson_9_sample;

-- для примера берём таблицу товаров из курсового проекта:
DROP TABLE IF EXISTS goods;
CREATE TABLE goods(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	international_article VARCHAR(100) UNIQUE COMMENT 'международный артикул',
	title VARCHAR(250) COMMENT 'Название',
	characteristics_goods JSON, # характеристики товаров
	created_at DATETIME DEFAULT NOW() COMMENT 'дата создания товара',
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления товара',
	
	INDEX title_idx(title),
	INDEX international_article_idx (international_article)
) COMMENT 'таблица товаров';


-- заполняем ее значениями на 11 строк, только в начале ещё руками created_at заполним для бОльшей наглядности
INSERT IGNORE INTO goods (created_at, international_article, title, characteristics_goods)
VALUES 
	('2021-04-18 17:02:35', '1907192', 'Ручка шариковая Parker Duofold (1907192) Big Red GT M черные чернила', '{"Коллекция(серия)": "Duofold", "Оригинальный цвет корпуса": "Big Red GT", "Материал корпуса": "акрил литой", "Вид упаковки": "коробка подарочная", "Размер пишущего узла": "средний (M)", "Цвет чернил в стержне": "черный", "Наличие колпачка": "без колпачка", "Наличие клипа": "ДА", "Тип": "Ручка шариковая", "Механизм выдвижения стержня": "поворотный", "Срок гарантии": "24 мес."}'),
	('2021-06-20 17:02:35', '1906779', 'Ручка шариковая Parker IM Premium (1906779) Brown Shadow M коричневый жемчуг', '{"Коллекция(серия)": "IM", "Цвет": "коричневый жемчуг", "Материал корпуса": "окрашенный алюминий с гравировкой", "Отделка": "хром", "Вид упаковки": "коробка подарочная", "Размер пишущего узла": "средний (M)", "Цвет чернил в стержне": "синий", "Наличие колпачка": "без колпачка", "Наличие клипа": "ДА", "Клип": "сталь", "Тип": "Ручка шариковая", "Механизм выдвижения стержня": "нажимной", "Срок гарантии": "24 мес."}'),
	('2021-09-23 17:02:35', '1931408', 'Ручка шариковая Parker Premier Lacque (1931408) Brown PGT M черные чернила', '{"Коллекция(серия)": "Premier", "Оригинальный цвет корпуса": "Brown PGT", "Материал корпуса": "латунь лакированная", "Отделка деталей": "позолота розовая", "Вид упаковки": "коробка подарочная", "Размер пишущего узла": "средний (M)", "Цвет чернил в стержне": "черный", "Наличие колпачка": "без колпачка", "Наличие клипа": "ДА", "Тип": "Ручка шариковая", "Механизм выдвижения стержня": "поворотный", "Срок гарантии": "24 мес."}'),
	('2021-10-24 17:02:35', '1931431', 'Ручка перьевая Parker Premier Monochrome Black (1931431) F перо золото 18K', '{ "Коллекция(серия)": "Premier", "Тип пера": "открытое", "Оригинальный цвет корпуса": "Monochrome Black", "Материал корпуса": "латунь ювелирная", "Отделка деталей": "покрытие PDV", "Вид упаковки": "коробка подарочная", "Материал пера": "золото 18K", "Размер пера": "F", "Система заправки": "конвертор/картриджи", "Дополнительная комплектация": "картридж 2 шт. с черными чернилами/конвертер Deluxe", "Срок гарантии": "24 мес."}'),
	('2021-11-25 17:02:35', '2054828', 'Ручка роллер Parker Sonnet F541 Special Edition Stratum (2054828) Grey PGT F черные чернила', '{"Коллекция(серия)": "Sonnet", "Зажим": "Отделка розовое золото", "Материал колпачка": "Нержавеющая сталь", "Отделка колпачка": "полировка + лазер", "Материал корпуса": "Латунь", "Отделка": "Серый лак + Полупрозрачное покрытие", "Зона захвата": "Нержавеющая сталь", "Кольцо зоны захвата": "отделка розовое золото"}'),
	('2021-12-26 17:02:35', '840.470', 'Ручка перьевая Carandache Office 849 Classic (840.470) Yellow Fluo M перо нержавеющая сталь', '{"Тип пера": "Открытое", "Коллекция/Серия": "Office", "Оригинальный цвет корпуса": "Yellow Fluo", "Материал корпуса": "алюминий", "Отделка деталей": "сталь нержавеющая", "Колпачок": "на защелкивающемся механизме", "Материал пера": "сталь нержавеющая", "Размер пера": "M", "Система заправки": "конвертор/картриджи", "Срок гарантии": "24 мес."}'),
	('2022-01-27 17:02:35', '4490.007', 'Ручка перьевая Carandache Varius Carbon 3000 SP (4490.007) F перо золото 18K', '{"Тип пера": "открытое", "Материал корпуса": "латунь ювелирная, углеволокно", "Отделка деталей": "посеребрение с родиевым покрытием", "Вид упаковки": "коробка подарочная", "Материал пера": "золото 18K с родиевым покрытием", "Размер пера": "F", "Колпачок": "завинчивающийся", "Система заправки": "поршневая/картриджи"}'),
	('2021-08-22 17:02:35', '4490.004', 'Ручка перьевая Carandache Varius Ivanhoe SP (4490.004) F перо золото 18K', '{"Тип пера": "открытое", "Материал корпуса": "латунь кольчуга с родиевым напылением", "Вид упаковки": "коробка подарочная", "Материал пера": "золото 18K", "Размер пера": "F", "Колпачок": "завинчивающийся", "Система заправки": "поршневая/картриджи"}'),
	('2021-07-21 17:02:35', '4779.168', 'Ручка роллер Carandache Leman Grand Blue SP (4779.168) F черные чернила', '{"Материал корпуса": "латунь лакированная, прозрачный темно-синий лак, гильоше волны", "Отделка корпуса": "посеребрение с родиевым покрытием", "Колпачок": "завинчивающийся. Торец колпачка оснащен новым идентификатором Caran d’Ache (темно-синий лакированный шестигранник)", "В комплекте": "стержень роллер Carandache (артикул стержня 8228.009) (F) черные чернила 1 шт.", "Вид упаковки": "коробка подарочная"}'),
	('2022-02-28 17:02:35', '4470.017', 'Ручка роллер Carandache Varius Carbon 3000 SP (4470.017) F черные чернила', '{"Материал корпуса": "латунь ювелирная, углеволокно", "Отделка деталей": "посеребрение с родиевым покрытием", "Вид упаковки": "коробка подарочная", "Цвет чернил в стержне": "черный", "Колпачок": "завинчивающийся", "В комплекте": "Стержень роллер Carandache (артикул стержня 8228.009) F"}'),
	('2021-05-19 17:02:35', 'AT0090-7', 'Многофункциональная ручка Cross Tech3+ со стилусом 8 мм (AT0090-7) черная матовая', NULL),
	('2022-03-29 17:02:35', 'AT0706-14MY', 'Перьевая ручка Cross Peerless Translucent Quartz Blue Engraved Lacquer (AT0706-14MY) перо M золото 18К, покрытое платиной', '{"Материал изготовления": "латунь, покрытая лаком синего цвета", "Отделка": "платина. Сверкающий кристалл Swarovski® на коническом торце ручки. Специальное место на колпачке для персонализации.", "Перо": "золото 18К, покрытое платиной", "Толщина пера": "M (средняя)", "Упаковка": "Подарочная коробка Люкс"}')
;

-- вот что получается:
SELECT * FROM goods;


-- если не удалять строки, а просто их скрыть, то можно сделать горизонтальное представление и возвращать в нём последние 5 строчек, отфильтровав строки по created_at 
CREATE OR REPLACE VIEW five_lines AS 
(SELECT * FROM goods ORDER BY created_at DESC LIMIT 5);

-- посмотрим на представление
SELECT * FROM five_lines;


-- а если всё же удалять, то запускаем транзакцию, в которой:

START TRANSACTION;
-- создаём временную пустую копию таблицы goods 
DROP TEMPORARY TABLE IF EXISTS limited;
CREATE TEMPORARY TABLE limited (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	international_article VARCHAR(100) UNIQUE,
	title VARCHAR(250),
	characteristics_goods JSON,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP);
-- заполняем временную копию отсортированными по дате создания пятью записями из основной таблицы goods 
INSERT INTO limited SELECT * FROM goods ORDER BY created_at DESC LIMIT 5;
-- пересоздаём goods, удалив из неё все строки и сбросив счётчик AUTO_INCREMENT 
TRUNCATE goods;
-- заполняем goods данными из временной таблицы копии
INSERT INTO goods SELECT * FROM limited;
-- закрываем транзакцию
COMMIT;

-- смотрим и радуемся - в нашей таблице goods остались только те 5 строк, что нам были нужны
SELECT * FROM goods ORDER BY created_at DESC;
