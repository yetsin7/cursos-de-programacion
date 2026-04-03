# Vocabulario de Bases de Datos

## Introducción

Las bases de datos son el corazón de casi toda aplicación. Este vocabulario
en inglés te permitirá leer documentación, escribir queries, discutir
arquitecturas y colaborar en equipos internacionales.

---

## Estructura de una base de datos relacional (SQL)

| Término | Significado | Ejemplo |
|---------|-------------|---------|
| **Table** | Estructura que almacena datos organizados en filas y columnas | `users`, `orders`, `products` |
| **Row** (record) | Una entrada individual en la tabla | Un usuario específico |
| **Column** (field) | Un atributo de la tabla | `name`, `email`, `created_at` |
| **Field** | Sinónimo de column, más usado en NoSQL | Un campo del documento |
| **Record** | Sinónimo de row | Un registro de la tabla |
| **Schema** | Estructura/definición de la base de datos | Tablas, columnas, tipos, relaciones |
| **Cell** | Intersección de una fila y columna | El valor `"John"` en la fila 1, columna `name` |

### Visualización

```
Table: users
┌────┬──────────┬─────────────────┬────────────┐
│ id │ name     │ email           │ created_at │  ← Columns (fields)
├────┼──────────┼─────────────────┼────────────┤
│ 1  │ John     │ john@email.com  │ 2024-01-15 │  ← Row (record)
│ 2  │ Maria    │ maria@email.com │ 2024-02-20 │  ← Row (record)
│ 3  │ Alex     │ alex@email.com  │ 2024-03-10 │  ← Row (record)
└────┴──────────┴─────────────────┴────────────┘
        ↑
       Cell: "Maria"
```

---

## Claves y relaciones

| Término | Significado |
|---------|-------------|
| **Primary key** (PK) | Identificador único de cada fila. No puede repetirse ni ser null |
| **Foreign key** (FK) | Columna que referencia la primary key de otra tabla |
| **Unique key** | Restricción que impide valores duplicados en una columna |
| **Composite key** | Clave primaria formada por dos o más columnas |
| **Index** | Estructura que acelera las búsquedas en una columna |

### Relaciones (Relationships)

| Tipo | Significado | Ejemplo |
|------|-------------|---------|
| **One-to-one** (1:1) | Un registro se relaciona con exactamente uno | User ↔ Profile |
| **One-to-many** (1:N) | Un registro se relaciona con muchos | User → Posts |
| **Many-to-many** (M:N) | Muchos registros se relacionan con muchos | Students ↔ Courses |

```sql
-- One-to-many: Un usuario tiene muchos posts
-- La tabla posts tiene un foreign key hacia users
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    user_id INTEGER REFERENCES users(id)  -- Foreign key
);
```

```
"The users table has a one-to-many relationship with posts."
"The foreign key user_id references the primary key in users."
"Students and courses have a many-to-many relationship
 through the enrollments table."
```

---

## Tipos de JOIN

Los JOINs combinan datos de dos o más tablas. Son fundamentales en SQL.

| Tipo | Descripción |
|------|-------------|
| **INNER JOIN** | Solo filas que coinciden en ambas tablas |
| **LEFT JOIN** (LEFT OUTER JOIN) | Todas las filas de la izquierda + coincidencias de la derecha |
| **RIGHT JOIN** (RIGHT OUTER JOIN) | Todas las filas de la derecha + coincidencias de la izquierda |
| **FULL JOIN** (FULL OUTER JOIN) | Todas las filas de ambas tablas |
| **CROSS JOIN** | Producto cartesiano (cada fila con cada fila) |
| **SELF JOIN** | Una tabla unida consigo misma |

### Ejemplo visual

```sql
-- INNER JOIN: Solo usuarios que tienen posts
SELECT users.name, posts.title
FROM users
INNER JOIN posts ON users.id = posts.user_id;

-- LEFT JOIN: Todos los usuarios, incluso sin posts
SELECT users.name, posts.title
FROM users
LEFT JOIN posts ON users.id = posts.user_id;
```

```
"Use an inner join to get only users with orders."
"A left join returns all users, even those without posts."
"We need a full join to see all records from both tables."
```

