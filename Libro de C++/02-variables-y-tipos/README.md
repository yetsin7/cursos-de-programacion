# Capítulo 02 — Variables y Tipos de Datos

Este capítulo profundiza en una idea central de C++: los tipos afectan memoria,
seguridad, claridad y rendimiento.

---

## ¿Qué aprenderás?

- tipos primitivos;
- `std::string`;
- deduccion con `auto`;
- diferencia entre `const` y `constexpr`;
- por que `nullptr` es mejor que `NULL`;
- inicialización uniforme.

---

## Tipos primitivos en C++

C++ hereda muchos tipos de C y mantiene la idea de que cada tipo representa una
forma concreta de almacenar datos en memoria.

> Usa `sizeof(tipo)` para verificar el tamaño real en tu plataforma.

---

## ¿Qué pasa en la maquina?

Cuando declaras variables:

- el compilador decide como representar el tipo;
- el programa reserva memoria al ejecutarse;
- ciertas conversiones pueden ser seguras o peligrosas;
- algunos errores se detectan ya en compilación.

Por eso C++ valora tanto los tipos claros y las inicializaciones seguras.

---

## `std::string`

A diferencia de C, C++ ofrece `std::string` para manejar texto de forma mucho
mas comoda y segura que `char[]` en muchos casos.

---

## `auto`

`auto` deja que el compilador deduzca el tipo en tiempo de compilación.
Eso no vuelve dinámico al lenguaje.

---

## `const`, `constexpr` y `nullptr`

- `const` protege valores que no deben cambiar;
- `constexpr` fija valores calculables en compilación;
- `nullptr` evita ambiguedades con punteros nulos.

---

## Errores comúnes

- creer que `auto` vuelve dinámico al lenguaje;
- usar `NULL` por costumbre;
- ignorar conversiones con perdida de información;
- no aprovechar inicialización con llaves.

---

## Archivo de ejemplo

Ver: [01_tipos.cpp](C:/Users/Yetsin/Documents/Programación/cursos-de-programación/Libro%20de%20C%2B%2B/02-variables-y-tipos/01_tipos.cpp)
