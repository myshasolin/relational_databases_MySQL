USE lesson_10_ki;


-- что здесь есть - в этом представлении видно:
-- 1) номер заказа
-- 2) id покупателя и его имя (покупатель может делать повторные заказы)
-- 3) товар и его артикул (это важно, так как у одного товара может быть несколько поставщиков, разные цены закупки, но единый международный артикул)
-- 4) проданное количество товара в рамках заказа
-- 5) розничная цена
-- 6) цена закупки
-- 7) у какого поставщика куплен конкретно этот товар
-- 8) с какого склада отгружались
-- дальше эту выборку можно в разных представлениях и выборках и так и сяк крутить по своему усмотрению
-- как лёгкий пример - ниже написаны две процедуры, вызывающие это представление и фильтрующие выборку одна по номеру заказа, другая по покупателю

CREATE OR REPLACE VIEW general_view AS
SELECT 
	o.id AS order_number, # номер заказа
	o.id_shopper AS buyer_number, # id покупателя 
	CONCAT(sh.firstname, ' ', sh.lastname) AS buyers_name, # имя покупателя
	g.international_article AS item_number, # артикул
	g.title AS name, # наименование
	gso.quantity_of_goods AS number_of_goods, # количество
	sp.price AS sale_price, # цена продажи
	pp.price AS purchase_price, # цена закупки
	gs.name AS supplier, # поставщик
	s.name AS warehouse_number # с какого склада
FROM orders AS o 
JOIN shopper AS sh 
JOIN goods_storehouse_orders AS gso 
JOIN goods AS g 
JOIN selling_price AS sp 
JOIN goods_goods_suppliers AS ggs 
JOIN goods_suppliers AS gs 
JOIN storehouse AS s 
JOIN purchase_price AS pp 
ON o.id_shopper = sh.id
AND gso.id_orders = o.id
AND gso.id_goods_suppliers = ggs.goods_suppliers 
AND g.id = gso.id_goods 
AND sp.id = g.id
AND ggs.goods = g.id
AND gs.id = ggs.goods_suppliers 
AND s.id = gso.id_storehouse 
AND pp.international_article = g.international_article 
AND pp.id_goods_suppliers = gs.id
ORDER BY o.id;

SELECT * FROM general_view;

DELIMITER //

-- смотреть конкретный заказ
DROP PROCEDURE IF EXISTS select_order//
CREATE PROCEDURE select_order (numb INT)
BEGIN
	SELECT order_number, buyer_number, buyers_name, item_number, name, number_of_goods, sale_price 
	FROM general_view
	WHERE order_number = numb;
END//


-- смотреть конкретного покупателя
DROP PROCEDURE IF EXISTS select_buyer//
CREATE PROCEDURE select_buyer (numb INT)
BEGIN
	SELECT buyer_number, buyers_name, item_number, name, number_of_goods
	FROM general_view
	WHERE buyer_number = numb;
END//

DELIMITER ;


-- посмотреть заказы
CALL select_order(5);
-- посмотреть покупателя - кто и что купил
CALL select_buyer(1);




