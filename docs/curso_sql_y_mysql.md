# Guía Completa de Bases de Datos SQL - Parte 1: Fundamentos y MySQL

## 1. Fundamentos de Bases de Datos

### 1.1 ¿Qué es una Base de Datos?
Una base de datos es un conjunto organizado de información estructurada que se almacena y gestiona de manera sistemática. Va más allá de ser un simple repositorio de datos; es un sistema complejo que permite:

- **Almacenamiento Estructurado**: Los datos se organizan siguiendo patrones y estructuras definidas.
- **Integridad de Datos**: Garantiza que la información almacenada sea precisa y consistente.
- **Acceso Controlado**: Permite gestionar quién puede ver o modificar la información.
- **Recuperación Eficiente**: Facilita la búsqueda y obtención rápida de información.

### 1.2 Arquitectura de Base de Datos

#### 1.2.1 Niveles de Abstracción
1. **Nivel Físico**:
   - Describe cómo se almacenan los datos en el disco
   - Maneja estructuras de archivos y métodos de acceso
   - Gestiona la ubicación física de los datos

2. **Nivel Lógico**:
   - Define qué datos se almacenan
   - Establece las relaciones entre los datos
   - Determina las restricciones y reglas de integridad

3. **Nivel de Vista**:
   - Presenta los datos al usuario final
   - Oculta la complejidad de los niveles inferiores
   - Permite diferentes perspectivas de los mismos datos

### 1.3 Tipos de Bases de Datos

#### 1.3.1 Bases de Datos Relacionales (SQL)
Características principales:
- **Estructura Tabular**: Datos organizados en tablas con filas y columnas
- **Relaciones Definidas**: Conexiones explícitas entre tablas
- **Integridad Referencial**: Garantiza la consistencia entre relaciones
- **ACID**:
  - Atomicidad: Las transacciones son todo o nada
  - Consistencia: Los datos siempre cumplen las reglas definidas
  - Aislamiento: Las transacciones no interfieren entre sí
  - Durabilidad: Los cambios son permanentes

Ejemplos populares:
```
- MySQL: Ideal para aplicaciones web, código abierto
- PostgreSQL: Robusto, extensible, soporte a tipos avanzados
- Oracle: Empresarial, alto rendimiento
- SQL Server: Integración con ecosistema Microsoft
```

#### 1.3.2 Bases de Datos No Relacionales (NoSQL)
Características:
- **Esquema Flexible**: No requieren estructura fija
- **Escalabilidad Horizontal**: Fácil distribución en múltiples servidores
- **Tipos Diversos**:
  - Documentales (MongoDB)
  - Clave-valor (Redis)
  - Columnares (Cassandra)
  - Grafos (Neo4j)

### 1.4 Elementos Fundamentales

#### 1.4.1 Tablas
- **Definición**: Estructura básica de almacenamiento
- **Componentes**:
  - Columnas (campos)
  - Filas (registros)
  - Claves primarias
  - Claves foráneas

#### 1.4.2 Relaciones
Tipos:
1. **Uno a Uno (1:1)**
   ```sql
   -- Ejemplo: Persona y Pasaporte
   CREATE TABLE persona (
       id INT PRIMARY KEY,
       nombre VARCHAR(100)
   );
   
   CREATE TABLE pasaporte (
       numero VARCHAR(20) PRIMARY KEY,
       persona_id INT UNIQUE,
       FOREIGN KEY (persona_id) REFERENCES persona(id)
   );
   ```

2. **Uno a Muchos (1:N)**
   ```sql
   -- Ejemplo: Departamento y Empleados
   CREATE TABLE departamento (
       id INT PRIMARY KEY,
       nombre VARCHAR(50)
   );
   
   CREATE TABLE empleado (
       id INT PRIMARY KEY,
       nombre VARCHAR(100),
       departamento_id INT,
       FOREIGN KEY (departamento_id) REFERENCES departamento(id)
   );
   ```

