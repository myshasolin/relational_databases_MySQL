-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

DROP DATABASE IF EXISTS lesson_9_sample;
CREATE DATABASE lesson_9_sample;
USE lesson_9_sample;

-- создадим точно такую же таблицу, как в БД shop, только пустую
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
) COMMENT = 'Покупатели';

-- убедимся, что никого-то там у нас нет
SELECT * FROM lesson_9_sample.users;

-- А теперь, используя транзакцию, переместим запись
START TRANSACTION;
INSERT INTO lesson_9_sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE users.id = 1;
COMMIT;

-- вот он наш Геннадий, кратота
SELECT * FROM lesson_9_sample.users;

-- ну а в исходной таблице его не осталось
SELECT * FROM shop.users;


# TRUNCATE users; 

