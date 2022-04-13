-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.


как рекомендовалось, настроил подключение к MongoDB по паролю:

/*
myshasolin@ubuntu-VB:~$ mongo --authenticationDatabase "admin" -u "Admin" -p
MongoDB shell version v4.2.19
Enter password: 
connecting to: mongodb://127.0.0.1:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("9ec7387e-b88d-4b32-bbdd-c88a63f06438") }
MongoDB server version: 4.2.19
Server has startup warnings: 
2022-04-13T20:59:12.616+0300 I  STORAGE  [initandlisten] 
2022-04-13T20:59:12.616+0300 I  STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2022-04-13T20:59:12.616+0300 I  STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2022-04-13T20:59:13.696+0300 I  CONTROL  [initandlisten] 
2022-04-13T20:59:13.696+0300 I  CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2022-04-13T20:59:13.696+0300 I  CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2022-04-13T20:59:13.696+0300 I  CONTROL  [initandlisten] 
---
Enable MongoDB's free cloud-based monitoring service, which will then receive and display
metrics about your deployment (disk utilization, CPU, operation statistics, etc).

The monitoring data will be available on a MongoDB website with a unique URL accessible to you
and anyone you share the URL with. MongoDB may use this information to make product
improvements and to suggest MongoDB products and deployment options to you.

To enable free monitoring, run the following command: db.enableFreeMonitoring()
To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
---

> 
*/

переходим в создаваемую БД и создаём в ней "коллекции", аналогичные таблицам в нашей БД shop 

/*
> use shop
switched to db shop
> db.createCollection('products')
{ "ok" : 1 }
> db.createCollection('catalogs')
{ "ok" : 1 }
> db.createCollection('users')
{ "ok" : 1 }
*/


заполняем таблицы данными (так себе удовольствие на самом деле)
а с помощью find() смотрим на получившийся результат и радуемся тому, что получилось:

