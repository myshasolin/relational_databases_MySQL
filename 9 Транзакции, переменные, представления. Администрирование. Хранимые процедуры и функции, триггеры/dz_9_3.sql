-- по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за 
-- август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, 
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

USE lesson_9_sample;


-- создаём таблицу
DROP TEMPORARY TABLE IF EXISTS calendar;
CREATE TEMPORARY TABLE calendar (
	id SERIAL,
	created_at DATE
);

-- заполняем таблицу
INSERT INTO calendar (created_at) VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

-- создаём таблицу на 31 строку
DROP TEMPORARY TABLE IF EXISTS temp;
CREATE TEMPORARY TABLE temp (
	id SERIAL,
	numbers BIT 
);

-- заполняем её
INSERT INTO temp (numbers) VALUES (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0);

-- создаём переменную со стартовой датой
SET @param := '2018-07-31';

-- выводим переменную, прибавляя по дню количество раз, равное строкам в таблице temp (31 строка)
-- если переменная равна столбцу с заданной датой из таблицы calendar, определяем её как 1, в остальных случаях как 0
-- и прибавляем 0 или 1 к одному из 31-ти нулей нашей таблицы temp
SELECT 
	@param := @param + INTERVAL 1 DAY AS `data`,
	CASE created_at
		WHEN '2018-08-01' THEN 1
		WHEN '2018-08-04' THEN 1
		WHEN '2018-08-16' THEN 1
		WHEN '2018-08-17' THEN 1
		ELSE 0
	END + numbers AS mark 
FROM temp
LEFT JOIN calendar ON created_at = @param + INTERVAL 1 DAY;


