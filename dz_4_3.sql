-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

USE vk;

-- добавляем столбец со значением по умолчанию (DEFAULT) = 1
ALTER TABLE profiles  
ADD COLUMN is_active BIT DEFAULT 1;

-- обновляем данные в этом столбце, делая его = 0 для тех, кто младше 18-ти по условию (WHERE) если ДР + 18 лет > текущей даты
UPDATE profiles 
SET 
	is_active = 0
WHERE birthday + INTERVAL 18 YEAR > NOW();

-- а так можно посмотреть на совершеннолетних, выведя имя из одной таблицы по условию из второй
SELECT firstname, lastname, birthday FROM profiles, users 
WHERE is_active = 1 AND id = user_id;

