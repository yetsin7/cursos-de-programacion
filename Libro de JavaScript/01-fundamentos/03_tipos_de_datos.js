// =============================================================================
// ARCHIVO: 03_tipos_de_datos.js
// TEMA: Los 7 tipos primitivos de JavaScript
// =============================================================================
//
// JavaScript tiene 7 tipos de datos primitivos: string, number, boolean,
// null, undefined, symbol y bigint. Entenderlos bien es fundamental porque
// JS es un lenguaje de tipado dinámico — las variables pueden cambiar de tipo
// y las conversiones implícitas pueden causar bugs sorpresivos.
//
// CÓMO EJECUTAR:
//   node 03_tipos_de_datos.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. string — Texto
// ─────────────────────────────────────────────────────────────────────────────

const saludo = 'Hola mundo';          // Comillas simples
const despedida = "Hasta luego";      // Comillas dobles (equivalente)
const interpolado = `Texto ${saludo}`; // Template literal (backticks)

console.log('--- STRING ---');
console.log(saludo, typeof saludo);
console.log(despedida, typeof despedida);
console.log(interpolado);

// ─────────────────────────────────────────────────────────────────────────────
// 2. number — Números (enteros Y decimales son el mismo tipo)
// ─────────────────────────────────────────────────────────────────────────────

// En JS no hay distinción entre int y float — todo es "number" (64-bit float)
const entero = 42;
const decimal = 3.14;
const negativo = -100;
const notacion = 1.5e6; // 1,500,000

console.log('\n--- NUMBER ---');
console.log(entero, typeof entero);
console.log(decimal, typeof decimal);
console.log(notacion); // 1500000

// Valores especiales de tipo number
console.log(Infinity);           // División por cero positiva
console.log(-Infinity);          // División por cero negativa
console.log(NaN);                // Not a Number — resultado de operación inválida
console.log(typeof NaN);         // "number" — esto sorprende a todos

// ─────────────────────────────────────────────────────────────────────────────
// 3. boolean — Verdadero o falso
// ─────────────────────────────────────────────────────────────────────────────

const activo = true;
const eliminado = false;

console.log('\n--- BOOLEAN ---');
console.log(activo, typeof activo);
console.log(eliminado, typeof eliminado);
console.log(5 > 3); // Las comparaciones retornan boolean

// ─────────────────────────────────────────────────────────────────────────────
// 4. null y undefined — Ausencia de valor
// ─────────────────────────────────────────────────────────────────────────────

// null: ausencia INTENCIONAL de valor (lo asigna el programador)
const seleccion = null; // "no hay nada seleccionado"

// undefined: variable declarada pero sin valor asignado
let sinValor;

console.log('\n--- NULL y UNDEFINED ---');
console.log(seleccion, typeof seleccion); // "object" — BUG histórico de JS
console.log(sinValor, typeof sinValor);

// NOTA: typeof null === "object" es un bug famoso de JS que no se puede corregir
// porque rompería demasiado código existente en la web.

// ─────────────────────────────────────────────────────────────────────────────
// 5. symbol — Identificador único (ES2015+)
// ─────────────────────────────────────────────────────────────────────────────

// Symbol crea un valor único e irrepetible. Se usa principalmente para
// claves de objetos que no deben colisionar con otras claves.
const sym1 = Symbol('descripcion');
const sym2 = Symbol('descripcion');

console.log('\n--- SYMBOL ---');
console.log(typeof sym1);
console.log(sym1 === sym2); // false — cada Symbol es único aunque tenga la misma descripción

// ─────────────────────────────────────────────────────────────────────────────
// 6. bigint — Números enteros grandes (ES2020+)
// ─────────────────────────────────────────────────────────────────────────────

// BigInt permite manejar enteros más grandes que Number.MAX_SAFE_INTEGER.
// Se declara añadiendo una n al final del número.
const numeroBig = 9007199254740991n; // Number.MAX_SAFE_INTEGER como BigInt
const otroGrande = 12345678901234567890n;

console.log('\n--- BIGINT ---');
console.log(numeroBig, typeof numeroBig);
console.log(otroGrande + 1n);

// ─────────────────────────────────────────────────────────────────────────────
// 7. typeof — Verificar el tipo de una variable
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- typeof ---');
console.log(typeof 'texto');     // "string"
console.log(typeof 42);          // "number"
console.log(typeof true);        // "boolean"
console.log(typeof undefined);   // "undefined"
console.log(typeof null);        // "object" (bug histórico de JS)
console.log(typeof Symbol());    // "symbol"
console.log(typeof 123n);        // "bigint"
console.log(typeof {});          // "object"
console.log(typeof []);          // "object" (los arrays también son objetos)
console.log(typeof function(){}); // "function"

// ─────────────────────────────────────────────────────────────────────────────
// 8. Coerción de tipos — Conversión explícita
// ─────────────────────────────────────────────────────────────────────────────

// JavaScript puede convertir tipos. Hazlo EXPLÍCITAMENTE para evitar bugs.
console.log('\n--- Coerción de tipos ---');

// String → Number
console.log(Number('42'));       // 42
console.log(Number('3.14'));     // 3.14
console.log(Number(''));         // 0
console.log(Number('hola'));     // NaN (no se puede convertir)
console.log(Number(true));       // 1
console.log(Number(false));      // 0
console.log(Number(null));       // 0
console.log(Number(undefined));  // NaN

// Number → String
console.log(String(42));         // "42"
console.log(String(true));       // "true"
console.log(String(null));       // "null"
console.log((42).toString());    // "42" — método en el número

// Cualquier valor → Boolean
console.log(Boolean(1));         // true
console.log(Boolean(0));         // false
console.log(Boolean('hola'));    // true
console.log(Boolean(''));        // false
console.log(Boolean(null));      // false
console.log(Boolean(undefined)); // false

// ─────────────────────────────────────────────────────────────────────────────
// 9. NaN — Not a Number
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- NaN ---');
const resultado = Number('abc'); // Conversión fallida
console.log(resultado);          // NaN

// TRAMPA: NaN no es igual a sí mismo — es el único valor así en JS
console.log(NaN === NaN);        // false

// La forma correcta de verificar NaN es con Number.isNaN()
console.log(Number.isNaN(NaN));      // true
console.log(Number.isNaN(42));       // false
console.log(Number.isNaN('texto'));  // false (no es NaN, es un string)

// isNaN() global tiene un comportamiento más impredecible (no usar)
console.log(isNaN('texto'));         // true (convierte a number primero: NaN)
console.log(Number.isNaN('texto')); // false (más preciso — no convierte)

// =============================================================================
// EXPERIMENTA:
// 1. ¿Qué tipo devuelve typeof [] ? ¿Y typeof null? ¿Por qué sorprende?
// 2. Intenta sumar un string y un number: '5' + 3 — ¿qué obtienes?
// 3. ¿Qué pasa con '5' - 3? ¿Y '5' * 3? JS hace conversión implícita
// 4. Crea variables de cada tipo primitivo y verifica con typeof
// 5. ¿Cuándo usarías BigInt en una aplicación real?
// =============================================================================
