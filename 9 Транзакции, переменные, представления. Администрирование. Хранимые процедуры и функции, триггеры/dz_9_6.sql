-- (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбцам id и name. Создайте пользователя user_read, который бы не имел 
-- доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

CREATE DATABASE IF NOT EXISTS lesson_9_sample;
USE lesson_9_sample;

-- создаём таблицу и заполняем её данными
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(200),
	password_hash VARCHAR(256)
);

INSERT INTO accounts 
	(id, name, password_hash)
VALUES 
	(1, 'Геннадий', '618dcdfb0cd9ae4481164961c4796dd8e3930c8d'),
	(2, 'Наталья', '6a0129d59aa4967c0627c4c0803ae1a9a49f6ddd'),
	(3, 'Александр', '3e20f31d5c665db6489ee25bdbbb6f0e7c66752d'),
	(4, 'Сергей', 'db1e933668f79538b1d5237bd4e4cc68dcf5598b'),
	(5, 'Иван', '1119cfd37ee247357e034a08d844eea25f6fd20f'),
	(6, 'Мария', '8a971eb7c079bd04b40b17049dc99a2c2155769a'),
	(7, 'Светлана', '04bbd491d4e945871fe5eb2a6e6240ba7ea77f1c'),
	(8, 'Олег', '233453b83d32b577fa4029e6427351934e817ff5'),
	(9, 'Юлия', 'f4f6075660f96a4ea9b7338418df2016c82155b4');

-- можем посмотреть:
SELECT * FROM accounts;

-- создаём представление
CREATE OR REPLACE VIEW username AS SELECT id, name FROM accounts;

-- посмотрим и на него
SELECT * FROM username;

-- создаём пользателя user_read с правамитолько на просмотр педставления username
CREATE USER 'shop_read'@'localhost' IDENTIFIED BY 'tratatatata';
GRANT SELECT ON lesson_9.username  TO 'shop_read'@'localhost';
FLUSH PRIVILEGES;
-- посмотрим на его права:
SHOW GRANTS FOR 'shop_read'@'localhost';


-- зайдём в mysql с терминала под пользователем shop_read 
/*
myshasolin@ubuntu-VB:~$ mysql -u shop_read -p
Enter password:

mysql> USE lesson_9
*/

-- проверяем - представление открывается, а вот таблица нет. Её и в списке таблиц для пользователя shop_read нет
/*
mysql> SELECT * FROM username ORDER BY name;
+----+--------------------+
| id | name               |
+----+--------------------+
|  3 | Александр          |
|  1 | Геннадий           |
|  5 | Иван               |
|  6 | Мария              |
|  2 | Наталья            |
|  8 | Олег               |
|  7 | Светлана           |
|  4 | Сергей             |
|  9 | Юлия               |
+----+--------------------+
9 rows in set (0,00 sec)

mysql> SELECT * FROM accounts;
ERROR 1142 (42000): SELECT command denied to user 'shop_read'@'localhost' for table 'accounts'

mysql> SHOW TABLES;
+--------------------+
| Tables_in_lesson_9 |
+--------------------+
| username           |
+--------------------+
1 row in set (0,00 sec)
*/

-- наш пользователь и на другие базы смотреть не может:
/*
mysql> SHOW TABLES FROM shop;
ERROR 1044 (42000): Access denied for user 'shop_read'@'localhost' to database 'shop'
*/


-- удалим shop_read
DROP USER IF EXISTS 'shop_read'@'localhost';

