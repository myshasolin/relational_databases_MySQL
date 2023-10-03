-- Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop — любые операции в пределах базы данных shop.


-- посмотрим всех пользователей
SELECT `user`, host FROM mysql.`user`;
-- посмотрим политику паролей
SHOW GLOBAL VARIABLES LIKE 'validate_password%';
-- поменяем политику паролей на "полегче", дабы не заморачиваться - с MEDIUM на LOW
SET GLOBAL validate_password.policy=LOW;

-- создаём пользателя shop_read с его правами
CREATE USER IF NOT EXISTS 'shop_read'@'localhost' IDENTIFIED BY 'password';
GRANT USAGE, SELECT ON shop.* TO 'shop_read'@'localhost';
-- посмотрим на его права:
SHOW GRANTS FOR 'shop_read'@'localhost';

-- создаём второго пользователя, у которого в этой БД будут все права доступа
CREATE USER IF NOT EXISTS 'shop'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON shop.* TO 'shop'@'localhost';
-- а вот его права:
SHOW GRANTS FOR 'shop'@'localhost';

-- активируем
FLUSH PRIVILEGES;

-- теперь в терминале зайдём под shop_read - читать можем, удалять не можем:
/*
myshasolin@ubuntu-VB:~$ mysql -u shop_read -p
Enter password: 

mysql> USE shop

mysql> SELECT * FROM users WHERE id = 2;
+----+----------------+-------------+---------------------+---------------------+
| id | name           | birthday_at | created_at          | updated_at          |
+----+----------------+-------------+---------------------+---------------------+
|  2 | Наталья        | 1984-11-12  | 2022-03-19 01:14:53 | 2022-03-19 01:14:53 |
+----+----------------+-------------+---------------------+---------------------+
1 row in set (0,01 sec)

mysql> DELETE FROM users WHERE id = 2;
ERROR 1142 (42000): DELETE command denied to user 'shop_read'@'localhost' for table 'users'
*/


-- и проделаем те же процедуры под shop, всё получится, но вот в другую БД пользователь shop не зайдёт:
/*
myshasolin@ubuntu-VB:~$ mysql -u shop -p
Enter password: 

mysql> USE shop

mysql> SELECT * FROM users WHERE id = 2;
+----+----------------+-------------+---------------------+---------------------+
| id | name           | birthday_at | created_at          | updated_at          |
+----+----------------+-------------+---------------------+---------------------+
|  2 | Наталья        | 1984-11-12  | 2022-03-19 01:14:53 | 2022-03-19 01:14:53 |
+----+----------------+-------------+---------------------+---------------------+
1 row in set (0,01 sec)

mysql> DELETE FROM users WHERE id = 2;
Query OK, 1 row affected (0,03 sec)

mysql> USE lesson_9
ERROR 1044 (42000): Access denied for user 'shop'@'localhost' to database 'lesson_9'
*/

-- удалим пользователей и убедимся, что удалили + вернём на место политику паролей
DROP USER IF EXISTS 'shop_read'@'localhost';
DROP USER IF EXISTS 'shop'@'localhost';
SELECT `user`, host FROM mysql.`user`;

SET GLOBAL validate_password.policy=MEDIUM;

