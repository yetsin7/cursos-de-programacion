# Libro de SQL — De cero a PRO

> Repositorio gratuito y abierto para aprender SQL desde absolutamente cero hasta nivel profesional.
> Sin cursos de pago. Sin registros. Solo abre una terminal y empieza.

---

## ¿Para quien es esto?

Para **cualquier persona** que quiera entender y manejar bases de datos relacionales.
No necesitas experiencia previa en programación. Solo necesitas:

- Una instalación de **SQLite** (viene incluido en Python, o descárgalo directamente)
- Un editor de texto o **DB Browser for SQLite** para visualizar los datos
- Ganas de aprender

Al terminar este libro deberias entender:

- como se guarda la información en tablas;
- como el motor de base de datos busca, filtra y ordena registros;
- como se relacionan los datos;
- como una consulta impacta rendimiento y uso de disco;
- como disenar estructuras claras para software real.

---

## ¿Como usar este repositorio?

1. Instala **DB Browser for SQLite** (ver instrucciones abajo) — es visual y gratuito
2. Clona o descarga este repositorio
3. Abre la carpeta del primer capítulo y lee el `README.md`
4. Luego abre los archivos `.sql` en orden — cada uno tiene ejercicios comentados
5. Ejecuta cada consulta en DB Browser o en la terminal de SQLite
6. Los capítulos 04 en adelante usan la base de datos de la Biblia como dataset real

> **Tip:** En VS Code puedes instalar la extension **SQLite Viewer** para ver y
> ejecutar archivos `.sql` sin salir del editor.

## Que ocurre dentro del motor SQL

Cuando ejecutas una consulta:

- el motor analiza la instrucción;
- revisa tablas, columnas e índices;
- busca datos en disco y memoria;
- filtra, agrupa, ordena o transforma resultados;
- devuelve una tabla temporal o modifica datos persistentes.

Aprender SQL bien es aprender a pensar información, no solo comandos.

---

## Instalar SQLite

### Opción 1 — DB Browser for SQLite (recomendado para aprender)
Interfaz gráfica para explorar bases de datos visualmente.
Descarga en: https://sqlitebrowser.org/

### Opción 2 — SQLite CLI
```bash
# En Windows (con Chocolatey)
choco install sqlite

# Verificar instalación
sqlite3 --version

# Abrir la base de datos de la Biblia
sqlite3 ../datos/biblia_rv60.sqlite3
```

### Opción 3 — Desde Python (sin instalar nada extra)
```python
import sqlite3

conn = sqlite3.connect('../datos/biblia_rv60.sqlite3')
cursor = conn.cursor()
cursor.execute('SELECT long_name FROM books LIMIT 5')
for row in cursor.fetchall():
    print(row[0])
conn.close()
```

---

## Base de datos del curso

Desde el capítulo 4 en adelante usamos la **Biblia Reina-Valera 1960** como dataset real.
El archivo está en la carpeta compartida del repositorio:

```
cursos-de-programacion/datos/biblia_rv60.sqlite3
```

Desde cualquier capítulo de este libro, la ruta relativa es:
```
../../datos/biblia_rv60.sqlite3
```

Es un dataset perfecto para aprender SQL porque:
- Tiene **31,103 filas** de versículos (datos reales para practicar SELECT, WHERE, JOIN)
- Tiene **2 tablas relacionadas** (books y verses) para practicar JOINs
- El texto en español permite practicar búsquedas con LIKE y texto

Consulta `../../datos/README.md` para la documentación completa de las tablas.

---

## Estructura del libro

### Nivel Básico — Los fundamentos

| Carpeta | Tema |
|---------|------|
| `01-introducción-sql/` | Qué es SQL, SQLite, primera consulta |
| `02-select-y-filtros/` | SELECT, WHERE, operadores de comparación |
| `03-ordenamiento-y-límites/` | ORDER BY, LIMIT, OFFSET |
| `04-funciones-agregadas/` | COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING |
| `05-joins/` | INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN |

### Nivel Intermedio — Más control

| Carpeta | Tema |
|---------|------|
| `06-subconsultas/` | Subqueries, EXISTS, IN, ANY/ALL |
| `07-modificar-datos/` | INSERT, UPDATE, DELETE, UPSERT |
| `08-diseno-de-tablas/` | CREATE TABLE, tipos de datos, constraints |
| `09-índices-y-performance/` | Índices, EXPLAIN QUERY PLAN, optimización |
| `10-transacciones/` | BEGIN, COMMIT, ROLLBACK, ACID |

### Nivel Avanzado — SQL profesional

| Carpeta | Tema |
|---------|------|
| `11-vistas-y-ctes/` | CREATE VIEW, CTEs (WITH), recursividad |
| `12-consultas-avanzadas/` | Window functions, CASE, funciones de texto |
| `13-proyecto-biblia/` | Proyecto final: análisis completo del dataset Biblia |

---

## Cómo ejecutar los ejercicios

### Con DB Browser for SQLite
1. Abre DB Browser → Archivo → Abrir base de datos
2. Selecciona `../../datos/biblia_rv60.sqlite3`
3. Ve a la pestaña **Ejecutar SQL**
4. Copia y pega las consultas de los archivos `.sql`
5. Presiona **F5** para ejecutar

### Con SQLite CLI
```bash
# Desde la carpeta del capítulo
sqlite3 ../../datos/biblia_rv60.sqlite3

# Dentro del prompt de sqlite3:
.headers on
.mode column
SELECT long_name FROM books LIMIT 5;
.quit
```

### Con Python (para practicar integración)
```python
import sqlite3
import os

db = os.path.join(os.path.dirname(__file__), '..', '..', 'datos', 'biblia_rv60.sqlite3')
conn = sqlite3.connect(db)
conn.row_factory = sqlite3.Row  # acceso por nombre de columna

for row in conn.execute('SELECT long_name FROM books LIMIT 5'):
    print(row['long_name'])

conn.close()
```

---

*Este libro es de acceso libre y gratuito. El dataset bíblico se usa únicamente con fines educativos.*
