-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

USE shop;


-- создаём таблицу
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id SERIAL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания записи', 
	name_tables CHAR(200) COMMENT 'название таблицы', 
	id_primary_key BIGINT COMMENT 'идентификатор первичного ключа',
	field_content VARCHAR(255) COMMENT 'содержимое поля name'
) COMMENT 'таблица логов' ENGINE=Archive;


-- список таблиц и там наша новая
SHOW TABLES;

-- вот так можем посмотреть движок у таблицы logs
SHOW TABLE STATUS LIKE 'logs';


-- а теперь создаём 3 триггера на автозаполнение таблицы logs
DELIMITER //

DROP TRIGGER IF EXISTS filling_the_log_table_from_users//
CREATE TRIGGER filling_the_log_table_from_users AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
		(name_tables, id_primary_key, field_content)
	VALUES
		('users', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS filling_the_log_table_from_catalogs//
CREATE TRIGGER filling_the_log_table_from_catalogs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
		(name_tables, id_primary_key, field_content)
	VALUES
		('catalogs', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS filling_the_log_table_from_products//
CREATE TRIGGER filling_the_log_table_from_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
		(name_tables, id_primary_key, field_content)
	VALUES
		('products', NEW.id, NEW.name);
END//

DELIMITER ;


-- заполним таблицы новыми данными, по 2 строчки на каждую для чистоты эксперимента
INSERT INTO users 
	(name, birthday_at)
VALUES
	('Первый Новый Пользователь', '1999-10-11'),
	('Второй Новый Пользователь', '2009-11-10')
;

INSERT INTO catalogs (name) VALUES
	('SSD накопители'),
	('Устройства расширения')
;

INSERT INTO products 
	(name, description, price, catalog_id)
VALUES 
	('LG GH24NSD5', 'Привод DVD-RW LG GH24NSD5, DVD+R 24x, DVD-R 8x, DVD+RW 8x, DVD+R DL 8x, DVD-RW 6x, DVD-RAM 5x, DVD-R DL 8x', 1229.00, 7),
	('Apacer AS340 PANTHER', '120 ГБ 2.5" SATA накопитель Apacer AS340 PANTHER [AP120GAS340G-1]', 2299.00, 6)
;


-- можем посмотреть на таблицы
SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products;


-- а вот что записалось в таблицу logs
SELECT * FROM logs ORDER BY created_at DESC;

