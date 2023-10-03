-- Определить кто больше поставил лайков (всего): мужчины или женщины.


-- выводим пол из таблицы profiles, группируем вывод по полу, подсчитывая количество строк для каждого
-- группируем результат по убыванию и выводим только верхнюю строчку - этот пол больше лайков и поставил

SELECT
	(SELECT 
		CASE (p.gender)
			WHEN 'm' THEN 'монсеньёры'
			ELSE 'мадамы'
		END
	FROM profiles p 
	WHERE p.user_id = l.user_id) AS пол,
	COUNT(l.id) AS лайков
FROM likes l
GROUP BY пол
ORDER BY лайков DESC
LIMIT 1;

