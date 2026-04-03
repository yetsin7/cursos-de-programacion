// =============================================================================
// ARCHIVO: 01_aritmeticos.js
// TEMA: Operadores aritméticos en JavaScript
// =============================================================================
//
// Los operadores aritméticos son los más básicos pero tienen algunos
// comportamientos particulares de JavaScript que debes conocer, especialmente
// el operador + que tiene doble personalidad (suma vs concatenación) y
// el comportamiento de ++ y -- pre vs post incremento.
//
// CÓMO EJECUTAR:
//   node 01_aritmeticos.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Operadores básicos
// ─────────────────────────────────────────────────────────────────────────────

const a = 17;
const b = 5;

console.log('--- Operadores básicos ---');
console.log(`${a} + ${b} = ${a + b}`);   // 22
console.log(`${a} - ${b} = ${a - b}`);   // 12
console.log(`${a} * ${b} = ${a * b}`);   // 85
console.log(`${a} / ${b} = ${a / b}`);   // 3.4 (siempre decimal en JS)
console.log(`${a} % ${b} = ${a % b}`);   // 2 (módulo = resto de la división)
console.log(`${a} ** ${b} = ${a ** b}`); // 1419857 (potencia ES2016)

// ─────────────────────────────────────────────────────────────────────────────
// 2. El operador % (módulo) — Mucho más útil de lo que parece
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Módulo % ---');
// Verificar si un número es par o impar
const esPar = (n) => n % 2 === 0;
console.log('4 es par:', esPar(4));    // true
console.log('7 es par:', esPar(7));    // false

// Ciclar dentro de un rango (útil para carruseles, paginación)
const totalSlides = 5;
for (let i = 0; i < 8; i++) {
  const indice = i % totalSlides;
  process.stdout.write(`${indice} `); // 0 1 2 3 4 0 1 2
}
console.log('(ciclo de índices)');

// ─────────────────────────────────────────────────────────────────────────────
// 3. Operadores de asignación compuesta
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Asignación compuesta ---');
let contador = 10;

contador += 5;  // contador = contador + 5
console.log('+= 5:', contador);  // 15

contador -= 3;  // contador = contador - 3
console.log('-= 3:', contador);  // 12

contador *= 2;  // contador = contador * 2
console.log('*= 2:', contador);  // 24

contador /= 4;  // contador = contador / 4
console.log('/= 4:', contador);  // 6

contador %= 4;  // contador = contador % 4
console.log('%= 4:', contador);  // 2

contador **= 3; // contador = contador ** 3
console.log('**= 3:', contador); // 8

// ─────────────────────────────────────────────────────────────────────────────
// 4. Incremento ++ y decremento -- (pre vs post)
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Incremento y decremento ---');

let x = 5;

// Pre-incremento: incrementa PRIMERO, luego retorna el valor nuevo
console.log('Valor inicial:', x);       // 5
console.log('Pre-incremento ++x:', ++x); // 6 (primero sube, luego retorna)
console.log('Después:', x);             // 6

// Post-incremento: retorna el valor ACTUAL, luego incrementa
let y = 5;
console.log('Post-incremento y++:', y++); // 5 (primero retorna, luego sube)
console.log('Después:', y);               // 6

// En la práctica: la diferencia importa sólo cuando usas el valor retornado
// En un for loop, i++ y ++i se comportan igual para el contador
let suma = 0;
for (let i = 1; i <= 5; i++) { // i++ y ++i son equivalentes aquí
  suma += i;
}
console.log('Suma 1..5:', suma); // 15

// ─────────────────────────────────────────────────────────────────────────────
// 5. División entera
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- División entera ---');
// JavaScript no tiene operador de división entera como Python (//)
// Se logra con Math.floor() para números positivos
console.log('Math.floor(17 / 5):', Math.floor(17 / 5));  // 3
console.log('Math.trunc(17 / 5):', Math.trunc(17 / 5));  // 3

// Con negativos, Math.floor y Math.trunc difieren:
console.log('Math.floor(-7 / 2):', Math.floor(-7 / 2));  // -4 (hacia -Infinity)
console.log('Math.trunc(-7 / 2):', Math.trunc(-7 / 2));  // -3 (hacia 0)

// ─────────────────────────────────────────────────────────────────────────────
// 6. El operador + con strings — Concatenación
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Operador + con strings ---');
// Cuando uno de los operandos es string, + concatena (no suma)
console.log(1 + 2);          // 3 (suma numérica)
console.log('1' + 2);        // '12' (concatena — el 2 se convierte a string)
console.log(1 + '2');        // '12' (concatena)
console.log(1 + 2 + '3');   // '33' (1+2=3 primero, luego 3+'3'='33')
console.log('1' + 2 + 3);   // '123' ('1'+2='12' primero, luego '12'+3='123')

// Los demás operadores aritméticos convierten a number
console.log('5' - 2);        // 3 (convierte '5' a 5)
console.log('5' * '2');      // 10 (convierte ambos)
console.log('hola' - 1);     // NaN (no se puede convertir 'hola')

// SOLUCIÓN: siempre convierte explícitamente
console.log(Number('5') + 2);  // 7 (explícito y claro)

// ─────────────────────────────────────────────────────────────────────────────
// 7. Ejemplos prácticos
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Ejemplos prácticos ---');

// Calcular porcentaje
const total = 850;
const descuento = 0.15;
const montoDescuento = total * descuento;
const precioFinal = total - montoDescuento;
console.log(`Precio: $${total}, Descuento: ${descuento * 100}%, Final: $${precioFinal}`);

// Convertir segundos a horas, minutos y segundos
const segundosTotales = 3723;
const horas = Math.floor(segundosTotales / 3600);
const minutos = Math.floor((segundosTotales % 3600) / 60);
const segundos = segundosTotales % 60;
console.log(`${segundosTotales}s = ${horas}h ${minutos}m ${segundos}s`);

// =============================================================================
// EXPERIMENTA:
// 1. ¿Qué da '5' + 3 + 2? ¿Y 5 + 3 + '2'? ¿Por qué son distintos?
// 2. Usa el operador módulo para determinar si un año es bisiesto
// 3. ¿Cuándo usarías Math.floor vs Math.trunc?
// 4. Crea una función que convierta minutos a formato horas:minutos
// 5. ¿Qué pasa con Infinity - Infinity? ¿Y 0 / 0?
// =============================================================================
