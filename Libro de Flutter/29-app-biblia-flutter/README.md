# Módulo 29 — Biblia RV60 (App Flutter)

## Descripción

App Flutter profesional para leer la Biblia Reina-Valera 1960. Es el proyecto final del Libro de Flutter: una aplicación completa con UI moderna, base de datos SQLite local, Clean Architecture y todas las funcionalidades de una app de lectura bíblica.

---

## Funcionalidades

| Funcionalidad | Descripción |
|---|---|
| Lista de libros | 66 libros organizados en AT (39) y NT (27) con tarjetas de colores |
| Selección de capítulos | Cuadrícula con todos los capítulos del libro seleccionado |
| Lectura de versículos | Lista de versículos con scroll, número en negrita y menú contextual |
| Versículo del día | Versículo aleatorio al abrir la app con botón para cambiar |
| Búsqueda global | Buscar texto en los ~31.000 versículos de la Biblia |
| Favoritos | Guardar y gestionar versículos favoritos con persistencia local |
| Modo oscuro | Toggle claro/oscuro que se persiste entre sesiones |

---

## Arquitectura: Clean Architecture

```
lib/
├── main.dart                          ← Punto de entrada, MultiProvider
├── core/
│   ├── database/database_helper.dart  ← Singleton SQLite, copia de assets
│   ├── theme/app_theme.dart           ← ThemeData claro y oscuro (Material 3)
│   └── utils/text_utils.dart          ← Limpieza de marcas Strong, formateo
├── data/
│   ├── models/book_model.dart         ← BookModel con fromMap/toMap
│   ├── models/verse_model.dart        ← VerseModel con fromMap/toMap
│   └── repositories/
│       └── bible_repository_impl.dart ← Implementación concreta con sqflite
├── domain/
│   ├── entities/book.dart             ← Entidad pura Book
│   ├── entities/verse.dart            ← Entidad pura Verse
│   ├── repositories/
│   │   └── bible_repository.dart      ← Interfaz abstracta
│   └── usecases/
│       ├── get_books.dart
│       ├── get_chapters.dart
│       ├── get_verses.dart
│       ├── search_verses.dart
│       └── get_random_verse.dart
└── presentation/
    ├── providers/
    │   ├── bible_provider.dart        ← Estado central de datos bíblicos
    │   ├── theme_provider.dart        ← Estado del tema visual
    │   └── favorites_provider.dart   ← Estado de versículos favoritos
    ├── screens/
    │   ├── home_screen.dart           ← Lista de libros + versículo del día
    │   ├── chapters_screen.dart       ← Capítulos de un libro
    │   ├── reading_screen.dart        ← Versículos de un capítulo
    │   ├── search_screen.dart         ← Búsqueda global
    │   └── favorites_screen.dart      ← Versículos favoritos
    └── widgets/
        ├── book_card.dart             ← Tarjeta de libro con color dinámico
        ├── verse_tile.dart            ← Fila de versículo con menú contextual
        └── verse_of_day_card.dart     ← Card del versículo del día
```

---

## Configuración inicial

### 1. Agregar la base de datos SQLite

Necesitas el archivo `biblia_rv60.sqlite3` con la siguiente estructura de tablas:

```sql
-- Tabla de libros
CREATE TABLE books (
    book_number INTEGER PRIMARY KEY,
    short_name  TEXT NOT NULL,
    long_name   TEXT NOT NULL,
    book_color  TEXT NOT NULL  -- hex, ej. "#1A3A5C"
);

-- Tabla de versículos
CREATE TABLE verses (
    book_number INTEGER NOT NULL,
    chapter     INTEGER NOT NULL,
    verse       INTEGER NOT NULL,
    text        TEXT NOT NULL,  -- puede tener marcas <S>7225</S>
    PRIMARY KEY (book_number, chapter, verse)
);
```

Copia el archivo a: `biblia_flutter/assets/biblia_rv60.sqlite3`

### 2. Declarar en pubspec.yaml

El asset ya está declarado en `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/biblia_rv60.sqlite3
```

### 3. Instalar dependencias

```bash
cd biblia_flutter
flutter pub get
```

### 4. Ejecutar la app

```bash
flutter run
```

---

## Dependencias principales

| Paquete | Versión | Uso |
|---|---|---|
| `sqflite` | ^2.3.0 | Leer la BD SQLite de la Biblia |
| `path_provider` | ^2.1.0 | Copiar la BD a documentos del dispositivo |
| `path` | ^1.9.0 | Construir rutas de archivo multiplataforma |
| `provider` | ^6.1.0 | Gestión de estado con ChangeNotifier |
| `shared_preferences` | ^2.2.0 | Persistir tema y favoritos |

---

## Cómo funciona la base de datos

La primera vez que la app arranca, `DatabaseHelper` copia automáticamente el archivo `biblia_rv60.sqlite3` desde los assets del bundle de Flutter al directorio de documentos del dispositivo. Esto es necesario porque sqflite no puede leer archivos directamente desde los assets. Las ejecuciones posteriores reutilizan la copia ya existente.

El texto de los versículos puede contener marcas Strong como `<S>7225</S>`. La clase `TextUtils.cleanVerseText()` las elimina con una expresión regular antes de mostrar cualquier texto en la UI.

---

## Módulos previos del Libro de Flutter

Este es el módulo 29, el proyecto final del curso. Los módulos anteriores cubren los conceptos individuales que se integran aquí: widgets, navegación, estado, persistencia local, bases de datos SQLite y arquitectura limpia.
