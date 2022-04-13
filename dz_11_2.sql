-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

USE shop;

-- сейчас у нас там вот сколько имён:
SELECT COUNT(*) FROM users;

-- создадим процедуру, которая в цикле LOOP будет заполнять таблицу users количеством строк, которое мы в неё передадим
-- др будет прибавлять к дате 1 день
-- а к имени будем прибавлять единицу

DELIMITER //

DROP PROCEDURE IF EXISTS autocomplete_users//
CREATE PROCEDURE autocomplete_users (num BIGINT)
BEGIN
	DECLARE birthday DATE DEFAULT '2000-01-01';
	DECLARE n BIGINT DEFAULT 1;
	DECLARE i BIGINT DEFAULT num - n;
	cycl: LOOP
		INSERT INTO users 
			(name, birthday_at)
		VALUES 
			(CONCAT('name ', n), birthday);
		SET birthday = birthday + INTERVAL 1 DAY;
		SET i = i - 1;
		SET n = n + 1;
		IF i < 0 THEN
			LEAVE cycl;
		END IF;
	END LOOP cycl;
END//

DELIMITER ;

-- добавим строчек (и миллион, конечно, можно, но это очень долго. Для примера можно попробовать добавить 100 строчек)
CALL autocomplete_users(100);


-- вот можем посмотреть на них
SELECT * FROM users;

-- а вот можем посчитать их
SELECT COUNT(*) FROM users;

