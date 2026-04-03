# Módulo 21 — Bases de Datos en Flutter

Flutter ofrece múltiples opciones para persistir datos localmente, cada una adecuada para diferentes casos de uso.

## Comparativa de opciones

| Opción | Tipo | Complejidad | Cuándo usar |
|---|---|---|---|
| `shared_preferences` | Clave-valor | Muy baja | Preferencias, configuraciones simples |
| `sqflite` | SQL relacional | Media | Datos estructurados y relacionales |
| `Hive` | NoSQL | Baja | Listas de objetos, alta velocidad |
| `Isar` | NoSQL | Media | Apps complejas, queries avanzadas |

## Contenido

### 01_shared_preferences.dart
Persistencia de datos simples.
- Strings, booleans, ints, doubles
- Casos de uso: onboarding, tema, idioma
- Limitaciones de seguridad

### 02_sqflite_intro.dart
Base de datos SQL local con sqflite.
- Crear tablas, insertar, consultar
- SQL directo con `rawQuery()`
- Ejemplo: tabla de notas

### 03_sqflite_crud.dart
CRUD completo con sqflite.
- `DatabaseHelper` singleton
- Modelo con `fromMap()` / `toMap()`
- Búsqueda con `WHERE LIKE`

### 04_hive_intro.dart
Base de datos NoSQL ultrarrápida.
- Cajas (`Box`) tipadas
- Adaptadores para tipos personalizados
- Ventajas vs sqflite
