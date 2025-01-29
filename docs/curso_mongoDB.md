# Curso MongoDB
## 1.1 ¿Qué es Mongo DB?

MongoDB es parte de la familia de bases de datos NoSQL y es una forma de alamacenar datos para lectura y escritura con una forma particular de guardar los datos.

## 1.2 Bases de datos noSQL

### 1.2.1 tipos de bases de datos noSQL 

- Documentales: se caracterizan por emparejar los documentos con una estructura clave-valor
- Orientada a grafos: se enfocan en re4presentar su informacion con conexiones de datos
- Clave valor: Bases de datos noSQL que solo guardan en una estructura de clave-valor, para un acceso rapido
- Orientadas a columnas: permiten consultas de grandes conjuntos de datos y los almacenan en columnas en lugar de filas

### 1.2.2 Escalamiento de las bases de datos noSQL

- Escalamiento vertical: tenemos una maquina y un servidor, y a medida de que queremos soportar mas capacidad o mas velocidad, lo que hacemos es incrementar las caracteristicas de esa maquina

- Escalamiento horizontal: tener una de esta maquinas y copiarla, tener varios de estos nodos, lo cual hace y asegura por ejemplo, alta disponibilidad, sistemas de replicacion o un conjunto que responde en simultaneo, 

### 1.2.3 Replicacion

- La replicacion, es una tecnica, en donde, una vez, la base de datos esta distribuida en varios de nuestros nodos, haciendo escalamiento horizontal, lo que hacemos es que tenemos un punto central, en donde asigna las peticiones y consultas a cada uno de sus nodos de forma ordenada

## 1.3 Documentos y colecciones

### 1.3.1 Documentos

Los documentos es la forma en que Mongo va a almacenar la información que este dentro de un dominio (entidad) o que queramos tener allí.

Ejemplos de dominio:

- Los productos de un ecommerce.
- Las clases de un curso.
- El inventario de una tienda.

### 1.3.2 Colecciones

Los Documentos son una forma de organizar y almacenar información con un conjunto de pares clave-valor.

Las Colecciones es la forma en que guardamos esos documentos y que normalmente comparten datos entre sí, o al menos sabemos que tenemos una entidad o un modelo de datos que se relacionan. MongoDB almacena documentos en una colección, usualmente con campos comunes entre sí.

Ejemplo: Podemos tener una colección llamada Usuarios que contenga todos los documentos de los usuarios de nuestra aplicación.