-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

DROP DATABASE IF EXISTS solin_dz_5;
CREATE DATABASE solin_dz_5;
USE solin_dz_5;

-- создаём и заполняет таблицу

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT IGNORE INTO catalogs VALUES 
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Материнские платы'),
    (DEFAULT, 'Видеокарты'),
    (DEFAULT, 'Блоки питания'),
    (DEFAULT, 'Звуковые карты'),
    (DEFAULT, 'Сетевые адапторы'),
    (DEFAULT, 'Оптические приводы'),
    (DEFAULT, 'Контроллеры'),
    (DEFAULT, 'Модули памяти');

   
-- первый способ, из видеоурока. Если требуется проверить несколько условий, используем выражение CASE
SELECT * FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY CASE 
	WHEN id = 5 THEN 1
	WHEN id = 1 THEN 2
	WHEN id = 2 THEN 3
END;

-- второй спосой из интернета (который, о чудо, нам ещё не перекрыли) - при помощи функции FIELD(), которая возвращает индексную позицию значения
SELECT * FROM catalogs 
WHERE id IN (5, 1, 2) 
ORDER BY FIELD(id, 5, 1, 2);

