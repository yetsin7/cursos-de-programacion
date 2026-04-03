// =============================================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios prácticos con arrays — map, filter, reduce sobre versículos
// =============================================================================
// CÓMO EJECUTAR: node 05_ejercicios.js
// =============================================================================

'use strict';

// Dataset simulado: versículos bíblicos con metadatos
const versiculos = [
  { id: 1,  libro: 'Juan',      capitulo: 3,  numero: 16, palabras: 26, texto: 'Porque de tal manera amó Dios al mundo...' },
  { id: 2,  libro: 'Salmos',    capitulo: 23, numero: 1,  palabras: 8,  texto: 'El Señor es mi pastor, nada me faltará.' },
  { id: 3,  libro: 'Romanos',   capitulo: 8,  numero: 28, palabras: 22, texto: 'Sabemos que Dios hace que todas las cosas...' },
  { id: 4,  libro: 'Juan',      capitulo: 1,  numero: 1,  palabras: 10, texto: 'En el principio era el Verbo...' },
  { id: 5,  libro: 'Filipenses',capitulo: 4,  numero: 13, palabras: 9,  texto: 'Todo lo puedo en Cristo que me fortalece.' },
  { id: 6,  libro: 'Salmos',    capitulo: 119,numero: 105,palabras: 14, texto: 'Lámpara es a mis pies tu palabra...' },
  { id: 7,  libro: 'Jeremías',  capitulo: 29, numero: 11, palabras: 20, texto: 'Porque yo sé los planes que tengo para ti...' },
  { id: 8,  libro: 'Juan',      capitulo: 14, numero: 6,  palabras: 17, texto: 'Yo soy el camino, la verdad y la vida.' },
  { id: 9,  libro: 'Proverbios',capitulo: 3,  numero: 5,  palabras: 15, texto: 'Confía en el Señor con todo tu corazón...' },
  { id: 10, libro: 'Marcos',    capitulo: 16, numero: 15, palabras: 11, texto: 'Id por todo el mundo y predicad el evangelio.' },
];

// =============================================================================
// EJERCICIO 1: Filtrar y formatear versículos de Juan
// =============================================================================
// Objetivo: Obtener todos los versículos del libro de Juan,
// formateados como "Juan 3:16" (libro capítulo:número)

console.log('=== EJERCICIO 1: Versículos de Juan ===');

const versiculosJuan = versiculos
  .filter(v => v.libro === 'Juan')
  .map(v => `${v.libro} ${v.capitulo}:${v.numero}`);

console.log('Versículos de Juan:', versiculosJuan);
// Esperado: ['Juan 3:16', 'Juan 1:1', 'Juan 14:6']

// =============================================================================
// EJERCICIO 2: Total de palabras y promedio
// =============================================================================
// Objetivo: Calcular el total de palabras en toda la colección
// y el promedio de palabras por versículo

console.log('\n=== EJERCICIO 2: Estadísticas de palabras ===');

const totalPalabras = versiculos.reduce((suma, v) => suma + v.palabras, 0);
const promedioPalabras = totalPalabras / versiculos.length;

console.log(`Total de palabras:   ${totalPalabras}`);
console.log(`Promedio por versículo: ${promedioPalabras.toFixed(1)}`);

// Versículo más largo y más corto
const masLargo  = versiculos.reduce((max, v) => v.palabras > max.palabras ? v : max);
const masCorto  = versiculos.reduce((min, v) => v.palabras < min.palabras ? v : min);
console.log(`Más largo:  ${masLargo.libro} ${masLargo.capitulo}:${masLargo.numero} (${masLargo.palabras} palabras)`);
console.log(`Más corto:  ${masCorto.libro} ${masCorto.capitulo}:${masCorto.numero} (${masCorto.palabras} palabras)`);

// =============================================================================
// EJERCICIO 3: Agrupar versículos por libro
// =============================================================================
// Objetivo: Crear un objeto donde cada clave es el nombre del libro
// y el valor es la cantidad de versículos de ese libro

console.log('\n=== EJERCICIO 3: Versículos por libro ===');

const porLibro = versiculos.reduce((acum, v) => {
  acum[v.libro] = (acum[v.libro] ?? 0) + 1;
  return acum;
}, {});

// Mostrar ordenado de mayor a menor cantidad
const libroOrdenado = Object.entries(porLibro)
  .sort(([, cantA], [, cantB]) => cantB - cantA);

console.log('Versículos por libro:');
libroOrdenado.forEach(([libro, cant]) => {
  console.log(`  ${libro.padEnd(12)}: ${cant}`);
});

// =============================================================================
// EJERCICIO 4: Buscar y transformar versículos con más de N palabras
// =============================================================================
// Objetivo: Obtener los versículos con más de 15 palabras,
// ordenados de mayor a menor, con su referencia completa

console.log('\n=== EJERCICIO 4: Versículos largos (>15 palabras) ===');

const largos = versiculos
  .filter(v => v.palabras > 15)
  .sort((a, b) => b.palabras - a.palabras)
  .map(v => ({
    referencia: `${v.libro} ${v.capitulo}:${v.numero}`,
    palabras: v.palabras,
    inicio: v.texto.substring(0, 40) + '...',
  }));

largos.forEach(v => {
  console.log(`  [${v.palabras} palabras] ${v.referencia}`);
  console.log(`    "${v.inicio}"`);
});

// =============================================================================
// EJERCICIO 5: Construir un índice con flatMap + destructuring
// =============================================================================
// Objetivo: Generar un array plano de palabras clave únicas
// extrayendo la primera palabra de cada texto, sin repeticiones

console.log('\n=== EJERCICIO 5: Palabras clave únicas ===');

// Extraer las primeras 2 palabras de cada texto como "palabras clave"
const palabrasClave = versiculos
  .flatMap(v => v.texto.replace(/[.,!?]/g, '').toLowerCase().split(' ').slice(0, 2));

const palabrasUnicas = [...new Set(palabrasClave)].sort((a, b) =>
  a.localeCompare(b, 'es')
);

console.log(`Total palabras clave (con dup): ${palabrasClave.length}`);
console.log(`Únicas: ${palabrasUnicas.length}`);
console.log('Lista:', palabrasUnicas.join(', '));

// Bonus: usar destructuring al iterar
console.log('\nBonus — referencia y texto con destructuring:');
versiculos.slice(0, 3).forEach(({ libro, capitulo, numero, texto }) => {
  console.log(`  ${libro} ${capitulo}:${numero} — "${texto.substring(0, 45)}..."`);
});

// =============================================================================
// EXPERIMENTA:
// - Agrega un versículo de Génesis y verifica que todos los ejercicios siguen funcionando
// - Ejercicio extra: encontrar el capítulo con más versículos en la colección
// - Ejercicio extra: ordenar los versículos por libro (alfabético) y luego por capítulo
// =============================================================================
