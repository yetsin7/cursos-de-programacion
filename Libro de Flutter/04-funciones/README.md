# Módulo 04 — Funciones en Dart

Las funciones permiten agrupar pasos bajo un nombre, reutilizar logica y dividir
problemas grandes en partes pequeñas. Son una de las bases mas importantes para
programar bien en Dart y Flutter.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_funciones_basicas.dart` | Declarar, llamar, `void` y retorno |
| `02_parametros.dart` | Posicionales, nombrados, opcionales y valores por defecto |
| `03_retorno.dart` | `return`, Records, funciones que retornan funciones |
| `04_arrow_functions.dart` | Sintaxis `=>` |
| `05_funciones_anonimas.dart` | Lambdas, closures, callbacks y `typedef` |
| `06_ejercicios.dart` | Practica guiada |

---

## ¿Por qué importan tanto?

Porque casi todo en Flutter se apoya en funciones:

- callbacks de botones;
- validaciones;
- transformacion de datos;
- metodos de clases;
- constructores y helpers.

Aprender funciones bien hace mucho mas facil entender widgets y arquitectura.

---

## Parámetros nombrados

Una de las ventajas mas utiles de Dart es la claridad de los parametros nombrados:

```dart
crearUsuario(nombre: 'Ana', edad: 28, esAdmin: true, estaActivo: false);
```

Eso mejora mucho la lectura, sobre todo en Flutter, donde los widgets aceptan
muchos argumentos.

---

## ¿Qué pasa dentro del programa?

Cuando llamas una funcion:

- el programa salta a ese bloque de codigo;
- recibe valores de entrada;
- ejecuta instrucciones;
- puede devolver un resultado;
- vuelve al punto desde donde fue llamada.

Esto organiza mejor el flujo y evita repetir codigo.

---

## Errores comunes

- crear funciones demasiado grandes;
- no distinguir entre imprimir y retornar;
- usar nombres poco claros;
- meter demasiada logica repetida en `main()`.

---

## Cómo ejecutar

```bash
dart run 01_funciones_basicas.dart
```
