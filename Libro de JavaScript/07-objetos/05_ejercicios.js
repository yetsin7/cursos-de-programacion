// =============================================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios prácticos combinando objetos, destructuring, spread y métodos
// =============================================================================
// CÓMO EJECUTAR: node 05_ejercicios.js
// =============================================================================

'use strict';

// Dataset: catálogo de libros
const catalogo = [
  { id: 1, titulo: 'Clean Code',       autor: 'Robert Martin', año: 2008, precio: 35, genero: 'programacion', disponible: true  },
  { id: 2, titulo: 'The Pragmatic Programmer', autor: 'Hunt & Thomas', año: 1999, precio: 40, genero: 'programacion', disponible: false },
  { id: 3, titulo: 'JavaScript: The Good Parts', autor: 'Douglas Crockford', año: 2008, precio: 28, genero: 'programacion', disponible: true  },
  { id: 4, titulo: 'Atomic Habits',    autor: 'James Clear',   año: 2018, precio: 22, genero: 'desarrollo-personal', disponible: true  },
  { id: 5, titulo: 'Deep Work',        autor: 'Cal Newport',   año: 2016, precio: 20, genero: 'desarrollo-personal', disponible: true  },
  { id: 6, titulo: 'El Quijote',       autor: 'Cervantes',     año: 1605, precio: 15, genero: 'literatura',  disponible: false },
];

// =============================================================================
// EJERCICIO 1: Función pick — extraer propiedades específicas
// =============================================================================
// Implementar pick(obj, campos) que retorne un nuevo objeto con solo esas claves

console.log('=== EJERCICIO 1: pick() ===');

/**
 * Extrae solo las propiedades indicadas de un objeto.
 * No muta el objeto original.
 * @param {object} obj - El objeto fuente
 * @param {string[]} campos - Las claves a extraer
 * @returns {object} Nuevo objeto solo con las claves indicadas
 */
function pick(obj, campos) {
  return Object.fromEntries(
    Object.entries(obj).filter(([clave]) => campos.includes(clave))
  );
}

const libro = catalogo[0];
console.log('Libro completo:', libro);
console.log('Solo public:   ', pick(libro, ['titulo', 'autor', 'precio']));
console.log('Para listado:  ', pick(libro, ['id', 'titulo', 'disponible']));

// =============================================================================
// EJERCICIO 2: Agrupar libros por género con reduce
// =============================================================================

console.log('\n=== EJERCICIO 2: Agrupar por género ===');

/**
 * Agrupa un array de objetos por el valor de una propiedad indicada.
 * @param {object[]} arr - Array de objetos
 * @param {string} campo - Clave por la que agrupar
 * @returns {object} Objeto donde cada clave es un valor del campo
 */
function agruparPor(arr, campo) {
  return arr.reduce((acum, item) => {
    const clave = item[campo];
    if (!acum[clave]) acum[clave] = [];
    acum[clave].push(item);
    return acum;
  }, {});
}

const porGenero = agruparPor(catalogo, 'genero');

for (const [genero, libros] of Object.entries(porGenero)) {
  const titulos = libros.map(l => l.titulo).join(', ');
  console.log(`  ${genero}: ${titulos}`);
}

// =============================================================================
// EJERCICIO 3: Actualizar inmutablemente un registro del catálogo
// =============================================================================
// Aplicar cambios a un libro sin mutar el array ni el objeto original

console.log('\n=== EJERCICIO 3: Actualización inmutable ===');

/**
 * Actualiza las propiedades de un objeto en un array por su ID.
 * No muta el array ni los objetos originales.
 * @param {object[]} arr - Array de objetos con propiedad 'id'
 * @param {number} id - ID del elemento a actualizar
 * @param {object} cambios - Propiedades a actualizar
 * @returns {object[]} Nuevo array con el elemento actualizado
 */
function actualizarPorId(arr, id, cambios) {
  return arr.map(item =>
    item.id === id ? { ...item, ...cambios } : item
  );
}

const catalogoActualizado = actualizarPorId(catalogo, 2, {
  disponible: true,
  precio: 38,
});

const libro2Original    = catalogo.find(l => l.id === 2);
const libro2Actualizado = catalogoActualizado.find(l => l.id === 2);

console.log('Original:    disponible=', libro2Original.disponible, 'precio=', libro2Original.precio);
console.log('Actualizado: disponible=', libro2Actualizado.disponible, 'precio=', libro2Actualizado.precio);
console.log('Array original intacto:', catalogo === catalogoActualizado ? 'NO' : 'SÍ');

// =============================================================================
// EJERCICIO 4: Estadísticas del catálogo usando Object methods
// =============================================================================

console.log('\n=== EJERCICIO 4: Estadísticas ===');

/**
 * Calcula estadísticas de precio de un catálogo.
 * @param {object[]} libros - Array de libros con propiedad precio
 * @returns {object} Objeto con min, max, promedio y total
 */
function calcularEstadisticas(libros) {
  const precios = libros.map(l => l.precio);
  const total   = precios.reduce((s, p) => s + p, 0);
  return {
    total,
    promedio: +(total / libros.length).toFixed(2),
    minimo:   Math.min(...precios),
    maximo:   Math.max(...precios),
    cantidad: libros.length,
  };
}

const stats = calcularEstadisticas(catalogo);
console.log('Estadísticas generales:');
for (const [clave, valor] of Object.entries(stats)) {
  console.log(`  ${clave.padEnd(10)}: ${valor}`);
}

// Stats por género usando agruparPor del ejercicio 2
console.log('\nEstadísticas por género:');
for (const [genero, libros] of Object.entries(porGenero)) {
  const { promedio, cantidad } = calcularEstadisticas(libros);
  console.log(`  ${genero.padEnd(22)}: ${cantidad} libros, promedio $${promedio}`);
}

// =============================================================================
// EJERCICIO 5: Construir índice de búsqueda por primera letra
// =============================================================================

console.log('\n=== EJERCICIO 5: Índice de búsqueda ===');

/**
 * Construye un índice de búsqueda agrupando los títulos por su primera letra.
 * @param {object[]} libros - Array de libros con propiedad titulo
 * @returns {object} Objeto con claves A-Z y arrays de títulos
 */
function construirIndice(libros) {
  return libros.reduce((indice, { titulo }) => {
    const letra = titulo[0].toUpperCase();
    indice[letra] = [...(indice[letra] ?? []), titulo];
    return indice;
  }, {});
}

const indice = construirIndice(catalogo);
console.log('Índice alfabético:');
// Mostrar ordenado por letra
for (const letra of Object.keys(indice).sort()) {
  console.log(`  [${letra}] ${indice[letra].join(', ')}`);
}

// Buscar libros que empiecen por una letra
function buscarPorLetra(indice, letra) {
  return indice[letra.toUpperCase()] ?? [];
}
console.log('\nLibros con C:', buscarPorLetra(indice, 'c'));
console.log('Libros con A:', buscarPorLetra(indice, 'A'));

// =============================================================================
// EXPERIMENTA:
// - Implementa omit(obj, campos) como el inverso de pick
// - Extiende calcularEstadisticas para incluir la mediana
// - Usa Object.freeze en el catálogo y verifica que actualizarPorId aún funciona
// - Crea un índice por año de publicación en vez de por primera letra
// =============================================================================
