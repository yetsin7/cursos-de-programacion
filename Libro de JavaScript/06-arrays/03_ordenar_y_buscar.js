// =============================================================================
// ARCHIVO: 03_ordenar_y_buscar.js
// TEMA: Ordenar y buscar en arrays — sort, reverse, find, duplicados, iteradores
// =============================================================================
// CÓMO EJECUTAR: node 03_ordenar_y_buscar.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. SORT() — CUIDADO CON EL ORDEN POR DEFECTO
// -----------------------------------------------------------------------------

console.log('=== SORT — PELIGRO CON NÚMEROS ===');

// sort() por defecto convierte elementos a STRING y los ordena lexicográficamente
const numeros = [10, 2, 30, 4, 100, 22];
const sortDefecto = [...numeros].sort(); // copiamos para no mutar el original
console.log('Original:        ', numeros);
console.log('sort() defecto:  ', sortDefecto); // ¡INCORRECTO! [10, 100, 2, 22, 30, 4]

// Para ordenar números correctamente: usar función comparadora
// La función debe retornar: negativo (a antes de b), 0 (igual), positivo (b antes de a)
const sortAscendente  = [...numeros].sort((a, b) => a - b);
const sortDescendente = [...numeros].sort((a, b) => b - a);
console.log('sort ascendente: ', sortAscendente);  // [2, 4, 10, 22, 30, 100]
console.log('sort descendente:', sortDescendente); // [100, 30, 22, 10, 4, 2]

// -----------------------------------------------------------------------------
// 2. SORT CON STRINGS — localeCompare
// -----------------------------------------------------------------------------

console.log('\n=== SORT CON STRINGS ===');

const nombres = ['Zebra', 'ángel', 'Carlos', 'ana', 'Beatriz', 'ñoño'];

// sort() sin comparadora falla con caracteres especiales (ñ, á, é...)
const sortSimple = [...nombres].sort();
console.log('sort() simple:      ', sortSimple); // puede estar mal ordenado

// localeCompare respeta el idioma, acentos y ñ
const sortCorrecto = [...nombres].sort((a, b) => a.localeCompare(b, 'es'));
console.log('localeCompare (es): ', sortCorrecto);

// Insensible a mayúsculas
const sortInsensible = [...nombres].sort((a, b) =>
  a.toLowerCase().localeCompare(b.toLowerCase(), 'es')
);
console.log('Insensible a case:  ', sortInsensible);

// -----------------------------------------------------------------------------
// 3. SORT CON OBJETOS
// -----------------------------------------------------------------------------

console.log('\n=== SORT CON OBJETOS ===');

const empleados = [
  { nombre: 'Carlos', salario: 3500, edad: 35 },
  { nombre: 'Ana',    salario: 4200, edad: 28 },
  { nombre: 'Luis',   salario: 2800, edad: 42 },
  { nombre: 'María',  salario: 4200, edad: 31 },
];

// Ordenar por salario descendente
const porSalario = [...empleados].sort((a, b) => b.salario - a.salario);
console.log('Por salario desc:');
porSalario.forEach(e => console.log(`  ${e.nombre.padEnd(8)} $${e.salario}`));

// Ordenar por salario desc, luego por nombre asc (múltiples criterios)
const porSalarioYNombre = [...empleados].sort((a, b) => {
  if (b.salario !== a.salario) return b.salario - a.salario;
  return a.nombre.localeCompare(b.nombre, 'es');
});
console.log('Por salario desc + nombre asc:');
porSalarioYNombre.forEach(e => console.log(`  ${e.nombre.padEnd(8)} $${e.salario}`));

// -----------------------------------------------------------------------------
// 4. REVERSE
// -----------------------------------------------------------------------------

console.log('\n=== REVERSE ===');

const letras = ['a', 'b', 'c', 'd', 'e'];

// reverse() MUTA el array original
const copiaLetras = [...letras];
copiaLetras.reverse();
console.log('Original:  ', letras);       // intacto porque usamos copia
console.log('Invertido: ', copiaLetras);

