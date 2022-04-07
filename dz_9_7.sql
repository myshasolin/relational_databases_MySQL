-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

CREATE DATABASE IF NOT EXISTS lesson_9_sample;
USE lesson_9_sample;

-- Создаём функцию hello(), принимающую один аргумент типа TIME. Функция через ветвление IF возвращает текст в соответствии с переданным 
-- в неё временем, если переданный аргумент находтится в подходящем диапазоне (BETWEEN)

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello (param TIME)
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
	IF (param BETWEEN '06:00:00' AND '12:00:00') THEN
		RETURN 'Доброе утро';
	ELSEIF (param BETWEEN '12:00:01' AND '18:00:00') THEN
		RETURN 'Добрый день';
	ELSEIF (param BETWEEN '18:00:01' AND '24:00:00') THEN
		RETURN 'Добрый вечер';
	ELSE
		RETURN 'Доброй ночи';
	END IF;
END//

-- а вот здесь можнм проверить, в т.ч. передав в функцию текущее время функцией CURTIME():

-- SELECT hello('06:00:00');
-- 
-- SELECT hello('12:00:01');
-- 
-- SELECT hello('18:00:01');
-- 
-- SELECT hello('24:00:01');
-- 
-- SELECT hello(CURTIME());

