-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился 
-- и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились 
-- в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

DROP DATABASE IF EXISTS solin_dz_5;
CREATE DATABASE solin_dz_5;
USE solin_dz_5;

-- формируем таблицу с товарами

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL (11,2) COMMENT 'Цена',
    value INT UNSIGNED NOT NULL,
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO storehouses_products  
	(name, description, price, value, catalog_id)
VALUES 
	('Intel Core i3-8100', 'Процессор для настольных персональный компьютеров, основанных на платформе Intel.', 7890.00, 0, 1),
	('Intel Core i5-7400', 'Процессор для настольных персональный компьютеров, основанных на платформе Intel.', 12700.00, 2500, 1),
	('AMD FX-8320E', 'Процессор для настольных персональный компьютеров, основанных на платформе AMD.', 4780.00, 0, 1),
	('AMD FX-8320', 'Процессор для настольных персональный компьютеров, основанных на платформе AMD.', 7120.00, 30, 1),
	('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 500, 2),
	('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 1, 2),
	('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 750, 2);

-- отфильтруем вывод по количеству при помощи ORDER BY, оставив 0 в конце таблицы

SELECT name, value FROM storehouses_products ORDER BY value = 0, value;

