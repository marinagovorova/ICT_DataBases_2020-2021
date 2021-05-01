INSERT INTO author (author_name, author_surname, author_patronymic, author_email)
VALUES 
	('Иван', 'Иванов', 'Иванович', 'ivan@gmail.com'), 
	('Петр', 'Петров', 'Петрович', 'petr@gmail.com');
SELECT * FROM author;
	
INSERT INTO book (book_pages, book_illustrated, book_year, book_name)
VALUES
	(100, true, 1999, 'Колобок'), 
	(200, false, 2010, 'Русские народные сказки');
SELECT * FROM book;

INSERT INTO category (category)
VALUES 
	('Сказки');
SELECT * FROM category;

INSERT INTO client (client_name, client_surname, client_patronymic, client_address, client_phone)
VALUES 
	('Олег', 'Олегов', NULL, 'Россия, Санкт-Петербруг, Невский пр., 1', '79211111111'), 
	('Мария', 'Сидоровна', NULL, 'Россия, Санкт-Петербруг, Кронверкский пр., 1', '79212222222');
SELECT * FROM client;

INSERT INTO manager (manager_name, manager_surname, manager_patronymic, manager_phone)
VALUES 
	('Василий', 'Васильев', NULL, '79213333333');
SELECT * FROM manager;