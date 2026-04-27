# Capítulo 12 — Proyecto Biblia: SQLite3 en C

Este capítulo final convierte la teoría en una experiencia más cercana al desarrollo real. En vez
de trabajar solo con ejemplos aislados, usarás C para conectarte a una base de datos SQLite y
consultar información concreta. Aquí se combinan archivos, strings, punteros, memoria, control de
flujo y organización del código.

## Objetivo del proyecto

Construir un programa que abra la base de datos `biblia_rv60.sqlite3`, consulte libros y
versículos, y muestre resultados útiles desde la terminal.

## Qué aprenderás aquí

- Qué es SQLite y por qué se usa tanto en software real
- Cómo abrir y cerrar una base de datos desde C
- Cómo ejecutar consultas y recorrer resultados
- Qué diferencia hay entre ejecutar SQL directo y usar sentencias preparadas
- Cómo conectar lo aprendido en el libro dentro de un proyecto más completo

## Qué está pasando dentro del software y del hardware

SQLite es un motor embebido. No necesitas un servidor aparte. Tu programa habla directamente con
una biblioteca que administra un archivo `.sqlite3` en disco. Cuando haces una consulta, SQLite
lee páginas del archivo, interpreta el SQL, busca los registros y te devuelve filas que luego tu
programa procesa en memoria.

Esto significa que aquí ya intervienen varias capas al mismo tiempo:

- Tu código en C
- La biblioteca SQLite
- El sistema operativo
- El sistema de archivos
- La memoria usada para consultas y resultados

## Ruta de la base de datos

Desde este capítulo la base se encuentra en:

```text
../../datos/biblia_rv60.sqlite3
```

## Conceptos clave del proyecto

### 1. Abrir la base de datos

```c
sqlite3 *db = NULL;
int rc = sqlite3_open("../../datos/biblia_rv60.sqlite3", &db);
```

Si `rc` no indica éxito, debes revisar el error y cerrar correctamente.

### 2. Ejecutar consultas

SQLite permite consultas sencillas con `sqlite3_exec`, pero para trabajo más serio conviene usar
sentencias preparadas.

### 3. Sentencias preparadas

```c
sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
sqlite3_bind_int(stmt, 1, 43);
```

Esto mejora seguridad, orden y reutilización. También ayuda a evitar errores al construir SQL.

### 4. Recorrer resultados

```c
while (sqlite3_step(stmt) == SQLITE_ROW) {
    const char *texto = (const char *)sqlite3_column_text(stmt, 0);
}
```

Tu programa recibe filas una por una y debe decidir cómo usarlas o mostrarlas.

### 5. Liberar recursos

No basta con abrir la base y consultar. También debes cerrar la conexión y finalizar statements.

## Por qué este proyecto es valioso

- Te acerca al desarrollo real con datos persistentes
- Te enseña a integrar librerías externas
- Te obliga a manejar errores de forma más profesional
- Refuerza la idea de que programar no es solo "hacer prints", sino conversar con otros sistemas

## Errores comúnes

- Usar una ruta incorrecta para la base de datos
- No comprobar los códigos de retorno de SQLite
- Olvidar `sqlite3_finalize` o `sqlite3_close`
- Construir consultas inseguras o poco claras
- Suponer que los datos siempre existirán

## Cómo estudiar este capítulo

1. Compila el proyecto con calma y revisa cada advertencia.
2. Prueba consultas pequeñas antes de tocar el programa completo.
3. Cambia parámetros y observa cómo cambian los resultados.
4. Lee mensajes de error completos cuando algo falle.
5. Relaciona cada parte del proyecto con capítulos anteriores del libro.

## Requisitos generales

- Tener disponible SQLite3 en tu sistema o usar la amalgamación oficial
- Compilar enlazando la biblioteca correspondiente
- Verificar que la ruta a la base de datos sea correcta

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_explorar_bd.c` | Programa de ejemplo para explorar la base de datos de la Biblia y consultar versículos |

## Cierre del libro

Si llegaste hasta aquí, ya recorriste un camino importante:

- Variables, tipos y operadores
- Decisiones, bucles y funciones
- Arreglos, strings y punteros
- Estructuras, archivos y memoria dinámica
- Preprocesador y uso de una biblioteca externa real

La mejor forma de consolidar este libro es volver a practicar, modificar ejemplos y construir
programas propios cada vez un poco más grandes.
