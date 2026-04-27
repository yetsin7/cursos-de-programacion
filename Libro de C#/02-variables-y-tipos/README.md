# Capítulo 02 — Variables y tipos de datos

Este capítulo te ayuda a entender una de las fortalezas principales de C#:
trabajar con tipos claros, seguros y expresivos.

---

## Sistema de tipos en C#

C# es de tipado estatico. Eso significa que el compilador conoce el tipo de cada
variable antes de correr el programa.

Esto sirve para:

- detectar errores temprano;
- usar mejor APIs y conversiones;
- escribir código mas claro y seguro.

---

## ¿Qué aprenderás?

- tipos numericos y de texto;
- diferencia entre `var`, `object` y `dynamic`;
- valores anulables;
- `const` y `readonly`;
- conversiones e interpolacion.

---

## ¿Qué pasa dentro del programa?

Cuando declaras variables en C#:

- el compilador valida tipos;
- .NET reserva y administra memoria;
- algunas conversiones ocurren automáticamente;
- otras requieren cast o métodos especiales.

Los tipos no son solo etiquetas: cambian el comportamiento real del programa.

---

## Tipos comúnes

### Enteros

`byte`, `short`, `int`, `long` y variantes sin signo.

### Decimales

`float`, `double` y `decimal`.

### Otros

`bool`, `char`, `string`, `object`.

---

## `var`, `object` y `dynamic`

- `var` mantiene tipado estatico con inferencia.
- `object` puede referenciar cualquier valor dentro del sistema de tipos.
- `dynamic` mueve parte de la comprobacion a tiempo de ejecución.

Usa `dynamic` con cuidado.

---

## Nulos y valores opcionales

No todos los tipos aceptan `null` por defecto. Por eso existen tipos anulables
como `int?`.

Esto es importante cuando un dato puede faltar en formularios, APIs o bases de
datos.

---

## Errores comúnes

- creer que `var` significa dinámico;
- usar `dynamic` donde no hace falta;
- olvidar que un cast puede truncar datos;
- usar `decimal` y `double` como si fueran iguales.

---

## Ejecutar el ejemplo

```bash
cd 02-variables-y-tipos
dotnet run
```
