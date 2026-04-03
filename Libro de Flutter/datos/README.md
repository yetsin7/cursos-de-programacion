# Carpeta `datos/`

Esta carpeta contiene el dataset principal usado a lo largo del Libro de Flutter para los módulos de base de datos y consultas reales.

---

## Base de datos: `biblia_rv60.sqlite3`

**Archivo:** `biblia_rv60.sqlite3`
**Origen:** Biblia Reina-Valera 1960 — dominio público
**Formato:** SQLite 3
**Tamaño aproximado:** ~5 MB

Esta es la misma base de datos usada en el **Libro de Python** de este repositorio. Se copia desde:

```
C:\Users\Yetsin\Documents\Programacion\Aprendiendo Python\Libro de Python\datos\biblia_rv60.sqlite3
```

Se usa a partir del **Módulo 22 — SQLite con Flutter**.

---

## Estructura de tablas

### Tabla `books` — 66 filas

Contiene los 66 libros de la Biblia.

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `book_number` | INTEGER | Número del libro (1–66) |
| `short_name` | TEXT | Nombre corto (ej: `Gn`, `Sal`, `Jn`) |
| `long_name` | TEXT | Nombre completo (ej: `Génesis`, `Salmos`) |
| `book_color` | TEXT | Color en formato HEX para la UI |

Ejemplo de filas:

```
1  | Gn  | Génesis    | #FF6B6B
19 | Sal | Salmos     | #4ECDC4
43 | Jn  | Juan       | #45B7D1
66 | Ap  | Apocalipsis| #96CEB4
```

---

### Tabla `verses` — 31,103 filas

Contiene todos los versículos de la Biblia.

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `book_number` | INTEGER | Referencia al libro (FK → books) |
| `chapter` | INTEGER | Número del capítulo |
| `verse` | INTEGER | Número del versículo |
| `text` | TEXT | Texto del versículo |

Ejemplo de filas:

```
1 | 1 | 1 | En el principio creó Dios los cielos y la tierra.
43 | 3 | 16 | Porque de tal manera amó Dios al mundo...
19 | 23 | 1 | Jehová es mi pastor; nada me faltará.
```

---

### Tabla `info` — 8 filas

Contiene metadatos de la base de datos.

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `name` | TEXT | Nombre del campo de metadato |
| `value` | TEXT | Valor del metadato |

Ejemplos de metadatos: nombre de la versión, idioma, año, autor, etc.

---

## Nota importante: marcas Strong

Algunos versículos en la base de datos pueden contener **marcas de números Strong** con este formato:

```
<S>NNNN</S>
```

Ejemplo:
```
En el principio <S>7225</S> creó <S>1254</S> Dios <S>430</S>...
```

Estas marcas son referencias al **Diccionario Strong** (numeración hebrea/griega). Al mostrar texto en la UI de Flutter, **debes limpiarlas** con una expresión regular:

```dart
// Eliminar marcas Strong del texto del versículo
String limpiarTexto(String texto) {
  return texto.replaceAll(RegExp(r'<S>\d+</S>'), '').trim();
}
```

Esto se practica en el Módulo 22.

---

## Cómo copiar la base de datos

Si tienes el Libro de Python instalado, copia el archivo manualmente:

```
Origen:  C:\Users\Yetsin\Documents\Programacion\Aprendiendo Python\Libro de Python\datos\biblia_rv60.sqlite3
Destino: C:\Users\Yetsin\Documents\Programacion\Aprendiendo Flutter\Libro de Flutter\datos\biblia_rv60.sqlite3
```

O bien descárgala desde cualquier fuente pública de Biblias en formato SQLite compatible con el esquema descrito arriba.
