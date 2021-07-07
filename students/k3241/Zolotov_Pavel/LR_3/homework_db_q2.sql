INSERT INTO author_book (author_id, book_id, "order")
VALUES
	(75, 75, 1), 
	(76, 76, 1);
SELECT * FROM author_book;
	
INSERT INTO category_book (book_id, category_id)
VALUES 
	(75, 35), 
	(76, 35);
SELECT * FROM category_book;

INSERT INTO "order" (order_date, order_finish, order_size, order_status, client_id, manager_id)
VALUES 
	('2021-04-18', '2021-05-14', 6000, 'p', 39, 1);
SELECT * FROM "order";