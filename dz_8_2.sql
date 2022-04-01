-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..


-- вот так можно найти id пользователей, которым < 10 лет, там у нас даже трёхлетние вундеркинды нашлись
SELECT user_id, birthday, TIMESTAMPDIFF(YEAR, birthday, NOW()) age 
FROM profiles 
WHERE (TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

	
-- добавим в таблицу лайков немного лайков от этих пользователей (а то там сейчас всего один лайк на самом деле)
INSERT INTO likes (user_id, media_id) 
VALUES 
	(17, 9), (45, 20), (57, 9), (63, 9), (78, 20), (85, 9);


-- и теперь вот так можно посчитать лайки от малявок

SELECT COUNT(*) AS number_of_likes FROM likes AS l 
JOIN users AS u ON u.id = l.user_id 
JOIN profiles AS p ON u.id = p.user_id 
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10;
	
	
-- можно посмотреть кто что лайкнул
-- присоединяем к таблице лайков таблицы пользователей и профилей + название файла, что лежит в таблице медиа и всё это по условию, что возраст меньше 10-ти годочков
SELECT 
	CONCAT(u.firstname, ' ', u.lastname) AS кто,
	m.filename AS 'название файла'
FROM likes AS l
JOIN users AS u ON l.user_id = u.id 
JOIN profiles AS p ON p.user_id = u.id
JOIN media AS m ON l.media_id = m.id 
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10;


-- и ещё проверка - если мы добавим в таблицу лайков лайков от тех, кому > 10-ти лет, то в наш подсчёт они попадать не будут, что логично.
-- добавим ещё строк	
	
INSERT INTO likes (user_id, media_id) 
VALUES 
	(1, 9), (2, 20), (1, 9), (2, 9), (1, 20), (2, 9);

-- и убедимся, что количество лайков от пользователей < 10-ти лет не увеличилось

SELECT COUNT(*) AS number_of_likes FROM likes AS l 
JOIN users AS u ON u.id = l.user_id 
JOIN profiles AS p ON u.id = p.user_id 
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10;
