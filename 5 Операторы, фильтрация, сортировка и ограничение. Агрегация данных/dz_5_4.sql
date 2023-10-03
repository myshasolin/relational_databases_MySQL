-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')

DROP DATABASE IF EXISTS solin_dz_5;
CREATE DATABASE solin_dz_5;
USE solin_dz_5;

-- вот таблица с пользователями, ДР у них записана с месяцами

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at VARCHAR (100) COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
) COMMENT = 'Покупатели';

INSERT INTO users 
	(id, name, birthday_at)
VALUES 
	(1, 'Паша', '1990 october 05'),
	(2, 'Маша', '1984 november 12'),
	(3, 'Глаша', '1985 may 20'),
	(4, 'Неваляша', '1988 february 14'),
	(5, 'Иваша', '1998 january 12'),
	(6, 'Наташа', '2006 august 29'),
	(7, 'Аркаша', '1988 february 04'),
	(8, 'Нюша', '1998 march 20'),
	(9, 'Горбуша (фантазия кончилась))', '2006 april 17');

-- решение с помощью оператора LIKE
SELECT name, birthday_at FROM users WHERE (birthday_at LIKE '%may%' OR birthday_at LIKE '%august%');

-- решение при помощи составления регулярного выражения с логическим ИЛИ
SELECT name, birthday_at FROM users WHERE birthday_at RLIKE '^[0-9]{4} (august|may) [0-9]{2}';


-- вчитался в текст задания, а ведь там речь шла о списке английских названий... Поэтому третий вариант рещения - выборка 
-- месяца из списка ENUM(), для этого переопределяем столцец, а выборку в SELECT делаем через WHERE

TRUNCATE users;

ALTER TABLE users 
MODIFY
	birthday_at ENUM ('january', 'february', 'march', 'april', 'may', 'june', 'July', 'august', 
					  'september', 'october', 'november', 'december');

INSERT INTO users
	(id, name, birthday_at)
VALUES 
	(1, 'Паша', 'october'),
	(2, 'Маша', 'november'),
	(3, 'Глаша', 'may'),
	(4, 'Неваляша', 'february'),
	(5, 'Иваша', 'january'),
	(6, 'Наташа', 'august'),
	(7, 'Аркаша', 'february'),
	(8, 'Нюша', 'march'),
	(9, 'Горбуша (фантазия кончилась))', 'april');

SELECT name , birthday_at FROM users WHERE birthday_at = 'august' OR birthday_at = 'may';

