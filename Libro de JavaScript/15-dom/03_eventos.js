// ============================================================
// ARCHIVO: 03_eventos.js
// TEMA: Eventos del DOM — escuchar y responder a acciones del usuario
// CÓMO EJECUTAR: Pega este código en la consola del navegador (F12 → Consola)
// ============================================================

// ─── NOTA ─────────────────────────────────────────────────────
// Este archivo requiere un navegador. Pega el código en la consola (F12).

// ─── 1. addEventListener — LA FORMA CORRECTA ─────────────────
// Permite múltiples listeners por evento y es la API moderna.
// NO usar onclick="..." en el HTML (mezcla lógica y presentación).

const boton = document.createElement('button');
boton.textContent = 'Haz clic';
boton.style.cssText = 'padding:8px 16px;margin:4px;cursor:pointer;';
document.body.appendChild(boton);

/**
 * Manejador del evento click.
 * @param {MouseEvent} e - Objeto del evento
 */
function alHacerClic(e) {
  console.log('Click detectado!');
  console.log('  e.target:', e.target.tagName, e.target.textContent);
  console.log('  e.currentTarget:', e.currentTarget.tagName);
  console.log('  Posición:', e.clientX, e.clientY);
}

// Registrar el listener
boton.addEventListener('click', alHacerClic);

// ─── 2. TIPOS DE EVENTOS COMUNES ─────────────────────────────
// Catálogo de los eventos más utilizados en aplicaciones web.

const input = document.createElement('input');
input.type = 'text';
input.placeholder = 'Escribe algo...';
input.style.cssText = 'padding:8px;margin:4px;display:block;';
document.body.appendChild(input);

// input: se dispara en cada pulsación de tecla
input.addEventListener('input', (e) => {
  console.log('input →', e.target.value);
});

// change: se dispara cuando el campo pierde foco con valor diferente
input.addEventListener('change', (e) => {
  console.log('change → valor final:', e.target.value);
});

// keydown: tecla presionada (antes de que aparezca el carácter)
input.addEventListener('keydown', (e) => {
  if (e.key === 'Enter') console.log('Enter presionado');
  if (e.key === 'Escape') input.blur();
});

// keyup: tecla soltada
input.addEventListener('keyup', (e) => {
  if (e.ctrlKey && e.key === 'a') console.log('Ctrl+A en el input');
});

// Eventos de ratón
boton.addEventListener('dblclick', () => console.log('Doble clic'));
boton.addEventListener('mouseover', () => console.log('Ratón encima'));
boton.addEventListener('mouseout', () => console.log('Ratón fuera'));

// Eventos de ventana
window.addEventListener('scroll', () => {
  // Usar con cuidado — se dispara muy frecuentemente
});

window.addEventListener('resize', () => {
  console.log('Ventana redimensionada:', window.innerWidth, 'x', window.innerHeight);
});

// ─── 3. OBJETO EVENT ─────────────────────────────────────────
// El objeto `e` contiene información sobre el evento y métodos de control.

const formulario = document.createElement('form');
const inputNombre = document.createElement('input');
inputNombre.placeholder = 'Tu nombre';
inputNombre.style.cssText = 'padding:8px;margin:4px;';
const btnEnviar = document.createElement('button');
btnEnviar.type = 'submit';
btnEnviar.textContent = 'Enviar';
btnEnviar.style.cssText = 'padding:8px 16px;margin:4px;';
formulario.append(inputNombre, btnEnviar);
document.body.appendChild(formulario);

formulario.addEventListener('submit', (e) => {
  // preventDefault: evita que el formulario recargue la página
  e.preventDefault();
  console.log('Formulario enviado:', inputNombre.value);
});

// ─── 4. EVENT DELEGATION — UN LISTENER PARA MUCHOS HIJOS ─────
// En lugar de agregar un listener a cada elemento hijo,
// se agrega UNO SOLO al padre y se identifica el hijo con e.target.
// Ventajas: menos memoria, funciona con elementos creados dinámicamente.

