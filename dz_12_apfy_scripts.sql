USE apfy;

-- представление ниже - простой прайс из категории, артикула, наименования и колонок цен.
-- при запросах от рекламных агентств вещь незаменимая

CREATE OR REPLACE VIEW price_list_for_wholesale_buyers AS
SELECT 
	c.name AS категория,
	g.international_article AS артикул, 
	g.title AS наименование, 
	SUM(quantity_of_goods) AS "доступно для заказа",
	sp.price AS "рекомендованная розничная цена",
	ROUND(sp.price * 0.9) AS "при заказе от 50000 р.",
	ROUND(sp.price  * 0.75) AS "при заказе от 100000 р."
FROM goods g 
JOIN selling_price sp 
	ON sp.id = g.id 
JOIN goods_category gc 
	ON gc.id_goods = g.id
JOIN category c 
	ON c.id = gc.id_category
JOIN goods_storehouse gs 
	ON gs.id_goods = g.id 
GROUP BY gs.id_goods;

-- посмотрим:
SELECT * FROM price_list_for_wholesale_buyers;

-- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- общее "главное" представление
-- что здесь есть - в этом представлении видно:
-- 1) номер заказа
-- 2) id покупателя и его имя (покупатель может делать повторные заказы)
-- 3) товар и его артикул (это важно, так как у одного и того же товара может быть несколько поставщиков, разные цены закупки, но единый международный артикул)
-- 4) проданное количество товара в рамках заказа
-- 5) розничная цена
-- 6) цена закупки
-- 7) у какого поставщика куплен конкретно этот товар
-- 8) с какого склада отгружались
-- дальше эту выборку можно по своему усмотрению и так и сяк крутить в разных представлениях и выборках 
-- как пример - ниже написаны две процедуры, вызывающие это представление и фильтрующие выборку одна по номеру заказа, другая по покупателю

CREATE OR REPLACE VIEW general_view AS
SELECT 
	orders.id AS order_number, 										 # номер заказа
	orders.id_shopper AS buyer_number, 								 # id покупателя 
	CONCAT(shopper.firstname, ' ', shopper.lastname) AS buyers_name, # имя покупателя
	goods.international_article AS item_number, 					 # артикул
	goods.title AS name, 											 # наименование
	goods_storehouse_orders.quantity_of_goods AS number_of_goods, 	 # количество
	selling_price.price AS sale_price, 								 # цена продажи
	purchase_price.price AS purchase_price, 						 # цена закупки
	goods_suppliers.name AS supplier, 								 # поставщик
	storehouse.name AS warehouse_number 							 # с какого склада
FROM orders JOIN shopper 
	ON orders.id_shopper = shopper.id
JOIN goods_storehouse_orders 
	ON goods_storehouse_orders.id_orders = orders.id
JOIN goods_goods_suppliers 
	ON goods_storehouse_orders.id_goods_suppliers = goods_goods_suppliers.goods_suppliers 
JOIN goods 
	ON goods.id = goods_storehouse_orders.id_goods 
	AND goods_goods_suppliers.goods = goods.id
JOIN selling_price 
	ON selling_price.id = goods.id
JOIN goods_suppliers 
	ON goods_suppliers.id = goods_goods_suppliers.goods_suppliers
JOIN storehouse 
	ON storehouse.id = goods_storehouse_orders.id_storehouse
JOIN purchase_price 
	ON purchase_price.international_article = goods.international_article 
	AND purchase_price.id_goods_suppliers = goods_suppliers.id
ORDER BY orders.id;

-- посмотреть
SELECT * FROM general_view;

SELECT SUM(sale_price) FROM general_view WHERE order_number = 5; # сумму заказа так можно посчитать

-- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- ниже 2 процедуры на основе представления general_view, что позволяют посмотреть:
-- 1) состав заказа. Смотрим номер заказа, номер и имя покупателя, что этот покупатель заказал, в каком количестве и по какой цене
-- 2) статистика по покупателю. Можем посмотреть кто покупал, что покупал и сколько заказов совершал

