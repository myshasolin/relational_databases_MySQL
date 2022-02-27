-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

USE vk;

SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;

/*
Из документации:

SELECT
	[DISTINCT] - выводит только уникальные значения
	select_expr
	[FROM table_references]
	[ORDER BY {col_name}
		[ASC]] - сортирует вывод "по возрастанию" (в нашем случае по алфавиту)
*/

