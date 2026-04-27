# Capítulo 03 — Operadores

Los operadores son las herramientas que usa el programa para calcular, comparar,
actualizar variables y tomar decisiones. Sin ellos, los datos no se transforman.

---

## ¿Qué aprenderás?

- operadores aritmeticos;
- comparación y lógica booleana;
- asignación compuesta;
- ternario;
- operadores modernos de null en C#;
- una introducción a operaciones bit a bit.

---

## ¿Qué pasa dentro del programa?

Cuando C# evalua una expresión:

- toma uno o mas valores;
- aplica una regla del lenguaje;
- genera un nuevo resultado;
- lo guarda, lo imprime o lo usa en una condición.

Esto conecta directamente con validaciones, formularios, cálculos y flujo del
software real.

---

## Operadores aritméticos

`+`, `-`, `*`, `/`, `%`, `++`, `--`

> La division entre enteros da otro entero. Si necesitas decimales, al menos uno
> de los operandos debe ser `double`, `float` o `decimal`.

---

## Comparación y lógica

Con `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||` y `!` puedes construir
condiciones reales.

Los operadores `&&` y `||` usan cortocircuito, lo cual puede evitar errores y
trabajo innecesario.

---

## Null operators

C# moderno tiene operadores muy útiles para trabajar con datos opcionales:

- `??`
- `??=`
- `?.`

Son fundamentales cuando una API, formulario o consulta puede devolver `null`.

---

## Errores comúnes

- olvidar que `7 / 2` entre enteros da `3`;
- abusar del ternario cuando un `if` seria mas claro;
- usar `!` o `?.` sin pensar el flujo;
- no entender por que el cortocircuito evita evaluar la segunda parte.

---

## Ejecutar el ejemplo

```bash
cd 03-operadores
dotnet run
```