const listaEventos = document.createElement('ul');
listaEventos.id = 'lista-delegacion';
listaEventos.style.cssText = 'padding-left:16px;cursor:pointer;';
['Manzana', 'Banana', 'Cereza'].forEach((fruta) => {
  const li = document.createElement('li');
  li.textContent = fruta;
  li.dataset.fruta = fruta.toLowerCase();
  listaEventos.appendChild(li);
});
document.body.appendChild(listaEventos);

// Un solo listener en el padre maneja los clicks de todos los hijos
listaEventos.addEventListener('click', (e) => {
  // Verificar que el clic fue en un <li> (no en el <ul> vacío)
  if (e.target.tagName === 'LI') {
    console.log('Fruta seleccionada:', e.target.dataset.fruta);
    // stopPropagation: evita que el evento suba más en el árbol
    e.stopPropagation();
  }
});

// Agregar un elemento dinámico — el listener del padre lo captura automáticamente
setTimeout(() => {
  const nuevoItem = document.createElement('li');
  nuevoItem.textContent = 'Durazno (añadido dinámicamente)';
  nuevoItem.dataset.fruta = 'durazno';
  listaEventos.appendChild(nuevoItem);
  console.log('Item dinámico agregado — el listener ya lo escucha');
}, 1000);

// ─── 5. OPCIONES DEL LISTENER ────────────────────────────────

const botonOnce = document.createElement('button');
botonOnce.textContent = 'Solo responde una vez';
botonOnce.style.cssText = 'padding:8px 16px;margin:4px;display:block;';
document.body.appendChild(botonOnce);

// { once: true }: el listener se elimina automáticamente tras el primer disparo
botonOnce.addEventListener('click', () => {
  console.log('Este mensaje solo aparece una vez');
}, { once: true });

// { passive: true }: promete no llamar preventDefault() — mejora el scroll
window.addEventListener('scroll', () => {}, { passive: true });

// ─── 6. removeEventListener — ELIMINAR UN LISTENER ───────────
// IMPORTANTE: para poder removerlo, se necesita la misma referencia de función.
// Las funciones anónimas NO se pueden remover.

const botonRemover = document.createElement('button');
botonRemover.textContent = 'Clic (luego se desactiva)';
botonRemover.style.cssText = 'padding:8px 16px;margin:4px;display:block;';
document.body.appendChild(botonRemover);

/** Listener con nombre para poder eliminarlo después */
function listenerTemporal() {
  console.log('Listener temporal activo');
  botonRemover.removeEventListener('click', listenerTemporal);
  botonRemover.textContent = 'Listener eliminado';
  botonRemover.disabled = true;
}

botonRemover.addEventListener('click', listenerTemporal);

// ─── 7. CUSTOM EVENTS ────────────────────────────────────────
// Crear y despachar eventos propios para comunicación entre componentes.

const canal = new EventTarget();  // receptor de eventos personalizado

// Escuchar el evento personalizado
canal.addEventListener('pedido:completado', (e) => {
  console.log('Evento personalizado recibido:', e.detail);
});

// Disparar el evento con datos adjuntos en `detail`
const eventoPersonalizado = new CustomEvent('pedido:completado', {
  detail: { id: 42, producto: 'Libro JS', total: 29.99 },
  bubbles: true,   // el evento sube por el DOM
  cancelable: true, // puede cancelarse con preventDefault()
});

canal.dispatchEvent(eventoPersonalizado);

// También se pueden disparar en elementos del DOM
document.body.dispatchEvent(
  new CustomEvent('app:listo', { detail: { version: '1.0.0' } })
);

console.log('\nReferencia de eventos:');
console.log('  click, dblclick       → clic del ratón');
console.log('  input, change         → cambios en formularios');
console.log('  keydown, keyup        → teclas');
console.log('  submit                → envío de formulario');
console.log('  mouseover, mouseout   → ratón entra/sale');
console.log('  scroll, resize        → ventana');
console.log('  CustomEvent           → eventos propios');
