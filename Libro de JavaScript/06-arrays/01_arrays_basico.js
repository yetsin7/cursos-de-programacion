// =============================================================================
// ARCHIVO: 01_arrays_basico.js
// TEMA: Arrays en JavaScript — Creación, acceso, mutación y copia
// =============================================================================
// CÓMO EJECUTAR: node 01_arrays_basico.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. FORMAS DE CREAR ARRAYS
// -----------------------------------------------------------------------------

// Literal: la forma más común y directa
const frutas = ['manzana', 'pera', 'uva', 'mango'];

// Array.from(): crea un array desde un iterable o un objeto array-like
const letras = Array.from('hola');               // ['h', 'o', 'l', 'a']
const dobles = Array.from([1, 2, 3], x => x * 2); // con función de transformación

// Array.of(): crea un array con los argumentos dados
const numeros = Array.of(10, 20, 30);

// new Array(n).fill(): array de longitud n con un valor inicial
const ceros = new Array(5).fill(0);              // [0, 0, 0, 0, 0]
const plantilla = new Array(3).fill('vacío');

console.log('=== CREACIÓN DE ARRAYS ===');
console.log('Literal:        ', frutas);
console.log('Array.from str: ', letras);
console.log('Array.from map: ', dobles);
console.log('Array.of:       ', numeros);
console.log('fill(0):        ', ceros);
console.log('fill(str):      ', plantilla);

// -----------------------------------------------------------------------------
// 2. ACCESO POR ÍNDICE
// -----------------------------------------------------------------------------

console.log('\n=== ACCESO POR ÍNDICE ===');

const colores = ['rojo', 'verde', 'azul', 'amarillo', 'morado'];

console.log('Primero:          ', colores[0]);         // 'rojo'
console.log('Tercero:          ', colores[2]);         // 'azul'
console.log('Último (clásico): ', colores[colores.length - 1]); // 'morado'

// at(): permite índices negativos para contar desde el final (ES2022)
console.log('Último con at(-1):', colores.at(-1));     // 'morado'
console.log('Penúltimo at(-2): ', colores.at(-2));     // 'amarillo'
console.log('Primero at(0):    ', colores.at(0));      // 'rojo'

// -----------------------------------------------------------------------------
// 3. LENGTH Y MÉTODOS BÁSICOS DE MUTACIÓN
// -----------------------------------------------------------------------------

console.log('\n=== LENGTH Y MUTACIÓN ===');

const pila = ['a', 'b', 'c'];
console.log('Array inicial:  ', pila, '| length:', pila.length);

// push: agrega al final — MUTA el array, retorna el nuevo length
const nuevoLength = pila.push('d');
console.log('Después de push:', pila, '| nuevo length:', nuevoLength);

// pop: elimina y retorna el último elemento — MUTA el array
const ultimo = pila.pop();
console.log('Después de pop: ', pila, '| elemento removido:', ultimo);

// unshift: agrega al inicio — MUTA el array, retorna el nuevo length
pila.unshift('z');
console.log('Después de unshift:', pila);

// shift: elimina y retorna el primer elemento — MUTA el array
const primero = pila.shift();
console.log('Después de shift:  ', pila, '| elemento removido:', primero);

// -----------------------------------------------------------------------------
// 4. SPLICE (MUTAR) Y SLICE (NO MUTAR)
// -----------------------------------------------------------------------------

console.log('\n=== SPLICE vs SLICE ===');

const animales = ['perro', 'gato', 'pez', 'conejo', 'tortuga'];

// slice(inicio, fin): NO muta. Retorna una copia de una porción.
const dosAnimales = animales.slice(1, 3);    // índices 1 y 2
const desdeEl2 = animales.slice(2);          // desde índice 2 hasta el final
console.log('Original (intacto):', animales);
console.log('slice(1, 3):       ', dosAnimales);
console.log('slice(2):          ', desdeEl2);

// splice(inicio, cuántos, ...insertar): MUTA el array original
// Úsalo cuando realmente necesites modificar el array
const copia = [...animales];                 // copiamos para no perder el original
const removidos = copia.splice(1, 2, 'hamster'); // desde pos 1, elimina 2, inserta 'hamster'
console.log('Después de splice: ', copia);
console.log('Elementos removidos:', removidos);

// -----------------------------------------------------------------------------
// 5. BÚSQUEDA EN ARRAYS
// -----------------------------------------------------------------------------

console.log('\n=== BÚSQUEDA ===');

const edades = [15, 30, 25, 42, 18, 30];
const personas = [
  { nombre: 'Ana', edad: 25 },
  { nombre: 'Luis', edad: 30 },
  { nombre: 'Eva', edad: 18 },
];

// indexOf: retorna el primer índice del valor, o -1 si no existe
console.log('indexOf(30):      ', edades.indexOf(30));   // 1 (primera ocurrencia)
console.log('indexOf(99):      ', edades.indexOf(99));   // -1

// includes: retorna true/false — más legible que indexOf !== -1
console.log('includes(18):     ', edades.includes(18));  // true
console.log('includes(99):     ', edades.includes(99));  // false

// findIndex: retorna el índice del primer elemento que cumple la condición
const indMayor = edades.findIndex(e => e > 40);
console.log('findIndex(>40):   ', indMayor);             // 3

// find: retorna el ELEMENTO (no el índice) que cumple la condición
const personaJoven = personas.find(p => p.edad < 20);
console.log('find(edad < 20):  ', personaJoven);         // { nombre: 'Eva', edad: 18 }

// -----------------------------------------------------------------------------
// 6. COPIAR ARRAYS (INMUTABILIDAD)
// -----------------------------------------------------------------------------

console.log('\n=== COPIAR ARRAYS ===');

const original = [1, 2, 3, 4, 5];

// Spread operator: la forma más idiomática en JS moderno
const copiaSpread = [...original];

// slice sin argumentos: también crea una copia shallow
const copiaSlice = original.slice();

// Demostrar que son copias independientes
copiaSpread.push(99);
console.log('Original (intacto):', original);
console.log('Copia con spread:  ', copiaSpread);
console.log('Copia con slice:   ', copiaSlice);

// ATENCIÓN: estas son copias SHALLOW (superficiales)
// Para arrays de objetos, los objetos internos siguen siendo referencias
const objetos = [{ x: 1 }, { x: 2 }];
const copiaShallow = [...objetos];
copiaShallow[0].x = 999;  // ¡modifica el objeto original también!
console.log('\nPeligro shallow copy:');
console.log('Original:   ', objetos);     // [{ x: 999 }, { x: 2 }]
console.log('Copia:      ', copiaShallow); // [{ x: 999 }, { x: 2 }]

// Para copia profunda de objetos: usar structuredClone (módulo 07)

// =============================================================================
// EXPERIMENTA:
// - Crea un array con Array.from({ length: 10 }, (_, i) => i + 1) para [1..10]
// - Usa at(-1) en un array vacío y observa qué retorna (undefined)
// - Intenta modificar una copia shallow de objetos anidados y observa el efecto
// - Combina slice y spread: [...arr.slice(0, 2), 'nuevo', ...arr.slice(2)]
// =============================================================================
