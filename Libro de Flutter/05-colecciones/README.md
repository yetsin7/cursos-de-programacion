# Módulo 05 — Colecciones en Dart

Las colecciones permiten agrupar datos y trabajar con ellos de forma ordenada.
En Flutter son esenciales porque listas, mapas e iterables aparecen en modelos,
formularios, menús, APIs y construcción de widgets.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_listas.dart` | `List` — colección ordenada con índice |
| `02_mapas.dart` | `Map` — clave y valor |
| `03_conjuntos.dart` | `Set` — sin duplicados |
| `04_iterables.dart` | `Iterable` — operaciones perezosas |
| `05_ejercicios.dart` | Practica guiada |

---

## ¿Por qué importa este módulo?

Porque en Flutter casi siempre manejas colecciones:

- listas de productos;
- mapas JSON;
- filtros de búsqueda;
- listas de widgets;
- transformaciones de datos.

Elegir bien entre `List`, `Map` y `Set` mejora claridad y rendimiento.

---

## Comparativa: Dart vs Python

| Dart | Python | Descripción |
|------|--------|-------------|
| `List<int>` | `list` | Ordenada, permite duplicados |
| `Map<String, int>` | `dict` | Pares clave-valor |
| `Set<String>` | `set` | Sin duplicados |
| `Iterable<T>` | `Iterable` / generadores | Secuencia perezosa |

---

## Errores comunes

- usar `List` cuando realmente necesitas claves;
- olvidar que los índices empiezan en 0;
- transformar iterables sin convertirlos a lista cuando hace falta;
- no pensar si pueden existir duplicados.

---

## Cómo ejecutar

```bash
dart run 01_listas.dart
```
