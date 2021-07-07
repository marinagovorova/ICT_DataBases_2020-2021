INSERT INTO edition (edition_date, edition_size, edition_warehouse, edition_price, book_id, order_id, isbn)
VALUES 
	('2021-04-20', 1000, 500, 220.0, 75, 1, '123456789012'), 
	('2021-04-23', 5000, 1000, 499.9, 76, 1, '0123456789012');
SELECT * FROM edition;