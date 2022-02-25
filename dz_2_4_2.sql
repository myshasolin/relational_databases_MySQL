-- (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. 
-- Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

# второй вариант - клоном

/*

	# создаём копию таблицы help_keyword, назовём её help_clon

mysql> CREATE TABLE help_clon SELECT * FROM mysql.help_keyword;
Query OK, 984 rows affected (0,09 sec)
Records: 984  Duplicates: 0  Warnings: 0

	# считаем в ней строки, их как и положено 984

mysql> SELECT COUNT(*) FROM help_clon;
+----------+
| COUNT(*) |
+----------+
|      984 |
+----------+
1 row in set (0,00 sec)

mysql> \q
Bye

	# создаём дамп по help_clon, назовём его help_keyword_dump_2.sql и в нём будет 100 строк

myshasolin@ubuntu-VB:~$ mysqldump lesson_2 help_clon --where='TRUE LIMIT 100' > help_keyword_dump_2.sql

	# загружаем дамп обратно в БД

myshasolin@ubuntu-VB:~$ mysql lesson_2 < help_keyword_dump_2.sql

	# заходим в БД lesson_2 и считаем количество строк в таблице help_clon. Их теперь ровно 100, а значит всё прошло успешно

myshasolin@ubuntu-VB:~$ mysql lesson_2 
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 55
Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


mysql> SELECT COUNT(*) FROM help_clon;
+----------+
| COUNT(*) |
+----------+
|      100 |
+----------+
1 row in set (0,00 sec)

*/


