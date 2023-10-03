-- Создайте представление, которое выводит название name товарной позиции из таблицы 
-- products и соответствующее название каталога name из таблицы catalogs.

USE shop;

-- создаём представление

CREATE OR REPLACE VIEW products_catalogs AS
SELECT p.name AS 'name products', c.name AS 'name catalogs' 
FROM products p 
RIGHT JOIN catalogs c ON c.id = p.catalog_id;

-- вот оно в списке таблиц
SHOW FULL TABLES;

-- посмотрим:
SELECT * FROM products_catalogs;

-- ну и удалить можно, если что
DROP VIEW IF EXISTS products_catalogs;