---

## Operaciones de datos

| Término | Significado |
|---------|-------------|
| **Query** | Consulta a la base de datos |
| **Insert** | Insertar nuevos registros |
| **Update** | Modificar registros existentes |
| **Delete** | Eliminar registros |
| **Select** | Obtener/leer registros |
| **Filter** (WHERE) | Filtrar resultados según condiciones |
| **Sort** (ORDER BY) | Ordenar resultados |
| **Group** (GROUP BY) | Agrupar resultados |
| **Aggregate** | Funciones como COUNT, SUM, AVG, MAX, MIN |

```
"Run a query to fetch all active users."
"Insert a new record into the orders table."
"Update the email field where id equals 5."
"Delete all expired sessions from the database."
```

---

## Migraciones y seeds

| Término | Significado |
|---------|-------------|
| **Migration** | Script que modifica la estructura de la BD (crear tablas, añadir columnas) |
| **Seed** | Script que inserta datos iniciales o de prueba |
| **Rollback** | Revertir una migración o transacción |
| **Up migration** | Aplicar un cambio (crear tabla, añadir columna) |
| **Down migration** | Revertir un cambio (eliminar tabla, quitar columna) |

```
"Run the migrations to create the database tables."
"Seed the database with sample data for testing."
"Rollback the last migration if something went wrong."
"The up migration adds a 'role' column to the users table."
```

---

## Transacciones y propiedades ACID

| Término | Significado |
|---------|-------------|
| **Transaction** | Grupo de operaciones que se ejecutan como una unidad |
| **Commit** | Confirmar y guardar los cambios de una transacción |
| **Rollback** | Deshacer todos los cambios de una transacción |
| **ACID** | Propiedades de transacciones confiables |

### ACID desglosado

| Letra | Propiedad | Significado |
|-------|-----------|-------------|
| A | **Atomicity** | Todas las operaciones se completan o ninguna |
| C | **Consistency** | La BD pasa de un estado válido a otro válido |
| I | **Isolation** | Las transacciones no interfieren entre sí |
| D | **Durability** | Los cambios confirmados se persisten permanentemente |

```
"Wrap the transfer in a transaction to ensure atomicity."
"If any step fails, rollback the entire transaction."
"Commit the transaction after all operations succeed."
"ACID compliance guarantees data integrity."
```

---

## SQL vs NoSQL

### SQL (Relacional)

| Término | Significado |
|---------|-------------|
| **SQL** (Structured Query Language) | Lenguaje para consultar bases de datos relacionales |
| **ORM** (Object-Relational Mapping) | Librería que mapea tablas a objetos del código |
| **Relational database** | BD basada en tablas con relaciones (PostgreSQL, MySQL) |
| **Normalized** | Datos organizados para minimizar redundancia |

### NoSQL (No relacional)

| Término | Significado |
|---------|-------------|
| **NoSQL** | Bases de datos no relacionales |
| **Document** | Unidad de datos en NoSQL (similar a un JSON) |
| **Collection** | Grupo de documentos (similar a una tabla) |
| **Document database** | BD que almacena documentos JSON (MongoDB, Firestore) |
| **Key-value store** | BD que almacena pares clave-valor (Redis) |
| **Denormalized** | Datos duplicados para optimizar lecturas |

```
"We use PostgreSQL as our relational database with Prisma as ORM."
"MongoDB stores data as documents in collections."
"Redis is a key-value store used for caching."
"The data is denormalized to avoid expensive joins."
```

---

## Frases comunes sobre bases de datos

```
"Query the database"        → Consultar la base de datos
"Seed the database"         → Poblar la BD con datos iniciales
"Run migrations"            → Ejecutar migraciones
"Add an index"              → Añadir un índice (para rendimiento)
"Normalize the data"        → Normalizar los datos
"Drop the table"            → Eliminar la tabla
"Truncate the table"        → Vaciar la tabla (eliminar todas las filas)
"Alter the table"           → Modificar la estructura de la tabla
"Back up the database"      → Hacer respaldo de la base de datos
"Restore from backup"       → Restaurar desde un respaldo
"Schema design"             → Diseño del esquema
"Data modeling"             → Modelado de datos
```
