# Capítulo 04 — Control de Flujo

El control de flujo decide qué camino sigue el programa y cuántas veces repite
una tarea. En C++ esto es esencial para validar, iterar y organizar lógica.

---

## ¿Qué aprenderás?

- `if` y `else`;
- `switch`;
- `for`, `while`, `do-while`;
- range-for;
- `break` y `continue`;
- inicializador en `if` de C++17.

---

## ¿Qué pasa en la maquina?

Cuando C++ evalúa flujo:

- comprueba condiciones;
- elige una rama;
- repite bloques;
- puede salir antes de un ciclo o saltar iteraciones.

Esto afecta directamente comportamiento, rendimiento y claridad del programa.

---

## `if`, `switch` y bucles

`if` sirve para decisiones generales.
`switch` es útil con valores discretos.
Los bucles permiten repetir trabajo con reglas claras.

Range-for mejora mucho la lectura cuando recorres colecciones.

---

## Errores comúnes

- olvidar `break` en `switch`;
- crear ciclos sin actualizar la condición;
- usar `for` tradicional cuando range-for seria mas claro;
- escribir condiciones complejas sin parentesis.

---

## Archivo de ejemplo

Ver: [01_control_flujo.cpp](C:/Users/Yetsin/Documents/Programación/cursos-de-programación/Libro%20de%20C%2B%2B/04-control-de-flujo/01_control_flujo.cpp)
