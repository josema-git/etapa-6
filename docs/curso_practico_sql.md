## Brief History of SQL

SQL (Structured Query Language) is a language based on two fundamental principles:

- Set theory.
- Relational algebra by Edgar Codd (English computer scientist).

SQL was created in 1974 by IBM. Originally it was called SEQUEL, but the name was later changed due to copyright issues.

Relation Company (now known as Oracle) created the Oracle V2 software in 1979.

Later, SQL would become a standard language that unifies everything within relational databases, becoming an ANSI or ISO standard.

## Relational Algebra

Relational algebra studies the operations that can be performed between various sets of data.

Do not confuse the relations of relational algebra with the relations of a relational database.

The relations of a database are when you join two tables.
The relations in relational algebra refer to a table. The difference is conceptual: Tables can have repeated tuples, but in relational algebra, each relation does not have a body, nor a first or last row.

### Types of Operators

#### Unary Operators
- **Projection (π)**: Equivalent to the SELECT command. It extracts a number of columns or attributes without needing to join with a second table. 
    Example: π<FirstName, LastName, Email>(Student_Table)
- **Selection (σ)**: Equivalent to the WHERE command. It consists of filtering tuples.
    Example: σ<Subscription=Expert>(Student_Table)

#### Binary Operators
- **Cartesian Product (x)**: Takes all elements of one table and combines them with the elements of the second table.
    Example: Teachers_Grade5 x Students_Grade5
- **Union (∪)**: Obtains the elements that exist in one of the tables or the other.
    Example: Students_Grade5_A ∪ Students_Grade5_B
- **Difference (-)**: Obtains the elements that exist in one table but do not correspond to the other table.
    Example: Students_PlanExpertPlus - Students_PlanFree

## Projection, SELECT

- **COUNT()**: Counts the number of elements that exist in all tuples of the database.
- **SUM()**: Takes the column you specify and sums its values consecutively.
- **AVG()**: (From AVErage) Calculates the average value of the entire column.
- Like other languages, you can use "IF" with many possibilities.

### Examples

#### All Records
```sql
SELECT *
    FROM PRUEBAS.ALUMNOS;

SELECT nombre as "name",
             apellido as "last name"
    FROM PRUEBAS.ALUMNOS;

SELECT COUNT(id)
    FROM PRUEBAS.ALUMNOS;

SELECT SUM(colegiatura)
    FROM PRUEBAS.ALUMNOS;

SELECT AVG(colegiatura)
    FROM PRUEBAS.ALUMNOS;

SELECT MIN(colegiatura)
    FROM PRUEBAS.ALUMNOS;

SELECT MAX(colegiatura)
    FROM PRUEBAS.ALUMNOS;

SELECT nombre,
             apellido,
             colegiatura,
    CASE
        WHEN (colegiatura > 4000) THEN 'Greater than 4000'
        WHEN (colegiatura = 2000) THEN 'Equal to 2000'
        ELSE 'Greater than 2000 and less than 4000'
    END cost
FROM PRUEBAS.ALUMNOS;
```

## SELECT and FROM

With SELECT, you specify which columns you want to retrieve from a given table, and with FROM, you indicate where the information to be projected with SELECT will be obtained. FROM comes after SELECT.

```sql
SELECT *
FROM database.table;
```

In the above statement, the database management system (DBMS) goes to the schema and projects the requested information.

SQL statements are not case-sensitive, but it is recommended to write keywords in UPPERCASE and the rest in lowercase.

### JOIN

JOIN is a complement to FROM. With JOIN, you can indicate relationships between different tables. It helps generate a more complete table for making queries.

### External Database

You can also retrieve information from a remote database, meaning the schema from which you want to obtain information is located in another DBMS.

To retrieve information from a table that is remotely located, the dblink function is used. This function takes two parameters:

- Connection configuration to the remote DBMS
- SQL query

Example of dblink:
```sql
SELECT *
FROM dblink('
        dbname=somedb
        port=5432 host=someserver
        user=someuser
        password=somepwd',
        'SELECT gid, area, perimeter,
                        state, country,
                        tract, blockgroup,
                        block, the_geom
        FROM massgis.cens2000blocks')
        AS blockgroups;
```

## Cartesian Products (JOIN)

