-- i. Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)


USE vk;

INSERT INTO users (firstname, lastname, email, phone)
VALUES
	('Xzavier', 'Parker', 'miller.samantha@example.net', 88393234398),
	('Everett', 'Ullrich', 'anais.rosenbaum@example.org', 88475506329),
	('Vena', 'Zieme', 'chance.jacobs@example.com', 88718300049),
	('Iva', 'Bahringer', 'veichmann@example.net', 88721753505),
	('Rosemary', 'Wilderman', 'curt.walsh@example.net', 88568094428),
	('Margaret', 'Adams', 'donnie04@example.com', 88184155888),
	('Diamond', 'Kiehn', 'faye.leuschke@example.com', 88987559120),
	('Reece', 'Doyle', 'aubree.schmidt@example.org', 88111663623),
	('Rigoberto', 'Herzog', 'darion15@example.org', 88860018181),
	('Rosetta', 'Simonis', 'lockman.jammie@example.org', 88481096292),
	('Norval', 'Dickinson', 'pouros.lenore@example.org', 88287616787),
	('Rodger', 'Botsford', 'karolann.torp@example.net', 88833146069),
	('Helena', 'Kutch', 'orlo62@example.org', 88175181419),
	('Cristopher', 'O\'Kon', 'jermey.emmerich@example.net', 88814853822),
	('Verdie', 'Schimmel', 'mann.aliza@example.com', 88929546650)
;

INSERT INTO profiles (user_id, gender, birthday, photo_id, hometown)
VALUES 
	(1, 'm', '2007-03-25', 1, 'Idellaland'),
	(2, 'm', '2012-11-18', 2, 'East Emilefort'),
	(3, 'w', '2017-01-30', 3, 'Gutkowskiview'),
	(4, 'w', '2008-08-25', 4, 'Estellton'),
	(5, 'w', '1989-04-26', 5, 'Cadeville'),
	(6, 'w', '1984-08-12', 6, 'Davisport'),
	(7, 'm', '1973-10-16', 7, 'Considineport'),
	(8, 'm', '2011-12-03', 8, 'Port Elishaview'),
	(9, 'm', '2000-06-05', 9, 'Port Hailey'),
	(10, 'w', '1988-01-21', 10, 'Leschville'),
	(11, 'm', '1981-05-20', 11, 'South Colleen'),
	(12, 'm', '1979-03-30', 12, 'Caylafort'),
	(13, 'w', '1975-08-20', 13, 'Monicaburgh'),
	(14, 'm', '1998-06-22', 14, 'Port Jessycahaven'),
	(15, 'm', '1999-08-07', 15, 'North Eleonore')
;

INSERT INTO messages (from_user_id, to_user_id, body)
VALUES
	(1, 2, 'lobortis mattis aliquam faucibus purus in massa tempor nec feugiat nisl pretium fusce id velit'),
	(1, 3, 'nullam ac tortor vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra tellus in'),
	(3, 2, 'placerat duis ultricies lacus sed turpis tincidunt id aliquet risus feugiat in ante metus dictum'),
	(2, 3, 'pulvinar sapien et ligula ullamcorper malesuada proin libero nunc consequat interdum varius sit amet mattis'),
	(6, 10, 'convallis aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius'),
	(11, 12, 'suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra'),
	(14, 1, 'tellus in hac habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt'),
	(15, 8, 'magna fermentum iaculis eu non diam phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet'),
	(1, 12, 'elit dignissim sodales ut eu sem integer vitae justo eget magna fermentum iaculis eu non'),
	(3, 5, 'sapien pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas sed'),
	(2, 1, 'etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus in ornare quam viverra orci')
;

INSERT INTO friend_requests (initiator_user_id, target_user_id)
VALUES 
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10)
;

UPDATE friend_requests 
SET
	status = 'approved'
WHERE initiator_user_id = 1 AND target_user_id = 2 OR
initiator_user_id = 1 AND target_user_id = 3 OR
initiator_user_id = 1 AND target_user_id = 4
;

UPDATE friend_requests 
SET
	status = 'unfriended'
WHERE initiator_user_id = 1 AND target_user_id = 8 OR
initiator_user_id = 1 AND target_user_id = 9 OR
initiator_user_id = 1 AND target_user_id = 10
;

UPDATE friend_requests 
SET
	status = 'declined'
WHERE initiator_user_id = 1 AND target_user_id = 5 OR
initiator_user_id = 1 AND target_user_id = 6 OR
initiator_user_id = 1 AND target_user_id = 7
;

INSERT INTO communities (name, admin_user_id)
VALUES 
	('lorem ipsum dolor sit', 6),
	('sit amet aliquam id', 2),
	('blandit turpis cursus in', 1),
	('rutrum quisque non tellus', 4),
	('faucibus nisl tincidunt eget', 5),
	('a cras semper auctor', 2),
	('aliquet nec ullamcorper sit', 12),
	('a diam maecenas sed', 13),
	('proin nibh nisl condimentum', 3),
	('urna neque viverra justo', 5)
;

INSERT INTO users_communities (user_id, community_id)
VALUES 
	(6, 1),
	(2, 2),
	(1, 3),
	(4, 4),
	(5, 5),
	(2, 6),
	(12, 7),
	(13, 8),
	(3, 9),
	(5, 10)
;

