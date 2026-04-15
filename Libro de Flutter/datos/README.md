# Carpeta `datos/` — Recursos del Libro de Flutter

> **La base de datos `biblia_rv60.sqlite3` se movió a la carpeta compartida.**

## Nueva ubicación

```
cursos-de-programacion/
└── datos/
    └── biblia_rv60.sqlite3   ← aquí está ahora
```

Ruta relativa desde cualquier capítulo de este libro (scripts Dart de consola):

```dart
import 'package:path/path.dart' as path;

final scriptDir = path.dirname(Platform.script.toFilePath());
final dbPath = path.normalize(
  path.join(scriptDir, '..', '..', 'datos', 'biblia_rv60.sqlite3')
);
```

> **Nota sobre proyectos Flutter reales:** Los proyectos Flutter completos
> (como `29-app-biblia-flutter/`) incluyen su propia copia de la base de datos
> en `assets/` porque Flutter accede a los datos como assets del bundle de la app,
> no como archivos del sistema de archivos del host.

## ¿Por qué se movió?

Para evitar tener copias duplicadas del mismo archivo en cada libro.
Todos los libros (Python, JavaScript, SQL, Flutter) apuntan ahora
a un único archivo centralizado en `cursos-de-programacion/datos/`.

→ Consulta `../../datos/README.md` para la documentación completa de la base de datos.
