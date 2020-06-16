--1. INSERT
-- 1.1 Без указания списка полей
INSERT INTO store VALUES (1, 'BestStore', 'Yoshkar-Ola pl Lenina 3', 200, 'U.A.Ivanov');
-- 1.2 С указанием списка полей
INSERT INTO book (id_book, title) VALUES (8, 'The Shining');
--1.3 С чтением значения из другой таблицы
INSERT INTO book_in_store(id_book) SELECT id_book FROM book;

--2. DELETE
-- 2.1 Всех записей
DELETE FROM store;
-- 2.2 По условию
DELETE FROM store WHERE id_store > 6;
-- 2.3 Очистить таблицу
TRUNCATE TABLE book_in_store;

--3. UPDATE
-- 3.1 Всех записей
UPDATE book
SET title = 'The Green Mile', isbn = '0987654321098', price = '200';
-- 3.2 По условию обновляя один атрибут
UPDATE book
SET isbn = '6789012345678' WHERE title = 'The Shining';
-- 3.3 По условию обновляя несколько атрибутов
UPDATE store
SET name = 'TopBestStore', number_of_books = '210' WHERE adress = 'Yoshkar-Ola pl Lenina 3';


--4. SELECT
-- 4.1 С определенным набором извлекаемых атрибутов
SELECT title, isbn FROM book;
-- 4.2 Со всеми атрибутами
SELECT * FROM book;
-- 4.3 С условием по атрибуту
SELECT * FROM book WHERE title = 'The Green Mile';


-- 5. SELECT ORDER BY + TOP (LIMIT)
-- 5.1 С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT * FROM book ORDER BY title ASC;
-- 5.2 С сортировкой по убыванию DESC
SELECT * FROM book ORDER BY price DESC;
-- 5.3 С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT TOP 10 * FROM book ORDER BY title, price DESC;
-- 5.4  С сортировкой по первому атрибуту, из списка извлекаемых
SELECT title, price FROM book ORDER BY 1;


--6. Работа с датами. Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME.
-- 6.1 WHERE по дате
SELECT title FROM book WHERE year_of_writing = '01.01.1977';
-- 6.2 Извлечь из таблицы не всю дату, а только год
SELECT YEAR(year_of_writing) from book;


--7. SELECT GROUP BY с функциями агрегации
-- 7.1 MIN
SELECT title, MIN(price) AS min_price FROM book GROUP BY title;
-- 7.2 MAX
SELECT title, MAX(price) AS max_price FROM book GROUP BY title;
-- 7.3 AVG
SELECT title, AVG(price) AS avg_price FROM book GROUP BY title;
-- 7.4 SUM
SELECT title, SUM(price) AS sum_price FROM book GROUP BY title;
-- 7.5 COUNT
SELECT title, COUNT(price) AS count_price FROM book GROUP BY title;


-- SELECT GROUP BY + HAVING
-- 8.1
SELECT title, price FROM book GROUP BY title, price HAVING sum(price) > 500;
-- 8.2
SELECT year_of_writing FROM book GROUP BY year_of_writing HAVING YEAR(year_of_writing)  > 1991;
-- 8.3
SELECT isbn FROM book GROUP BY isbn
HAVING MIN(DATEPART(year, year_of_writing)) < 1980;


--9. SELECT JOIN
-- 9.1 LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT * FROM "book" LEFT JOIN publisher on "book".id_publisher = publisher.id_publisher WHERE publisher.id_publisher > 156;

-- 9.2 RIGHT JOIN. Получить такую же выборку, как и в 9.1
SELECT * FROM "book" RIGHT JOIN publisher on "book".id_publisher = publisher.id_publisher WHERE publisher.id_publisher > 156 ORDER BY title ASC;

-- 9.3 LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT * FROM book LEFT JOIN publisher on "book".id_publisher = publisher.id_publisher
LEFT JOIN buyer on "book".id_book = buyer.id_book
WHERE buyer.name = 'Afonasii' and "publisher".phone = '89276736461' and book.id_book = 128;

-- 9.4 FULL OUTER JOIN двух таблиц
SELECT * FROM "book" FULL OUTER JOIN publisher on "book".id_publisher = publisher.id_publisher;


--10. Подзапросы
-- 10.1 Написать запрос с WHERE IN (подзапрос)
SELECT title, isbn FROM "book" WHERE price IN ('100', '400');
-- 10.2 Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
SELECT id_book, title FROM "book" WHERE price > (SELECT MIN(price) FROM "book");