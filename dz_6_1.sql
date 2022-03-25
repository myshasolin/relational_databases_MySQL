-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

/*
 * выводим id (для наглядности), имя и фамилию отправителя и получателя, считаем в COUNT() отправителей, группируем по COUNT(отправителям), 
 * сортируем вывод от бОльшего к меньшему, оставляем только верхнюю строчку
 */

SELECT 
	(SELECT CONCAT(u.id, ') ', u.firstname, ' ', u.lastname) FROM users u WHERE u.id = m.to_user_id) AS 'кому',
	COUNT(from_user_id) AS 'кол-во сообщений', 
	(SELECT CONCAT(u.id, ') ', u.firstname, ' ', u.lastname) FROM users u WHERE u.id = m.from_user_id) AS 'от кого'
FROM messages m 
WHERE to_user_id = 1 
GROUP BY from_user_id
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;