DELIMITER //

-- процедура: смотреть конкретный заказ
DROP PROCEDURE IF EXISTS select_order//
CREATE PROCEDURE select_order (numb INT)
BEGIN
	SELECT order_number, buyer_number, buyers_name, item_number, name, number_of_goods, sale_price 
	FROM general_view
	WHERE order_number = numb;
END//


-- проедура: смотреть конкретного покупателя
DROP PROCEDURE IF EXISTS select_buyer//
CREATE PROCEDURE select_buyer (numb INT)
BEGIN
	SELECT buyer_number, buyers_name, item_number, name, number_of_goods
	FROM general_view
	WHERE buyer_number = numb;
END//

DELIMITER ;

-- посмотреть заказ
CALL select_order(14);
-- посмотреть покупателя - кто и что купил
CALL select_buyer(1);

-- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- ещё одна процедура на основе general_view - генерация подарка за покупку (была у нас такая акция, пользовалась популярностью)
-- суть - при заказе свыше 5000 р. полагался гарантированный подарок, любой из ассортимента магазина, но на сумму в 5% от общей суммы заказа
-- чаще всего в качестве подарка шли дополнительные стержни к ручкам, всякие чехлы или кухонные ножи
-- процедура gift_for_purchase рандомно выбирает товар из всего ассортимента магазина и предлагает его в качестве подарка
-- требование к заказу - сумма свыше 5000 р.
-- требование к подарку, т.к. товаров сейчас в таблицах мало - не дороже 40% от суммы заказа
-- если сумма заказа меньше 5000 р., подарка не будет, о чём упадёт уведомление
-- ниже кода процедура два варианта её вызова - один с подбором подарка и второй с сообщением о том, что условия акции не выполнены

DELIMITER //

DROP PROCEDURE IF EXISTS gift_for_purchase//
CREATE PROCEDURE gift_for_purchase (`order` BIGINT UNSIGNED)
BEGIN
	DECLARE order_cost DECIMAL(10, 2);
	SET order_cost = (SELECT SUM(sale_price) FROM general_view WHERE order_number = `order`);
	IF order_cost > 5000 THEN
		SELECT 
			g.international_article, 
			g.title, 
			pp.price
		FROM goods AS g 
		JOIN purchase_price AS pp 
			ON g.international_article = pp.international_article
		WHERE pp.price < (order_cost * 0.4)
		ORDER BY RAND() LIMIT 1;
	ELSE
		SELECT 'условия акции не выполнены';
	END IF;
END//

DELIMITER ;

-- подарка нет, как жаль
CALL gift_for_purchase(2);
-- а к этому заказу подарок предлагается:
CALL gift_for_purchase(5);

-- так можем проверить сумму заказа: 
-- SELECT SUM(purchase_price) FROM general_view WHERE order_number = 5;

-- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- ниже процедура для удобного заведения товара. В ней в рамках транзакции мы заполняем данными все обязательные поля в таблицах по товару, а именно:
-- 1) международный артикул товара
-- 2) название товара
-- 3) характеристики (JSON)
-- 4) описание 
-- 5) категория товара (одна из 5-ти)
-- 6) поставщик товара (один из 3-х)
-- 7) сколько товара кладём на первый склад
-- 8) а сколько на второй 
-- 9) цена продажи товара
-- 10) цена закупки
-- плюсом добавляем блок оработки ошибок DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, результат работы которого записываем в OUT-переменную
-- ниже за скриптом создания процедуры два примера добавления товара с её помощью: один успешный, он добавляет товар и нужные строки во все таблица, 
-- а второй заканчивается ROLLBACK-ом и записывает текс ошибки в OUT-переменную tran_result

DELIMITER //

DROP PROCEDURE IF EXISTS sp_product_addition//
CREATE PROCEDURE sp_product_addition (international_articles VARCHAR(100), title VARCHAR(250), characteristics_goods JSON, description TEXT, 
				 id_category BIGINT UNSIGNED, id_supplier BIGINT UNSIGNED, goods_stor_1 BIGINT UNSIGNED, goods_stor_2 BIGINT UNSIGNED,
				 selling_pr DECIMAL(10, 2), purchase_price DECIMAL(10, 2), OUT tran_result VARCHAR(200))
