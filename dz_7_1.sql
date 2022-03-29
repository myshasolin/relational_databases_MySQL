-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

# USE lesson_7;

-- решение с помощью вложенного запроса
SELECT id, name FROM users WHERE id IN (SELECT user_id FROM orders);

-- решение с помощью JOIN
SELECT users.id, users.name AS имя, COUNT(users.name) AS 'кол-во заказов' 
FROM users JOIN orders 
ON users.id = orders.user_id 
GROUP BY user_id;

-- для проверки:
SELECT * FROM orders;