/*
> db.catalogs.insert({name: 'Процессоры'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Материнские платы'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Видеокарты'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Жесткие диски'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Оперативная память'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.find()
{ "_id" : ObjectId("625721bd21393d9d4d975b00"), "name" : "Процессоры" }
{ "_id" : ObjectId("625721c521393d9d4d975b01"), "name" : "Материнские платы" }
{ "_id" : ObjectId("625721d021393d9d4d975b02"), "name" : "Видеокарты" }
{ "_id" : ObjectId("625721db21393d9d4d975b03"), "name" : "Жесткие диски" }
{ "_id" : ObjectId("625721e521393d9d4d975b04"), "name" : "Оперативная память" }
> db.products.insert({name: 'Intel Core i3-8100', description: 'Процессор для настольных персональный компьютеров, основанных на платформе Intel.', price: 7890.00, catalog_id: new ObjectId("6257131221393d9d4d975aea"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.insert({name: 'Intel Core i5-7400', description: 'Процессор для настольных персональный компьютеров, основанных на платформе Intel.', price: 12700.00, catalog_id: new ObjectId("6257131221393d9d4d975aea"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.insert({name: 'AMD FX-8320E', description: 'Процессор для настольных персональный компьютеров, основанных на платформе AMD.', price: 4780.00, catalog_id: new ObjectId("6257131221393d9d4d975aea"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.insert({name: 'AMD FX-8320', description: 'Процессор для настольных персональный компьютеров, основанных на платформе AMD.', price: 7120.00, catalog_id: new ObjectId("6257131221393d9d4d975aea"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.insert({name: 'ASUS ROG MAXIMUS X HERO', description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', price: 19310.00, catalog_id: new ObjectId("6257133221393d9d4d975aeb"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.insert({name: 'Gigabyte H310M S2H', description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', price: 4790.00, catalog_id: new ObjectId("6257133221393d9d4d975aeb"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.insert({name: 'MSI B250M GAMING PRO', description: 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', price: 5060.00, catalog_id: new ObjectId("6257133221393d9d4d975aeb"), created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.products.find()
{ "_id" : ObjectId("625722d921393d9d4d975b05"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональный компьютеров, основанных на платформе Intel.", "price" : 7890, "catalog_id" : ObjectId("6257131221393d9d4d975aea"), "created_at" : ISODate("2022-04-13T19:22:01.772Z") }
{ "_id" : ObjectId("6257232b21393d9d4d975b06"), "name" : "Intel Core i5-7400", "description" : "Процессор для настольных персональный компьютеров, основанных на платформе Intel.", "price" : 12700, "catalog_id" : ObjectId("6257131221393d9d4d975aea"), "created_at" : ISODate("2022-04-13T19:23:23.988Z") }
{ "_id" : ObjectId("6257233821393d9d4d975b07"), "name" : "AMD FX-8320E", "description" : "Процессор для настольных персональный компьютеров, основанных на платформе AMD.", "price" : 4780, "catalog_id" : ObjectId("6257131221393d9d4d975aea"), "created_at" : ISODate("2022-04-13T19:23:36.245Z") }
{ "_id" : ObjectId("6257234521393d9d4d975b08"), "name" : "AMD FX-8320", "description" : "Процессор для настольных персональный компьютеров, основанных на платформе AMD.", "price" : 7120, "catalog_id" : ObjectId("6257131221393d9d4d975aea"), "created_at" : ISODate("2022-04-13T19:23:49.205Z") }
{ "_id" : ObjectId("6257235021393d9d4d975b09"), "name" : "ASUS ROG MAXIMUS X HERO", "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price" : 19310, "catalog_id" : ObjectId("6257133221393d9d4d975aeb"), "created_at" : ISODate("2022-04-13T19:24:00.796Z") }
{ "_id" : ObjectId("6257236121393d9d4d975b0a"), "name" : "Gigabyte H310M S2H", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : 4790, "catalog_id" : ObjectId("6257133221393d9d4d975aeb"), "created_at" : ISODate("2022-04-13T19:24:17.100Z") }
{ "_id" : ObjectId("6257237121393d9d4d975b0b"), "name" : "MSI B250M GAMING PRO", "description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price" : 5060, "catalog_id" : ObjectId("6257133221393d9d4d975aeb"), "created_at" : ISODate("2022-04-13T19:24:33.444Z") }
> db.users.insert({name: 'Геннадий', birthday_at: '1990-10-05', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Наталья', birthday_at: '1984-11-12', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Александр', birthday_at: '1985-05-20', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Сергей', birthday_at: '1988-02-14', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Иван', birthday_at: '1998-01-12', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Машка', birthday_at: '2006-08-29', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Светлашка', birthday_at: '1988-02-04', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Олег', birthday_at: '1998-03-20', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.insert({name: 'Юлия', birthday_at: '2006-02-17', created_at: new Date()});
WriteResult({ "nInserted" : 1 })
> db.users.find()
{ "_id" : ObjectId("6257243521393d9d4d975b0c"), "name" : "Геннадий", "birthday_at" : "1990-10-05", "created_at" : ISODate("2022-04-13T19:27:49.660Z") }
{ "_id" : ObjectId("6257244321393d9d4d975b0d"), "name" : "Наталья", "birthday_at" : "1984-11-12", "created_at" : ISODate("2022-04-13T19:28:03.164Z") }
{ "_id" : ObjectId("6257244f21393d9d4d975b0e"), "name" : "Александр", "birthday_at" : "1985-05-20", "created_at" : ISODate("2022-04-13T19:28:15.371Z") }
{ "_id" : ObjectId("6257245821393d9d4d975b0f"), "name" : "Сергей", "birthday_at" : "1988-02-14", "created_at" : ISODate("2022-04-13T19:28:24.859Z") }
{ "_id" : ObjectId("6257246221393d9d4d975b10"), "name" : "Иван", "birthday_at" : "1998-01-12", "created_at" : ISODate("2022-04-13T19:28:34.954Z") }
{ "_id" : ObjectId("6257246e21393d9d4d975b11"), "name" : "Машка", "birthday_at" : "2006-08-29", "created_at" : ISODate("2022-04-13T19:28:46.345Z") }
{ "_id" : ObjectId("6257247921393d9d4d975b12"), "name" : "Светлашка", "birthday_at" : "1988-02-04", "created_at" : ISODate("2022-04-13T19:28:57.763Z") }
{ "_id" : ObjectId("6257248321393d9d4d975b13"), "name" : "Олег", "birthday_at" : "1998-03-20", "created_at" : ISODate("2022-04-13T19:29:07.747Z") }
{ "_id" : ObjectId("6257248b21393d9d4d975b14"), "name" : "Юлия", "birthday_at" : "2006-02-17", "created_at" : ISODate("2022-04-13T19:29:15.834Z") }
*/