BEGIN
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);
	
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET tran_rollback = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result := CONCAT(code, ': ', error_string);
	END;
	
	START TRANSACTION;
		INSERT INTO goods (international_article, title, characteristics_goods)
		VALUES (international_articles, title, characteristics_goods);
		
		INSERT INTO description
		VALUES (LAST_INSERT_ID(), description);
	
		INSERT INTO goods_category
		VALUES (id_category, LAST_INSERT_ID());
	
		INSERT INTO goods_goods_suppliers
		VALUES (id_supplier, LAST_INSERT_ID());
	
		INSERT INTO goods_storehouse
		VALUES (1, LAST_INSERT_ID(), goods_stor_1);
	
		INSERT INTO goods_storehouse
		VALUES (2, LAST_INSERT_ID(), goods_stor_2);
	
		INSERT INTO selling_price (id, price)
		VALUES (LAST_INSERT_ID(), selling_pr);
	
		INSERT INTO purchase_price (price)
		VALUES (purchase_price);
	
		UPDATE purchase_price
		SET 
			international_article = international_articles, 
			id_goods_suppliers = id_supplier
		WHERE purchase_price.id = LAST_INSERT_ID();
	
	IF tran_rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result := 'УСПЕШНО!';
		COMMIT;
	END IF;
END//

DELIMITER ;

-- шпаргалка
-- 1) международный артикул товара
-- 2) название товара
-- 3) характеристики (JSON)
-- 4) описание 
-- 5) категория товара (одна из 5-ти)
-- 6) поставщик товара (один из 3-х)
-- 7) сколько товара кладём на первый склад
-- 8) а сколько на второй 
-- 9) цена продажи товара
-- 10) цена закупки

-- вот этот товар добавится
CALL sp_product_addition('ggg11', 'проверочка', '{"цвет": "кислотный"}', 'текстовый текст', 5, 1, 22, 33, 15000, 5000, @tran_result);
-- а этот нет, так как ключ совпадает и транзакция откатится
CALL sp_product_addition('ggg11', 'проверочка', '{"а запах": "с ума сойти"}', 'всякое описание', 2, 3, 22, 33, 15000, 5000, @tran_result);

SELECT @tran_result;

-- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- ниже триггер перед рассмотрением процедуры с транзакцией оформления заказа.
-- благодаря ему при заказе после заполнения таблицы goods_storehouse_orders автоматически будет заполняться таблица order_status содержимым:
-- id заказа и статус заказа "новый"

DELIMITER //

DROP TRIGGER IF EXISTS order_status_trigger//
CREATE TRIGGER order_status_trigger AFTER INSERT ON goods_storehouse_orders
FOR EACH ROW 
BEGIN 
	INSERT INTO order_status 
	VALUES
		(NEW.id_orders, 'новый');
END//

DELIMITER ;

-- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- // -- //

-- процедура оформления заказа, при которой автоматически заполняются таблицы нужными данными, а именно:
-- передаём в транзакцию параметры:
-- 1) покупатель
-- 2) спокоб доставки
-- 3) способ оплаты
-- 4) комментарий к заказу (если есть)
-- 5) id товара
-- 6) количество товара
-- Важно! Транзакция будет успешной только в случае, если количество товара суммарно на обоих складах больше или равно количеству товаров в заказе
-- Плюс - обеспечение заказа будет производиться в первую очередь со склада № 2. Если количества товара на нём не хватит, добавится товар с первого склада
-- Плюс - если в заказе есть товар от разных поставщиков и на него разная цена закупки, в первую очередь в заказ подтянется товар с меньшей ценой закупки

DELIMITER //

