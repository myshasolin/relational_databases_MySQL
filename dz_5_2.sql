-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
-- значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP DATABASE IF EXISTS solin_dz_5;
CREATE DATABASE solin_dz_5;
USE solin_dz_5;

-- вот таблица, столбцы created_at и updated_at у неё типа VARCHAR. 
-- Заполним её данными и посмотрим на структуру, в которой видно тип столбцов

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at VARCHAR(250),
    updated_at VARCHAR(250)
) COMMENT = 'Покупатели';

INSERT INTO users 
	(id, name, birthday_at, created_at, updated_at)
VALUES 
	(1, 'Паша', '1990-10-05', '20.10.2017 8:10', '20.10.2018 9:10'),
	(2, 'Маша', '1984-11-12', '25.05.2015 21:21', '11.12.2020 14:15'),
	(9, 'Даша', '2006-02-17', '08.07.2006 05:04', '13.12.2011 10:09');

DESCRIBE users;

-- добавлям 2 новых столбца типа DATETIME. Смотрим на структуру обновлённой таблицы, чтоб убедиться, что они есть

ALTER TABLE users 
ADD new_created_at DATETIME DEFAULT NOW(),
ADD new_updated_at DATETIME;

DESCRIBE users;

-- переносим данные из строковых столбцов в новые, отформатировав строку функцией STR_TO_DATE()

UPDATE users 
SET 
	new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

-- удаляем старые строки, а новым даём название удалённых. Смотрим на структуру таблицы и на данные в ней - всё как надо,
-- данные столбцов не изменились

ALTER TABLE users 
DROP created_at,
DROP updated_at,
RENAME COLUMN new_created_at TO created_at,
RENAME COLUMN new_updated_at TO updated_at;

DESCRIBE users;
SELECT * FROM users;

