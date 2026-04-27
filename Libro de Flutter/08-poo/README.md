# Módulo 08 — Programación Orientada a Objetos (POO) en Dart

## ¿Qué es la POO?

La **Programación Orientada a Objetos** organiza el código en torno a **objetos**: entidades que combinan datos (propiedades) y comportamiento (métodos). Es el paradigma central de Dart y Flutter.

## Comparación con Python

Si vienes de Python, Dart te resultará familiar pero con diferencias clave:

| Carácterística | Python | Dart |
|---|---|---|
| Clase | `class Perro:` | `class Perro {` |
| Constructor | `def __init__(self, nombre):` | `Perro(this.nombre);` |
| Acceso privado | `self._nombre` (convención) | `_nombre` (real, por librería) |
| Herencia | `class Labrador(Perro):` | `class Labrador extends Perro {` |
| Múltiple herencia | `class A(B, C):` | No permitida — usa mixins |
| Interfaces | (duck typing) | `implements` |
| Tipos | Dinámico por defecto | Estático con null safety |

## Conceptos clave de este módulo

### Clases y objetos
Una **clase** es el molde; un **objeto** es la instancia concreta. `Perro` es la clase, `miPerro` es el objeto.

### herencia (`extends`)
Permite que una clase herede propiedades y métodos de otra. Usa `super` para acceder al padre.

### Mixins (`with`)
La alternativa de Dart a la herencia múltiple. Permiten reutilizar comportamiento entre clases no relacionadas sin la ambigüedad del diamante.

### Interfaces (`implements`)
En Dart, **toda clase es una interfaz implícita**. `implements` exige implementar todos sus miembros públicos.

### Genéricos (`<T>`)
Permiten escribir código que funciona con cualquier tipo, manteniendo la seguridad de tipos en tiempo de compilación.

## Archivos de este módulo

| Archivo | Contenido |
|---|---|
| `01_clases_objetos.dart` | Declaración, instanciación, getters/setters |
| `02_constructores.dart` | Todos los tipos de constructores |
| `03_herencia.dart` | extends, super, abstract, override |
| `04_mixins.dart` | Mixins con with y on |
| `05_interfaces.dart` | implements, interface class, sealed class |
| `06_genericos.dart` | Tipos genéricos y bounded generics |
| `07_ejercicios.dart` | Ejercicios con soluciones |

## Cómo ejecutar

```bash
dart run 01_clases_objetos.dart
dart run 02_constructores.dart
# ... etc
```