Retrieve all data from all the tables involved. It is not desirable to do all against all. Each join has an equivalent in Venn diagrams.

```sql
SELECT * 
FROM daily_table AS dt
        JOIN monthly_table AS mt
        ON dt.pk = mt.fk;
```

## Summary of Cartesian Products (JOIN)

### General Concepts
- **Cartesian Products**: Retrieve all data from all the tables involved, although it is not desirable to do all against all.
- **Venn Diagrams**: Each type of JOIN has an equivalent in Venn diagrams.

### Types of JOIN

#### 1. **Inner Join**
- **Description**: Returns only the records that have matches in both tables.
- **Usage**: It is the most common and is considered the default value.

#### 2. **Left Join**
- **Description**: Returns all elements from table A, regardless of whether they are in table B.

#### 3. **Right Join**
- **Description**: Returns all elements from table B, regardless of whether they are in table A.

#### 4. **Exclusive Left Join**
- **Description**: Returns the elements that exist in A and not in B.

#### 5. **Exclusive Right Join**
- **Description**: Returns the elements that exist in B and not in A.

#### 6. **Full Outer Join**
- **Description**: Returns all records from A and B. Rarely used due to its low performance.

#### 7. **Exclusive Full Outer Join**
- **Description**: Returns all records from A and B, except those that match.

### SQL Example
```sql
SELECT *
FROM daily_table AS dt
JOIN monthly_table AS mt
ON dt.pk = mt.fk;
```

## Selección (WHERE)

WHERE es usado para filtrar registros. WHERE es cuando para extraer solamente las condiciones que cumplen con esa condición.

```sql
SELECT *
FROM tabla_diaria
WHERE id=1;

SELECT *
FROM tabla_diaria
WHERE cantidad>10;

SELECT *
FROM tabla_diaria
WHERE cantidad<100;
```

Este puede ser combinado con AND, OR y NOT.

AND y OR son usados para filtrar registros de más de una condición.

- **AND** muestra un registro si todas las condiciones separadas por AND son TRUE.
- **OR** muestra un registro si alguna de las condiciones separadas por OR son TRUE.

```sql
SELECT *
FROM tabla_diaria
WHERE cantidad > 10
    AND cantidad < 100;

SELECT *
FROM tabla_diaria
WHERE cantidad BETWEEN 10
    AND cantidad < 100;
```

BETWEEN puede ser usado para definir límites.

La separación por paréntesis es muy importante.

```sql
SELECT * 
FROM users
WHERE name = "Israel"
    AND (
    lastname = "Vázquez"
    OR
    lastname = "López"
);

SELECT * 
FROM users
WHERE name = "Israel"
    AND 
    lastname = "Vázquez"
    OR
    lastname = "López";
```

En el primero va a devolver todos los que son Israel Vázquez o Israel López, en el segundo devolverá a todos los que se llaman Israel Vázquez o se apellida López (sólo apellido).

NOT valida que un dato no sea TRUE.

```sql
SELECT column1, column2, ...
FROM table_name
WHERE NOT condition;
```

Para especificar patrones en una columna usamos LIKE. Podemos mostrar diferentes cosas que buscamos.

```sql
SELECT *
FROM users
WHERE name LIKE "Is%";

SELECT *
FROM users
WHERE name LIKE "Is_ael";

SELECT *
FROM users
WHERE name NOT LIKE "Is_ael";
```

En el primero, colocamos un % para representar que se va a buscar lo que tenga is% pero que no importa los caracteres después de %. En el segundo le estamos diciendo con _ que puede haber lo que sea en medio de Is y ael. Y en el último le decimos que ponga todas las filas que no sean igual a lo que arriba estábamos buscando.

Igual podemos decir que nos traiga registros que estén vacíos o que no lo estén.

```sql
SELECT * 
FROM users
WHERE name IS NULL;

SELECT *
FROM users
WHERE name IS NOT NULL;
```

Y para seleccionar filas con datos específicos, usamos IN.

```sql
SELECT *
FROM users
WHERE name IN ('Israel','Laura','Luis');
```

## Order by

Las partes más importantes y más usadas de los queries de SQL son:
- La proyección (con SELECT)
- El origen de los datos (Con FROM y sus JOIN)
- WHERE, que nos ayuda a filtrar las tuplas dependiendo de las condiciones que se cumplan.

