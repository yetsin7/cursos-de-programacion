# 11 - Proyecto Final Básico: Gestor de Tareas

Mini proyecto integrador en Node.js puro. Une todo lo aprendido en los módulos anteriores.

## ¿Qué integra?

| Concepto | Dónde se usa |
|---|---|
| Clases y POO | `Tarea`, `GestorTareas` |
| Arrays y métodos | `filter`, `find`, `map`, `forEach` |
| Objetos | Serialización/deserialización JSON |
| Manejo de errores | try/catch en lectura/escritura de archivo |
| Closures y módulos | Encapsulación del gestor |
| fs (Node.js) | Persistencia en `tareas.json` |
| readline (Node.js) | Menú interactivo en consola |

## Cómo ejecutar

```bash
node gestor_tareas.js
```

Se abrirá un menú interactivo. Las tareas se guardan automáticamente en `tareas.json` en la misma carpeta.

## Funcionalidades

- Listar todas las tareas con su estado
- Agregar nueva tarea con título y descripción
- Marcar tarea como completada
- Eliminar tarea
- Buscar tareas por título
- Ver solo pendientes o completadas
- Persistencia automática al salir

## Archivo de datos

Las tareas se guardan en `tareas.json`. Si el archivo no existe, se crea automáticamente con 3 tareas de ejemplo.
