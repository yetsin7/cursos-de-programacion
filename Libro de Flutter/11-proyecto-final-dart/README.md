# Módulo 11 — Proyecto Final: Gestor de Contactos

## ¿Qué es este proyecto?

Un **mini proyecto integrador** en Dart puro (sin Flutter) que consolida todos los conceptos aprendidos en el libro: clases, colecciones, null safety, manejo de errores, y programación básica de consola.

Es una aplicación de consola completamente funcional con menú interactivo.

## Conceptos integrados

| Concepto | Dónde se usa |
|---|---|
| Clases y POO | Clase `Contacto` con propiedades y métodos |
| Null safety | `email` y `telefono2` son nullable |
| Colecciones | `List<Contacto>` como almacenamiento |
| Strings | Búsqueda, formateo, interpolación |
| Manejo de errores | try/catch en entrada del usuario |
| Constructores | Constructor nombrado `Contacto.ejemplo()` |
| Getters | `nombreCompleto`, `tieneEmail` |
| Métodos | `mostrar()`, `coincidenConBusqueda()` |

## Funcionalidades

1. Ver todos los contactos
2. Agregar contacto
3. Buscar contacto por nombre
4. Marcar/desmarcar como favorito
5. Eliminar contacto
6. Ver favoritos
7. Salir

## Datos de ejemplo precargados

Al iniciar, la app carga 3 contactos:
- **Pedro Páramo** — 555-0001
- **Pablo Neruda** — 555-0002
- **María Martínez** — 555-0003 (favorito)

## Cómo ejecutar

```bash
dart run gestor_contactos.dart
```