Hay otras partes de los queries que son opcionales, que no encontraremos en todos los queries pero que igual juegan un papel muy importantes. Una de ellas es el ordenamiento (ORDER BY).

### Índices

Los índices son excelentes para búsquedas y ordenamientos, especialmente cuando estamos haciendo queries complejos, extrayendo información constantemente, o realizando joins complicados. Un índice guarda el orden de un campo en particular para hacer extracciones muy rápidas.

#### Consideraciones para Alta Transaccionalidad

La contrapartida de usar índices es que, durante la escritura (por ejemplo, al hacer un UPDATE en una columna indexada), cada escritura tardará un poco más. Esto se debe a que el índice debe actualizarse, revisando y reordenando los elementos.

No debemos poner índices indiscriminadamente. Debemos ser cuidadosos y poner índices en columnas que usamos frecuentemente en JOINs o que contienen muchos datos y siempre estamos ordenando por esa columna. Es importante considerar la cantidad de lecturas versus escrituras en una tabla o campo particular para decidir si conviene poner un índice.

Si realizas muchas escrituras por segundo, no es conveniente poner índices o deberías mantenerlos al mínimo. En cambio, si escribes muy poco en esa tabla pero haces búsquedas constantes y muchos joins, vale la pena usar un índice en el campo donde haces el join o el ordenamiento, ya que es un gran complemento para nuestra cláusula ORDER BY.

## Aggregation and Limits

### GROUP BY and LIMIT (SELECT TOP because LIMIT does not exist in SQL)

`GROUP BY` is a statement that groups rows that have the same value in columns with the sum. It's like saying 'find the number of customers in each country'.

It is often used with the functions `COUNT`, `MAX`, `MIN`, `SUM`, `AVG` on a group of one or more columns.

```sql
SELECT *
FROM tabla_diaria
GROUP BY marca;

SELECT *
FROM tabla_diaria
GROUP BY marca, modelo;

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;
```

`SELECT TOP` is used to specify the number of records to return.

`SELECT TOP` is useful for tables with thousands of records, as a large number of records can affect performance.

```sql
SELECT TOP number
FROM table1
WHERE condition;

SELECT TOP 1500
FROM tabla_diaria;
```

## Agregación (GROUP BY y LIMIT)

GROUP BY especifica por qué campos se agrupan las agregaciones
LIMIT especifica la cantidad de registros, en SQL Server se llama TOP y va después de SELECT
OFFSET especifica a partir de qué registro se trae la consulta, luego puede venir LIMIT para cerrar el rango. En SQL Server es FETCH NEXT

### Date and Time Functions

In SQL, you can extract parts of a date or time using functions like `EXTRACT` and `DATE_PART`.

#### Examples

```sql
SELECT EXTRACT(YEAR FROM fecha_incorporacion) AS anio_incorporacion
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
    DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion,
    DATE_PART('DAY', fecha_incorporacion) AS dia_incorporacion
FROM platzi.alumnos;
```

#### Challenge

```sql
SELECT EXTRACT(HOUR FROM fecha_incorporacion) AS hora,
    EXTRACT(MINUTE FROM fecha_incorporacion) AS minutos,
    EXTRACT(SECOND FROM fecha_incorporacion) AS segundos
FROM platzi.alumnos;
```

## HAVING Clause

La cláusula HAVING es una implementación que el sistema gestor de bases de datos SQL crea para complementar el condicionante WHERE, ya que el condicionante WHERE no permite utilizar funciones de agregación como SUM, MAX, MIN o AVG. Es decir, con un condicionante WHERE no podemos crear consultas válidas que sean capaces de devolvernos los datos de los clientes que compraron más de 1000 productos durante un año, por ejemplo.

### Example

```sql
SELECT CustomerID, COUNT(ProductID) as TotalProducts
FROM Sales
GROUP BY CustomerID
HAVING COUNT(ProductID) > 1000;
```

## Duplicates

In SQL, identifying and handling duplicate records is crucial for maintaining data integrity. Here are some examples of how to find duplicates in a table.

### Example 1: Using a Subquery
This query finds duplicates by counting the occurrences of each `id` in the table.

