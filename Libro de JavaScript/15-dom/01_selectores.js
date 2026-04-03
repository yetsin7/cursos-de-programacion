// ============================================================
// ARCHIVO: 01_selectores.js
// TEMA: Selectores del DOM — cómo encontrar elementos HTML
// CÓMO EJECUTAR: Pega este código en la consola del navegador (F12 → Consola)
// ============================================================

// ─── NOTA IMPORTANTE ─────────────────────────────────────────
// Este archivo requiere un navegador. No funciona con Node.js.
// Abre cualquier página web, presiona F12, ve a "Consola" y pega el código.

// ─── 1. getElementById ───────────────────────────────────────
// Busca UN elemento por su atributo id. Retorna el elemento o null.
// Es el selector más rápido porque los IDs son únicos en el documento.

const encabezado = document.getElementById('header');
console.log('getElementById:', encabezado);
// Si no existe, retorna null — siempre verificar antes de usarlo
if (encabezado) {
  console.log('Texto del encabezado:', encabezado.textContent);
}

// ─── 2. querySelector — EL MÁS USADO ─────────────────────────
// Acepta cualquier selector CSS. Retorna el PRIMER elemento que coincida.
// Es el más flexible y el más usado en JavaScript moderno.

const primerParrafo = document.querySelector('p');
const boton = document.querySelector('.btn-primary');       // por clase
const enlace = document.querySelector('a[href]');           // por atributo
const itemActivo = document.querySelector('li.active');     // combinado
const inputEmail = document.querySelector('input[type="email"]');

console.log('\nquerySelector:');
console.log('Primer párrafo:', primerParrafo?.textContent?.slice(0, 50));
console.log('Botón:', boton);
console.log('Enlace:', enlace?.href);

// ─── 3. querySelectorAll — LISTA DE ELEMENTOS ─────────────────
// Retorna un NodeList con TODOS los elementos que coinciden.
// Es estático: no se actualiza si el DOM cambia después.

const todosLosParagrafos = document.querySelectorAll('p');
const todosLosEnlaces = document.querySelectorAll('a');
const itemsDeNavegacion = document.querySelectorAll('nav li');

console.log('\nquerySelectorAll:');
console.log(`Párrafos encontrados: ${todosLosParagrafos.length}`);
console.log(`Enlaces encontrados: ${todosLosEnlaces.length}`);

// NodeList soporta forEach directamente
todosLosEnlaces.forEach((enlace, i) => {
  if (i < 3) console.log(`  Enlace ${i + 1}: ${enlace.href}`);
});

// Para usar métodos de Array (map, filter, etc.) se convierte primero
const textoDeEnlaces = [...todosLosEnlaces].map((a) => a.textContent.trim());
console.log('Textos de enlaces:', textoDeEnlaces.slice(0, 5));

// ─── 4. getElementsByClassName — HTMLCollection (live) ───────
// Retorna una HTMLCollection "viva": se actualiza automáticamente
// si se añaden o quitan elementos con esa clase del DOM.
// Menos moderno que querySelector, pero útil en algunos casos.

const elementosDestacados = document.getElementsByClassName('highlight');
console.log('\ngetElementsByClassName (live):');
console.log(`Elementos con clase "highlight": ${elementosDestacados.length}`);

// HTMLCollection NO tiene forEach nativo — hay que convertirla
Array.from(elementosDestacados).forEach((el) => {
  console.log('  Destacado:', el.tagName, el.textContent.slice(0, 30));
});

// ─── 5. DIFERENCIA: querySelector (estático) vs getElementsBy* (live) ───
// querySelector devuelve una foto fija del DOM en ese momento.
// getElementsBy* devuelve una referencia viva que cambia con el DOM.

console.log('\n=== Diferencia estático vs live ===');

// Crear un contenedor de prueba
const contenedor = document.createElement('div');
contenedor.innerHTML = '<span class="test">A</span>';
document.body.appendChild(contenedor);

// Selector estático — captura el estado actual
const staticList = document.querySelectorAll('.test');
// Live collection — siempre refleja el estado real del DOM
const liveList = document.getElementsByClassName('test');

console.log('Antes de agregar elemento:');
console.log('  staticList.length:', staticList.length);
console.log('  liveList.length:', liveList.length);

// Agregar otro elemento con la misma clase
const nuevoSpan = document.createElement('span');
nuevoSpan.className = 'test';
nuevoSpan.textContent = 'B';
contenedor.appendChild(nuevoSpan);

console.log('Después de agregar elemento:');
console.log('  staticList.length:', staticList.length, '← no cambió (estático)');
console.log('  liveList.length:', liveList.length, '← se actualizó (live)');

// Limpiar el DOM de prueba
document.body.removeChild(contenedor);

// ─── 6. element.closest() — BUSCAR HACIA ARRIBA ──────────────
// Sube por el árbol del DOM buscando el ancestro más cercano
// que coincida con el selector dado. Muy útil en event delegation.

console.log('\n=== closest() — buscar hacia arriba ===');

// Ejemplo: dado un botón dentro de una tarjeta, encontrar la tarjeta
const cualquierBoton = document.querySelector('button');
if (cualquierBoton) {
  const tarjeta = cualquierBoton.closest('.card');
  const formulario = cualquierBoton.closest('form');
  console.log('Botón encontrado:', cualquierBoton.textContent.trim());
  console.log('Tarjeta padre:', tarjeta);
  console.log('Formulario padre:', formulario);
} else {
  console.log('No hay botones en esta página');
}

// ─── RESUMEN DE SELECTORES ────────────────────────────────────
console.log('\n=== Resumen ===');
console.log(`
  getElementById('id')          → Elemento o null (más rápido para IDs)
  querySelector('css')          → Primer elemento o null (el más usado)
  querySelectorAll('css')       → NodeList estático (snapshot)
  getElementsByClassName('cls') → HTMLCollection viva (se actualiza)
  getElementsByTagName('tag')   → HTMLCollection viva por etiqueta
  element.closest('.padre')     → Busca hacia arriba en el árbol DOM
`);
