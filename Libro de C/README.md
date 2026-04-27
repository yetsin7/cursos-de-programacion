# Libro de C — De cero a PRO

## ¿Qué es este libro?

Una guía práctica y progresiva para aprender C desde cero hasta un nivel
profesional. Este libro no solo ensena sintaxis: ensena como el software usa la
memoria, como se comunica con el sistema operativo y por que C esta tan cerca
del hardware.

## ¿Para quien es?

- Principiantes que quieren aprender su primer lenguaje de bajo nivel
- Programadores de otros lenguajes (Python, JavaScript, etc.) que quieren entender cómo funciona
  la memoria y el hardware
- Estudiantes de informática, sistemas o electrónica
- Cualquier persona que quiera entender la base sobre la que se construyen sistemas operativos,
  compiladores, drivers y software embebido

## ¿Por que C?

C es el lenguaje que define cómo funciona la computación moderna. Linux, Windows, macOS, Python,
Ruby, SQLite y miles de herramientas críticas están escritas en C. Aprenderlo te da:

- Comprensión real de la memoria y los punteros
- Control total sobre el hardware
- Base sólida para aprender C++, Rust, sistemas embebidos
- Habilidad para leer código de bajo nivel y contribuir a proyectos de sistemas

## Que aprenderas sobre la computadora

En C veras con mas claridad que en muchos otros lenguajes:

- como viven los datos en memoria;
- que diferencia hay entre stack y heap;
- que significa compilar un programa;
- como una instrucción termina ejecutandose en la maquina;
- por que un error de memoria puede romper un programa.

---

## Como estudiar este libro

1. Lee el `README.md` de cada capítulo.
2. Compila y ejecuta cada archivo por separado.
3. Cambia valores y observa el resultado.
4. Intenta explicar cada ejemplo sin leer el comentario.
5. Si algo falla, lee el error del compilador con calma.

## Cómo compilar

### Con GCC (recomendado)

```bash
gcc -o programa archivo.c
./programa
```

Con advertencias habilitadas (recomendado siempre):

```bash
gcc -Wall -Wextra -o programa archivo.c
./programa
```

### Con Clang

```bash
clang -o programa archivo.c
./programa
```

### Compilar con SQLite (capítulo 12)

```bash
gcc -o programa archivo.c -lsqlite3
```

### Instalar GCC

- **Linux (Debian/Ubuntu):** `sudo apt install gcc`
- **macOS:** `xcode-select --install` (instala clang con alias gcc)
- **Windows:** Instalar [MinGW-w64](https://winlibs.com/) o usar WSL

---

## Estructura del libro

| Cap | Tema                     | Contenido principal                                        |
|-----|--------------------------|------------------------------------------------------------|
| 01  | Introducción             | Hola mundo, historia de C, primer programa                 |
| 02  | Variables y tipos        | int, float, char, bool, sizeof, rangos                     |
| 03  | Operadores               | Aritméticos, lógicos, bitwise, ternario                    |
| 04  | Control de flujo         | if/else, switch, for, while, do-while                      |
| 05  | funciones                | Declaración, prototipos, recursividad, paso por referencia |
| 06  | Arreglos y Strings       | Arrays 1D/2D, char[], string.h                             |
| 07  | Punteros                 | &, *, aritmética de punteros, punteros a funciones         |
| 08  | Structs                  | struct, typedef, union, enum, CRUD básico                  |
| 09  | Manejo de archivos       | fopen, fclose, fread, fwrite, fprintf, fgets               |
| 10  | Memoria dinámica         | malloc, calloc, realloc, free, valgrind                    |
| 11  | Preprocesador            | #define, #include, #ifdef, macros, include guards          |
| 12  | Proyecto Biblia          | SQLite3 en C, consultas reales sobre biblia_rv60.sqlite3   |

---

## Base de datos de la Biblia

A partir del **capítulo 09** y especialmente en el **capítulo 12**, los ejemplos utilizan una base
de datos SQLite con la Biblia Reina-Valera 1960.

Ruta de la base de datos desde la raíz del libro:

```
../../datos/biblia_rv60.sqlite3
```

Desde los archivos dentro de cada capítulo la ruta relativa es:

```
../../datos/biblia_rv60.sqlite3
```

---

## convenciones del libro

- Todo el código es **compilable directamente** con gcc sin dependencias externas (salvo cap. 12)
- Los comentarios en el código están en **español**
- Cada capítulo tiene su propio `README.md` con la teoría y ejemplos `.c` con código funcional
- Los archivos no superan las 200 líneas para mantener la legibilidad

---

## Licencia

Material educativo de uso libre para aprendizaje personal.
