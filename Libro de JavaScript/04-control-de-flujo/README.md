# 04 - Control de Flujo

El **control de flujo** determina el orden en que se ejecutan las instrucciones de un programa. Sin él, el código siempre haría lo mismo de la misma forma, sin importar los datos o condiciones del momento.

## ¿Qué aprenderás aquí?

### Toma de decisiones
- **`if / else if / else`** — ejecuta código condicionalmente
- **`switch`** — selecciona entre múltiples casos posibles
- **Operador ternario** — decisión en una sola línea
- **`?.` y `??`** — alternativas modernas para condiciones comunes

### Repetición (bucles)
- **`for` clásico** — cuando necesitas un contador explícito
- **`for...of`** — iterar sobre valores de arrays, strings, Maps, Sets
- **`for...in`** — iterar sobre claves de objetos
- **`while`** — repetir mientras una condición sea verdadera
- **`do...while`** — igual que while, pero ejecuta al menos una vez

### Control dentro de bucles
- **`break`** — salir del bucle completamente
- **`continue`** — saltar a la siguiente iteración
- **Labels** — controlar bucles anidados

## Estructura del módulo

| Archivo | Contenido |
|---|---|
| `01_if_else.js` | Condicionales: if, switch, ternario, ?., ?? |
| `02_bucle_for.js` | Bucles for, for...of, for...in, forEach |
| `03_bucle_while.js` | while, do...while, alternativas declarativas |
| `04_break_continue.js` | break, continue, labels |
| `05_ejercicios.js` | 5 ejercicios prácticos con soluciones |

## Concepto clave

> El flujo de control transforma un programa lineal en uno que **responde** a los datos. La clave es elegir la herramienta correcta: prefiere métodos declarativos (`map`, `filter`, `every`) cuando sean más claros que los bucles imperativos.

## Cómo ejecutar

```bash
node 01_if_else.js
node 02_bucle_for.js
# etc.
```
