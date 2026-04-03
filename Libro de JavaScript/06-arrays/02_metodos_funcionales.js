// =============================================================================
// ARCHIVO: 02_metodos_funcionales.js
// TEMA: Métodos funcionales de arrays — map, filter, reduce y más
// =============================================================================
// CÓMO EJECUTAR: node 02_metodos_funcionales.js
// =============================================================================

'use strict';

// Datos de ejemplo para los ejercicios
const productos = [
  { nombre: 'Laptop',   precio: 1200, categoria: 'tecnologia', stock: 5  },
  { nombre: 'Libro',    precio: 25,   categoria: 'educacion',  stock: 50 },
  { nombre: 'Teclado',  precio: 80,   categoria: 'tecnologia', stock: 15 },
  { nombre: 'Cuaderno', precio: 8,    categoria: 'educacion',  stock: 100},
  { nombre: 'Monitor',  precio: 400,  categoria: 'tecnologia', stock: 3  },
  { nombre: 'Mochila',  precio: 60,   categoria: 'accesorios', stock: 20 },
];

// -----------------------------------------------------------------------------
// 1. MAP — Transformar cada elemento, retorna un NUEVO array del mismo tamaño
// -----------------------------------------------------------------------------

console.log('=== MAP ===');

// Extraer solo los nombres
const nombres = productos.map(p => p.nombre);
console.log('Nombres:', nombres);

// Aplicar descuento del 10% a todos los precios
const conDescuento = productos.map(p => ({
  ...p,
  precio: +(p.precio * 0.90).toFixed(2), // + convierte string a número
}));
console.log('Con 10% descuento (primeros 2):', conDescuento.slice(0, 2));

// map con índice (segundo parámetro del callback)
const conIndice = productos.map((p, i) => `${i + 1}. ${p.nombre}`);
console.log('Numerados:', conIndice);

// -----------------------------------------------------------------------------
// 2. FILTER — Filtrar elementos que cumplen la condición, retorna nuevo array
// -----------------------------------------------------------------------------

console.log('\n=== FILTER ===');

// Productos de tecnología
const tecnologia = productos.filter(p => p.categoria === 'tecnologia');
console.log('Tecnología:', tecnologia.map(p => p.nombre));

// Productos baratos (menos de 100)
const baratos = productos.filter(p => p.precio < 100);
console.log('Baratos (<100):', baratos.map(p => `${p.nombre} $${p.precio}`));

// Encadenar filter + map (la combinación más común)
const nombresTecnologiaCara = productos
  .filter(p => p.categoria === 'tecnologia')
  .filter(p => p.precio > 100)
  .map(p => p.nombre);
console.log('Tecnología cara:', nombresTecnologiaCara);

// -----------------------------------------------------------------------------
// 3. REDUCE — Acumular un valor a partir del array (el más poderoso)
// -----------------------------------------------------------------------------

console.log('\n=== REDUCE ===');

// Suma total de precios
const totalPrecios = productos.reduce((acum, p) => acum + p.precio, 0);
console.log('Total precios: $', totalPrecios);

// Precio promedio
const promedio = totalPrecios / productos.length;
console.log('Precio promedio: $', promedio.toFixed(2));

// Agrupar por categoría usando reduce
const porCategoria = productos.reduce((acum, p) => {
  // Si la categoría no existe en el acumulador, crearla como array vacío
  if (!acum[p.categoria]) acum[p.categoria] = [];
  acum[p.categoria].push(p.nombre);
  return acum;
}, {});
console.log('Por categoría:', porCategoria);

// Encontrar el producto más caro con reduce
const masCaro = productos.reduce((max, p) => p.precio > max.precio ? p : max);
console.log('Más caro:', masCaro.nombre, '$' + masCaro.precio);

// -----------------------------------------------------------------------------
// 4. FOREACH — Iterar sin retornar (solo efectos secundarios)
// -----------------------------------------------------------------------------

console.log('\n=== FOREACH ===');

// forEach no retorna nada útil — úsalo para efectos secundarios
console.log('Inventario:');
productos.forEach(p => {
  const estado = p.stock < 5 ? '⚠ BAJO STOCK' : '';
  console.log(`  ${p.nombre.padEnd(12)} $${String(p.precio).padStart(6)} ${estado}`);
});

// DIFERENCIA CLAVE: map retorna nuevo array, forEach retorna undefined
const resultadoMap     = productos.map(p => p.nombre);    // array de nombres
const resultadoForEach = productos.forEach(p => p.nombre); // undefined
console.log('\nmap retorna:    ', Array.isArray(resultadoMap));
console.log('forEach retorna:', resultadoForEach);          // undefined

// -----------------------------------------------------------------------------
// 5. SOME Y EVERY
// -----------------------------------------------------------------------------

console.log('\n=== SOME Y EVERY ===');

// some: retorna true si AL MENOS UN elemento cumple la condición
const hayCaros    = productos.some(p => p.precio > 1000);
const hayGratuito = productos.some(p => p.precio === 0);
console.log('¿Hay productos > $1000?:', hayCaros);     // true
console.log('¿Hay productos gratis?: ', hayGratuito);  // false

// every: retorna true si TODOS los elementos cumplen la condición
const todosTienenStock = productos.every(p => p.stock > 0);
const todosSonBaratos  = productos.every(p => p.precio < 50);
console.log('¿Todos tienen stock?:   ', todosTienenStock); // true
console.log('¿Todos son baratos?:    ', todosSonBaratos);  // false

// -----------------------------------------------------------------------------
// 6. FLAT Y FLATMAP — Aplanar arrays anidados
// -----------------------------------------------------------------------------

console.log('\n=== FLAT Y FLATMAP ===');

const anidado = [1, [2, 3], [4, [5, 6]]];

// flat(profundidad): aplana un nivel por defecto
console.log('flat(1):      ', anidado.flat());    // [1, 2, 3, 4, [5, 6]]
console.log('flat(2):      ', anidado.flat(2));   // [1, 2, 3, 4, 5, 6]
console.log('flat(Infinity):', anidado.flat(Infinity)); // aplanar sin importar profundidad

// flatMap: equivale a map seguido de flat(1) — más eficiente
const oraciones = ['hola mundo', 'js es genial'];
const palabras = oraciones.flatMap(o => o.split(' '));
console.log('flatMap palabras:', palabras); // ['hola', 'mundo', 'js', 'es', 'genial']

// Caso real: expandir array de tags por producto
const tags = productos.flatMap(p => [p.categoria, p.nombre.toLowerCase()]);
console.log('Tags (primeros 6):', tags.slice(0, 6));

// -----------------------------------------------------------------------------
// 7. RESUMEN: MUTANTES vs NO MUTANTES
// -----------------------------------------------------------------------------

console.log('\n=== MUTANTES vs NO MUTANTES ===');

console.log('MUTAN el array original:');
console.log('  push, pop, shift, unshift, splice, sort, reverse, fill, copyWithin');

console.log('NO mutan (retornan nuevo array o valor):');
console.log('  map, filter, reduce, slice, concat, flat, flatMap, find, findIndex');
console.log('  some, every, forEach (retorna undefined), includes, indexOf');

// =============================================================================
// EXPERIMENTA:
// - Encadena filter + map + reduce para obtener el total de productos baratos
// - Usa reduce para contar cuántos productos hay por categoría (objeto con counts)
// - Intenta usar flatMap para generar todas las combinaciones de dos arrays
// - Compara el rendimiento de forEach vs for...of para arrays muy grandes
// =============================================================================