DROP PROCEDURE IF EXISTS complete_order_processing//
CREATE PROCEDURE complete_order_processing 
	(id_shopper BIGINT UNSIGNED, methods_logistics ENUM('склад-склад', 'склад-дверь', 'дверь-склад', 'дверь-дверь', 'иное'), 
	payment_methods BIGINT UNSIGNED, comments VARCHAR(300), id_good BIGINT UNSIGNED, quantity_of_good BIGINT UNSIGNED, OUT tran_result VARCHAR(200))
BEGIN
	DECLARE number_of_goods INT UNSIGNED;
	DECLARE stor INT UNSIGNED;
	DECLARE supp BIGINT UNSIGNED;

	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);
	
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET tran_rollback = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result := CONCAT(code, ': ', error_string);
	END;

	START TRANSACTION;
		INSERT INTO orders (id_shopper, methods_logistics, payment_methods, comments)
		VALUES (id_shopper, methods_logistics, payment_methods, comments);
	
		INSERT INTO goods_storehouse_orders (id_orders, id_goods)
		VALUES (LAST_INSERT_ID(), id_good);
	# сюда записывается количество товаров
		SELECT SUM(quantity_of_goods) INTO number_of_goods 
		FROM goods_storehouse 
		GROUP BY id_goods 
		HAVING id_goods = id_good;
	# сюда записывается склад (1 или 2), на котором больше всего товаров
		SELECT gs.id_storehouse INTO stor 
		FROM goods_storehouse gs 
		JOIN goods_goods_suppliers ggs 
			ON gs.id_goods = ggs.goods 
		WHERE gs.id_goods = id_good 
		ORDER BY gs.quantity_of_goods DESC 
		LIMIT 1;
	# сюда записываем поставщика (1, 2 или 3), у которого самый дешёвый по закупке товар (фильтруем по цене закупки)
		SELECT ggs.goods_suppliers INTO supp 
		FROM goods_storehouse gs 
		JOIN goods_goods_suppliers ggs 
			ON gs.id_goods = ggs.goods 
		JOIN goods g 
			ON g.id = ggs.goods 
		JOIN purchase_price pp 
			ON pp.international_article = g.international_article 
		WHERE gs.id_goods = id_good 
		ORDER BY pp.price 
		LIMIT 1;
	# если количество заказываемых товаров есть на складе:
		IF number_of_goods >= quantity_of_good THEN 
			UPDATE goods_storehouse_orders	# дополняем goods_storehouse_orders
			SET 
				quantity_of_goods = quantity_of_good,
				id_goods_suppliers = supp,
				id_storehouse = stor
			WHERE id_goods = id_good;
			
			IF quantity_of_good <= (SELECT quantity_of_goods FROM goods_storehouse 
									WHERE id_storehouse = 2 AND id_goods = id_good) THEN # если нужное количество есть на втором складе, берём с него
				UPDATE goods_storehouse
				SET
					quantity_of_goods = quantity_of_goods - quantity_of_good 
				WHERE id_goods = id_good AND id_storehouse = 2;
			ELSE
				UPDATE goods_storehouse
				SET
					quantity_of_goods = number_of_goods - quantity_of_good
				WHERE id_goods = id_good AND id_storehouse = 1; # иначе обнуляем второй склад (насколько возможно), а остатки добираем с первого
				
				UPDATE goods_storehouse 
				SET
					quantity_of_goods = 0
				WHERE id_goods = id_good AND id_storehouse = 2;
			END IF;
		ELSE								# иначе откат транзакции
			SELECT 'сток товара нет на складах';
			ROLLBACK;
		END IF;
	
	IF tran_rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result := 'УСПЕШНО!';
		COMMIT;
	END IF;
END//

DELIMITER ;

-- шпаргалка
-- 1) покупатель
-- 2) спокоб доставки
-- 3) способ оплаты
-- 4) комментарий к заказу (если есть)
-- 5) id товара
-- 6) количество товара

-- заказу быть
CALL complete_order_processing(10, 'склад-дверь', 3, NULL, 1, 3, @tran_result);
-- заказу не быть, так как нет такого кол-ва товара
CALL complete_order_processing(8, 'дверь-дверь', 2, NULL, 2, 6, @tran_result);

