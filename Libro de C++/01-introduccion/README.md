# Capítulo 01 — Introducción a C++

Este capítulo te presenta C++ como una evolucion poderosa de C: un lenguaje que
permite trabajar cerca de la maquina, pero con herramientas mas expresivas para
construir software grande y mantenible.

---

## ¿Qué es C++?

C++ es un lenguaje compilado, tipado y multiparadigma. Puede usarse de forma
procedural, orientada a objetos y generica.

Eso lo hace muy valioso para:

- software de alto rendimiento;
- motores de juego;
- sistemas;
- herramientas de escritorio;
- bibliotecas complejas.

---

## ¿Qué aprenderás en este capítulo?

Al terminar deberias poder explicar:

- que diferencia hay entre C y C++;
- que hacen `cout` y `cin`;
- por que existe `std::`;
- como compilar y ejecutar un ejemplo simple;
- como se conecta el código con la consola y la memoria.

---

## Diferencias clave entre C y C++

| Carácterística | C | C++ |
|----------------|---|-----|
| Paradigma | Procedural | Multiparadigma |
| I/O estándar | `printf` / `scanf` | `cout` / `cin` |
| Strings | `char[]` | `std::string` |
| Memoria dinámica | `malloc` / `free` | `new` / `delete` y mas |
| Clases | No | Sí |
| Namespaces | No | Sí |
| Templates | No | Sí |

---

## ¿Qué pasa cuando se ejecuta un programa C++?

1. el compilador traduce el código fuente;
2. se genera un ejecutable;
3. el sistema operativo lo carga en memoria;
4. el programa entra por `main()`;
5. la consola recibe entradas y salidas según tu código.

Eso te ayuda a entender que `cout` y `cin` no son magia: son interfaces entre tu
programa y el entorno.

---

## `<iostream>` y `std`

`<iostream>` permite trabajar con entrada y salida estandar.

- `std::cout` envia texto a la consola;
- `std::cin` lee datos desde teclado;
- `std::cerr` comunica errores;
- `std::endl` agrega salto de linea y vacia el buffer.

La biblioteca estandar vive dentro del namespace `std`, por eso ves `std::`.

---

## Errores comúnes del principiante

- confundir C++ con C "solo con clases";
- abusar de `using namespace std;` sin entenderlo;
- no distinguir entre `\n` y `std::endl`;
- creer que compilar y ejecutar es el mismo paso.

---

## Compilar y ejecutar

```bash
g++ -std=c++17 -o hola_mundo 01_hola_mundo.cpp
./hola_mundo
```

En Windows normalmente:

```bash
hola_mundo.exe
```

---

## Archivo de ejemplo

Ver: [01_hola_mundo.cpp](C:/Users/Yetsin/Documents/Programación/cursos-de-programación/Libro%20de%20C%2B%2B/01-introducción/01_hola_mundo.cpp)