3. **Muchos a Muchos (N:M)**
   ```sql
   -- Ejemplo: Estudiantes y Cursos
   CREATE TABLE estudiante (
       id INT PRIMARY KEY,
       nombre VARCHAR(100)
   );
   
   CREATE TABLE curso (
       id INT PRIMARY KEY,
       nombre VARCHAR(50)
   );
   
   CREATE TABLE inscripcion (
       estudiante_id INT,
       curso_id INT,
       fecha_inscripcion DATE,
       PRIMARY KEY (estudiante_id, curso_id),
       FOREIGN KEY (estudiante_id) REFERENCES estudiante(id),
       FOREIGN KEY (curso_id) REFERENCES curso(id)
   );
   ```

### 1.5 Normalización
Proceso de diseño de bases de datos que minimiza la redundancia y dependencias:

#### 1.5.1 Primera Forma Normal (1NF)
- Eliminar grupos repetitivos
- Cada columna contiene valores atómicos
- Cada registro es único

#### 1.5.2 Segunda Forma Normal (2NF)
- Cumple 1NF
- No hay dependencias parciales de la clave primaria

#### 1.5.3 Tercera Forma Normal (3NF)
- Cumple 2NF
- No hay dependencias transitivas

Ejemplo de normalización:
```sql
-- Tabla no normalizada
CREATE TABLE ventas_no_normalizada (
    id_venta INT,
    cliente_nombre VARCHAR(100),
    cliente_direccion VARCHAR(200),
    producto_nombre VARCHAR(100),
    producto_precio DECIMAL(10,2),
    cantidad INT
);

-- Tablas normalizadas
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200)
);

CREATE TABLE producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

CREATE TABLE venta (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
```


# Guía Completa de Bases de Datos SQL - Parte 2: MySQL en Profundidad

## 2. MySQL

### 2.1 Instalación y Configuración

#### 2.1.1 Archivos de Configuración Principales
```ini
# my.cnf o my.ini
[mysqld]
port=3306
basedir=/usr/local/mysql
datadir=/var/lib/mysql
max_connections=150
key_buffer_size=16M
max_allowed_packet=16M
```

#### 2.1.2 Variables del Sistema
```sql
-- Ver variables del sistema
SHOW VARIABLES;

-- Modificar variable en tiempo de ejecución
SET GLOBAL max_connections = 200;
SET SESSION sql_mode = 'STRICT_TRANS_TABLES';
```

### 2.2 Gestión de Conexiones

#### 2.2.1 Conexión desde Terminal
```bash
# Sintaxis básica
mysql -u [usuario] -p[contraseña] -h [host] -P [puerto]

# Ejemplo práctico
mysql -u root -p -h 127.0.0.1 -P 3306
```

#### 2.2.2 Gestión de Usuarios
```sql
-- Crear nuevo usuario
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'contraseña';

-- Otorgar privilegios
GRANT SELECT, INSERT, UPDATE ON base_datos.* TO 'usuario'@'localhost';

-- Revocar privilegios
REVOKE INSERT ON base_datos.* FROM 'usuario'@'localhost';

-- Ver privilegios
SHOW GRANTS FOR 'usuario'@'localhost';
```

### 2.3 Tipos de Tablas (Storage Engines)

#### 2.3.1 InnoDB
```sql
-- Crear tabla InnoDB
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    salario DECIMAL(10,2)
) ENGINE=InnoDB;
```

Características:
- Soporte para transacciones ACID
- Bloqueo a nivel de fila
- Integridad referencial
- Recuperación ante fallos

#### 2.3.2 MyISAM
```sql
-- Crear tabla MyISAM
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(100),
    fecha TIMESTAMP
) ENGINE=MyISAM;
```

Características:
- Mayor velocidad en lecturas
- Bloqueo a nivel de tabla
- Mejor para datos de solo lectura
- Menor consumo de recursos

### 2.4 Tipos de Datos

#### 2.4.1 Numéricos
```sql
-- Enteros
TINYINT    -- -128 a 127
SMALLINT   -- -32768 a 32767
MEDIUMINT  -- -8388608 a 8388607
INT        -- -2147483648 a 2147483647
BIGINT     -- -9223372036854775808 a 9223372036854775807

-- Decimales
DECIMAL(p,s)  -- Precisión exacta
FLOAT         -- Precisión aproximada simple
DOUBLE        -- Precisión aproximada doble
```