INSERT INTO media_types (filename)
VALUES 
	('text'),
	('video'),
	('music'),
	('image')
;

INSERT INTO media (user_id, media_type_id, body, filename)
VALUES 
	(3, 2, 'eget velit aliquet sagittis id consectetur', 'congue'),
	(5, 1, 'purus sit amet luctus venenatis lectus magna', 'fringilla ut'),
	(1, 4, 'nulla facilisi cras fermentum odio eu feugiat', 'velit'),
	(8, 1, 'turpis nunc eget lorem dolor sed viverra', 'fermentum'),
	(4, 4, 'fermentum leo vel orci porta non pulvinar', 'diam donec'),
	(8, 4, 'faucibus vitae aliquet nec ullamcorper sit amet', 'arcu'),
	(15, 3, 'aliquam eleifend mi in nulla posuere sollicitudin', 'viverra'),
	(11, 1, 'ipsum a arcu cursus vitae congue mauris', 'ultrices'),
	(9, 4, 'sollicitudin aliquam ultrices sagittis orci a scelerisque', 'leo integer malesuada'),
	(2, 2, 'sem nulla pharetra diam sit amet nisl', 'eget'),
	(2, 1, 'ut tristique et egestas quis ipsum suspendisse', 'pharetra'),
	(6, 3, 'risus nullam eget felis eget nunc lobortis', 'bibendum'),
	(13, 4, 'integer malesuada nunc vel risus commodo viverra', 'sem nulla'),
	(11, 4, 'in egestas erat imperdiet sed euismod nisi', 'ultrices'),
	(1, 1, 'magna fringilla urna porttitor rhoncus dolor purus', 'enim'),
	(7, 1, 'eros in cursus turpis massa tincidunt dui', 'pulvinar')
;


INSERT INTO likes (user_id, media_id)
VALUES 
	(3, 9),
	(5, 4),
	(3, 2),
	(14, 10),
	(9, 1)
;

INSERT INTO photo_albums (name, user_id)
VALUES 
	('donec et odio pellentesque', 2),
	('condimentum id venenatis a', 1),
	('scelerisque mauris pellentesque pulvinar', 15),
	('faucibus turpis in eu', 2),
	('in pellentesque massa placerat', 4),
	('mattis enim ut tellus', 6),
	('eget mi proin sed', 10),
	('non consectetur a erat', 13),
	('sed turpis tincidunt id', 1),
	('natoque penatibus et magnis', 9),
	('quis imperdiet massa tincidunt', 7),
	('vulputate sapien nec sagittis', 14),
	('aliquet lectus proin nibh', 8),
	('aliquam ultrices sagittis orci', 5),
	('porta lorem mollis aliquam', 11)
;

INSERT INTO photos (media_id, album_id)
VALUES 
	(3, 1),
	(5, 5),
	(6, 7),
	(9, 9),
	(13, 11),
	(14, 14)
;

INSERT INTO users_sympathy (from_which_user_id, for_which_user, sympathy, body)
VALUES 
	(2, 1, 'exellent', 'convallis posuere morbi leo'),
	(1, 2, 'good', 'facilisi cras fermentum odio'),
	(5, 7, 'very_good', 'vitae purus'),
	(5, 1, 'good', 'fusce ut placerat orci nulla pellentesque'),
	(8, 11, 'very_good', 'turpis'),
	(15, 3, 'exellent', 'vestibulum morbi blandit cursus risus at'),
	(12, 14, 'exellent', 'tortor dignissim'),
	(6, 2, 'very_good', 'vulputate odio'),
	(8, 10, 'fail', 'ac tortor vitae purus'),
	(2, 13, 'very_good', 'tincidunt augue interdum')
;

INSERT INTO video_tiktok_style (user_id, video_name)
VALUES 
	(3, 'duis ut diam'),
	(4, 'sit amet luctus venenatis'),
	(9, 'risus quis'),
	(11, 'rhoncus est'),
	(8, 'quam viverra orci sagittis'),
	(1, 'pellentesque'),
	(3, 'duis ut diam'),
	(14, 'mauris vitae'),
	(3, 'tellus'),
	(2, 'cursus sit amet'),
	(14, 'nunc vel risus'),
	(7, 'porta lorem mollis aliquam ut'),
	(5, 'sollicitudin'),
	(10, 'integer'),
	(2, 'metus vulputate'),
	(6, 'elit eget'),
	(5, 'viverra accumsan in nisl')
;

INSERT INTO gifts_types (gift_category)
VALUES 
	('economy'),
	('average'),
	('expensive'),
	('vip')
;

INSERT INTO gifts (gifts_type_id, from_user_id, to_user_id, body)
VALUES 
	(4, 1, 2, 'leo integer malesuada nunc'),
	(2, 2, 1, 'aliquet eget sit amet'),
	(1, 15, 1, 'velit scelerisque in dictum non consectetur'),
	(2, 14, 5, 'erat velit'),
	(3, 9, 7, 'tristique risus nec feugiat'),
	(1, 7, 8, 'ipsum dolor sit amet'),
	(1, 1, 2, 'nam'),
	(4, 12, 3, 'nascetur ridiculus mus mauris'),
	(1, 5, 2, 'vulputate mi'),
	(1, 8, 10, 'feugiat nibh sed pulvinar proin gravida'),
	(1, 3, 4, 'placerat')
;












