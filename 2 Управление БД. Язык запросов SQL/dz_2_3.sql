-- Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

/*
	# это задание делал в cmd Windows
	# идём в mysql 

C:\Users\Mysha\Desktop\GB\Основное обучение\Основы реляционных баз данных MySQL\lesson_2\дз>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 29
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

	# и создаём БД sample 

mysql> CREATE DATABASE IF NOT EXISTS sample;
Query OK, 1 row affected (0.01 sec)

	# убеждаемся, что она появилась в спике и выходим их mysql 

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sample             |
| sys                |
| world              |
+--------------------+
8 rows in set (0.01 sec)

mysql> \q
Bye

	# из терминала создаём дамп БД example в файл example.sql

C:\Users\Mysha\Desktop\GB\Основное обучение\Основы реляционных баз данных MySQL\lesson_2\дз>mysqldump example > example.sql

	# проверяем список файлов и убеждаемся, что дамп там есть

C:\Users\Mysha\Desktop\GB\Основное обучение\Основы реляционных баз данных MySQL\lesson_2\дз>dir example*
 Том в устройстве C имеет метку Acer
 Серийный номер тома: 28C5-523F

 Содержимое папки C:\Users\Mysha\Desktop\GB\Основное обучение\Основы реляционных баз данных MySQL\lesson_2\дз

17.02.2022  03:23             1 968 example.sql
               1 файлов          1 968 байт
               0 папок  86 318 284 800 байт свободно
               
	# загружаем дамп в БД sample
               
C:\Users\Mysha\Desktop\GB\Основное обучение\Основы реляционных баз данных MySQL\lesson_2\дз>mysql sample < example.sql

	# ну и финальное - идём сразу в ДБ sample:
               
C:\Users\Mysha\Desktop\GB\Основное обучение\Основы реляционных баз данных MySQL\lesson_2\дз>mysql sample
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 32
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

	# и ищем там табицу users. Она там есть, а значит содержимое дампа успешно перенесено в новую БД

mysql> DESCRIBE users\G
*************************** 1. row ***************************
  Field: id
   Type: bigint unsigned
   Null: NO
    Key: PRI
Default: NULL
  Extra: auto_increment
*************************** 2. row ***************************
  Field: name
   Type: varchar(50)
   Null: NO
    Key: UNI
Default: NULL
  Extra:
2 rows in set (0.03 sec)
               
*/

               