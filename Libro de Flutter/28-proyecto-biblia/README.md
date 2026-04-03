# Módulo 28 — Proyecto Biblia (Dart de consola)

Este módulo es la versión **Dart puro** del proyecto Biblia Reina-Valera 1960. Sin Flutter, sin UI: solo scripts de consola que acceden a una base de datos SQLite real.

Es el equivalente al capítulo 29 del Libro de Python, pero escrito en Dart.

---

## ¿Por qué este dataset es perfecto para aprender Dart?

La Biblia RV60 contiene **31,103 versículos** en 66 libros. Es un dataset real, en español, de tamaño suficiente para practicar:

- Consultas SQL complejas con `JOIN` y `GROUP BY`
- Procesamiento de texto (limpiar marcas Strong con `RegExp`)
- Lógica de negocio (AT vs NT, búsquedas, estadísticas)
- Programación asíncrona con `async/await`
- Manejo de errores con `try/catch`
- E/S de consola con `stdin.readLineSync()`

---

## Conceptos Dart que integra este módulo

| Concepto | Dónde se usa |
|---|---|
| `sqlite3` package | Todos los scripts |
| `RegExp` | Limpieza de marcas Strong |
| `async / await` | Consultas y menús |
| `try / catch / finally` | Conexión a la BD |
| `List`, `Map`, `Set` | Resultados de consultas |
| Funciones con parámetros opcionales | Consultas reutilizables |
| String interpolation y format | Mostrar tablas en consola |
| `stdin.readLineSync()` | Menús interactivos |
| `Platform.script` | Ruta relativa a la BD |

---

## Estructura de la base de datos

**Archivo:** `../datos/biblia_rv60.sqlite3`

```sql
-- Libros (66 filas)
CREATE TABLE books (
  book_number INTEGER PRIMARY KEY,
  short_name  TEXT,    -- Ej: "Gn", "Mr", "Ap"
  long_name   TEXT,    -- Ej: "Génesis", "Marcos", "Apocalipsis"
  book_color  TEXT     -- Color hex para la UI (no usado en consola)
);

-- Versículos (31,103 filas)
CREATE TABLE verses (
  book_number INTEGER,
  chapter     INTEGER,
  verse       INTEGER,
  text        TEXT     -- Puede contener marcas Strong: <S>7225</S>
);

-- Información de la versión
CREATE TABLE info (
  name  TEXT,  -- Ej: "description", "language", "encoding"
  value TEXT
);
```

### Marcas Strong en el texto

Algunos versículos contienen referencias Strong intercaladas:
```
En el principio<S>7225</S> creó<S>1254</S> Dios<S>430</S>...
```

Se limpian con esta expresión regular:
```dart
final RegExp _strongRegex = RegExp(r'<[^>]+>');
String limpiarMarcas(String texto) => texto.replaceAll(_strongRegex, '');
```

---

## Archivos del módulo

| Archivo | Descripción | Líneas aprox. |
|---|---|---|
| `00_explorar_bd.dart` | Explorar la estructura de la BD | ~80 |
| `01_lector_basico.dart` | Menú interactivo para leer versículos | ~150 |
| `02_buscador.dart` | Búsqueda de texto con paginación | ~120 |
| `03_estadisticas.dart` | Estadísticas del texto bíblico | ~140 |

---

## Cómo ejecutar cada script

### Requisito previo: crear un proyecto Dart

```bash
# Crear proyecto Dart de consola
dart create -t console biblia_dart
cd biblia_dart
```

### Agregar dependencias en `pubspec.yaml`

```yaml
dependencies:
  sqlite3: ^2.4.0
  path: ^1.9.0
```

```bash
dart pub get
```

### Ejecutar un script

```bash
# Desde la carpeta del proyecto
dart run lib/00_explorar_bd.dart
dart run lib/01_lector_basico.dart
dart run lib/02_buscador.dart
dart run lib/03_estadisticas.dart
```

---

## Notas importantes

- La ruta a la base de datos es **relativa al script**: `../datos/biblia_rv60.sqlite3`
- En Windows, la ruta usa el formato del sistema de archivos local
- Los scripts usan `Platform.script.toFilePath()` para calcular la ruta absoluta de forma portátil
- Si la BD no existe, los scripts muestran un mensaje de error claro y terminan graciosamente

---

## Siguiente paso

Una vez que domines estos scripts de consola, el siguiente nivel es crear una app Flutter que consuma la misma base de datos usando `sqflite` (el equivalente de `sqlite3` pero para Flutter/móvil).
