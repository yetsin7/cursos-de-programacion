# Módulo 02 — Operadores en Dart

Los operadores son herramientas para transformar valores. Gracias a ellos un
programa puede calcular, comparar, decidir y actualizar datos.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_aritmeticos.dart` | `+`, `-`, `*`, `/`, `~/`, `%` y `dart:math` |
| `02_comparacion.dart` | `==`, `!=`, `<`, `>`, `<=`, `>=`, `identical()` |
| `03_logicos.dart` | `&&`, `||`, `!` y cortocircuito |
| `04_asignacion.dart` | `=`, `+=`, `-=`, `??=`, `++`, `--` |
| `05_ejercicios.dart` | Practica guiada |

---

## ¿Por qué importa este módulo?

Porque en los siguientes temas necesitarás evaluar condiciones, modificar estado
y escribir lógica más real. Sin operadores, no hay decisiones ni cálculos.

---

## Operadores especiales de Dart

Dart tiene varios operadores muy útiles que conviene dominar desde temprano:

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `~/` | División entera | `7 ~/ 2 == 3` |
| `??` | Si es `null`, usa este valor | `nombre ?? 'Anonimo'` |
| `??=` | Asignar solo si es `null` | `x ??= 10` |
| `?.` | Acceso seguro a nulos | `usuario?.nombre` |
| `!` | Afirmar que no es `null` | `usuario!.nombre` |
| `is` | Verificar tipo | `valor is String` |
| `as` | Castear tipo | `valor as String` |

---

## ¿Qué pasa dentro del programa?

Cuando Dart evalúa una expresión:

- toma valores de entrada;
- aplica el operador;
- genera un nuevo resultado;
- lo guarda, lo compara o lo imprime.

En Flutter, estas pequeñas operaciones terminan afectando estados, validaciones,
precios, contadores, navegación y muchas otras partes de la app.

---

## Errores comúnes

- confundir `/` con `~/`;
- no prever el caso `null` cuando aparecen `??` o `??=`;
- abusar de `!` sin verificar valores;
- escribir expresiones complejas sin paréntesis claros.

---

## Cómo ejecutar

```bash
dart run 01_aritmeticos.dart
```