#### 2.4.2 Cadenas
```sql
-- Tipos de cadenas
CHAR(n)      -- Longitud fija
VARCHAR(n)   -- Longitud variable
TEXT         -- Texto largo
BLOB         -- Datos binarios
ENUM         -- Lista de valores permitidos
```

#### 2.4.3 Fecha y Hora
```sql
-- Tipos de fecha/hora
DATE        -- YYYY-MM-DD
TIME        -- HH:MM:SS
DATETIME    -- YYYY-MM-DD HH:MM:SS
TIMESTAMP   -- Timestamp UNIX
YEAR        -- Año en 2 o 4 dígitos
```

### 2.5 Índices y Optimización

#### 2.5.1 Tipos de Índices
```sql
-- Índice simple
CREATE INDEX idx_nombre ON empleados(nombre);

-- Índice compuesto
CREATE INDEX idx_nombre_dept ON empleados(nombre, departamento);

-- Índice único
CREATE UNIQUE INDEX idx_email ON usuarios(email);

-- Índice FULLTEXT
CREATE FULLTEXT INDEX idx_contenido ON articulos(contenido);
```

#### 2.5.2 Optimización de Consultas
```sql
-- Analizar consulta
EXPLAIN SELECT * FROM empleados WHERE salario > 50000;

-- Optimizar tabla
OPTIMIZE TABLE empleados;

-- Analizar tabla
ANALYZE TABLE empleados;
```

### 2.6 Transacciones y Bloqueos

#### 2.6.1 Gestión de Transacciones
```sql
-- Iniciar transacción
START TRANSACTION;

-- Operaciones
INSERT INTO cuentas (id, balance) VALUES (1, 1000);
UPDATE cuentas SET balance = balance - 500 WHERE id = 1;
UPDATE cuentas SET balance = balance + 500 WHERE id = 2;

-- Confirmar cambios
COMMIT;

-- O deshacer cambios
ROLLBACK;
```

#### 2.6.2 Niveles de Aislamiento
```sql
-- Configurar nivel de aislamiento
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Niveles disponibles:
-- READ UNCOMMITTED
-- READ COMMITTED
-- REPEATABLE READ
-- SERIALIZABLE
```

### 2.7 Backup y Restauración

#### 2.7.1 Realizar Backup
```bash
# Backup completo
mysqldump -u root -p --all-databases > backup_completo.sql

# Backup de una base de datos específica
mysqldump -u root -p nombre_bd > backup_bd.sql

# Backup con opciones adicionales
mysqldump -u root -p \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    nombre_bd > backup_completo.sql
```

#### 2.7.2 Restauración
```bash
# Restaurar backup
mysql -u root -p nombre_bd < backup_bd.sql

# Restaurar con progreso
pv backup_bd.sql | mysql -u root -p nombre_bd
```

# Guía Completa de Bases de Datos SQL - Parte 3: PostgreSQL en Profundidad

## 3. PostgreSQL

### 3.1 Características Fundamentales

#### 3.1.1 Arquitectura
PostgreSQL utiliza una arquitectura cliente-servidor:
```
Cliente <--> Proceso Postmaster <--> Procesos Backend
                    |
                    v
             Almacenamiento
```

#### 3.1.2 Conexión y Configuración Básica
```bash
# Conexión desde terminal
psql -U postgres -h localhost -p 5432 -d nombre_bd

# Archivo postgresql.conf principales configuraciones
listen_addresses = '*'
max_connections = 100
shared_buffers = 128MB
work_mem = 4MB
maintenance_work_mem = 64MB
```

### 3.2 Tipos de Datos Avanzados

#### 3.2.1 Tipos Geométricos
```sql
-- Puntos
CREATE TABLE ubicaciones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    coordenada POINT
);

INSERT INTO ubicaciones (nombre, coordenada) 
VALUES ('Centro', POINT(40.4168, -3.7038));

-- Líneas y Polígonos
CREATE TABLE areas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    perimetro POLYGON
);
```

