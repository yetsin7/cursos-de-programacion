# Módulo 05 — Colecciones en Dart

Las colecciones son estructuras de datos que agrupan múltiples valores. Dart tiene tres colecciones principales: List, Map y Set, más la clase base Iterable que comparten en común. Conocerlas bien es fundamental porque en Flutter las usarás constantemente para manejar datos, construir listas de widgets y transformar información.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_listas.dart` | List — colección ordenada con acceso por índice |
| `02_mapas.dart` | Map — pares clave-valor (como dict de Python) |
| `03_conjuntos.dart` | Set — colección sin duplicados |
| `04_iterables.dart` | Iterable — la clase base, lazy evaluation, generators |
| `05_ejercicios.dart` | Ejercicios prácticos con soluciones |

---

## Comparativa: Dart vs Python

| Dart | Python | Descripción |
|------|--------|-------------|
| `List<int>` | `list` | Colección ordenada, duplicados permitidos |
| `Map<String, int>` | `dict` | Pares clave-valor |
| `Set<String>` | `set` | Colección sin duplicados |
| `Iterable<T>` | `Iterable` / generadores | Secuencia perezosa |
| `[...lista1, ...lista2]` | `[*lista1, *lista2]` | Spread operator |
| `lista.where(f)` | `filter(f, lista)` | Filtrar elementos |
| `lista.map(f)` | `map(f, lista)` | Transformar elementos |
| `lista.reduce(f)` | `reduce(f, lista)` | Reducir a un valor |

---

## Cómo ejecutar

```bash
dart run 01_listas.dart
```
