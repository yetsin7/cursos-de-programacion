# Capítulo 01 — Introducción a SQL

Este capítulo te enseña a mirar una base de datos como un sistema organizado, no
como una caja negra. La meta no es memorizar `SELECT`, sino entender que estas
pidiendole información a un motor especializado.

---

## ¿Que es SQL?

SQL es el lenguaje estandar para trabajar con bases de datos relacionales.
Sirve para consultar, insertar, modificar, eliminar y estructurar información.

La idea importante es esta:

- en muchos lenguajes dices **como** hacer algo paso a paso;
- en SQL dices **que** datos quieres obtener o cambiar.

---

## ¿Que es una base de datos relacional?

Una base relacional organiza información en tablas:

- las **columnas** describen tipos de dato;
- las **filas** representan registros concretos;
- las relaciones conectan datos de distintas tablas.

Eso permite modelar información real de forma consistente y consultable.

---

## ¿Que ocurre dentro del motor de base de datos?

Cuando ejecutas una consulta:

1. el motor analiza la instrucción;
2. revisa tablas, columnas e índices;
3. busca datos en disco o memoria;
4. construye un resultado;
5. te devuelve una tabla temporal o modifica datos persistentes.

Por eso SQL esta conectado directamente con almacenamiento, memoria y
rendimiento.

---

## ¿Por que usamos SQLite para aprender?

SQLite guarda toda la base de datos en un solo archivo.
Eso la hace ideal para estudiar porque:

- no necesitas un servidor aparte;
- puedes abrir el archivo fácilmente;
- ves resultados rápido;
- prácticas SQL real que luego se parece mucho a PostgreSQL o MySQL.

---

## Tu primera consulta SQL

```sql
SELECT * FROM books;
SELECT long_name FROM books;
SELECT long_name FROM books LIMIT 5;
```

Estas tres consultas ya muestran ideas clave:

- pedir todo;
- pedir solo una columna;
- limitar resultados para explorar sin saturarte.

---

## Reglas básicas de sintaxis

1. `SELECT` y `select` funcionan igual, pero se suele escribir en mayusculas.
2. El `;` marca el final de la instrucción.
3. `--` crea comentarios de una linea.
4. Los textos se escriben entre comillas simples.
5. Las tablas y columnas normalmente no se escriben entre comillas.

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_primeras_consultas.sql` | Primeras consultas y exploracion de la base |

---

## Errores comúnes

- creer que `SELECT *` siempre es la mejor opcion;
- no distinguir entre columna y fila;
- olvidar el `;` cuando hay varias consultas;
- pensar que SQL es solo para "ver datos";
- ejecutar consultas sin entender de donde sale el resultado.

---

## Practica guiada

1. Ejecuta el archivo completo.
2. Luego ejecuta cada consulta por separado.
3. Cambia `LIMIT 5` por `LIMIT 10`.
4. Pide dos columnas distintas de `books`.
5. Explica que hace `sqlite_master`.

---

## Herramientas recomendadas

| Herramienta | Uso | Enlace |
|-------------|-----|--------|
| DB Browser for SQLite | GUI visual, ideal para aprender | https://sqlitebrowser.org/ |
| SQLite CLI | Terminal, rápida para pruebas | `sqlite3 archivo.db` |
| VS Code + SQLite Viewer | Extension para VS Code | Buscar en Extensions |
| TablePlus | GUI profesional | https://tableplus.com/ |
