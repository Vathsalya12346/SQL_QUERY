ALTER TABLE Products ADD tax_rate DECIMAL(5, 2) DEFAULT 12.00;
UPDATE Products SET tax_rate = 12.00;

SELECT title FROM Titles WHERE title LIKE '%s' OR title LIKE '%t';


SELECT * FROM Titles WHERE type IN ('Business', 'Psychology', 'Undecided');


SELECT title FROM Titles WHERE sales > 5000 AND royalty < 20;

SELECT title FROM Titles WHERE pub_id = 0736 ORDER BY sales ASC;

SELECT MAX(royalty) - MIN(royalty) AS royalty_difference FROM Titles WHERE pub_id = 0877;

SELECT author_id, COUNT(title_id) AS books_written FROM Title_Author GROUP BY author_id;

SELECT title_id, COUNT(author_id) AS number_of_authors FROM Title_Author GROUP BY title_id;

SELECT author_id, AVG(royalty) AS average_royalty FROM Titles T
JOIN Title_Author TA ON T.title_id = TA.title_id WHERE TA.author_id = 1 GROUP BY author_id;

SELECT title FROM Titles WHERE sales BETWEEN 10000 AND 20000 ORDER BY price;

SELECT COUNT(*) AS authors_in_menlo_park FROM Authors WHERE city = 'Menlo Park';

SELECT state, COUNT(author_id) AS num_authors FROM Authors GROUP BY state ORDER BY state;

SELECT state FROM Authors WHERE first_name LIKE 'S%' GROUP BY state HAVING COUNT(author_id) > 2;

SELECT REPLACE(REPLACE(title, ' ', '.'), '-', '*') AS modified_title FROM Titles;

SELECT REPLACE(title, ' ', '') AS title_no_spaces FROM Titles;

SELECT LEFT(title, CHARINDEX(' ', title + ' ') - 1) AS first_word FROM Titles;

SELECT MONTH(publication_date) AS publish_month, COUNT(title_id) AS books_published
FROM Titles
GROUP BY MONTH(publication_date);

SELECT T.title, P.pub_name
FROM Titles T
JOIN Publishers P ON T.pub_id = P.pub_id
WHERE P.country = 'USA';

SELECT P.pub_name, AVG(T.price) AS average_price
FROM Titles T
JOIN Publishers P ON T.pub_id = P.pub_id
GROUP BY P.pub_name;

SELECT A.city, COUNT(TA.title_id) AS books_written
FROM Authors A
JOIN Title_Author TA ON A.author_id = TA.author_id
GROUP BY A.city;

SELECT A.first_name + ' ' + A.last_name AS author_name, T.title
FROM Authors A
LEFT JOIN Title_Author TA ON A.author_id = TA.author_id
LEFT JOIN Titles T ON TA.title_id = T.title_id;

SELECT T.title, P.pub_name, A.first_name + ' ' + A.last_name AS primary_author
FROM Titles T
JOIN Title_Author TA ON T.title_id = TA.title_id
JOIN Authors A ON TA.author_id = A.author_id
JOIN Publishers P ON T.pub_id = P.pub_id
WHERE TA.author_id = (SELECT MIN(author_id) FROM Title_Author WHERE title_id = T.title_id);

SELECT P.city, MAX(T.price) AS max_price
FROM Publishers P
JOIN Titles T ON P.pub_id = T.pub_id
GROUP BY P.city;

SELECT T.title
FROM Titles T
JOIN Title_Author TA ON T.title_id = TA.title_id
JOIN Authors A ON TA.author_id = A.author_id
WHERE A.city = 'Menlo Park';

SELECT DISTINCT P.pub_name
FROM Publishers P
JOIN Titles T ON P.pub_id = T.pub_id
WHERE YEAR(T.publication_date) = 1991;

SELECT T.title
FROM Titles T
JOIN Publishers P ON T.pub_id = P.pub_id
WHERE P.country = 'USA' OR T.price < 5;

CREATE VIEW TitleDetails AS
SELECT T.title,
       P.pub_name AS publisher,
       YEAR(T.publication_date) AS year_of_publishing,
       ISNULL(T.price, 0) AS price,
       ISNULL(T.type, 'Unknown') AS type
FROM Titles T
JOIN Publishers P ON T.pub_id = P.pub_id;

SELECT DISTINCT P.pub_name
FROM Publishers P
JOIN Titles T ON P.pub_id = T.pub_id
JOIN Title_Author TA ON T.title_id = TA.title_id
GROUP BY P.pub_name, TA.author_id
HAVING COUNT(TA.title_id) > 2;

DELETE FROM Title_Author
WHERE author_id IN (SELECT author_id FROM Authors WHERE first_name = 'Dean');

SELECT title
FROM Titles
WHERE DATEDIFF(YEAR, publication_date, GETDATE()) <= 25;

UPDATE Titles
SET price = (SELECT price FROM Titles WHERE title_id = 'MC2222')
WHERE title_id = 'BU1111';


SELECT T.title
FROM Titles T
WHERE T.pub_id IN (SELECT pub_id FROM Titles WHERE YEAR(publication_date) = 2021);

CREATE VIEW PublisherSummary AS
SELECT P.pub_name AS publisher,
       P.city,
       COUNT(T.title_id) AS books_published
FROM Publishers P
LEFT JOIN Titles T ON P.pub_id = T.pub_id
GROUP BY P.pub_name, P.city;