// Patrón común: sort + reverse
const sortDescStr = [...nombres].sort((a, b) => a.localeCompare(b, 'es')).reverse();
console.log('Nombres invertidos:', sortDescStr);

// -----------------------------------------------------------------------------
// 5. FIND Y FINDINDEX
// -----------------------------------------------------------------------------

console.log('\n=== FIND vs FINDINDEX ===');

const usuarios = [
  { id: 101, nombre: 'Eva',   activo: true  },
  { id: 102, nombre: 'Pedro', activo: false },
  { id: 103, nombre: 'Sofía', activo: true  },
  { id: 104, nombre: 'Jorge', activo: false },
];

// find(): retorna el primer ELEMENTO que cumple la condición (o undefined)
const primerInactivo = usuarios.find(u => !u.activo);
console.log('Primer inactivo:      ', primerInactivo);

// findIndex(): retorna el ÍNDICE del primer elemento (o -1)
const indPrimerInactivo = usuarios.findIndex(u => !u.activo);
console.log('Índice primer inactivo:', indPrimerInactivo);

// Buscar por id (patrón muy común en apps)
const usuario103 = usuarios.find(u => u.id === 103);
console.log('Usuario id 103:       ', usuario103);

// Si no existe, find retorna undefined — usar ?. para acceder con seguridad
const inexistente = usuarios.find(u => u.id === 999);
console.log('Usuario inexistente:  ', inexistente?.nombre ?? 'No encontrado');

// -----------------------------------------------------------------------------
// 6. ELIMINAR DUPLICADOS CON SET
// -----------------------------------------------------------------------------

console.log('\n=== ELIMINAR DUPLICADOS ===');

const conDuplicados = [1, 2, 3, 2, 4, 1, 5, 3, 6];
const sinDuplicados = Array.from(new Set(conDuplicados));
// también se puede: [...new Set(conDuplicados)]
console.log('Con duplicados:  ', conDuplicados);
console.log('Sin duplicados:  ', sinDuplicados);

// Duplicados en array de strings
const tags = ['js', 'web', 'js', 'node', 'web', 'ts'];
const tagsUnicos = [...new Set(tags)];
console.log('Tags únicos:     ', tagsUnicos);

// Duplicados en objetos (por propiedad) — requiere lógica manual
const productosConDup = [
  { id: 1, nombre: 'Laptop' },
  { id: 2, nombre: 'Teclado' },
  { id: 1, nombre: 'Laptop' }, // duplicado
];
const sinDupObjetos = productosConDup.filter(
  (p, index, arr) => arr.findIndex(x => x.id === p.id) === index
);
console.log('Sin duplicados (objetos):', sinDupObjetos);

// -----------------------------------------------------------------------------
// 7. ENTRIES, KEYS Y VALUES — ITERADORES DE ARRAY
// -----------------------------------------------------------------------------

console.log('\n=== ENTRIES, KEYS, VALUES ===');

const frutas = ['manzana', 'pera', 'uva'];

// keys(): itera sobre los índices
console.log('keys():');
for (const indice of frutas.keys()) {
  process.stdout.write(indice + ' ');
}
console.log();

// values(): itera sobre los valores (equivale a for...of directo)
console.log('values():');
for (const valor of frutas.values()) {
  process.stdout.write(valor + ' ');
}
console.log();

// entries(): itera sobre pares [índice, valor] — muy útil
console.log('entries():');
for (const [i, fruta] of frutas.entries()) {
  console.log(`  [${i}] ${fruta}`);
}

// entries() como alternativa a forEach con índice
const resultado = [];
for (const [i, f] of frutas.entries()) {
  resultado.push(`${i + 1}. ${f}`);
}
console.log('Numeradas:', resultado);

// =============================================================================
// EXPERIMENTA:
// - Ordena un array de fechas (strings ISO 'YYYY-MM-DD') con sort() y verifica
// - Usa find() en un array vacío y comprueba qué retorna
// - Crea una función genérica ordenarPor(arr, campo, direccion) usando sort
// - Combina Set y map: obtén los IDs únicos de un array de pedidos con duplicados
// =============================================================================