```sql
SELECT *
FROM platzi.alumnos AS ou
WHERE (
    SELECT COUNT(*)
    FROM platzi.alumnos AS inr
    WHERE ou.id = inr.id
) > 1;
```

### Example 2: Using GROUP BY and HAVING
This query groups the records by all columns and counts the occurrences, returning only those with more than one occurrence.

```sql
SELECT (platzi.alumnos.*)::text, COUNT(*)
FROM platzi.alumnos 
GROUP BY platzi.alumnos.*
HAVING COUNT(*) > 1;
```

### Example 3: Specifying Columns in GROUP BY
This query groups by specific columns and counts the occurrences, returning only those with more than one occurrence.

```sql
SELECT (
       platzi.alumnos.nombre,
       platzi.alumnos.apellido,
       platzi.alumnos.email,
       platzi.alumnos.colegiatura,
       platzi.alumnos.fecha_incorporacion,
       platzi.alumnos.carrera_id,
       platzi.alumnos.tutor_id
       )::text, COUNT(*)
FROM platzi.alumnos 
GROUP BY  platzi.alumnos.nombre,
       platzi.alumnos.apellido,
       platzi.alumnos.email,
       platzi.alumnos.colegiatura,
       platzi.alumnos.fecha_incorporacion,
       platzi.alumnos.carrera_id,
       platzi.alumnos.tutor_id
HAVING COUNT(*) > 1;
```

### Example 4: Using ROW_NUMBER() Window Function
This query uses the `ROW_NUMBER()` window function to assign a unique row number to each record within the partition of specified columns and then filters out the duplicates.

```sql
SELECT *
FROM (
    SELECT id,
    ROW_NUMBER() OVER(
        PARTITION BY
            nombre,
            apellido,
            email,
            colegiatura,
            fecha_incorporacion,
            carrera_id,
            tutor_id
        ORDER BY id ASC
    ) AS row,
    *
    FROM platzi.alumnos
) AS duplicados
WHERE duplicados.row > 1;
```

## Range Selectors

Range selectors are especially useful for use in the WHERE statement.

```sql
SELECT int4range(1,20) @> 3;
```
This query checks if the range contains the number 3.

```sql
SELECT numrange(11,20) && numrange(20.0, 30.0);
```
This query returns a boolean result, as the `&&` operator checks if there are overlapping values between the two high-precision number ranges.

```sql
SELECT LOWER(int8range(15,25));
```
This query returns the lower bound of the range. It works similarly with `UPPER`.

```sql
SELECT int4range(10,20) * int4range(15,25);
```
This query returns the numeric range that both ranges share.

```sql
SELECT ISEMPTY(numrange(1,5));
```
This boolean query checks if the range is empty.

## SELFISH

### Selfjoins

Selfjoins are used to join columns within the same table.

Essentially, you select the columns and assign them to sub-tables.

```sql
SELECT a.nombre, t.nombre
```

You assign aliases (a, t) to the new tables you want to compare, and then execute the join.

```sql
SELECT a.nombre, a.apellido, t.nombre, t.apellido 
FROM platzi.alumnos AS a
INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id;
```

## Tipos de JOIN en SQL

En SQL, las uniones (JOINs) son utilizadas para combinar datos de dos o más tablas en función de una condición relacionada. Aquí tienes una lista completa de los tipos de uniones más comunes, con ejemplos y explicaciones:

1. **INNER JOIN**
    Devuelve las filas que tienen coincidencias en ambas tablas.
    ```sql
    SELECT a.id, a.nombre, b.curso 
    FROM estudiantes a 
    INNER JOIN cursos b ON a.curso_id = b.id;
    ```
    Resultado: Sólo incluye las filas que tienen valores coincidentes en ambas tablas.

2. **LEFT JOIN (o LEFT OUTER JOIN)**
    Devuelve todas las filas de la primera tabla (izquierda) y las coincidencias de la segunda tabla (derecha). Si no hay coincidencias, muestra NULL.
    ```sql
    SELECT a.id, a.nombre, b.curso 
    FROM estudiantes a 
    LEFT JOIN cursos b ON a.curso_id = b.id;
    ```
    Resultado: Incluye todas las filas de estudiantes, con datos de cursos si hay coincidencias; en caso contrario, muestra NULL.