#### 3.2.2 Arrays
```sql
-- Tabla con campo array
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    tags TEXT[],
    precios_historicos NUMERIC[]
);

-- Insertar con arrays
INSERT INTO productos (nombre, tags, precios_historicos)
VALUES ('Laptop', 
        ARRAY['electrónica', 'computadora', 'portátil'],
        ARRAY[999.99, 899.99, 849.99]);

-- Consultas con arrays
SELECT * FROM productos WHERE 'electrónica' = ANY(tags);
```

#### 3.2.3 JSON y JSONB
```sql
-- Tabla con campos JSON
CREATE TABLE documentos (
    id SERIAL PRIMARY KEY,
    datos JSON,
    datos_binarios JSONB
);

-- Insertar JSON
INSERT INTO documentos (datos) 
VALUES ('{"nombre": "Juan", "edad": 30, "hobbies": ["lectura", "música"]}');

-- Consultas JSON
SELECT datos->>'nombre' as nombre FROM documentos;
SELECT * FROM documentos 
WHERE datos_binarios @> '{"edad": 30}';
```

### 3.3 Herencias de Tablas

```sql
-- Tabla padre
CREATE TABLE vehiculos (
    id SERIAL PRIMARY KEY,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    año INT
);

-- Tablas hijas
CREATE TABLE autos INHERITS (vehiculos) (
    numero_puertas INT
);

CREATE TABLE motos INHERITS (vehiculos) (
    cilindrada INT
);

-- Consultas con herencia
SELECT * FROM vehiculos;  -- Incluye todos los vehículos
SELECT * FROM ONLY vehiculos;  -- Solo tabla padre
```

### 3.4 Funciones y Procedimientos Almacenados

#### 3.4.1 Funciones en PL/pgSQL
```sql
CREATE OR REPLACE FUNCTION calcular_edad(
    fecha_nacimiento DATE
) RETURNS INTEGER AS $$
BEGIN
    RETURN EXTRACT(YEAR FROM age(current_date, fecha_nacimiento));
END;
$$ LANGUAGE plpgsql;

-- Usar función
SELECT calcular_edad('1990-01-01');
```

#### 3.4.2 Triggers
```sql
-- Función para el trigger
CREATE OR REPLACE FUNCTION actualizar_ultima_modificacion()
RETURNS TRIGGER AS $$
BEGIN
    NEW.ultima_modificacion = current_timestamp;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear trigger
CREATE TRIGGER tr_ultima_modificacion
    BEFORE UPDATE ON empleados
    FOR EACH ROW
    EXECUTE FUNCTION actualizar_ultima_modificacion();
```

### 3.5 Particionamiento de Tablas

#### 3.5.1 Particionamiento por Rango
```sql
-- Tabla particionada
CREATE TABLE ventas (
    id SERIAL,
    fecha_venta DATE,
    monto DECIMAL(10,2)
) PARTITION BY RANGE (fecha_venta);

-- Crear particiones
CREATE TABLE ventas_2023 PARTITION OF ventas
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE ventas_2024 PARTITION OF ventas
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
```

#### 3.5.2 Particionamiento por Lista
```sql
CREATE TABLE ventas_regionales (
    id SERIAL,
    region VARCHAR(50),
    monto DECIMAL(10,2)
) PARTITION BY LIST (region);

CREATE TABLE ventas_norte PARTITION OF ventas_regionales
    FOR VALUES IN ('norte', 'noroeste', 'noreste');

CREATE TABLE ventas_sur PARTITION OF ventas_regionales
    FOR VALUES IN ('sur', 'suroeste', 'sureste');
```

### 3.6 Replicación y Alta Disponibilidad

#### 3.6.1 Configuración de Replicación
```ini
# En postgresql.conf del primario
wal_level = replica
max_wal_senders = 10
wal_keep_segments = 32

# En pg_hba.conf
host    replication     replicator      192.168.1.0/24        md5
```

#### 3.6.2 Configuración del Standby
```bash
# Crear base para standby
pg_basebackup -h primary_host -D /data -U replicator -P -v -R
```

### 3.7 Extensiones Populares

#### 3.7.1 PostGIS para Datos Espaciales
```sql
-- Instalar PostGIS
CREATE EXTENSION postgis;

-- Crear tabla espacial
CREATE TABLE ubicaciones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    geom GEOMETRY(Point, 4326)
);

-- Consulta espacial
SELECT nombre
FROM ubicaciones
WHERE ST_DWithin(
    geom,
    ST_SetSRID(ST_MakePoint(-73.935242, 40.730610), 4326),
    1000  -- metros
);
```

