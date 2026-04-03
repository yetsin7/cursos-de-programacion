// =============================================================================
// ARCHIVO: 04_destructuring.js
// TEMA: Destructuring de arrays — extracción elegante de valores
// =============================================================================
// CÓMO EJECUTAR: node 04_destructuring.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. DESTRUCTURING BÁSICO
// -----------------------------------------------------------------------------

console.log('=== DESTRUCTURING BÁSICO ===');

const coordenadas = [10, 20, 30];

// Sin destructuring — verboso
const x1 = coordenadas[0];
const y1 = coordenadas[1];
const z1 = coordenadas[2];

// Con destructuring — elegante y legible
const [x, y, z] = coordenadas;
console.log('x:', x, '| y:', y, '| z:', z);

// Los nombres de las variables son libres (no tienen que coincidir con nada)
const colores = ['rojo', 'verde', 'azul'];
const [primero, segundo, tercero] = colores;
console.log('Colores:', primero, segundo, tercero);

// Si el array tiene menos elementos que las variables: undefined
const [a, b, c, d] = [1, 2];
console.log('Variable d (sin valor):', d); // undefined

// -----------------------------------------------------------------------------
// 2. SALTAR ELEMENTOS
// -----------------------------------------------------------------------------

console.log('\n=== SALTAR ELEMENTOS ===');

const semana = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes'];

// Coma sin variable = saltar ese elemento
const [lunes, , miercoles, , viernes] = semana;
console.log('Lunes:     ', lunes);
console.log('Miércoles: ', miercoles);
console.log('Viernes:   ', viernes);

// Solo el primero y el último
const [inicio, , , , fin] = semana;
console.log('Inicio:', inicio, '| Fin:', fin);

// -----------------------------------------------------------------------------
// 3. REST EN DESTRUCTURING
// -----------------------------------------------------------------------------

console.log('\n=== REST OPERATOR ===');

const numeros = [1, 2, 3, 4, 5, 6, 7];

// El resto va a un array (rest debe ser el último)
const [primNum, segundoNum, ...resto] = numeros;
console.log('Primero: ', primNum);
console.log('Segundo: ', segundoNum);
console.log('Resto:   ', resto);   // [3, 4, 5, 6, 7]

// Patrón común: separar cabeza de cola (como en lenguajes funcionales)
const [cabeza, ...cola] = ['A', 'B', 'C', 'D'];
console.log('Cabeza:', cabeza); // 'A'
console.log('Cola:  ', cola);   // ['B', 'C', 'D']

// rest en el único elemento: obtiene todo el array
const [...todoElArray] = numeros;
console.log('Todo el array:', todoElArray); // equivale a [...numeros]

// -----------------------------------------------------------------------------
// 4. DEFAULT VALUES
// -----------------------------------------------------------------------------

console.log('\n=== DEFAULT VALUES ===');

// Si el valor es undefined, se usa el default
const [p = 'desconocido', q = 0, r = false] = ['JavaScript'];
console.log('p:', p); // 'JavaScript' — tiene valor
console.log('q:', q); // 0 — usó default
console.log('r:', r); // false — usó default

// IMPORTANTE: null NO activa el default, solo undefined
const [val1 = 'default'] = [null];
const [val2 = 'default'] = [undefined];
console.log('null   → default activa:', val1); // null — ¡no activó el default!
console.log('undefined → default activa:', val2); // 'default' — sí activó

// Combinando default y rest
const config = [true];
const [habilitado = false, maxItems = 10, ...opciones] = config;
console.log('habilitado:', habilitado); // true (tenía valor)
console.log('maxItems:  ', maxItems);   // 10 (default)
console.log('opciones:  ', opciones);   // [] (vacío)

// -----------------------------------------------------------------------------
// 5. SWAP DE VARIABLES
// -----------------------------------------------------------------------------

console.log('\n=== SWAP DE VARIABLES ===');

// Sin destructuring — necesita variable temporal
let temp, valorA = 5, valorB = 10;
temp = valorA;
valorA = valorB;
valorB = temp;
console.log('Swap manual: a =', valorA, '| b =', valorB);

// Con destructuring — una sola línea, sin variable temporal
let m = 100, n = 200;
[m, n] = [n, m];
console.log('Swap con destructuring: m =', m, '| n =', n);

// Ordenar tres variables sin sort
let x2 = 30, y2 = 10, z2 = 20;
if (x2 > y2) [x2, y2] = [y2, x2];
if (y2 > z2) [y2, z2] = [z2, y2];
if (x2 > y2) [x2, y2] = [y2, x2];
console.log('Tres ordenadas:', x2, y2, z2); // 10, 20, 30

// -----------------------------------------------------------------------------
// 6. DESTRUCTURING ANIDADO
// -----------------------------------------------------------------------------

console.log('\n=== DESTRUCTURING ANIDADO ===');

// Array dentro de array
const matriz = [[1, 2], [3, 4], [5, 6]];
const [[fila1col1, fila1col2], [fila2col1]] = matriz;
console.log('Fila 1:', fila1col1, fila1col2);
console.log('Fila 2 col 1:', fila2col1);

// Array con objetos adentro
const puntos = [{ x: 0, y: 0 }, { x: 5, y: 10 }];
const [{ x: px1, y: py1 }, { x: px2, y: py2 }] = puntos;
console.log('Punto 1:', px1, py1);
console.log('Punto 2:', px2, py2);

// Destructuring en parámetros de función — muy común con map/forEach
const estudiantes = [
  ['Ana', 9.5, 'matemáticas'],
  ['Luis', 8.0, 'física'],
];
estudiantes.forEach(([nombre, nota, materia]) => {
  console.log(`${nombre} obtuvo ${nota} en ${materia}`);
});

// Con entries() — patrón muy útil
const frutas = ['manzana', 'pera', 'uva'];
frutas.forEach(([indice, fruta] = []) => {}); // NO funciona así con forEach de array simple

// Correctamente con entries()
for (const [i, fruta] of frutas.entries()) {
  console.log(`[${i}] ${fruta}`);
}

// =============================================================================
// EXPERIMENTA:
// - Usa destructuring para intercambiar el primer y último elemento de un array
// - Desestructura el resultado de split: const [usuario, dominio] = email.split('@')
// - Combina default + rest: const [admin = false, ...permisos] = rolesDelUsuario
// - Prueba destructuring en el retorno de una función: const [ok, datos] = buscarUsuario()
// =============================================================================