3. **RIGHT JOIN (o RIGHT OUTER JOIN)**
    Devuelve todas las filas de la segunda tabla (derecha) y las coincidencias de la primera tabla (izquierda). Si no hay coincidencias, muestra NULL.
    ```sql
    SELECT a.id, a.nombre, b.curso 
    FROM estudiantes a 
    RIGHT JOIN cursos b ON a.curso_id = b.id;
    ```
    Resultado: Incluye todas las filas de cursos, con datos de estudiantes si hay coincidencias; en caso contrario, muestra NULL.

4. **FULL JOIN (o FULL OUTER JOIN)**
    Devuelve todas las filas cuando hay coincidencias en cualquiera de las tablas. Si no hay coincidencias, muestra NULL en las columnas de la tabla que falta.
    ```sql
    SELECT a.id, a.nombre, b.curso 
    FROM estudiantes a 
    FULL OUTER JOIN cursos b ON a.curso_id = b.id;
    ```
    Resultado: Todas las filas de ambas tablas, llenando con NULL donde no haya coincidencias.

5. **CROSS JOIN**
    Devuelve el producto cartesiano de las dos tablas (todas las combinaciones posibles de filas).
    ```sql
    SELECT a.nombre, b.curso 
    FROM estudiantes a 
    CROSS JOIN cursos b;
    ```
    Resultado: Si estudiantes tiene 5 filas y cursos tiene 4 filas, el resultado será de 20 filas (5 × 4).

6. **SELF JOIN**
    Una tabla se une consigo misma. Se utiliza con alias para diferenciar las instancias.
    ```sql
    SELECT a.id AS estudiante1, b.id AS estudiante2 
    FROM estudiantes a 
    INNER JOIN estudiantes b ON a.tutor_id = b.id;
    ```
    Resultado: Une los estudiantes con sus tutores, que también están en la misma tabla.

7. **NATURAL JOIN**
    Une tablas automáticamente basándose en las columnas con el mismo nombre y tipo de datos.
    ```sql
    SELECT * 
    FROM estudiantes 
    NATURAL JOIN cursos;
    ```
    Resultado: Une estudiantes y cursos en las columnas que tengan el mismo nombre, como curso_id.

8. **USING**
    Es similar a NATURAL JOIN, pero especificas las columnas que deben coincidir.
    ```sql
    SELECT * 
    FROM estudiantes 
    JOIN cursos USING (curso_id);
    ```
    Resultado: Une las tablas en la columna curso_id.

### Resumen de uniones:
| Tipo de JOIN | Descripción |
|--------------|-------------|
| INNER JOIN   | Coincidencias en ambas tablas. |
| LEFT JOIN    | Todas las filas de la tabla izquierda. |
| RIGHT JOIN   | Todas las filas de la tabla derecha. |
| FULL JOIN    | Todas las filas de ambas tablas. |
| CROSS JOIN   | Producto cartesiano de ambas tablas. |
| SELF JOIN    | Una tabla unida consigo misma. |
| NATURAL JOIN | Une columnas comunes con el mismo nombre. |
| USING        | Une en base a columnas específicas. |

### SQL Join Examples

#### Right Join
```sql
/* Right Join todo de la tabla de alumnos */
SELECT 
    a.[nombre],
    a.[apellido],
    a.[carrera_id],
    b.id,
    b.carrera
FROM [HAHM].[dbo].[platzialumnos] a
RIGHT JOIN platzicarreras b ON a.carrera_id = b.id
WHERE b.carrera IS NOT NULL 
ORDER BY carrera DESC;
```

#### Left Join
```sql
/* Left Join todo de la tabla de alumnos */
SELECT 
    a.[nombre],
    a.[apellido],
    a.[carrera_id],
    b.id,
    b.carrera
FROM [HAHM].[dbo].[platzialumnos] a
LEFT JOIN platzicarreras b ON a.carrera_id = b.id
WHERE b.id IS NOT NULL 
ORDER BY carrera DESC;
```

#### Inner Join
```sql
/* Inner Join todo lo que coincida en ambas tablas */
SELECT 
    a.[nombre],
    a.[apellido],
    a.[carrera_id],
    b.id,
    b.carrera
FROM [HAHM].[dbo].[platzialumnos] a
INNER JOIN platzicarreras b ON a.carrera_id = b.id
ORDER BY carrera DESC;
```

