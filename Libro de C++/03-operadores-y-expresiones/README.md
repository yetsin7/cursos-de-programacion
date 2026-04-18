# Capítulo 03 — Operadores y Expresiones

Los operadores permiten transformar datos y construir expresiones con sentido.
En C++ esto incluye no solo matematicas y comparaciones, sino tambien acceso a
memoria, punteros y detalles muy cercanos al funcionamiento real del programa.

---

## ¿Qué aprenderás?

- operadores aritmeticos;
- comparacion y logica;
- asignacion compuesta;
- ternario;
- `new`, `delete`, `::` y `->`;
- precedencia basica.

---

## ¿Qué pasa en la maquina?

Cuando evalua una expresion, C++:

- toma valores y tipos;
- aplica reglas de precedencia;
- genera un resultado;
- en algunos casos accede a memoria o manipula punteros.

Por eso entender operadores en C++ no es solo sintaxis: tambien es entender
comportamiento y costo.

---

## Operadores aritméticos

`+`, `-`, `*`, `/`, `%`, `++`, `--`

> La division entre enteros corta la parte decimal. Si necesitas flotante,
> convierte al menos uno de los operandos.

---

## Comparación, lógica y ternario

Con estos operadores construyes condiciones, validaciones y decisiones.

El cortocircuito en `&&` y `||` es importante porque puede evitar errores, por
ejemplo divisiones por cero o accesos peligrosos.

---

## Operadores propios de C++

- `new` y `delete` trabajan con memoria dinamica;
- `::` resuelve alcance;
- `->` accede a miembros a traves de punteros.

Estos operadores te acercan mas al funcionamiento interno del programa.

---

## Errores comunes

- olvidar liberar memoria reservada con `new`;
- confundir `.` con `->`;
- no distinguir entre division entera y flotante;
- escribir expresiones complejas sin parentesis.

---

## Archivo de ejemplo

Ver: [01_operadores.cpp](C:/Users/Yetsin/Documents/Programacion/cursos-de-programacion/Libro%20de%20C%2B%2B/03-operadores-y-expresiones/01_operadores.cpp)