#### 3.7.2 pg_stat_statements para Monitoreo
```sql
-- Activar extensión
CREATE EXTENSION pg_stat_statements;

-- Consultar estadísticas
SELECT query, calls, total_time, rows
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

# Guía Completa de Bases de Datos SQL - Parte 4: Administración Avanzada

## 4. Administración Avanzada de Bases de Datos

### 4.1 Monitoreo y Diagnóstico

#### 4.1.1 Monitoreo de Rendimiento
```sql
-- Consultas activas en PostgreSQL
SELECT pid, query, state, waiting, query_start
FROM pg_stat_activity
WHERE state != 'idle';

-- Consultas activas en MySQL
SHOW PROCESSLIST;

-- Estadísticas de tablas
-- PostgreSQL
SELECT schemaname, relname, seq_scan, idx_scan
FROM pg_stat_user_tables;

-- MySQL
SHOW TABLE STATUS;
```

#### 4.1.2 Análisis de Consultas Lentas
```sql
-- PostgreSQL: Configurar log de consultas lentas
ALTER SYSTEM SET log_min_duration_statement = '1000';  -- ms

-- MySQL: Activar slow query log
SET GLOBAL slow_query_log = 1;
SET GLOBAL long_query_time = 1;  -- segundos
```

### 4.2 Optimización de Rendimiento

#### 4.2.1 Configuración de Memoria
```ini
# PostgreSQL (postgresql.conf)
shared_buffers = '256MB'         # 25% de RAM
work_mem = '16MB'                # Para operaciones de ordenamiento
maintenance_work_mem = '64MB'    # Para mantenimiento

# MySQL (my.cnf)
innodb_buffer_pool_size = 1G     # 70-80% de RAM
innodb_log_file_size = 256M
key_buffer_size = 256M           # Para tablas MyISAM
```

#### 4.2.2 Optimización de Índices
```sql
-- Análisis de uso de índices
-- PostgreSQL
SELECT schemaname, tablename, indexname, idx_scan
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;

-- MySQL
SHOW INDEX FROM nombre_tabla;

-- Crear índices eficientes
CREATE INDEX CONCURRENTLY idx_nombre ON tabla(columna);  -- PostgreSQL
CREATE INDEX idx_nombre ON tabla(columna) ALGORITHM=INPLACE;  -- MySQL
```

### 4.3 Mantenimiento Programado

#### 4.3.1 Vacuum y Análisis (PostgreSQL)
```sql
-- Vacuum manual
VACUUM (VERBOSE, ANALYZE) tabla;

-- Vacuum full
VACUUM FULL tabla;

-- Configuración de autovacuum
ALTER SYSTEM SET autovacuum_vacuum_scale_factor = 0.1;
ALTER SYSTEM SET autovacuum_analyze_scale_factor = 0.05;
```

#### 4.3.2 Optimización de Tablas (MySQL)
```sql
-- Optimizar tablas
OPTIMIZE TABLE tabla1, tabla2;

-- Analizar tablas
ANALYZE TABLE tabla1, tabla2;

-- Reparar tablas
REPAIR TABLE tabla1;
```

### 4.4 Gestión de Espacio

#### 4.4.1 Monitoreo de Espacio
```sql
-- PostgreSQL: Tamaño de bases de datos
SELECT datname, pg_size_pretty(pg_database_size(datname))
FROM pg_database;

-- MySQL: Tamaño de bases de datos
SELECT 
    table_schema AS 'Base de Datos',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Tamaño (MB)'
FROM information_schema.tables
GROUP BY table_schema;
```

#### 4.4.2 Gestión de Tablespaces
```sql
-- PostgreSQL: Crear tablespace
CREATE TABLESPACE ts_datos
LOCATION '/ruta/a/datos';

-- Mover tabla a nuevo tablespace
ALTER TABLE tabla SET TABLESPACE ts_datos;