#### Full Join
```sql
/* Full Join */
SELECT 
    a.[nombre],
    a.[apellido],
    a.[carrera_id],
    b.id,
    b.carrera
FROM [HAHM].[dbo].[platzialumnos] a
FULL JOIN platzicarreras b ON a.carrera_id = b.id
ORDER BY carrera DESC;
```

## String Functions

### LPAD and RPAD

The `LPAD` function is used to add characters to the left of a string. If the original string is shorter than the specified length, characters will be added to the left until that length is reached.

### Examples

#### LPAD
```sql
SELECT lpad('sql', 15, '+');

SELECT lpad('*', id, '*')
FROM platzi.alumnos
WHERE id < 10
ORDER BY carrera_id;

SELECT lpad('*', CAST(row_id AS int), '*')
FROM (
    SELECT ROW_NUMBER() OVER(ORDER BY carrera_id) AS row_id, *
    FROM platzi.alumnos
) AS alumnos_with_row_id
WHERE row_id <= 5
ORDER BY carrera_id;
```

The `RPAD` function is used to add characters to the right of a string. If the original string is shorter than the specified length, characters will be added to the right until that length is reached.

## Generando Rangos

Se hace con la función `generate_series()`. Genera una tabla con una única columna dinámica. Recibe tres parámetros:

- El primero es el número de inicio de la serie.
- El segundo es el final de la serie.
- El tercero es el delta o paso, que puede ser negativo si hay overlap.

Overlap es cuando el número de inicio > número de final. Se pueden utilizar fechas. El delta se puede escribir literal para el caso de timestamps.

```sql
SELECT *
FROM generate_series('2020-12-06 11:50:00'::timestamp, '2020-10-10 05:30:55', '-7 hours, 23 minutes, 3 seconds');
```

## Distributed Databases

### Summary

Distributed databases are a collection of multiple databases that are physically separated but communicate through a computer network.

### Advantages
- **Modular Development**: Easier to develop and manage.
- **Increased Reliability**: More resilient to failures.
- **Improved Performance**: Faster data access and processing.
- **Higher Availability**: Data is accessible even if some nodes fail.
- **Faster Response**: Reduced latency in data retrieval.

### Disadvantages
- **Security Management**: More complex to secure.
- **Processing Complexity**: More difficult to process queries.
- **Data Integrity**: Ensuring data consistency is harder.
- **Cost**: Higher implementation and maintenance costs.

### Types
- **Homogeneous**: Same type of database, DBMS, and operating system.
- **Heterogeneous**: Different types of databases, DBMS, or operating systems.

### Architectures
- **Client-Server**: A main database with several client databases that retrieve data from the main one.
- **Peer-to-Peer**: All nodes are equal and communicate directly with each other.
- **Multi-DBMS**: Multiple database management systems working together.

### Design Strategy
- **Top-Down**: Plan the database thoroughly and configure it from top to bottom.
- **Bottom-Up**: Build on an existing database.

### Distributed Storage
- **Fragmentation**: Deciding where data is stored.
    - **Horizontal Fragmentation (Sharding)**: Splitting tables into horizontal pieces.
    - **Vertical Fragmentation**: Splitting tables by columns.
    - **Mixed Fragmentation**: Combining horizontal and vertical fragmentation.

- **Replication**: Copying data across multiple databases.
    - **Full Replication**: Entire database is copied across multiple locations.
    - **Partial Replication**: Only some data is replicated.
    - **No Replication**: Data is not copied; each database is independent.

### Data Distribution
- **Centralized**: Data is distributed from a central point.
- **Partitioned**: Data is divided among different geographic locations.
- **Replicated**: Same data is stored in multiple locations to ensure consistency.

## Bases de datos distribuidas

Al realizar una consulta que involucre bases de datos distribuidas y bajo ciertos supuestos podemos resolverla de varias formas posibles, con resultados que se dan desde los 0.1s o 2s hasta las 5.56h dependiendo de cómo esté estructurado el query. Existen cálculos que ayudan a preveer estos tiempos de respuesta, por ejemplo:

