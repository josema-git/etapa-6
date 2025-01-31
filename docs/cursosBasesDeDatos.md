# Apuntes para Examen de Bases de Datos

## Tipos de Bases de Datos

### Bases de Datos Relacionales
- **Definición:** Organizan los datos en tablas relacionadas entre sí mediante claves primarias y foráneas.
- **Ejemplos:**
  - SQL Server
  - Oracle
  - PostgreSQL
  - MySQL
  - MariaDB

### Bases de Datos No Relacionales
- **Definición:** No utilizan un esquema tabular tradicional. Almacenan datos en formatos como documentos, grafos o pares clave-valor.
- **Ejemplos:**
  - Cassandra
  - DynamoDB
  - ElasticSearch
  - BigQuery
  - MongoDB

---

## Tipos de Servicios de Bases de Datos

### Autoadministrados
- **Definición:** Bases de datos que instalas en tu computadora o servidor. Tú te encargas del mantenimiento, actualizaciones y configuración.

### Administrados
- **Definición:** Servicios ofrecidos por proveedores en la nube. No necesitas preocuparte por la administración de la base de datos, solo utilizas el servicio.

---

## Entidades y Atributos

### Entidad
- Representa algo del mundo real, similar a un objeto.

### Atributos
- Características o propiedades que describen a una entidad.

---

## Bases de Datos Relacionales (RBD)

### Niveles de Datos
1. **Bases de Datos o Esquemas:** Repositorios donde se almacenan los datos.
2. **Tablas:** Provienen del concepto de entidades.
3. **Tuplas o Renglones:** Representan cada registro dentro de una tabla.

### Contexto Histórico
- Antes se usaban bases de datos basadas en archivos (texto plano), que eran fáciles de guardar pero difíciles de extraer.
- En 1990, Edgar Frank Codd definió las 12 reglas para que un sistema de gestión de bases de datos (SGBD) sea considerado verdaderamente relacional.

### Reglas de Codd
1. **Regla 0:** El sistema debe gestionar bases de datos exclusivamente mediante capacidades relacionales.
2. **Regla 1:** Todos los datos deben almacenarse en tablas.
3. **Regla 2:** Cualquier dato debe ser accesible mediante clave de fila y nombre de columna.
4. **Regla 3:** Manejo sistemático de valores nulos.
5. **Regla 4:** Catálogo dinámico en línea basado en el modelo relacional.
6. **Regla 5:** Lenguaje completo para todas las funciones del SGBD.
7. **Regla 6:** Las vistas deben mostrar información actualizada.
8. **Regla 7:** Alto nivel de inserción, actualización y eliminación.
9. **Regla 8:** Independencia física de los datos.
10. **Regla 9:** Independencia lógica de los datos.
11. **Regla 10:** Gestión de reglas de integridad por el SGBD.
12. **Regla 11:** Independencia de la distribución.
13. **Regla 12:** No debe existir forma de subvertir las reglas anteriores.

---

## Relaciones y Cardinalidad

### Relaciones
- Representadas por un rombo, conectan entidades.
- Las relaciones suelen ser verbos que indican cómo interactúan las entidades.

### Cardinalidad
- Define la cantidad y correspondencia entre entidades:
  - Uno a uno
  - Uno a varios
  - Varios a uno
  - Varios a varios

---

## Tipos de Datos y Constraints

### Tipos de Datos

#### Texto
- **CHAR(n):** Tamaño fijo.
- **VARCHAR(n):** Tamaño variable (0 a n).
- **TEXT:** Cadenas grandes, mayores a 256 caracteres.

#### Números
- **INTEGER:** Enteros sin punto decimal.
- **BIGINT:** Enteros grandes.
- **SMALLINT:** Enteros pequeños.
- **DECIMAL(n, s):** Números decimales con precisión definida.
- **NUMERIC(n, s):** Similar a DECIMAL.

#### Fecha/Hora
- **DATE:** Año, mes y día.
- **TIME:** Hora del día.
- **DATETIME:** Fecha y hora.
- **TIMESTAMP:** Fecha y hora (similar a DATETIME).

#### Lógico
- **BOOLEAN:** Verdadero o falso.

### Constraints
- **NOT NULL:** La columna no puede tener valores nulos.
- **UNIQUE:** El valor debe ser único en toda la tabla.
- **PRIMARY KEY:** Combinación de NOT NULL y UNIQUE.
- **FOREIGN KEY:** Identifica de forma única una tupla en otra tabla.
- **CHECK:** Valida que el valor cumpla una condición.
- **DEFAULT:** Asigna un valor por defecto si no se especifica uno.
- **INDEX:** Mejora la velocidad de búsqueda.

---

## Normalización

### Primera Forma Normal (1FN)
- **Objetivo:** Eliminar valores repetidos y no atómicos.
- **Requisitos:**
  - Atributos atómicos.
  - Independencia del orden de filas y columnas.
  - Dependencia funcional de los campos no clave con la clave.

