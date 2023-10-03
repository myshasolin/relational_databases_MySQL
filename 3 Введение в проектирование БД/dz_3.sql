-- Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)

USE vk;

DROP TABLE IF EXISTS users_sympathy;
CREATE TABLE users_sympathy(
	id SERIAL,
	from_which_user_id BIGINT UNSIGNED NOT NULL COMMENT 'от какого пользователя',
	for_which_user BIGINT UNSIGNED NOT NULL COMMENT 'какому пользователю',
	created_at DATETIME DEFAULT NOW() COMMENT 'дата создания оценки',
	updated_at DATETIME ON UPDATE NOW() COMMENT 'дата изменения оценки',
	sympathy ENUM('exellent', 'very_good', 'good', 'satisfactory', 'fail') COMMENT 'вид оценки',
	body VARCHAR(255) DEFAULT NULL COMMENT 'текст поста',
	
	PRIMARY KEY (from_which_user_id, for_which_user),
	FOREIGN KEY (from_which_user_id) REFERENCES users(id),
	FOREIGN KEY (for_which_user) REFERENCES users(id),
	CHECK (from_which_user_id != for_which_user)	
) COMMENT 'таблица симпатий пользователей';

DROP TABLE IF EXISTS group_chats;
CREATE TABLE group_chats(
	id SERIAL,
	chat_name VARCHAR(255) COMMENT 'название чата',
	chat_created_at DATETIME DEFAULT NOW() COMMENT 'дата создания чата',
	chat_initiator_id BIGINT UNSIGNED NOT NULL COMMENT 'автор темы',
	
	INDEX (chat_name),
	FOREIGN KEY (chat_initiator_id) REFERENCES users(id)
) COMMENT 'таблица чата';

DROP TABLE IF EXISTS users_group_chats;
CREATE TABLE users_group_chats(
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'участник чата',
	status_user_id ENUM('beginner', 'veteran', 'ban') COMMENT 'статус',
	chat_id BIGINT UNSIGNED NOT NULL COMMENT 'чат',
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (chat_id) REFERENCES group_chats(id)
) COMMENT 'таблица пользователей и чатов';

DROP TABLE IF EXISTS messages_chat;
CREATE TABLE messages_chat(
	id_mess INT UNSIGNED NOT NULL,
	id_chat SERIAL,
	mess_author_id BIGINT UNSIGNED NOT NULL COMMENT 'автор сообщения',
	mess_created_at DATETIME DEFAULT NOW() COMMENT 'дата создания сообщения',
	body TEXT COMMENT 'текст сообщения',
	mess_updated_at DATETIME ON UPDATE NOW() COMMENT 'дата редактирования',
	
	FOREIGN KEY (mess_author_id) REFERENCES users(id),
	FOREIGN KEY (id_chat) REFERENCES group_chats(id)
) COMMENT 'сообщения чата';

DROP TABLE IF EXISTS video_tiktok_style;
CREATE TABLE video_tiktok_style(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	video_name VARCHAR(255) COMMENT 'название',
	metadata JSON COMMENT 'всякая доп.инфа',
	created_at DATETIME DEFAULT NOW() COMMENT 'дата создания записи',
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления записи',
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS gifts_types;
CREATE TABLE gifts_types(
	id SERIAL,
	gift_category VARCHAR(100) # 'economy', 'average', 'expensive', 'vip'
) COMMENT 'таблица для сегментирования подарков на категории';

DROP TABLE IF EXISTS gifts;
CREATE TABLE gifts(
	id SERIAL,
	gifts_type_id BIGINT UNSIGNED NOT NULL COMMENT 'категория',
	from_user_id BIGINT UNSIGNED NOT NULL COMMENT 'отправитель',
	to_user_id BIGINT UNSIGNED NOT NULL COMMENT 'получатель',
	body VARCHAR(200) DEFAULT '' COMMENT 'текст сообщения',
	created_at DATETIME DEFAULT NOW() COMMENT 'дата отправки подарка',
	
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id),
	FOREIGN KEY (gifts_type_id) REFERENCES gifts_types(id),
	CHECK (from_user_id != to_user_id)
);