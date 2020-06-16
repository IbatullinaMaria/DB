--1. INSERT
-- 1.1 ��� �������� ������ �����
INSERT INTO store VALUES (1, 'BestStore', 'Yoshkar-Ola pl Lenina 3', 200, 'U.A.Ivanov');
-- 1.2 � ��������� ������ �����
INSERT INTO book (id_book, title) VALUES (8, 'The Shining');
--1.3 � ������� �������� �� ������ �������
INSERT INTO book_in_store(id_book) SELECT id_book FROM book;

--2. DELETE
-- 2.1 ���� �������
DELETE FROM store;
-- 2.2 �� �������
DELETE FROM store WHERE id_store > 6;
-- 2.3 �������� �������
TRUNCATE TABLE book_in_store;

--3. UPDATE
-- 3.1 ���� �������
UPDATE book
SET title = 'The Green Mile', isbn = '0987654321098', price = '200';
-- 3.2 �� ������� �������� ���� �������
UPDATE book
SET isbn = '6789012345678' WHERE title = 'The Shining';
-- 3.3 �� ������� �������� ��������� ���������
UPDATE store
SET name = 'TopBestStore', number_of_books = '210' WHERE adress = 'Yoshkar-Ola pl Lenina 3';


--4. SELECT
-- 4.1 � ������������ ������� ����������� ���������
SELECT title, isbn FROM book;
-- 4.2 �� ����� ����������
SELECT * FROM book;
-- 4.3 � �������� �� ��������
SELECT * FROM book WHERE title = 'The Green Mile';


-- 5. SELECT ORDER BY + TOP (LIMIT)
-- 5.1 � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT * FROM book ORDER BY title ASC;
-- 5.2 � ����������� �� �������� DESC
SELECT * FROM book ORDER BY price DESC;
-- 5.3 � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT TOP 10 * FROM book ORDER BY title, price DESC;
-- 5.4  � ����������� �� ������� ��������, �� ������ �����������
SELECT title, price FROM book ORDER BY 1;


--6. ������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
-- 6.1 WHERE �� ����
SELECT title FROM book WHERE year_of_writing = '01.01.1977';
-- 6.2 ������� �� ������� �� ��� ����, � ������ ���
SELECT YEAR(year_of_writing) from book;


--7. SELECT GROUP BY � ��������� ���������
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
-- 9.1 LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT * FROM "book" LEFT JOIN publisher on "book".id_publisher = publisher.id_publisher WHERE publisher.id_publisher > 156;

-- 9.2 RIGHT JOIN. �������� ����� �� �������, ��� � � 9.1
SELECT * FROM "book" RIGHT JOIN publisher on "book".id_publisher = publisher.id_publisher WHERE publisher.id_publisher > 156 ORDER BY title ASC;

-- 9.3 LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
SELECT * FROM book LEFT JOIN publisher on "book".id_publisher = publisher.id_publisher
LEFT JOIN buyer on "book".id_book = buyer.id_book
WHERE buyer.name = 'Afonasii' and "publisher".phone = '89276736461' and book.id_book = 128;

-- 9.4 FULL OUTER JOIN ���� ������
SELECT * FROM "book" FULL OUTER JOIN publisher on "book".id_publisher = publisher.id_publisher;


--10. ����������
-- 10.1 �������� ������ � WHERE IN (���������)
SELECT title, isbn FROM "book" WHERE price IN ('100', '400');
-- 10.2 �������� ������ SELECT atr1, atr2, (���������) FROM ...
SELECT id_book, title FROM "book" WHERE price > (SELECT MIN(price) FROM "book");