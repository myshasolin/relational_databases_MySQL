-- Выведите список товаров products и разделов catalogs, который соответствует товару.

# USE lesson_7;

-- если не ставить условие WHERE, то выведутся все товары и соответствующие им каталоги

SELECT 
	products.name, 
	catalogs.name AS catalogs
FROM catalogs JOIN products 
ON products.catalog_id  = catalogs.id;

-- а с помощью LEFT JOIN мы можем увидеть также пустые разделы каталога, товаров в которых не оказалось

SELECT 
	products.name, 
	catalogs.name AS catalogs
FROM catalogs LEFT JOIN products 
ON products.catalog_id  = catalogs.id;


-- а так поищем товар по подстроке названия:

-- решение с помощью вложенного запроса
SELECT 
	name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS catalogs
FROM products
WHERE name LIKE '%FX%';

-- решение с помощью JOIN
SELECT 
	products.name, 
	catalogs.name AS catalogs
FROM catalogs JOIN products 
ON products.catalog_id  = catalogs.id 
WHERE products.name LIKE '%H3%';