Retraso total de comunicación = (Retraso total de acceso) + (volumen total de datos / tasa de transferencia)

## Sharding

Sharding es un tipo de partición horizontal para nuestras bases de datos. Divide las tuplas de nuestras tablas en diferentes ubicaciones de acuerdo a ciertos criterios de modo que para hacer consultas, las tendremos que dirigir al shard o parte que corresponda.

### Cuándo usar

Cuando tenemos grandes volúmenes de información estática que representa un problema para obtener solo unas cuantas tuplas en consultas frecuentes.

### Inconvenientes

- Cuando debamos hacer joins frecuentemente entre shards.
- Baja elasticidad. Los shards crecen de forma irregular unos más que otros y vuelve a ser necesario usar sharding (subsharding).
- La llave primaria pierde utilidad.

## Window Functions

Realizan cálculos que relacionan una tupla con el resto dentro de un mismo scope o partición.

- Evita el uso del self joins.
- Reduce la complejidad alrededor de la analítica, agregaciones y cálculos.
- Luego de una agregación, la función `OVER` dicta el scope de la window function, al realizar un `PARTITION BY` campo.
- Si no se especifica un `PARTITION BY`, la función `OVER()` por default tomará toda la tabla.
- También se puede usar `ORDER BY` campo, esto agrega un campo de granularidad al cálculo, a la vez que agrupa todos los valores iguales dentro de la partición, que ahora se encuentran ordenados.

```sql
SELECT *,
    SUM(colegiatura) OVER (PARTITION BY carrera_id ORDER BY colegiatura)
FROM platzi.alumnos;
```

Podemos usar funciones de `RANK()`. Las Window Function se procesan casi al final de todas las operaciones, por eso para usar estas WF como un campo en `WHERE`, debemos hacer un subquery.

```sql
SELECT *
FROM (
    SELECT *,
        RANK() OVER (PARTITION BY carrera_id ORDER BY colegiatura DESC) AS brand_rank
    FROM platzi.alumnos
) AS ranked_colegiaturas_por_carrera
WHERE brand_rank < 3
ORDER BY brand_rank;
```

### Window Functions

- **ROW_NUMBER()**: Nos da el número de la tupla que estamos utilizando en ese momento.
- **OVER([PARTITION BY column] [ORDER BY column DIR])**: Nos deja particionar y ordenar la window function.
- **PARTITION BY(column/s)**: Es un `GROUP BY` para la window function, se coloca dentro de `OVER`.
- **FIRST_VALUE(column)**: Devuelve el primer valor de una serie de datos.
- **LAST_VALUE(column)**: Devuelve el último valor de una serie de datos.
- **NTH_VALUE(column, row_number)**: Recibe la columna y el número de fila que queremos devolver de una serie de datos.
- **RANK()**: Nos dice el lugar que ocupa de acuerdo al orden de cada tupla, deja gaps entre los valores.
- **DENSE_RANK()**: Es un rango más denso que trata de eliminar los gaps que nos deja `RANK`.
- **PERCENT_RANK()**: Categoriza de acuerdo al lugar que ocupa igual que los anteriores pero por porcentajes.

### Particiones y Agregaciones

- **ROW_NUMBER()**: Nos da el número de fila, se mantiene ordenado por más que establezcamos otro criterio de ordenamiento en donde el ID se desordene.
- **OVER(PARTITION BY campo ORDER BY campo2)**: Particiona según campo y campo2 ordenando por campo2 y agrupando valores de resultados según esta partición.
- **FIRST_VALUE(campo)**: Trae el primer valor de una serie de datos.
- **LAST_VALUE(campo)**: Trae el último valor de una serie de datos.
- **NTH_VALUE(campo, row_num)**: Trae el enésimo valor de una serie de datos.
- **RANK()**: Ranke valores según la partición y `ORDER BY` si cabe.
- **DENSE_RANK()**: Es como el `RANK`, pero si existen varios valores empatados, en lugar de saltar (ej: 1,1,1,4,4,6) mantiene el orden (ej: 1,1,1,2,2,3).
- **PERCENT_RANK()**: Ranke según el porcentaje al que pertenece el valor, a través de la siguiente fórmula: `(RANK() - 1) / (total de filas - 1)`.

