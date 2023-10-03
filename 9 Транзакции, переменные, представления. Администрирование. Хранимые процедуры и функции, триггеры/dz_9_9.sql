-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

CREATE DATABASE IF NOT EXISTS lesson_9_sample;
USE lesson_9_sample;

-- функция принимает произвольное число и рекурсивно в цикле WHILE подсчитывает в результирующий вывод число Фибоначчи

DELIMITER //

DROP FUNCTION IF EXISTS FIBONACCI//
CREATE FUNCTION FIBONACCI (param INT)
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE `result`, buf, frst INT DEFAULT 0;
	DECLARE sec INT DEFAULT 1;
	DECLARE n INT DEFAULT param;
	IF n < 2 THEN
		RETURN n;
	ELSE
		WHILE (n - 1) != 0 DO
			SET buf = frst;
			SET frst = sec;
			SET sec = buf + sec;
			SET `result` = sec;
			SET n = n - 1;
		END WHILE;
	RETURN `result`;
	END IF;
END//

-- можно проверить, подставив в вызов любое число - работает

-- SELECT FIBONACCI(10) AS "число Фибоначчи";

