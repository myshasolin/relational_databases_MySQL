-- Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

# создаём БД example
CREATE DATABASE IF NOT EXISTS example;
# смотрим список БД и убеждаемся, что наша в нём есть
SHOW DATABASES;
# переходим в неё
USE example;
# создаём таблицу users с двумя столбцами:
# 1) id SERIAL (из видеоурока: SERIAL=BIGIT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE, т.е. тип BIGIT с доп.атрибутами) PRIMARY KEY (первичный ключ)
# 2) name VARCHAR(50) (из видеоурока: VARCHAR - тип нефиксированного размера, но не более 65536 байт) NOT NULL (не пустой тип) UNIQUE (ограничение уникальности)
DROP TABLE IF EXISTS users;
CREATE TABLE users (id SERIAL PRIMARY KEY, NAME VARCHAR(50) NOT NULL UNIQUE);
# смотрим список таблиц
SHOW TABLES;
# ну и саму таблицу тоже смотрим
SELECT * FROM users; 


/*Ну и результат выполнения в терминале выглядит так:

mysql> \. dz_2_2.sql
Query OK, 1 row affected, 1 warning (0.01 sec)

+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.01 sec)

Database changed
Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

+-------------------+
| Tables_in_example |
+-------------------+
| users             |
+-------------------+
1 row in set (0.00 sec)

Empty set (0.00 sec)

mysql> \q
Bye
*/