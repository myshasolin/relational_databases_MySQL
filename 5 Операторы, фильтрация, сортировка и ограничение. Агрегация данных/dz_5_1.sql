-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

DROP DATABASE IF EXISTS solin_dz_5;
CREATE DATABASE solin_dz_5;
USE solin_dz_5;

-- вот скрипт формирования таблицы, в котором поля created_at и updated_at по умолчанию не заданы, а значит они будут NULL

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

-- заполним таблицу данными

INSERT INTO users 
	(id, name, birthday_at)
VALUES 
	(1, 'Первый', '1990-10-05'),
	(2, 'Второй', '1984-11-12'),
	(3, 'Третий', '1985-05-20'),
	(4, 'Четвёртый', '1988-02-14'),
	(5, 'Пятый', '1998-01-12'),
	(6, 'Шестой', '2006-08-29'),
	(7, 'Седьмой', '1988-02-04'),
	(8, 'Восьмой', '1998-03-20'),
	(9, 'Девятый', '2006-02-17');

-- можем глянуть на них и убедиться, что они NULL

SELECT * FROM users;

-- исправим ситуацию - подставим в created_at и updated_at текущие дату и время

UPDATE users
SET
	created_at = NOW(),
	updated_at = NOW();

-- убедимся в том, что всё получилось

SELECT id, name, birthday_at, created_at , updated_at FROM users;

