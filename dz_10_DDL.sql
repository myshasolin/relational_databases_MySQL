DROP DATABASE IF EXISTS lesson_10_ki;
CREATE DATABASE lesson_10_ki;
USE lesson_10_ki;

DROP TABLE IF EXISTS goods;
CREATE TABLE goods(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	international_article VARCHAR(100) UNIQUE COMMENT 'международный артикул',
	title VARCHAR(250) COMMENT 'Название',
	characteristics_goods JSON, # характеристики товаров
	created_at DATETIME DEFAULT NOW() COMMENT 'дата создания товара',
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления товара',
	
	INDEX title_idx(title),
	INDEX international_article_idx (international_article)
) COMMENT 'таблица товаров';


DROP TABLE IF EXISTS description;
CREATE TABLE description(
	id SERIAL,
	description TEXT DEFAULT NULL COMMENT 'Описание',
	
	FOREIGN KEY (id) REFERENCES goods(id) ON DELETE RESTRICT ON UPDATE RESTRICT	
) COMMENT 'описание товара';


DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
	id_photo SERIAL, 
	name VARCHAR(50),
	format_photos ENUM ('jpg', 'png', 'pdf', 'psd')	
) COMMENT 'таблица-хранилище с фото';


DROP TABLE IF EXISTS photos_goods;
CREATE TABLE photos_goods(
	id_photos BIGINT UNSIGNED NOT NULL,
	id_goods BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (id_photos) REFERENCES photos(id_photo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_goods) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'таблица для привязки фото к товару';


DROP TABLE IF EXISTS category;
CREATE TABLE category (
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'таблица с категориями товаров';


DROP TABLE IF EXISTS goods_category;
CREATE TABLE goods_category(
	id_category BIGINT UNSIGNED NOT NULL,
	id_goods BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (id_category) REFERENCES category(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_goods) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'таблица для привязки товара к категории';


DROP TABLE IF EXISTS goods_suppliers;
CREATE TABLE goods_suppliers(
	id SERIAL,
	name VARCHAR(100) COMMENT 'Название',
	description VARCHAR(250) COMMENT 'Описание',
	country VARCHAR(100),
	city VARCHAR(100),
	address VARCHAR(150),
	phone CHAR(15),
	email VARCHAR(50),
	personal_manager JSON,
	comment VARCHAR(250),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	
	CONSTRAINT CHECK (REGEXP_LIKE(phone, '^[0-9]{11}$')),
	CONSTRAINT CHECK (REGEXP_LIKE(email, '^((([0-9A-Za-z]{1}[-0-9A-z\.]{0,30}[0-9A-Za-z]?)|([0-9А-Яа-я]{1}[-0-9А-я\.]{0,30}[0-9А-Яа-я]?))@([-A-Za-z]{1,}\.){1,}[-A-Za-z]{2,})$'))
) COMMENT 'поставщики';


DROP TABLE IF EXISTS goods_suppliers_category;
CREATE TABLE goods_suppliers_category(
	id_goods_suppliers BIGINT UNSIGNED NOT NULL,
	id_category BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (id_goods_suppliers) REFERENCES goods_suppliers(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_category) REFERENCES category(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'таблица для привязки поставщика к категории';


DROP TABLE IF EXISTS goods_goods_suppliers;
CREATE TABLE goods_goods_suppliers(
	goods_suppliers BIGINT UNSIGNED NOT NULL,
	goods BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (goods_suppliers) REFERENCES goods_suppliers(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (goods) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'таблица для привязки товаров к поставщикам';


DROP TABLE IF EXISTS purchase_price;
CREATE TABLE purchase_price(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_goods_suppliers BIGINT UNSIGNED NOT NULL COMMENT 'id поставщика',
	international_article VARCHAR(100) COMMENT 'международный артикул',
 	price DECIMAL(10, 2) NOT NULL COMMENT 'цена',
 	created_at DATETIME DEFAULT NOW() COMMENT 'дата создания цены',
 	updated_at DATETIME ON UPDATE NOW() COMMENT 'дата обновления цены',
 	
 	FOREIGN KEY (international_article) REFERENCES goods(international_article) ON DELETE CASCADE ON UPDATE CASCADE,
 	FOREIGN KEY (id_goods_suppliers) REFERENCES goods_suppliers(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'цена закупки';


DROP TABLE IF EXISTS selling_price;
CREATE TABLE selling_price(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 	price DECIMAL(10, 2) NOT NULL COMMENT 'цена',
 	created_at DATETIME DEFAULT NOW() COMMENT 'дата создания цены',
 	updated_at DATETIME ON UPDATE NOW() COMMENT 'дата обновления цены',
 	
 	FOREIGN KEY (id) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'цена продажи';


DROP TABLE IF EXISTS storehouse;
CREATE TABLE storehouse(
	id SERIAL,
	name VARCHAR(100) COMMENT 'Название',
	city VARCHAR(100),
	phone CHAR(15),
	email VARCHAR(50),
	
	CONSTRAINT CHECK (REGEXP_LIKE(phone, '^[0-9]{11}$')),
	CONSTRAINT CHECK (REGEXP_LIKE(email, '^((([0-9A-Za-z]{1}[-0-9A-z\.]{0,30}[0-9A-Za-z]?)|([0-9А-Яа-я]{1}[-0-9А-я\.]{0,30}[0-9А-Яа-я]?))@([-A-Za-z]{1,}\.){1,}[-A-Za-z]{2,})$'))
) COMMENT 'склад';


DROP TABLE IF EXISTS goods_storehouse;
CREATE TABLE goods_storehouse(
	id_storehouse BIGINT UNSIGNED NOT NULL,
	id_goods BIGINT UNSIGNED NOT NULL,
	id_goods_suppliers BIGINT UNSIGNED NOT NULL COMMENT 'от какого поставщика',
	quantity_of_goods BIGINT COMMENT 'количество товаров на складе', 
	
	FOREIGN KEY (id_storehouse) REFERENCES storehouse(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_goods) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_goods_suppliers) REFERENCES purchase_price(id_goods_suppliers) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'таблица для привязки склада и товара';


DROP TABLE IF EXISTS shopper;
CREATE TABLE shopper(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100),
	phone BIGINT UNSIGNED UNIQUE NOT NULL,
	email VARCHAR(100) UNIQUE,
	password_hash VARCHAR(256),
	city VARCHAR(100),
	street VARCHAR(100),
	house CHAR(10),
	building_or_letter VARCHAR(100) COMMENT 'корпус или литера',
	apartment VARCHAR(100),
	comment TEXT,
	created_at DATETIME DEFAULT NOW() COMMENT 'дата регистрации покупателя',
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата изменения данных о покупателе',
	
	CONSTRAINT CHECK (REGEXP_LIKE(phone, '^[0-9]{11}$')),
	CONSTRAINT CHECK (REGEXP_LIKE(email, '^((([0-9A-Za-z]{1}[-0-9A-z\.]{0,30}[0-9A-Za-z]?)|([0-9А-Яа-я]{1}[-0-9А-я\.]{0,30}[0-9А-Яа-я]?))@([-A-Za-z]{1,}\.){1,}[-A-Za-z]{2,})$'))
) COMMENT 'покупатели, пользовательские данные';


DROP TABLE IF EXISTS payment_methods;
CREATE TABLE payment_methods(
	id SERIAL,
	name VARCHAR(100)
) COMMENT 'способы оплаты';


DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_shopper BIGINT UNSIGNED NOT NULL, #покупатель (кто)
	methods_logistics ENUM ('склад-склад', 'склад-дверь', 'дверь-склад', 'дверь-дверь', 'иное'),
	payment_methods BIGINT UNSIGNED NOT NULL,
	comments VARCHAR(300),
	created_at DATETIME DEFAULT NOW() COMMENT 'дата оформления заказа',
	
	FOREIGN KEY (id_shopper) REFERENCES shopper(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (payment_methods) REFERENCES payment_methods(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'заказы';


DROP TABLE IF EXISTS goods_storehouse_orders;
CREATE TABLE goods_storehouse_orders(
	id_orders BIGINT UNSIGNED NOT NULL, # какой заказ
	id_goods BIGINT UNSIGNED NOT NULL, # какой товар
	quantity_of_goods BIGINT UNSIGNED NOT NULL, # количество
	id_goods_suppliers BIGINT UNSIGNED NOT NULL, # кто поставщик
	id_storehouse BIGINT UNSIGNED NOT NULL, # с какого склада
	
	FOREIGN KEY (id_goods) REFERENCES goods_storehouse(id_goods) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY (id_storehouse) REFERENCES goods_storehouse(id_storehouse) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_orders) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_goods_suppliers) REFERENCES purchase_price(id_goods_suppliers) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'таблица для привязки товаров к заказу (так как в заказе может быть несколько товаров)';


DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews(
	id SERIAL,
	description TEXT,
	created_at DATETIME DEFAULT NOW() COMMENT 'дата заказа'
) COMMENT 'отзывы';


DROP TABLE IF EXISTS reviews_goods_shopper;
CREATE TABLE reviews_goods_shopper(
	id_reviews BIGINT UNSIGNED NOT NULL,
	id_goods BIGINT UNSIGNED NOT NULL,
	id_shopper BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (id_reviews) REFERENCES reviews(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_goods) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_shopper) REFERENCES shopper(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'отзывы - 1) id отзыва, 2) на что и 3) от кого';


DROP TABLE IF EXISTS order_status;
CREATE TABLE order_status(
	id_order BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	status ENUM('новый', 'в работе', 'завершён', 'отменён'),
	
	FOREIGN KEY (id_order) REFERENCES orders(id) ON DELETE RESTRICT ON UPDATE RESTRICT
) COMMENT 'статус заказа';



-- небольшое наполнение таблиц:

-- товар
INSERT INTO goods (international_article, title, characteristics_goods)
VALUES (
	'1907192', 
	'Ручка шариковая Parker Duofold (1907192) Big Red GT M черные чернила', 
	'{
    	"Коллекция(серия)": "Duofold",
    	"Оригинальный цвет корпуса": "Big Red GT",
    	"Материал корпуса": "акрил литой",
    	"Вид упаковки": "коробка подарочная",
    	"Размер пишущего узла": "средний (M)",
    	"Цвет чернил в стержне": "черный",
    	"Наличие колпачка": "без колпачка",
    	"Наличие клипа": "ДА",
    	"Тип": "Ручка шариковая",
    	"Механизм выдвижения стержня": "поворотный",
    	"Срок гарантии": "24 мес."
	}'),
	(
	'1906779', 
	'Ручка шариковая Parker IM Premium (1906779) Brown Shadow M коричневый жемчуг', 
	'{
    	"Коллекция(серия)": "IM",
    	"Цвет": "коричневый жемчуг",
    	"Материал корпуса": "окрашенный алюминий с гравировкой",
		"Отделка": "хром",
    	"Вид упаковки": "коробка подарочная",
    	"Размер пишущего узла": "средний (M)",
    	"Цвет чернил в стержне": "синий",
    	"Наличие колпачка": "без колпачка",
    	"Наличие клипа": "ДА",
		"Клип": "сталь",
    	"Тип": "Ручка шариковая",
    	"Механизм выдвижения стержня": "нажимной",
    	"Срок гарантии": "24 мес."
	}'),
	(
	'1931408',
	'Ручка шариковая Parker Premier Lacque (1931408) Brown PGT M черные чернила',
	'{
	    "Коллекция(серия)": "Premier",
	    "Оригинальный цвет корпуса": "Brown PGT",
	    "Материал корпуса": "латунь лакированная",
		"Отделка деталей": "позолота розовая",
	    "Вид упаковки": "коробка подарочная",
	    "Размер пишущего узла": "средний (M)",
	    "Цвет чернил в стержне": "черный",
	    "Наличие колпачка": "без колпачка",
	    "Наличие клипа": "ДА",
	    "Тип": "Ручка шариковая",
	    "Механизм выдвижения стержня": "поворотный",
	    "Срок гарантии": "24 мес."
	}'),
	('1931431',
	'Ручка перьевая Parker Premier Monochrome Black (1931431) F перо золото 18K',
	'{
	    "Коллекция(серия)": "Premier",
		"Тип пера": "открытое",
	    "Оригинальный цвет корпуса": "Monochrome Black",
	    "Материал корпуса": "латунь ювелирная",
		"Отделка деталей": "покрытие PDV",
	    "Вид упаковки": "коробка подарочная",
		"Материал пера": "золото 18K",
		"Размер пера": "F",
		"Система заправки": "конвертор/картриджи",
		"Дополнительная комплектация": "картридж 2 шт. с черными чернилами/конвертер Deluxe",
	    "Срок гарантии": "24 мес."
	}'),
	('4779.168',
	'Ручка роллер Carandache Leman Grand Blue SP (4779.168) F черные чернила',
	'{
		"Материал корпуса": "латунь лакированная, прозрачный темно-синий лак, гильоше волны",
		"Отделка корпуса": "посеребрение с родиевым покрытием",
		"Колпачок": "завинчивающийся. Торец колпачка оснащен новым идентификатором Caran d’Ache (темно-синий лакированный шестигранник)",
		"В комплекте": "стержень роллер Carandache (артикул стержня 8228.009) (F) черные чернила 1 шт.",
		"Вид упаковки": "коробка подарочная"
	}'),
	('886-3FS',
	'Ручка перьевая Cross ATX (886-3FS) матовая черная с серебристой отделкой',
	'{
		"Корпус": "латунь и хромовое покрытие", 
		"Отделка и детали дизайна": "хром", 
		"Перо": "сталь, тонкое",
		"Цвет": "серебристый"
	}'),
	('AT0156-1MS',
	'Ручка перьевая Cross Aventura (AT0156-1MS) черная',
	'{
		"Корпус": "латунь и лакированное покрытие", 
		"Отделка и детали дизайна": "хром",
		"Перо": "сталь, родий, толщина средняя",
		"Цвет": "черный"
	}'),
	('8945S-1 blue',
	'Флакон с чернилами Cross (8945S-1 blue) для перьевой ручки, синий, 62,5 мл',
	'{
		"Объем флакона": "62,5 мл",
		"Цвет": "синий"
	}'),
	('8945S-2 black',
	'Флакон с чернилами Cross (8945S-2 black) для перьевой ручки, черный, 62,5 мл',
	'{
		"Объем флакона": "62,5 мл",
		"Цвет": "черный"
	}'),
	('AT0725-3',
	'Ручка роллер Cross X без колпачка (AT0725-3) красная',
	'{
		"Корпус": "латунь и эпоксидная смола",
		"Цвет": "красный"
	}'),
	('AT0622-101',
	'Шариковая ручка Cross Click Lustrous Chrome (AT0622-101) зеркальный хром',
	'{"материал корпуса": "латунь",
	"механизм выдвижения стержня": "нажимной",
	"цвет": "зеркальный хром"
	}'),
	('S0911450',
	'Ручка шариковая Parker Urban Premium (S0911450) Pearl Metal Chiselled M синие чернила',
	'{"Тип": "Шарикова ручка",
	"Толщина пишущего узла": "Средний (М)",
	"Цвет стержня": "Синий",
	"Корпус": "Латунь",
	"Отделка": "Лаковое покрытие, оригинальная гравировка, хромированные детали",
	"Цвет" : "Pearl Metal Chiselled",
	"Комплектация": "1 стержень, в ручке",
	"Упаковка": "Подарочная коробка"
	}'),
	('806251',
	'Ручка перьевая Pelikan Office Twist P457 (806251) Girly Rose M перо сталь нержавеющая',
	'{"Коллекция/Серия": "Office",
	"Оригинальный цвет корпуса": "Girly Rose",
	"Материал корпуса": "пластик",
	"Материал пера": "сталь нержавеющая",
	"Размер пера": "M",
	"Вид упаковки": "коробка подарочная",
	"Срок гарантии": "36 мес."
	}')
;
	
	
-- описание товара
INSERT INTO description (description)
VALUES ('СИМВОЛ ПРЕВОСХОДСТВА
	С 1921 Duofold является символом поразительного мастерства фирмы PARKER.
	Покрытая дорогим полимером, Duofold обеспечивает исключительно удобное и роскошное письмо благодаря твердому золотому перу. 
	Duofold – эталон перьевых ручек.
	Глубокий красный
	Возрождение Глубокого красного во всем своем смелом великолепии и роскоши. Возвращение неустаревающего цвета, сейчас модного как никогда. Подходит для покупателей обоих полов, желающих выразить свою индивидуальность с помощью этой яркой ручки.'
	),
	('Выгравированный логотип PARKER на декоративном хромированном кольце'
	),
	('Символ профессионализма и престижа, ручка Parker Premier отличается смелым и изысканным современным дизайном, сводя воедино разные направления наследия Parker. Каждый штрих, написанный элегантной ручкой, дает представление об удобстве и истинном наслаждении от пользования ею.
	Soft Brown
	Корпус покрыт мягким на ощупь матовым лаком коричневого цвета с эффектом резиновой поверхности. Дизайн дополнен декоративными элементами с покрытием из розового золота. Ручка упакована в изысканную подарочную коробку Parker.'
	),
	('Современный дизайн и безусловный престиж 
	Символ профессионализма и престижа, ручка Parker Premier отличается смелым и изысканным современным дизайном, сводя воедино разные направления наследия Parker. Каждый штрих, написанный элегантной ручкой с пером из чистого 18-каратного золота, дает представление об удобстве и истинном наслаждении от пользования ею.'
	),
	('Leman Grand Bleu, союз между ветром и волнами
	Caran d’Ache использует свой уникальный опыт в области цвета и тончайшей гравировки для того чтобы расширить и обогатить цветную палитру коллекции ручек Leman. 
	Искупанные в свете и ветре, волны оживают вместе с новой коллекцией Leman Grand Bleu. Изящно выгравированный фон создает впечатление размеренной ряби волн на поверхности воды. Слой прозрачного лака, напоминающего об интенсивном синем цвете океанских глубин, раскрывает эти волнообразные отражения на изысканном корпусе пишущих инструментов Leman Grand Bleu.
	Убаюканные волнами и песней ласкающего ветерка, приверженцы пишущих инструментов класса Премиум нырнут с головой в волнующую одиссею с новой коллекцией ручек Leman Grand Bleu.
	Пожизненная международная гарантия
	Изготовлено в Швейцарии.'
	),
	('Эта ручка сравнима с деловым костюмом от Кутюр, начиная с тактильных ощущений и заканчивая уверенностью, которую она придает своему владельцу. Идеальный баланс четкой формы корпуса и классических пропорций с элегантными покрытиями делают ее совершенно особенным аксессуаром. Вдохновение и традиционная романтичность ручки Apogee - это вершина совершенства дизайна 21 века.
	- Утяжеленная и сбалансированная форма корпуса для непринужденного письма.
	- Пружинный клип.
	- Пулевидная форма корпуса.
	- Пожизненная гарантия на механическую часть.
	- Элегантная подарочная коробка.'
	),
	('Ручка для широкой аудитории.
	Надежный инструмент на любой вкус. Коллекция Aventura сделает Вашу повседневную жизнь особенной. Легкая и удобная ручка с традиционной формой корпуса и хромированными элементами подарит Вам ощущение классики в повседневных делах. 
	- Утонченная форма корпуса.
	- Центральный ободок в современном стиле.
	- Пожизненная гарантия на механическую часть.'
	),
	('Используя оригинальные расходные материалы СROSS Вы получаете безупречное качество письма.'
	),
	('Используя оригинальные расходные материалы СROSS Вы получаете безупречное качество письма.'
	),
	('CROSS X
	Представляем вам самый современный силуэт Cross в обновленном дизайне, подчеркивающем новый образ бренда Cross и самые популярные корпоративные подарочные цвета. 
	Особенности:
	- Новый гладкий, утонченный, современный силуэт;
	- Новый образ бренда Cross;
	- Тот же популярный, запатентованный раздвижной открывающий механизм, что и в серии Cross® Edge;
	- Идеальные отделки для корпоративных подарков;
	- Возможность необычного декорирования.'
	),
	('Классика с кнопкой.
	Наиболее известная форма Cross теперь с кнопкой. Включите ручку одним кликом! Ручка Cross Click позволяет писать также ровно, как и стройный гриф коллекции Classic Century®, но в отличие от своего предшественника не имеет поворотного механизма, вместо него имеется кнопка. Нужно всего лишь нажать на кнопку и писать с удовольствием.
	- Современная версия классики.
	- Легкий в использовании нажимной кнопочный механизм, первая ручка Cross такого рода.
	- Стильные популярные цвета.
	- Пожизненная гарантия на механическую часть.
	- Упакована в премиальную подарочную коробку.'
	),
	(NULL
	),
	('Перьевая ручка Pierre Cardin, ESPACE'
	)
;


-- таблица-хранилище с фото
INSERT INTO photos (name, format_photos)
VALUES 
	('1907192-1', 'jpg'), ('1907192-2', 'jpg'), ('1907192-3', 'jpg'), ('1907192-4', 'jpg'), ('1907192-5', 'jpg'),
	('1907193-1', 'jpg'), ('1907193-2', 'jpg'), ('1907193-3', 'jpg'), ('1907193-4', 'jpg'), ('1907193-5', 'jpg'), ('1907193-6', 'jpg'),
	('1931408-1', 'jpg'), ('1931408-2', 'jpg'), ('1931408-3', 'jpg'), ('1931408-4', 'jpg'), ('1931408-5', 'jpg'),
	('1931431-1', 'jpg'), ('1931431-2', 'jpg'), ('1931431-3', 'jpg'), ('1931431-4', 'jpg'), ('1931431-5', 'jpg'), ('1931431-6', 'jpg'), ('1931431-7', 'jpg'),
	('4779.168-1', 'png'), ('4779.168-2', 'png'), ('4779.168-3', 'png'), ('4779.168-4', 'png'), ('4779.168-5', 'png'), ('4779.168-6', 'png'),
	('886-3FS-1','jpg'), ('886-3FS-2','jpg'), ('886-3FS-3','jpg'), ('886-3FS-4','jpg'),
	('AT0156-1MS-1', 'jpg'), ('AT0156-1MS-2', 'jpg'), ('AT0156-1MS-3', 'jpg'), ('AT0156-1MS-4', 'jpg'), ('AT0156-1MS-5', 'jpg'), ('AT0156-1MS-6', 'jpg'),
	('8945S-1_blue-1', 'jpg'), ('8945S-1_blue-2', 'jpg'),
	('8945S-2_black-1', 'jpg'), ('8945S-2_black-2', 'jpg'),
	('AT0725-3-1', 'jpg'), ('AT0725-3-2', 'jpg'), ('AT0725-3-3', 'jpg'), ('AT0725-3-4', 'jpg'), ('AT0725-3-5', 'jpg'), ('AT0725-3-6', 'jpg'), ('AT0725-3-7', 'jpg'),
	('AT0622-101-1', 'jpg'), ('AT0622-101-2', 'jpg'), ('AT0622-101-3', 'jpg'), ('AT0622-101-4', 'jpg'), ('AT0622-101-5', 'jpg'), ('AT0622-101-6', 'jpg'), ('AT0622-101-7', 'jpg'), ('AT0622-101-8', 'jpg'),
	('S0911450-1', 'jpg'), ('S0911450-2', 'jpg'), ('S0911450-3', 'jpg'), ('S0911450-4', 'jpg'),
	('806251-1', 'jpg'), ('806251-2', 'jpg'), ('806251-3', 'jpg')
;


-- таблица для привязки фото к товару. Сначала id фото, потом id товара
INSERT INTO photos_goods
VALUES 
	(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
	(6, 2), (7, 2), (8, 2), (9, 2), (10, 2), (11, 2),
	(12, 3), (13, 3), (14, 3), (15, 3), (16, 3),
	(17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), (23, 4),
	(24, 5), (25, 5), (26, 5), (27, 5), (28, 5), (29, 5),
	(30, 6), (31, 6), (32, 6), (33, 6),
	(34, 7), (35, 7), (36, 7), (37, 7), (38, 7), (39, 7),
	(40, 8), (41, 8),
	(42, 9), (43, 9),
	(44, 10), (45, 10), (46, 10), (47, 10), (48, 10), (49, 10), (50, 10),
	(51, 11), (52, 11), (53, 11), (54, 11), (55, 11), (56, 11), (57, 11), (58, 11),
	(59, 12), (60, 12), (61, 12), (62, 12),
	(63, 13), (64, 13), (65, 13)
;


-- таблица с категориями товаров (уже заполнена всеми категориями, что были на apfy)
INSERT INTO category (name)
VALUES 
	('Пишущие инструменты'),
	('Ножи Victorinox'),
	('Рюкзаки, сумки, дорожные аксессуары,'),
	('Зажигалки'),
	('Outdoor')
;


-- таблица для привязки товара к категории. Сначала id категории, потом id товара
INSERT INTO goods_category
VALUES 
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6), 
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	(1, 11),
	(1, 12),
	(1, 13)
;


-- таблица поставщиков
INSERT INTO goods_suppliers (name, description, country, city, address, phone, email, personal_manager, comment)
VALUES 
	('MERLION', 'ножи, пишущие', 'Россия', 'Красногорск', 'б-р Строителей, 4', '74959818484', 'info@merlion.com', '{"имя": "Иванов Иван", "телефон": "доб. 1552", "почта": "ivanovivan@merlion.com"}', 'менеджер тупит'),
	('ГАЛСЭР', 'Pierre Cardin, Cross, багажка', 'Россия', 'Москва', 'ул. Вятская, д.27, корпус 5', '74957877147', 'galser@galser.ru', '{"имя": "Ксения", "телефон": "доб. 12", "почта": "ks@galser.ru"}', NULL)
;


-- таблица для привязки поставщика к категории. Сначала id поставщика, потом id категории
INSERT INTO goods_suppliers_category
VALUES 
	(1, 1), (1, 2), (1, 5),
	(2, 1), (2, 2), (2, 3), (2, 4)
;


-- таблица для привязки товаров к поставщикам. Сначала id поставщика, потом id товара
INSERT INTO goods_goods_suppliers
VALUES 
	(1, 1),
	(1, 2),
	(2, 3),
	(1, 4), (2, 4),
	(1, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(2, 11),
	(1, 12), (2, 12),
	(1, 13)
;


-- цена закупки. 1) на что (товар) 2) поставщик 3) цена
INSERT INTO purchase_price (international_article, id_goods_suppliers, price)
VALUES 
	('1907192', 1, 14225),
	('1906779', 1, 1555),
	('1931408', 2, 12350),
	('1931431', 1, 26142.50),
	('1931431', 2, 33985.25),
	('4779.168', 1, 18600),
	('886-3FS', 2, 8400),
	('AT0156-1MS', 2, 2589),
	('8945S-1 blue', 2, 1884),
	('8945S-2 black', 2, 1884),
	('AT0725-3', 2, 2190),
	('AT0622-101', 2, 3000),
	('S0911450', 1, 2577),
	('S0911450', 2, 2577),
	('806251', 1, 700)
;


-- цена продажи. 1) на что (товар) 2) цена
INSERT INTO selling_price (id, price)
VALUES 
	(1, 28450),
	(2, 3110),
	(3, 24700),
	(4, 52285),
	(5, 37200),
	(6, 14000),
	(7, 4315),
	(8, 3140),
	(9, 3140),
	(10, 3650),
	(11, 5000),
	(12, 4295),
	(13, 1400)
;


-- склад
INSERT INTO storehouse (name, city, phone, email)
VALUES 
	('На Дубровке', 'Москва', '74952741001', 'info@apfy.ru'),
	('Перекладной', 'Балашиха', '74962223344', 'solin@apfy.ru')
;


-- таблица для привязки склада и товара. Отображает количество товара на конкретном складе. 1) склад, 2) товар, 3) от какого поставщика 4) количество
INSERT INTO goods_storehouse
VALUES 
	(1, 1, 1, 3), (2, 1, 1, 2),
	(1, 2, 1, 1), (2, 2, 1, 1),
	(1, 3, 2, 1), (2, 3, 2, 0),
	(1, 4, 2, 0), (2, 4, 2, 1),
	(1, 5, 1, 1), (2, 5, 1, 0),
	(1, 6, 2, 1), (2, 6, 2, 1),
	(1, 7, 2, 0), (2, 7, 2, 1),
	(1, 8, 2, 5), (2, 8, 2, 3),
	(1, 9, 2, 4), (2, 9, 2, 2),
	(1, 10, 2, 1), (2, 10, 2, 0),
	(1, 11, 2, 1), (2, 11, 2, 0),
	(1, 12, 2, 1), (2, 12, 2, 0),
	(1, 13, 1, 3), (2, 13, 1, 2)
;


-- покупатель
INSERT INTO shopper (firstname, lastname, phone, email, password_hash, city, street, house, building_or_letter, apartment, comment)
VALUES 
	('Екатерина', 'Каленова', '79035555555', 'gygygy@yandex.ru', '1ccc0f1ecd201e2b71200cdb2e59f1126de19356', 'Москва', 'Трёхпудный проезд', '11', '4', DEFAULT, DEFAULT),
	('Николай', 'Чернявский', '79156667777', 'bybyby@mail.ru', 'a0487eb31b1c3d82398ddc220e70348d661dcdf1', 'Санкт-Петербург', 'Ленинский пр-т', '2', 'лит.6', 'помещение 88', DEFAULT),
	('Ирина', 'Иванова', '79855555555', 'tratata@tratata.ta', '92c33360fe4291cde541ee8a0947fd23931351d5', 'Москва', 'пр-кт Маршала Жукова', '75', 'корп. 2', DEFAULT, 'есть вопросы по доставке'),
	('Сергей', 'Кузнецов', '75556662211', 'lalala@topolya.lya', 'f4f6075660f96a4ea9b7338418df2016c82155b4', 'Москва', '7-я Паврковая ул', '12', DEFAULT, '3', DEFAULT),
	('Антон', 'Модин', '79156669988', 'huhuhu@hohoho.ho', 'db3522f2ee904b606b0191dd362e19ec09fd8f16', 'Москва', 'Таллинская', '2', '3', '22', 'Подъезд 2, этаж 9, домофон 22'),
	('Дарья', 'С', '78005556644', 'dyk@dyk.dy', 'ecaf8bdcc8c2a37329e199920ead4e995c78238c', 'Хабаровск', 'Промышленная', '22', DEFAULT, DEFAULT, 'офис 2'),
	('Анастасия', 'Довлатова', '75553336699', 'bum@bubum.bum', '8479d8314d8a5f43e45faae5f853ccc13136d390', 'Люберцы', 'Митрофанова', '11', '2', '31', 'Подъезд 5, этаж 6'),
	('Сергей', '', '79996665522', 'tt@yy.oo', '95bc8877a611704b51d3a24eada62cb6fa760d1e', 'Москва', 'Космодамианская наб.', '50/8', DEFAULT, DEFAULT, DEFAULT)
;


-- перечислены способы оплаты заказа
INSERT INTO payment_methods (name)
VALUES 
	('наличными при получении заказа'),
	('картой при получении заказа'),
	('онлайн'),
	('рассрочка')
;


-- заказы, номер заказа присваивается автоматически
-- перечислены способы оплаты заказа. 1) покупатель, 2) способ доставки, 3) способ оплаты, 4) комментарий
INSERT INTO orders (id_shopper, methods_logistics, payment_methods, comments)
VALUES 
	(1, 'склад-дверь', 2, 'позвонить за час'),
	(1, 'склад-дверь', 2, 'позвонить за час'),
	(2, 'склад-склад', 1, 'решение о покупке при вручении на месте'),
	(3, 'склад-дверь', 3, NULL), 
	(4, 'склад-дверь', 4, NULL),
	(5, 'иное', 1, 'позвонить за час'),
	(6, 'склад-склад', 3, 'Доставка ПЭК'),
	(7, 'склад-дверь', 1, NULL),
	(8, 'склад-дверь', 3, 'позвонить за час')
