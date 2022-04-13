-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

-- погуглил я и понял, что вроде как искать значение можно только по ключу, и никак наоборот
-- получается задача схожая по логике словарей Python,

-- а значит создадим два хэша: 
-- 1) Первый назовём "users" и в нём "имя" это будет ключ, 
-- 2) а во втором с названием "email" в качестве ключа выступает "почта"

-- заполняем их данными 
127.0.0.1:6379> hset users user_1 lyalya@mail.con
(integer) 1
127.0.0.1:6379> hset users user_2 topolya@mail.con
(integer) 1
127.0.0.1:6379> hset users user_3 trulyalya@mail.con
(integer) 1
127.0.0.1:6379> hset email lyalya@mail.con user_1
(integer) 1
127.0.0.1:6379> hset email topolya@mail.con user_2
(integer) 1
127.0.0.1:6379> hset email trulyalya@mail.con user_3
(integer) 1

-- с помощью hgetall смотрим на первый хэш
127.0.0.1:6379> hgetall users
1) "user_1"
2) "lyalya@mail.con"
3) "user_2"
4) "topolya@mail.con"
5) "user_3"
6) "trulyalya@mail.con"

-- и на второй посмотрим тоже:
127.0.0.1:6379> hgetall email
1) "lyalya@mail.con"
2) "user_1"
3) "topolya@mail.con"
4) "user_2"
5) "trulyalya@mail.con"
6) "user_3"

-- ну и с помощью кострукции "hget имя_хэша название_ключа" мы можем возвращать значение, хрянящееся с этим ключом
-- сделаем это для хэша "users" 
127.0.0.1:6379> hget users user_2
"topolya@mail.con"

-- и для хэша "email" сделаем тоже:
127.0.0.1:6379> hget email trulyalya@mail.con
"user_3"

