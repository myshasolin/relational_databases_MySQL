-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

/*
 * выводим id (для наглядности), имя и фамилию отправителя и получателя, считаем в COUNT() отправителей, группируем по COUNT(отправителям), 
 * сортируем вывод от бОльшего к меньшему, оставляем только верхнюю строчку
 */

SELECT 
	CONCAT(u1.id, ') ', u1.firstname, ' ', u1.lastname) AS 'кому',
	COUNT(m.from_user_id) AS 'кол-во сообщений',
	CONCAT(u2.id, ') ', u2.firstname, ' ', u2.lastname) AS 'от кого'
FROM messages AS m 
JOIN users AS u1 ON u1.id = m.to_user_id
JOIN users AS u2 ON u2.id = m.from_user_id
WHERE m.to_user_id = 1
GROUP BY m.from_user_id
ORDER BY COUNT(m.from_user_id) DESC
LIMIT 1;

