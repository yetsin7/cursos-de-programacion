# Capítulo 00 — Tu primera base de datos personalizada

> **Lee esto antes de empezar el libro.**

Este capítulo te enseña a crear una base de datos **desde cero, tuya, completamente vacía**,
y a hacer todas las operaciones básicas (CRUD) sobre ella. No usamos la Biblia aquí —
este es tu espacio para experimentar sin miedo a romper nada.

La base de datos de la Biblia se usa desde el capítulo 04 en adelante. Pero primero,
aprende con algo simple que tú mismo diseñas.

---

## ¿Qué vas a construir?

Una base de datos de **contactos personales** con estas tablas:

```
contactos/
├── personas     ← nombre, email, teléfono, ciudad
└── notas        ← notas personales sobre cada contacto
```

Es simple, pero cubre todo el CRUD:
- `CREATE` — crear las tablas
- `INSERT` — agregar contactos
- `SELECT` — leer y buscar
- `UPDATE` — actualizar datos
- `DELETE` — eliminar registros

---

## Cómo crear la base de datos

```bash
# Desde la terminal, en la carpeta de este capítulo:
sqlite3 mi_base_de_datos.db

# Dentro de sqlite3, puedes ejecutar el archivo directamente:
.read 01_crear_bd.sql

# O bien ejecutarlo desde fuera:
sqlite3 mi_base_de_datos.db < 01_crear_bd.sql
```

El archivo `mi_base_de_datos.db` se creará en esta misma carpeta.
**Está en el `.gitignore`** — es tuya, no se sube al repositorio.

---

## Archivos del capítulo

| Archivo | Qué hace |
|---------|----------|
| `01_crear_bd.sql` | Crea las tablas desde cero (puedes ejecutarlo varias veces sin error) |
| `02_insertar_datos.sql` | Inserta contactos de ejemplo para practicar |
| `03_consultar_datos.sql` | SELECT con filtros, búsquedas y JOINs |
| `04_actualizar_datos.sql` | UPDATE — modificar registros existentes |
| `05_eliminar_datos.sql` | DELETE — borrar registros individuales y en grupo |
| `06_crud_completo.sql` | Flujo completo de una operación real: agregar, editar, buscar, eliminar |
| `07_personaliza_tu_bd.sql` | Plantilla para que diseñes TU propia base de datos |

---

## La regla más importante

> **Puedes ejecutar todos los scripts de este capítulo cuantas veces quieras.**
> Al inicio de cada archivo se borra y recrea la BD para que siempre partas desde cero.
> No rompas nada — experimenta libremente.
