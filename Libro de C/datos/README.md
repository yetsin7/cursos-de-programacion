# Datos — Base de datos de la Biblia

Este directorio documenta la base de datos que usa el proyecto final del `Libro de C`. La idea no
es solo saber que existe un archivo `.sqlite3`, sino entender qué representa y cómo un programa en
C puede trabajar con él.

## Archivo principal

La base utilizada por el proyecto es:

```text
C:/Users/Yetsin/Documents/Programacion/datos/biblia_rv60.sqlite3
```

Desde el capítulo `12-proyecto-biblia`, la ruta relativa es:

```text
../../datos/biblia_rv60.sqlite3
```

## Qué contiene esta base de datos

La base almacena información estructurada de la Biblia Reina-Valera 1960. Lo normal es encontrar
tablas para libros y versículos, donde cada registro representa una parte concreta del texto.

Un esquema simplificado sería:

```sql
CREATE TABLE libros (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    abrev TEXT,
    testamento TEXT
);

CREATE TABLE versiculos (
    id INTEGER PRIMARY KEY,
    libro_id INTEGER NOT NULL,
    capitulo INTEGER NOT NULL,
    versiculo INTEGER NOT NULL,
    texto TEXT NOT NULL
);
```

## Qué pasa cuando C consulta esta base

Tu programa no lee el archivo como texto normal. En su lugar, usa la biblioteca SQLite para abrir
el archivo, interpretar su formato interno y ejecutar consultas SQL. SQLite devuelve resultados que
tu programa convierte en texto, números o estructuras propias.

En otras palabras:

- El disco guarda el archivo
- SQLite entiende la base
- Tu programa en C pide datos y procesa respuestas

## recomendaciones para practicar

- Primero abre la base y verifica que la conexión funcione
- Consulta pocos registros antes de hacer búsquedas más complejas
- Comprueba siempre los códigos de retorno y mensajes de error
- No asumas que todas las consultas devolverán datos

## Relación con el libro

Este recurso conecta especialmente con:

- `09-manejo-de-archivos`
- `10-memoria-dinámica`
- `12-proyecto-biblia`

Si todavía no te sientes cómodo con punteros, strings o validación de errores, conviene reforzar
esos capítulos antes de profundizar en SQLite.
