-- (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. 
-- Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

/*
	# это задание делал в терминале Ubuntu и в dBeaver (та часть, где про копирование)
	# заходим в mysql и создаём БД lesson_2

myshasolin@ubuntu-VB:~$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 20
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE IF NOT EXISTS lesson_2;
Query OK, 1 row affected (0,01 sec)

	# посчитаем количество строк всего в таблице help_keyword БД mysql с помощью метода COUNT

mysql> SELECT COUNT(*) FROM mysql.help_keyword;
+----------+
| COUNT(*) |
+----------+
|      984 |
+----------+
1 row in set (0,00 sec)

mysql> \q
Bye

	# теперь делаем дамп этой таблицы, но только 100 строк

mysqldump mysql help_keyword --where='TRUE LIMIT 100' > help_keyword_dump.sql 

	# а вот загрузить его у меня не получается, потому как ERROR 3723 (HY000): The table 'help_clon' may not be created in the reserved tablespace 'mysql'.
	# зато получается просто скопировать 100 строк без дампа, вот так:

DROP TABLE IF EXISTS keyword;
CREATE TABLE keyword (SELECT * FROM mysql.help_keyword LIMIT 100);

SELECT * FROM lesson_2.keyword;

SELECT COUNT(*) FROM lesson_2.keyword;

	# проверим в терминале:
	
mysql> SELECT COUNT(*) FROM lesson_2.keyword;
+----------+
| COUNT(*) |
+----------+
|      100 |
+----------+
1 row in set (0,00 sec)

	
*/