;


-- таблица для привязки товаров к заказу (так как в заказе может быть несколько товаров)
-- 1) номер заказа, 2) id товара, 3) количество, 4) от какого поставщика 5) id склада
INSERT INTO goods_storehouse_orders (id_orders, id_goods, quantity_of_goods, id_goods_suppliers, id_storehouse)
VALUES
	(1, 1, 2, 1, 2),
	(2, 2, 1, 1, 1),
	(3, 4, 1, 2, 1),
	(4, 5, 1, 1, 1),
	(5, 6, 2, 2, 2),
	(5, 7, 1, 2, 2),
	(5, 9, 1, 2, 2),
	(5, 8, 1, 2, 2),
	(6, 10, 1, 2, 1),
	(7, 11, 1, 2, 1),
	(8, 12, 2, 1, 1),
	(9, 13, 1, 1, 1)
;
	

-- таблица отзывов на товары
INSERT INTO reviews (description)
VALUES 
	('ручка щикаарная, всем рекомендую'),
	('оригинал, быстрая доставка, рекомендую'),
	('ответили на все вопросы, быстро доставили, рекомендую.'),
	('оперативная доставка, товар оригинал'),
	('заказ не пришел'),
	('рекомендую'),
	('отлично ставит почерк')
;
	
-- таблица для привязки отзыва к покупателю и заказу 1) отзыв, 2) товар, 3) покупатель
INSERT INTO reviews_goods_shopper
VALUES 
	(1, 1, 1),
	(2, 4, 2),
	(3, 5, 3),
	(4, 6, 4),
	(4, 7, 4),
	(4, 9, 4),
	(4, 8, 4),
	(5, 11, 6),
	(6, 12, 7),
	(7, 13, 8)
;


INSERT INTO order_status 
VALUES
	(1, 'завершён'),
	(2, 'завершён'),
	(3, 'в работе'),
	(4, 'завершён'),
	(5, 'завершён'),
	(6, 'завершён'),
	(7, 'отменён'),
	(8, 'завершён'),
	(9, 'завершён')
;

