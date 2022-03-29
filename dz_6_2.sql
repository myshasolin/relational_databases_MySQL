-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..


-- вот так можно найти id пользователей, которым < 10 лет, там у нас даже трёхлетние вундеркинды нашлись
SELECT user_id, birthday, TIMESTAMPDIFF(YEAR, birthday, NOW()) age 
	 FROM profiles 
	 WHERE (TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);
	
	
-- добавим в таблицу лайков немного лайков от этих пользователей (а то там сейчас всего один лайк на самом деле)
INSERT INTO likes (user_id, media_id) VALUES (17, 9), (45, 20), (57, 9), (63, 9), (78, 20), (85, 9);


-- и теперь вот так можно посчитать лайки от малявок, добавив подзапрос в WHERE
SELECT 
	COUNT(*) AS number_of_likes
FROM likes
WHERE user_id IN 
	(SELECT user_id 
	 FROM profiles 
	 WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);
	
	
-- можно посмотреть кто что лайкнул, добавив вместо COUNT() два других подзапроса (имя пользователя и название файла)	
SELECT 
 	(SELECT CONCAT(firstname, ' ', lastname) FROM users WHERE user_id = users.id) кто,
 	(SELECT filename FROM media WHERE likes.media_id = media.id) 'название файла'
FROM likes
WHERE user_id IN 
	(SELECT user_id 
	 FROM profiles 
	 WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);
	

-- и ещё проверка - если мы добавим в таблицу лайков лайков от тех, кому > 10-ти лет, то в наш подсчёт они попадать не будут, что логично.
-- добавим ещё строк	
	
INSERT INTO likes (user_id, media_id) VALUES (1, 9), (2, 20), (1, 9), (2, 9), (1, 20), (2, 9);

-- и убедимся, что количество лайков от пользователей < 10-ти лет не увеличилось

SELECT 
	COUNT(*) AS number_of_likes
FROM likes
WHERE user_id IN 
	(SELECT user_id 
	 FROM profiles 
	 WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