### Segunda Forma Normal (2FN)
- **Objetivo:** Diferenciar datos en diversas entidades.
- **Requisitos:**
  - Cumplir con 1FN.
  - Los atributos no clave deben depender completamente de la clave principal.

### Tercera Forma Normal (3FN)
- **Objetivo:** Separar entidades no dependientes.
- **Requisitos:**
  - Cumplir con 2FN.
  - No debe haber dependencias funcionales transitivas entre atributos no clave.

### Boyce Codd Forma normal (BCFN)
 - **Objetivo:** Eliminar datos multivaluados repetidos.
- **Requisitos:**
  - Cumplir con 3FN.
  - Identificar campos multivaluados con una clave única.


### Cuarta Forma Normal (4FN)
- **Objetivo:** Eliminar datos multivaluados repetidos.
- **Requisitos:**
  - Cumplir con 3FN.
  - Identificar campos multivaluados con una clave única.



---

## Bases de Datos Basadas en Documentos

### Niveles de Datos
- **Base de Datos:** Similar al esquema en bases relacionales.
- **Colección:** Equivalente a una tabla.
- **Documento:** Equivalente a una tupla o registro.

### Tipos de Colecciones
1. **Top-Level Collections:** Colecciones de nivel superior.
2. **Subcollections:** Colecciones que existen dentro de un documento padre.

### Reglas para Diseñar Colecciones
1. **Piensa en la Vista de tu Aplicación:** Diseña la estructura para reflejar cómo se mostrarán los datos en la aplicación.
2. **La Colección Tiene Vida Propia:** Si una entidad necesita modificarse de forma independiente, debería ser una colección de nivel superior.

---

## Bases de Datos en la Vida Real

### Uso de Diferentes Tipos de Bases de Datos
- Las bases de datos relacionales fueron dominantes, pero con el incremento de datos se volvieron ineficientes en algunos casos.
- Bases como Firestore o MongoDB son ideales para datos en tiempo real, pero no para consultas complejas.
- Es común usar múltiples tipos de bases de datos en un mismo proyecto.

### Conceptos Clave
1. **Big Data:** Manejo de grandes cantidades de datos, como en YouTube.
2. **Data Warehouse:** Almacenamiento de datos masivos para análisis a largo plazo.
3. **Data Mining:** Extracción y análisis de datos para obtener información útil.
4. **ETL (Extract, Transform, Load):** Proceso para transformar datos y cargarlos en un data warehouse.
5. **Business Intelligence:** Preparación de datos para la toma de decisiones empresariales.
6. **Machine Learning:** Uso de inteligencia artificial para detectar patrones y realizar:
   - **Clasificación**
   - **Predicción**
7. **Data Science:** Aplicación de técnicas avanzadas de análisis de datos, combinando estadísticas y ciencias duras.

---

## Lenguajes SQL

### DML (Data Manipulation Language)
- **Funciones:**
  - `SELECT`: Seleccionar registros.
  - `INSERT`: Insertar nuevos registros.
  - `UPDATE`: Actualizar registros existentes.
  - `DELETE`: Eliminar registros.

### DDL (Data Definition Language)
- **Funciones:**
  - `CREATE`: Crear bases de datos, tablas o vistas.
  - `ALTER`: Modificar tablas existentes.
  - `DROP`: Eliminar objetos.

### DCL (Data Control Language)
- **Funciones:**
  - `GRANT`: Otorgar permisos.
  - `REVOKE`: Revocar permisos.

### TCL (Transaction Control Language)
- **Funciones:**
  - `BEGIN`: Iniciar transacción.
  - `COMMIT`: Confirmar transacción.
  - `ROLLBACK`: Revertir transacción.

---

## Consultas SQL Básicas

### SELECT
- Mostrar datos:
  ```sql
  SELECT columna1, columna2 FROM tabla;
  ```

### WHERE
- Filtrar datos:
  ```sql
  SELECT * FROM tabla WHERE columna = 'valor';
  ```

### JOIN
- Combinar tablas:
  ```sql
  SELECT * FROM tabla1 JOIN tabla2 ON tabla1.id = tabla2.id;
  ```

### GROUP BY
- Agrupar datos:
  ```sql
  SELECT columna, COUNT(*) FROM tabla GROUP BY columna;
  ```

### ORDER BY
- Ordenar datos:
  ```sql
  SELECT * FROM tabla ORDER BY columna ASC;
  ```

### LIMIT
- Limitar resultados:
  ```sql
  SELECT * FROM tabla LIMIT 10;
  ```

---

## Resumen de Sentencias SQL
1. **SELECT:** Qué mostrar.
2. **FROM:** De dónde tomar los datos.
3. **WHERE:** Filtros.
4. **GROUP BY:** Agrupación.
5. **ORDER BY:** Ordenamiento.
6. **HAVING:** Filtros en datos agrupados.
7. **LIMIT:** Limitar resultados.
