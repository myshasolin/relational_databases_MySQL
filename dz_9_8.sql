-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;

-- создаём два триггера, на операции обновления и вставки, в которых в IF-условии следим за полями name и description
-- если оба этих поля принимают значение NULL, генерируем ошибку и выводим её текст, мол, нельзя так делать

DELIMITER //

DROP TRIGGER IF EXISTS filling_check_update//
CREATE TRIGGER filling_check_update BEFORE UPDATE ON shop.products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'одно из полей должно быть заполнено!';
	END IF;
END//

DROP TRIGGER IF EXISTS filling_check_insert//
CREATE TRIGGER filling_check_insert BEFORE INSERT ON shop.products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'одно из полей должно быть заполнено!';
	END IF;
END//




-- так можно проверить - при обновлении одного из полей NULL делается, а вот оба уже нет

-- UPDATE products 
-- SET description = NULL 
-- WHERE id = 2;
-- 
-- UPDATE products 
-- SET name = NULL
-- WHERE id = 2;

-- и при добавлении нового товара оба этих поля оставить NULL не получится

-- INSERT INTO products (name, description, price, catalog_id) 
-- VALUES
-- 	(NULL, NULL, 15000, 2);