-- MySQL: Mover archivos de datos
ALTER TABLE tabla DISCARD TABLESPACE;
ALTER TABLE tabla IMPORT TABLESPACE;
```

### 4.5 Seguridad Avanzada

#### 4.5.1 Auditoría
```sql
-- PostgreSQL: Configurar auditoría
CREATE EXTENSION pgaudit;

-- MySQL: Activar log de auditoría
SET GLOBAL audit_log_policy = 'ALL';
```

#### 4.5.2 Cifrado de Datos
```sql
-- PostgreSQL: Cifrado a nivel de columna
CREATE EXTENSION pgcrypto;

-- Insertar datos cifrados
INSERT INTO usuarios (nombre, password) 
VALUES ('usuario', crypt('contraseña', gen_salt('bf')));

-- MySQL: Cifrado de datos en reposo
ALTER INSTANCE ROTATE INNODB MASTER KEY;
```

### 4.6 Alta Disponibilidad

#### 4.6.1 Configuración de Clustering
```bash
# PostgreSQL: Configurar replicación streaming
# En primary:
postgresql.conf:
wal_level = replica
max_wal_senders = 10

# En standby:
postgresql.conf:
hot_standby = on
```

#### 4.6.2 Balanceo de Carga
```nginx
# Ejemplo de configuración Nginx para balanceo
upstream database {
    server db1.ejemplo.com:5432;
    server db2.ejemplo.com:5432 backup;
}
```

### 4.7 Recuperación ante Desastres

#### 4.7.1 Estrategias de Backup
```bash
# PostgreSQL: Backup físico
pg_basebackup -D /ruta/backup -Ft -z -P

# MySQL: Backup lógico
mysqldump --all-databases --single-transaction \
    --triggers --routines --events > backup.sql
```

#### 4.7.2 Plan de Recuperación
```sql
-- Punto de recuperación (PostgreSQL)
SELECT pg_create_restore_point('nombre_punto');

-- Recuperación a punto en el tiempo
-- PostgreSQL
recovery.conf:
restore_command = 'cp /ruta/archivo/%f %p'
recovery_target_time = '2024-01-28 16:34:00'

-- MySQL
mysqlbinlog --stop-datetime="2024-01-28 16:34:00" \
    /var/log/mysql/mysql-bin.* | mysql -u root -p
```

# Guía Completa de Bases de Datos SQL - Parte 5: Seguridad y Roles

## 5. Seguridad y Gestión de Roles

### 5.1 Gestión de Usuarios y Roles

#### 5.1.1 Creación y Gestión de Roles
```sql
-- PostgreSQL
CREATE ROLE nombre_rol LOGIN PASSWORD 'contraseña';
CREATE ROLE admin_role NOINHERIT;

-- Asignar roles
GRANT admin_role TO usuario;

-- MySQL
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'contraseña';
CREATE ROLE 'admin_role';
GRANT 'admin_role' TO 'usuario'@'localhost';
```

#### 5.1.2 Privilegios Específicos
```sql
-- PostgreSQL
GRANT SELECT, INSERT ON tabla TO rol;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO rol;

-- Revocar privilegios
REVOKE INSERT ON tabla FROM rol;

-- MySQL
GRANT SELECT, INSERT ON base_datos.tabla TO 'usuario'@'localhost';
REVOKE INSERT ON base_datos.tabla FROM 'usuario'@'localhost';
```

### 5.2 Políticas de Seguridad

#### 5.2.1 Row Level Security (RLS)
```sql
-- PostgreSQL
-- Activar RLS en una tabla
ALTER TABLE empleados ENABLE ROW LEVEL SECURITY;

-- Crear política
CREATE POLICY acceso_empleados ON empleados
    FOR SELECT
    USING (departamento = current_user);

-- MySQL (Emulación de RLS)
CREATE VIEW empleados_vista AS
SELECT * FROM empleados 
WHERE departamento = CURRENT_USER();
```

#### 5.2.2 Cifrado y Seguridad de Datos
```sql
-- PostgreSQL con pgcrypto
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Cifrar datos
UPDATE usuarios SET 
    datos_sensibles = pgp_sym_encrypt(
        'información confidencial',
        'clave_maestra'
    );

