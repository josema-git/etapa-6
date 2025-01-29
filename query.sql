SHOW DATABASES; -- show databases

CREATE DATABASE test; -- create database

CREATE DATABASE if not exists test; -- create database if not exists

USE test; -- use database

DROP DATABASE test; -- drop database

CREATE TABLE IF NOT EXISTS test_book ( -- create table if not exists
    book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    author_id INTEGER UNSIGNED ,
    title VARCHAR(100) NOT NULL,
    year INTEGER UNSIGNED NOT NULL DEFAULT 0,
    language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
    cover_url VARCHAR(500),
    price DOUBLE(6,2) NOT NULL DEFAULT 10.00,
    sellable TINYINT(1) NOT NULL DEFAULT 1,
    copies INTEGER UNSIGNED NOT NULL DEFAULT 1,
    description TEXT
);

CREATE TABLE IF NOT EXISTS test_author ( -- create table if not exists
    author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(3)
);

CREATE TABLE IF NOT EXISTS test_clients ( -- create table if not exists
    client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    birthday DATETIME,
    gender ENUM('M', 'F', 'ND') NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE test_book ADD COLUMN column INTEGER UNSIGNED; -- add column

ALTER TABLE test_book MODIFY COLUMN column INTEGER UNSIGNED NOT NULL; -- modify column

ALTER TABLE test_book CHANGE COLUMN column new_column INTEGER UNSIGNED NOT NULL; -- change column name

ALTER TABLE test_book ALTER COLUMN column SET DEFAULT 0; -- alter column

ALTER TABLE test_book DROP COLUMN column; -- drop column

SHOW TABLES; -- show tables

SHOW FULL COLUMNS FROM test_book; -- show columns from table

DESCRIBE test_book; -- describe table

DROP TABLE test_book; -- drop table

INSERT INTO test_clients (name, email, birthday, gender) VALUES ('John Doe', 'jhondoe@gmail.com', '1990-01-01', 'M') -- insert into table
ON DUPLICATE KEY UPDATE name = 'John Doe'; -- on duplicate key update

INSERT INTO test_book (author_id, title, year) VALUES ((SELECT author_id FROM test_author WHERE name = 'Octavio Paz' LIMIT 1 ), 'Book Title', 2020); -- insert into table

-- Listar todas la tuplas de la tabla clients
SELECT * FROM clients;

-- Listar todos los nombres de la tabla clients
SELECT name FROM clients;

-- Listar todos los nombres, email y género de la tabla clients
SELECT name, email, gender FROM clients;

-- Listar los 10 primeros resultados de la tabla clients
SELECT name, email, gender FROM clients LIMIT 10;

-- Listar todos los clientes de género Masculino
SELECT name, email, gender FROM clients WHERE gender = 'M';

-- Listar el año de nacimientos de los clientes, con la función YEAR()
SELECT YEAR(birthdate) FROM clients;

-- Mostrar el año actual
SELECT YEAR(NOW());

-- Listar los 10 primeros resultados de las edades de los clientes
SELECT YEAR(NOW()) - YEAR(birthdate) FROM clients LIMIT 10;

-- Listar nombre y edad de los 10 primeros clientes
SELECT name, YEAR(NOW()) - YEAR(birthdate) FROM clients LIMIT 10;

-- Listar clientes que coincidan con el nombre de &quot;Saave&quot;
SELECT * FROM clients WHERE name LIKE '%Saave%';

-- Listar clientes (nombre, email, edad y género). con filtro de genero = F y nombre que coincida con 'Lop'
--Usando alias para nombrar la función como 'edad'
SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender FROM clients WHERE gender = 'F' AND name LIKE '%Lop%';

-- Listar todos los autores con ID entre 1 y 5 con los filtro mayor y menor igual
SELECT * FROM authors WHERE author_id &gt; 0 AND author_id &lt;= 5;

-- Listar todos los autores con ID entre 1 y 5 con el filtro BETWEEN
SELECT * FROM authors WHERE author_id BETWEEN 1 AND 5;

-- Listar los libros con filtro de author_id entre 1 y 5
SELECT book_id, author_id, title FROM books WHERE author_id BETWEEN 1 AND 5;

-- Listar nombre y titulo de libros mediante el JOIN de las tablas books y authors
SELECT b.book_id, a.name, a.author_id, b.title
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5;

-- Listar transactions con detalle de nombre, titulo y tipo. Con los filtro genero = F y tipo = Vendido.
-- Haciendo join entre transactions, books y clients.
SELECT c.name, b.title, t.type
FROM transactions AS t
JOIN books AS b
  ON t.book_id = b.book_id
JOIN clients AS c
  ON t.client_id = c.client_id
WHERE c.gender = 'F'
  AND t.type = 'sell';

-- Listar transactions con detalle de nombre, titulo, autoor y tipo. Con los filtro genero = M y de tipo = Vendido y Devuelto.
-- Haciendo join entre transactions, books, clients y authors.
SELECT c.name, b.title, a.name, t.type
FROM transactions AS t
JOIN books AS b
  ON t.book_id = b.book_id
JOIN clients AS c
  ON t.client_id = c.client_id
JOIN authors AS a
  ON b.author_id = a.author_id
WHERE c.gender = 'M'
  AND t.type IN ('sell', 'lend');

1. Inner Join
Esta es la forma mas fácil de seleccionar información de diferentes tablas, es tal vez la que mas usas a diario en tu trabajo con bases de datos. Esta union retorna todas las filas de la tabla A que coinciden en la tabla B. Es decir aquellas que están en la tabla A Y en la tabla B, si lo vemos en conjuntos la intersección entre la tabla A y la B.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n> 
FROM Tabla_A A
INNER JOIN Tabla_B B
ON A.pk = B.pk
2. Left Join
Esta consulta retorna todas las filas que están en la tabla A y ademas si hay coincidencias de filas en la tabla B también va a traer esas filas.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n> 
FROM Tabla_A A
LEFT JOIN Tabla_B B
ON A.pk = B.pk
3. Right Join
Esta consulta retorna todas las filas de la tabla B y ademas si hay filas en la tabla A que coinciden también va a traer estas filas de la tabla A.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n>
FROM Tabla_A A
RIGHT JOIN Tabla_B B
ON A.pk = B.pk
4. Outer Join
Este join retorna TODAS las filas de las dos tablas. Hace la union entre las filas que coinciden entre la tabla A y la tabla B.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n>
FROM Tabla_A A
FULL OUTER JOIN Tabla_B B
ON A.pk = B.pk
5. Left excluding join
Esta consulta retorna todas las filas de la tabla de la izquierda, es decir la tabla A que no tienen ninguna coincidencia con la tabla de la derecha, es decir la tabla B.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n>
FROM Tabla_A A
LEFT JOIN Tabla_B B
ON A.pk = B.pk
WHERE B.pk IS NULL
6. Right Excluding join
Esta consulta retorna todas las filas de la tabla de la derecha, es decir la tabla B que no tienen coincidencias en la tabla de la izquierda, es decir la tabla A.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <columna_1> , <columna_2>,  <columna_3> ... <columna_n>
FROM Tabla_A A
RIGHT JOIN Tabla_B B
ON A.pk = B.pk
WHERE A.pk IS NULL
7. Outer excluding join
Esta consulta retorna todas las filas de la tabla de la izquierda, tabla A, y todas las filas de la tabla de la derecha, tabla B que no coinciden.

Esto lo podemos implementar de esta forma cuando estemos escribiendo las consultas:

SELECT <select_list>
FROM Table_A A
FULL OUTER JOIN Table_B B
ON A.Key = B.Key
WHERE A.Key IS NULL OR B.Key IS NULL

-- 1. ¿Qué nacionalidades hay?
-- Mediante la clausula DISTINCT trae solo los elementos distintos
SELECT DISTINCT nationality 
FROM authors
ORDER BY 1;

-- 2. ¿Cuántos escritores hay de cada nacionalidad?
-- IS NOT NULL para traer solo los valores diferentes de nulo
-- NOT IN para traer valores que no sean los declarados (RUS y AUT)
SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
WHERE nationality IS NOT NULL
	AND nationality NOT IN ('RUS','AUT')
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;

¿Qué nacionalidades de escritores hay?
Comenzamos con una pregunta básica: ¿qué nacionalidades de escritores tenemos? En SQL, podríamos iniciar de forma sencilla con:

SELECT nationality FROM authors;
Esta consulta trae todas las nacionalidades de la tabla authors. Sin embargo, presentará duplicados, lo que no es óptimo si buscamos diversidad. Aquí es donde entra el comando DISTINCT, el cual se encargará de eliminar repeticiones. La consulta revisada sería:

SELECT DISTINCT nationality FROM authors;
Esto nos devolverá una lista única de nacionalidades. No olvides que siempre aparecerá un null si existen nacionalidades no especificadas. Utiliza ORDER BY nationality para ordenar los resultados alfabéticamente.

¿Cuántos escritores hay de cada nacionalidad?
Cuando nuestro enfoque cambia a cantidad, el uso de la función de agregación COUNT se vuelve imprescindible. El primer intento podría parecer así:

SELECT nationality, COUNT(author_id) FROM authors;
Pero, para que COUNT funcione correctamente en conjunto con SELECT, es necesario agrupar los resultados:

SELECT nationality, COUNT(author_id) AS count_authors FROM authors GROUP BY nationality;
También es útil ordenar de manera descendente para ver cuál nacionalidad tiene más escritores:

ORDER BY count_authors DESC;
¿Cómo excluir ciertos datos específicos?
A veces, desearás excluir datos, como nacionalidades específicas. Esto puede lograrse utilizando las cláusulas WHERE y NOT IN:

WHERE nationality IS NOT NULL AND nationality NOT IN ('RUS', 'AUT')
Esto excluirá resultados ‘null’ y aquellos relacionados con Rusia (RUS) y Austria (AUT). También puedes incluir varios países utilizando comas entre las cláusulas en NOT IN.

-- 4. ¿Cuál es el promedio/desviación standard del precio de libros?
SELECT a.nationality,  
  AVG(b.price) AS promedio, 
  STDDEV(b.price) AS std 
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
GROUP BY a.nationality
ORDER BY promedio DESC;

-- 5. ¿Cuál es el promedio/desviación standard del precio de libros por nacionalidad?
-- Agrupar por la columna pivot
SELECT a.nationality,
  COUNT(b.book_id) AS libros,  
  AVG(b.price) AS promedio, 
  STDDEV(b.price) AS std 
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
GROUP BY a.nationality
ORDER BY libros DESC;

-- 6. ¿Cuál es el precio máximo/mínimo de un libro?
SELECT nationality, MAX(price), MIN(price)
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
GROUP BY nationality;

-- 7. ¿cómo quedaría el reporte de préstamos?
-- CONCAT: para concatenar en cadenas de texto.
-- TO_DAYS: recibe un timestamp ó un datetime
SELECT c.name, t.type, b.title, 
  CONCAT(a.name, &quot; (&quot;, a.nationality, &quot;)&quot;) AS autor,
  TO_DAYS(NOW()) - TO_DAYS(t.created_at)
FROM transactions AS t
LEFT JOIN clients AS c
  ON c.client_id = t.client_id
LEFT JOIN books AS b
  ON b.book_id = t.book_id
LEFT JOIN authors AS a
  ON b.author_id = a.author_id;

-- DELETE: borra el registro.
-- Adicionalmente filtrar con WHERE por id y limitarlo.
DELETE FROM authors WHERE author_id = 161 LIMIT 1;

-- UPDATE: actualizar datos de una tupla existente.
-- También se debe filtrar con WHERE
UPDATE clients
SET active = 0
WHERE client_id = 80
LIMIT 1;

UPDATE clients
SET active = 0
WHERE client_id IN (1,6,8,27,90)
  OR NAME like '%Lopez%';


-- TRUNCATE: Borra todo el contenido de una tabla
TRUNCATE transactions;

-- SUM(), para sumar cada valor(1) en una tupla
SELECT 
  COUNT(book_id), 
  SUM(IF(year &lt; 1950, 1, 0)) AS `&lt;1950`,
  SUM(IF(year &gt;= 1950 AND year &lt; 1990, 1, 0)) AS `&lt;1990`,
  SUM(IF(year &gt;= 1990 AND year &lt; 2000, 1, 0)) AS `&lt;2000`,
  SUM(IF(year &gt;= 2000, 1, 0)) AS `&lt;hoy`
FROM books;

-- Agrupar el query anterior y mostrar su nacionalidad
SELECT 
  nationality,
  COUNT(book_id), 
  SUM(IF(year &lt; 1950, 1, 0)) AS `&lt;1950`,
  SUM(IF(year &gt;= 1950 AND year &lt; 1990, 1, 0)) AS `&lt;1990`,
  SUM(IF(year &gt;= 1990 AND year &lt; 2000, 1, 0)) AS `&lt;2000`,
  SUM(IF(year &gt;= 2000, 1, 0)) AS `&lt;hoy`
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
WHERE a.nationality IS NOT NULL
GROUP BY nationality;

¿Cómo modificar el esquema de una tabla en MySQL?
A veces es necesario realizar modificaciones en el diseño original de nuestras tablas de base de datos. Para esto, MySQL nos ofrece el comando ALTER, el cual permite alterar el esquema de una tabla. Al utilizar este comando, es importante tener en cuenta que los errores pueden provocar la pérdida de datos y afectar la estructura del esquema. Por lo tanto, siempre es recomendable consultar la documentación oficial de MySQL antes de realizar cambios.

¿Cuál es la sintaxis básica del comando ALTER?
El comando ALTER para modificar el esquema de una base de datos sigue una sintaxis sencilla. A continuación, se muestra cómo agregar, modificar y eliminar columnas en una tabla:

Agregar una columna:

ALTER TABLE Authors ADD COLUMN BirthYear INTEGER DEFAULT 1930 AFTER Name;

En este ejemplo, se añade una columna llamada BirthYear del tipo INTEGER, con un valor por defecto de 1930, después de la columna Name.

Modificar una columna:

ALTER TABLE Authors MODIFY COLUMN BirthYear YEAR DEFAULT 1920;

Este comando cambia el tipo de dato de la columna BirthYear a YEAR y establece un nuevo valor por defecto de 1920.

Eliminar una columna:

ALTER TABLE Authors DROP COLUMN BirthYear;

Aquí se elimina la columna BirthYear de la tabla Authors. Se debe ejercer extrema precaución al utilizar DROP para evitar pérdidas accidentales de datos.

¿Cómo respaldar y versionar una base de datos MySQL?
El respaldo y versionado de bases de datos son pasos críticos para manejar datos de manera efectiva. MySQL ofrece herramientas como mysqldump, que permite exportar tanto el esquema como los datos de la base.

¿Cómo utilizar mysqldump para hacer un respaldo?
mysqldump es una utilidad de línea de comandos que no forma parte del núcleo de MySQL, pero se distribuye junto con él. A continuación se describe cómo usarla:

Exportar toda la base de datos:

mysqldump -u root -p --databases curso_platzi > respaldo.sql

Este comando genera un archivo SQL que contiene todo el esquema y los datos de la base curso_platzi.

Exportar solo el esquema:

mysqldump -u root -p --no-data curso_platzi > esquema.sql

Utilizando la bandera --no-data, se exporta únicamente el esquema sin incluir los datos. Este archivo es ideal para ser versionado utilizando sistemas de control de versiones como Git.

¿Por qué es importante versionar el esquema?
Versionar el esquema de una base de datos es crucial para mantener un registro de los cambios estructurales a lo largo del tiempo. A diferencia de los datos, que se respaldan pero no se versionan, el esquema puede evolucionar y mejorar, siendo esencial para el desarrollo de aplicaciones que integran bases de datos. Además, tener un esquema versionado junto con el código del proyecto permite mantener la coherencia entre la estructura de la base de datos y la lógica de negocio.

¿Qué tan útil es la documentación de MySQL?
La documentación de MySQL es una herramienta vital para cualquier desarrollador que trabaje con este sistema de gestión de bases de datos. Contiene más de 190 funciones para diferentes necesidades, como condicionales, agrupaciones y operaciones sobre columnas y filas. Consultar la documentación, junto con participar en foros como Stack Overflow, puede ser extremadamente útil para resolver dudas y aprender prácticas recomendadas. Así, lograrás diseñar bases de datos eficientes y optimizadas que contribuyan significativamente al rendimiento de tus aplicaciones.

