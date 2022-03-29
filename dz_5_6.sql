-- Подсчитайте средний возраст пользователей в таблице users

SELECT * FROM users;

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 2) AS "средний возраст" FROM users;
