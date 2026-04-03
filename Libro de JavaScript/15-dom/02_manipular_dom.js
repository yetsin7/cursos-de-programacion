// ============================================================
// ARCHIVO: 02_manipular_dom.js
// TEMA: Manipular el DOM — leer, modificar y crear elementos
// CÓMO EJECUTAR: Pega este código en la consola del navegador (F12 → Consola)
// ============================================================

// ─── NOTA ─────────────────────────────────────────────────────
// Este archivo requiere un navegador. Abre cualquier página,
// presiona F12 → Consola y pega el código.

// Crear un contenedor de práctica para no dañar la página
const zona = document.createElement('div');
zona.id = 'zona-practica';
zona.style.cssText = 'position:fixed;top:10px;right:10px;background:#1e1e2e;color:#cdd6f4;padding:16px;border-radius:8px;font-family:monospace;font-size:13px;z-index:99999;max-width:340px;';
document.body.appendChild(zona);

/** Muestra un mensaje en la zona de práctica y en consola */
const mostrar = (texto) => {
  const linea = document.createElement('div');
  linea.textContent = texto;
  zona.appendChild(linea);
  console.log(texto);
};

mostrar('🧪 Zona de práctica DOM');

// ─── 1. textContent vs innerHTML ─────────────────────────────
// textContent: trata todo como texto plano — SEGURO con datos del usuario
// innerHTML:   interpreta HTML — PELIGROSO si el contenido viene del usuario

const titulo = document.createElement('h2');
zona.appendChild(titulo);

// Seguro: no interpreta etiquetas HTML
titulo.textContent = 'Hola <b>mundo</b>';   // Muestra literalmente: Hola <b>mundo</b>
mostrar('textContent (texto plano): ' + titulo.textContent);

// Interpreta HTML — NUNCA usar con datos del usuario (riesgo XSS)
titulo.innerHTML = 'Hola <b>mundo</b>';     // Muestra: Hola mundo (negrita)
mostrar('innerHTML (interpreta HTML): ' + titulo.innerHTML);

// Peligro XSS — ejemplo de lo que NO se debe hacer:
// titulo.innerHTML = userInput;  ← NUNCA hacer esto

// ─── 2. setAttribute y getAttribute ──────────────────────────
// Leer y escribir atributos HTML de cualquier elemento.

const enlace = document.createElement('a');
enlace.textContent = 'Visitar MDN';
zona.appendChild(enlace);

// Establecer atributos
enlace.setAttribute('href', 'https://developer.mozilla.org');
enlace.setAttribute('target', '_blank');
enlace.setAttribute('rel', 'noopener noreferrer');

// Leer atributos
mostrar('href: ' + enlace.getAttribute('href'));
mostrar('target: ' + enlace.getAttribute('target'));

// Verificar existencia
mostrar('¿Tiene rel? ' + enlace.hasAttribute('rel'));

// Eliminar atributo
enlace.removeAttribute('target');
mostrar('Después de removeAttribute target: ' + enlace.getAttribute('target'));

// ─── 3. classList — Manipular clases CSS ─────────────────────
// La forma moderna y limpia de gestionar clases de un elemento.

const tarjeta = document.createElement('div');
tarjeta.textContent = 'Soy una tarjeta';
zona.appendChild(tarjeta);

// Agregar clases
tarjeta.classList.add('card', 'card-shadow');
mostrar('Clases: ' + tarjeta.className);

// Eliminar una clase
tarjeta.classList.remove('card-shadow');
mostrar('Sin card-shadow: ' + tarjeta.className);

// toggle: agrega si no está, elimina si está
tarjeta.classList.toggle('activo');
mostrar('Toggle activo (1): ' + tarjeta.classList.contains('activo'));  // true
tarjeta.classList.toggle('activo');
mostrar('Toggle activo (2): ' + tarjeta.classList.contains('activo'));  // false

// replace: sustituye una clase por otra
tarjeta.classList.add('tema-claro');
tarjeta.classList.replace('tema-claro', 'tema-oscuro');
mostrar('Después de replace: ' + tarjeta.className);

// ─── 4. style — Estilos inline ───────────────────────────────
// Se puede leer y escribir estilos CSS directamente.
// Usar con moderación — preferir clases CSS cuando sea posible.

const caja = document.createElement('div');
caja.textContent = 'Caja con estilos';
zona.appendChild(caja);

// Las propiedades CSS con guión se escriben en camelCase
caja.style.backgroundColor = '#313244';
caja.style.color = '#a6e3a1';
caja.style.padding = '8px 12px';
caja.style.borderRadius = '4px';
caja.style.marginTop = '8px';

// Leer un estilo inline
mostrar('backgroundColor: ' + caja.style.backgroundColor);

// Para leer el estilo computado (incluyendo CSS externo)
const estiloComputado = window.getComputedStyle(caja);
mostrar('Padding computado: ' + estiloComputado.padding);

// ─── 5. createElement, appendChild, append, prepend ──────────
// Crear nuevos elementos y añadirlos al DOM.

const lista = document.createElement('ul');
lista.style.cssText = 'padding-left:16px;margin:8px 0;';
zona.appendChild(lista);

// createElement: crea el elemento pero NO lo inserta en el DOM
const item1 = document.createElement('li');
item1.textContent = 'Elemento 1';

const item2 = document.createElement('li');
item2.textContent = 'Elemento 2';

// appendChild: inserta UN elemento hijo al final
lista.appendChild(item1);
lista.appendChild(item2);

// append: más moderno, acepta múltiples nodos y strings
const item3 = document.createElement('li');
item3.textContent = 'Elemento 3';
lista.append(item3, 'texto directo');  // también acepta texto

// prepend: inserta al INICIO
const itemCero = document.createElement('li');
itemCero.textContent = 'Elemento 0 (prepend)';
lista.prepend(itemCero);

mostrar('Items en lista: ' + lista.children.length);

// insertAdjacentElement: control fino de posición
// 'beforebegin', 'afterbegin', 'beforeend', 'afterend'
const itemExtra = document.createElement('li');
itemExtra.textContent = 'Insertado antes del fin';
item2.insertAdjacentElement('afterend', itemExtra);

// ─── 6. element.remove() — Eliminar del DOM ──────────────────
// La forma moderna de eliminar un elemento (sin necesitar el padre).

mostrar('Lista antes de remove: ' + lista.children.length + ' items');
itemExtra.remove();   // elimina el elemento directamente
mostrar('Lista después de remove: ' + lista.children.length + ' items');

// ─── LIMPIEZA OPCIONAL ────────────────────────────────────────
// Descomentar para eliminar la zona de práctica del DOM
// setTimeout(() => zona.remove(), 10000);

mostrar('✅ Fin de la demostración');
console.log('\nReferencia rápida:');
console.log('  el.textContent     → texto seguro');
console.log('  el.innerHTML       → HTML (cuidado con XSS)');
console.log('  el.setAttribute()  → escribir atributo');
console.log('  el.getAttribute()  → leer atributo');
console.log('  el.classList.*     → clases CSS');
console.log('  el.style.*         → estilos inline');
console.log('  document.createElement() → crear elemento');
console.log('  parent.append()    → insertar al final');
console.log('  parent.prepend()   → insertar al inicio');
console.log('  el.remove()        → eliminar del DOM');
