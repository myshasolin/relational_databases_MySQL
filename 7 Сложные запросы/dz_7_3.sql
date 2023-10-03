-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL,
	`from` VARCHAR(100),
	`to` VARCHAR(100)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(100),
	name VARCHAR(100)
);

INSERT INTO flights (`from`, `to`) VALUES 
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

INSERT INTO cities VALUES 
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');


SELECT 
	id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM flights
ORDER BY id;
