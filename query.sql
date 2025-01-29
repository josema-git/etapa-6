-- Mostrar bases de datos
SHOW DATABASES;

-- Crear base de datos
CREATE DATABASE test;

-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS test;

-- Usar base de datos
USE test;

-- Eliminar base de datos
DROP DATABASE test;

-- Crear tabla test_book si no existe
CREATE TABLE IF NOT EXISTS test_book (
  book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  author_id INTEGER UNSIGNED,
  title VARCHAR(100) NOT NULL,
  year INTEGER UNSIGNED NOT NULL DEFAULT 0,
  language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
  cover_url VARCHAR(500),
  price DOUBLE(6,2) NOT NULL DEFAULT 10.00,
  sellable TINYINT(1) NOT NULL DEFAULT 1,
  copies INTEGER UNSIGNED NOT NULL DEFAULT 1,
  description TEXT
);

-- Crear tabla test_author si no existe
CREATE TABLE IF NOT EXISTS test_author (
  author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  nationality VARCHAR(3)
);

-- Crear tabla test_clients si no existe
CREATE TABLE IF NOT EXISTS test_clients (
  client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  birthday DATETIME,
  gender ENUM('M', 'F', 'ND') NOT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Agregar columna a test_book
ALTER TABLE test_book ADD COLUMN new_column INTEGER UNSIGNED;

-- Modificar columna en test_book
ALTER TABLE test_book MODIFY COLUMN new_column INTEGER UNSIGNED NOT NULL;

-- Cambiar nombre de columna en test_book
ALTER TABLE test_book CHANGE COLUMN new_column another_column INTEGER UNSIGNED NOT NULL;

-- Alterar columna en test_book
ALTER TABLE test_book ALTER COLUMN another_column SET DEFAULT 0;

-- Eliminar columna en test_book
ALTER TABLE test_book DROP COLUMN another_column;

-- Mostrar tablas
SHOW TABLES;

-- Mostrar columnas de test_book
SHOW FULL COLUMNS FROM test_book;

-- Describir tabla test_book
DESCRIBE test_book;

-- Eliminar tabla test_book
DROP TABLE test_book;

-- Insertar en test_clients
INSERT INTO test_clients (name, email, birthday, gender) VALUES ('John Doe', 'jhondoe@gmail.com', '1990-01-01', 'M')
ON DUPLICATE KEY UPDATE name = 'John Doe';

-- Insertar en test_book
INSERT INTO test_book (author_id, title, year) VALUES ((SELECT author_id FROM test_author WHERE name = 'Octavio Paz' LIMIT 1), 'Book Title', 2020);


-- Selecciona todos los registros de la tabla clients
SELECT * FROM clients;

-- Selecciona solo el nombre de todos los registros de la tabla clients
SELECT name FROM clients;

-- Selecciona el nombre, email y género de todos los registros de la tabla clients
SELECT name, email, gender FROM clients;

-- Selecciona el nombre, email y género de los primeros 10 registros de la tabla clients
SELECT name, email, gender FROM clients LIMIT 10;

-- Selecciona el nombre, email y género de los registros de la tabla clients donde el género es masculino
SELECT name, email, gender FROM clients WHERE gender = 'male';

-- Selecciona el año de nacimiento de todos los registros de la tabla clients
SELECT YEAR(birth_date) FROM clients;

-- Selecciona el año actual
SELECT YEAR(CURDATE());

-- Selecciona la diferencia entre el año actual y el año de nacimiento de los primeros 10 registros de la tabla clients
SELECT YEAR(CURDATE()) - YEAR(birth_date) AS age FROM clients LIMIT 10;

-- Selecciona el nombre y la diferencia entre el año actual y el año de nacimiento de los primeros 10 registros de la tabla clients
SELECT name, YEAR(CURDATE()) - YEAR(birth_date) AS age FROM clients LIMIT 10;

-- Selecciona todos los registros de la tabla clients donde el nombre contiene 'Saave'
SELECT * FROM clients WHERE name LIKE '%Saave%';

-- Selecciona el nombre, email, edad calculada y género de los registros de la tabla clients donde el género es femenino y el nombre contiene 'Lop'
SELECT name, email, YEAR(CURDATE()) - YEAR(birth_date) AS age, gender FROM clients WHERE gender = 'female' AND name LIKE '%Lop%';

-- Selecciona todos los registros de la tabla authors donde el author_id es mayor que 0 y menor o igual a 5
SELECT * FROM authors WHERE author_id > 0 AND author_id <= 5;

-- Selecciona todos los registros de la tabla authors donde el author_id está entre 1 y 5
SELECT * FROM authors WHERE author_id BETWEEN 1 AND 5;

-- Selecciona el book_id, author_id y título de los libros donde el author_id está entre 1 y 5
SELECT book_id, author_id, title FROM books WHERE author_id BETWEEN 1 AND 5;

-- Selecciona el book_id, nombre del autor, author_id y título de los libros donde el author_id está entre 1 y 5, utilizando un JOIN entre las tablas books y authors
SELECT books.book_id, authors.name AS author_name, books.author_id, books.title 
FROM books 
JOIN authors ON books.author_id = authors.author_id 
WHERE books.author_id BETWEEN 1 AND 5;

-- Selecciona el nombre del cliente, título del libro y tipo de transacción para las transacciones donde el género del cliente es femenino y el tipo de transacción es 'sell', utilizando un JOIN entre las tablas transactions, books y clients
SELECT clients.name AS client_name, books.title AS book_title, transactions.transaction_type 
FROM transactions 
JOIN books ON transactions.book_id = books.book_id 
JOIN clients ON transactions.client_id = clients.client_id 
WHERE clients.gender = 'female' AND transactions.transaction_type = 'sell';

-- Selecciona el nombre del cliente, título del libro, nombre del autor y tipo de transacción para las transacciones donde el género del cliente es masculino y el tipo de transacción es 'sell' o 'lend', utilizando un JOIN entre las tablas transactions, books, clients y authors
SELECT clients.name AS client_name, books.title AS book_title, authors.name AS author_name, transactions.transaction_type 
FROM transactions 
JOIN books ON transactions.book_id = books.book_id 
JOIN clients ON transactions.client_id = clients.client_id 
JOIN authors ON books.author_id = authors.author_id 
WHERE clients.gender = 'male' AND (transactions.transaction_type = 'sell' OR transactions.transaction_type = 'lend');

-- Right Join
SELECT columna_1, columna_2, columna_3, ... columna_n
FROM Tabla_A A
RIGHT JOIN Tabla_B B ON A.pk = B.pk;

-- Outer Join
SELECT columna_1, columna_2, columna_3, ... columna_n
FROM Tabla_A A
FULL OUTER JOIN Tabla_B B ON A.pk = B.pk;

-- Left excluding join
SELECT columna_1, columna_2, columna_3, ... columna_n
FROM Tabla_A A
LEFT JOIN Tabla_B B ON A.pk = B.pk
WHERE B.pk IS NULL;

-- Right excluding join
SELECT columna_1, columna_2, columna_3, ... columna_n
FROM Tabla_A A
RIGHT JOIN Tabla_B B ON A.pk = B.pk
WHERE A.pk IS NULL;

-- Outer excluding join
SELECT select_list
FROM Table_A A
FULL OUTER JOIN Table_B B ON A.Key = B.Key
WHERE A.Key IS NULL OR B.Key IS NULL;

-- Consultas adicionales
-- 1. ¿Qué nacionalidades hay?
SELECT DISTINCT nationality FROM authors ORDER BY 1;

-- 2. ¿Cuántos escritores hay de cada nacionalidad?
SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
WHERE nationality IS NOT NULL AND nationality NOT IN ('RUS', 'AUT')
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;

-- 4. ¿Cuál es el promedio/desviación estándar del precio de libros?
SELECT a.nationality, AVG(b.price) AS promedio, STDDEV(b.price) AS std
FROM books AS b
JOIN authors AS a ON a.author_id = b.author_id
GROUP BY a.nationality
ORDER BY promedio DESC;

-- 5. ¿Cuál es el promedio/desviación estándar del precio de libros por nacionalidad?
SELECT a.nationality, COUNT(b.book_id) AS libros, AVG(b.price) AS promedio, STDDEV(b.price) AS std
FROM books AS b
JOIN authors AS a ON a.author_id = b.author_id
GROUP BY a.nationality
ORDER BY libros DESC;

-- 6. ¿Cuál es el precio máximo/mínimo de un libro?
SELECT nationality, MAX(price), MIN(price)
FROM books AS b
JOIN authors AS a ON a.author_id = b.author_id
GROUP BY nationality;

-- 7. ¿Cómo quedaría el reporte de préstamos?
SELECT c.name, t.type, b.title, CONCAT(a.name, " (", a.nationality, ")") AS autor, TO_DAYS(NOW()) - TO_DAYS(t.created_at)
FROM transactions AS t
LEFT JOIN clients AS c ON c.client_id = t.client_id
LEFT JOIN books AS b ON b.book_id = t.book_id
LEFT JOIN authors AS a ON b.author_id = a.author_id;

-- Eliminar registro
DELETE FROM authors WHERE author_id = 161 LIMIT 1;

-- Actualizar datos de una tupla existente
UPDATE clients
SET active = 0
WHERE client_id = 80
LIMIT 1;

UPDATE clients
SET active = 0
WHERE client_id IN (1, 6, 8, 27, 90) OR name LIKE '%Lopez%';

-- Borrar todo el contenido de una tabla
TRUNCATE transactions;

-- Sumar valores en una tupla
SELECT COUNT(book_id), 
  SUM(IF(year < 1950, 1, 0)) AS '<1950',
  SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS '<1990',
  SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS '<2000',
  SUM(IF(year >= 2000, 1, 0)) AS '<hoy'
FROM books;

-- Agrupar el query anterior y mostrar su nacionalidad
SELECT nationality, COUNT(book_id), 
  SUM(IF(year < 1950, 1, 0)) AS '<1950',
  SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS '<1990',
  SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS '<2000',
  SUM(IF(year >= 2000, 1, 0)) AS '<hoy'
FROM books AS b
JOIN authors AS a ON a.author_id = b.author_id
WHERE a.nationality IS NOT NULL
GROUP BY nationality;

-- Modificar el esquema de una tabla en MySQL
-- Agregar una columna
ALTER TABLE Authors ADD COLUMN BirthYear INTEGER DEFAULT 1930 AFTER Name;

-- Modificar una columna
ALTER TABLE Authors MODIFY COLUMN BirthYear YEAR DEFAULT 1920;

-- Eliminar una columna
ALTER TABLE Authors DROP COLUMN BirthYear;

-- Respaldo y versionado de una base de datos MySQL
-- Exportar toda la base de datos
mysqldump -u root -p --databases curso_platzi > respaldo.sql

-- Exportar solo el esquema
mysqldump -u root -p --no-data curso_platzi > esquema.sql
