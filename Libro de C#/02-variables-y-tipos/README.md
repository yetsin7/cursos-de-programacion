# Capítulo 02 — Variables y tipos de datos

Este capitulo te ayuda a entender una de las fortalezas principales de C#:
trabajar con tipos claros, seguros y expresivos.

---

## Sistema de tipos en C#

C# es de tipado estatico. Eso significa que el compilador conoce el tipo de cada
variable antes de correr el programa.

Esto sirve para:

- detectar errores temprano;
- usar mejor APIs y conversiones;
- escribir codigo mas claro y seguro.

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
- algunas conversiones ocurren automaticamente;
- otras requieren cast o metodos especiales.

Los tipos no son solo etiquetas: cambian el comportamiento real del programa.

---

## Tipos comunes

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
- `dynamic` mueve parte de la comprobacion a tiempo de ejecucion.

Usa `dynamic` con cuidado.

---

## Nulos y valores opcionales

No todos los tipos aceptan `null` por defecto. Por eso existen tipos anulables
como `int?`.

Esto es importante cuando un dato puede faltar en formularios, APIs o bases de
datos.

---

## Errores comunes

- creer que `var` significa dinamico;
- usar `dynamic` donde no hace falta;
- olvidar que un cast puede truncar datos;
- usar `decimal` y `double` como si fueran iguales.

---

## Ejecutar el ejemplo

```bash
cd 02-variables-y-tipos
dotnet run
```