-- Descifrar datos
SELECT pgp_sym_decrypt(
    datos_sensibles::bytea,
    'clave_maestra'
) FROM usuarios;
```

### 5.3 Auditoría

#### 5.3.1 Configuración de Auditoría
```sql
-- PostgreSQL con pgaudit
CREATE EXTENSION pgaudit;

-- Configurar auditoría de sesión
ALTER SYSTEM SET pgaudit.log = 'write, ddl';
ALTER SYSTEM SET pgaudit.log_catalog = off;

-- MySQL
SET GLOBAL audit_log_format = JSON;
SET GLOBAL audit_log_policy = ALL;
```

#### 5.3.2 Consulta de Logs de Auditoría
```sql
-- PostgreSQL
SELECT * FROM pg_audit_log
WHERE action_statement_tag = 'INSERT';

-- MySQL
SELECT * FROM mysql.audit_log_file
WHERE event_type = 'query'
AND status = 0;
```

### 5.4 Gestión de Contraseñas

#### 5.4.1 Políticas de Contraseñas
```sql
-- PostgreSQL
CREATE EXTENSION passwordcheck;

-- MySQL
INSTALL COMPONENT 'file://component_validate_password';
SET GLOBAL validate_password.policy = STRONG;
SET GLOBAL validate_password.length = 12;
```

#### 5.4.2 Rotación de Contraseñas
```sql
-- PostgreSQL
ALTER ROLE usuario PASSWORD 'nueva_contraseña' VALID UNTIL '2025-12-31';

-- MySQL
ALTER USER 'usuario'@'localhost' 
    IDENTIFIED BY 'nueva_contraseña' 
    PASSWORD EXPIRE INTERVAL 90 DAY;
```

### 5.5 SSL/TLS y Conexiones Seguras

#### 5.5.1 Configuración SSL
```ini
# PostgreSQL (postgresql.conf)
ssl = on
ssl_cert_file = 'server.crt'
ssl_key_file = 'server.key'
ssl_ca_file = 'root.crt'

# MySQL (my.cnf)
[mysqld]
ssl-cert=/path/to/server-cert.pem
ssl-key=/path/to/server-key.pem
ssl-ca=/path/to/ca-cert.pem
```

#### 5.5.2 Forzar Conexiones SSL
```sql
-- PostgreSQL
ALTER ROLE nombre_usuario SET requiressl = on;

-- MySQL
ALTER USER 'usuario'@'localhost' REQUIRE SSL;
```

### 5.6 Gestión de Acceso a Red

#### 5.6.1 Control de Acceso por IP
```bash
# PostgreSQL (pg_hba.conf)
host    database    user    192.168.1.0/24    md5
host    all         all     0.0.0.0/0         reject

# MySQL
CREATE USER 'usuario'@'192.168.1.%' IDENTIFIED BY 'contraseña';
```

#### 5.6.2 Firewall y Puertos
```bash
# Configurar firewall (Linux)
sudo ufw allow from 192.168.1.0/24 to any port 5432  # PostgreSQL
sudo ufw allow from 192.168.1.0/24 to any port 3306  # MySQL
```

### 5.7 Monitoreo de Seguridad

#### 5.7.1 Detección de Intrusiones
```sql
-- PostgreSQL
CREATE TABLE intentos_fallidos (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(100),
    ip_address INET,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para registrar intentos fallidos
CREATE OR REPLACE FUNCTION registrar_intento_fallido()
RETURNS event_trigger AS $$
BEGIN
    IF TG_EVENT = 'login_failed' THEN
        INSERT INTO intentos_fallidos (usuario, ip_address)
        VALUES (current_user, inet_client_addr());
    END IF;
END;
$$ LANGUAGE plpgsql;
```

#### 5.7.2 Alertas de Seguridad
```sql
-- Ejemplo de procedimiento de alerta
CREATE OR REPLACE PROCEDURE verificar_intentos_fallidos()
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM intentos_fallidos
        WHERE fecha > NOW() - INTERVAL '5 minutes'
        GROUP BY ip_address
        HAVING COUNT(*) > 5
    ) THEN
        -- Enviar alerta (implementación específica)
        RAISE NOTICE 'Detectados múltiples intentos fallidos de login';
    END IF;
END;
$$;
```