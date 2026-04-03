// ============================================================
// ARCHIVO: 04_ejercicios.js
// TEMA: Ejercicios prácticos de manipulación del DOM
// CÓMO EJECUTAR: Pega este código en la consola del navegador (F12 → Consola)
// ============================================================

// ─── NOTA ─────────────────────────────────────────────────────
// Estos ejercicios están diseñados para practicar en el navegador.
// Cada ejercicio crea su propia UI en la página actual.

// ─── EJERCICIO 1: Lista de tareas (To-Do) ─────────────────────
// Crear una mini lista de tareas con:
// - Input para agregar tareas
// - Botón para marcarlas como completadas (tachado)
// - Botón para eliminarlas

console.log('=== Ejercicio 1: Lista de Tareas ===');

// Contenedor principal
const appTareas = document.createElement('div');
appTareas.style.cssText = 'position:fixed;top:10px;left:10px;background:#1e1e2e;color:#cdd6f4;padding:16px;border-radius:8px;font-family:monospace;z-index:99999;width:280px;';
appTareas.innerHTML = '<h3 style="margin:0 0 8px">Lista de Tareas</h3>';

// Input y botón para agregar
const rowTareas = document.createElement('div');
rowTareas.style.cssText = 'display:flex;gap:4px;margin-bottom:8px;';
const inputTarea = document.createElement('input');
inputTarea.placeholder = 'Nueva tarea...';
inputTarea.style.cssText = 'flex:1;padding:4px 8px;background:#313244;color:#cdd6f4;border:1px solid #45475a;border-radius:4px;';
const btnAgregar = document.createElement('button');
btnAgregar.textContent = '+';
btnAgregar.style.cssText = 'padding:4px 10px;background:#89b4fa;color:#1e1e2e;border:none;border-radius:4px;cursor:pointer;font-weight:bold;';
rowTareas.append(inputTarea, btnAgregar);
appTareas.appendChild(rowTareas);

// Lista de tareas
const ulTareas = document.createElement('ul');
ulTareas.style.cssText = 'list-style:none;padding:0;margin:0;';
appTareas.appendChild(ulTareas);
document.body.appendChild(appTareas);

/**
 * Agrega una nueva tarea a la lista.
 * @param {string} texto - Descripción de la tarea
 */
function agregarTarea(texto) {
  if (!texto.trim()) return;
  const li = document.createElement('li');
  li.style.cssText = 'display:flex;align-items:center;gap:6px;padding:4px 0;border-bottom:1px solid #313244;';

  const span = document.createElement('span');
  span.textContent = texto;
  span.style.cssText = 'flex:1;cursor:pointer;font-size:13px;';

  // Clic en el texto → marcar/desmarcar como completada
  span.addEventListener('click', () => {
    const completada = span.style.textDecoration === 'line-through';
    span.style.textDecoration = completada ? 'none' : 'line-through';
    span.style.opacity = completada ? '1' : '0.5';
  });

  const btnEliminar = document.createElement('button');
  btnEliminar.textContent = '✕';
  btnEliminar.style.cssText = 'background:none;border:none;color:#f38ba8;cursor:pointer;font-size:12px;';
  btnEliminar.addEventListener('click', () => li.remove());

  li.append(span, btnEliminar);
  ulTareas.appendChild(li);
  inputTarea.value = '';
  inputTarea.focus();
}

btnAgregar.addEventListener('click', () => agregarTarea(inputTarea.value));
inputTarea.addEventListener('keydown', (e) => {
  if (e.key === 'Enter') agregarTarea(inputTarea.value);
});

// Agregar algunas tareas de ejemplo
['Estudiar DOM en JS', 'Practicar eventos', 'Crear un proyecto'].forEach(agregarTarea);

// ─── EJERCICIO 2: Cambio de tema claro/oscuro ─────────────────
// Toggle de tema usando classList y CSS custom properties.

console.log('=== Ejercicio 2: Toggle de Tema ===');

const appTema = document.createElement('div');
appTema.style.cssText = 'position:fixed;top:10px;right:10px;z-index:99999;';

const btnTema = document.createElement('button');
btnTema.textContent = '🌙 Modo oscuro';
btnTema.style.cssText = 'padding:8px 16px;background:#fab387;color:#1e1e2e;border:none;border-radius:8px;cursor:pointer;font-weight:bold;font-family:monospace;';
appTema.appendChild(btnTema);
document.body.appendChild(appTema);

// Agregar estilos del tema oscuro al documento
const estilosTema = document.createElement('style');
estilosTema.textContent = `
  .tema-oscuro { filter: invert(0.9) hue-rotate(180deg); }
  .tema-oscuro img { filter: invert(1) hue-rotate(180deg); }
`;
document.head.appendChild(estilosTema);

btnTema.addEventListener('click', () => {
  const estaOscuro = document.body.classList.toggle('tema-oscuro');
  btnTema.textContent = estaOscuro ? '☀️ Modo claro' : '🌙 Modo oscuro';
  console.log('Tema:', estaOscuro ? 'oscuro' : 'claro');
});

// ─── EJERCICIO 3: Filtro de lista en tiempo real ──────────────
// Input que filtra elementos de una lista mientras el usuario escribe.
// Usa event delegation en el padre.

console.log('=== Ejercicio 3: Filtro de Lista ===');

const appFiltro = document.createElement('div');
appFiltro.style.cssText = 'position:fixed;bottom:10px;left:10px;background:#1e1e2e;color:#cdd6f4;padding:16px;border-radius:8px;font-family:monospace;z-index:99999;width:220px;';
appFiltro.innerHTML = '<h3 style="margin:0 0 8px;font-size:13px;">Filtrar frutas</h3>';

const inputFiltro = document.createElement('input');
inputFiltro.placeholder = 'Buscar...';
inputFiltro.style.cssText = 'width:100%;padding:6px;box-sizing:border-box;background:#313244;color:#cdd6f4;border:1px solid #45475a;border-radius:4px;margin-bottom:8px;';

const frutas = ['Manzana', 'Banana', 'Cereza', 'Durazno', 'Frambuesa', 'Kiwi', 'Limón', 'Mango', 'Naranja', 'Pera'];
const ulFrutas = document.createElement('ul');
ulFrutas.style.cssText = 'list-style:none;padding:0;margin:0;max-height:140px;overflow-y:auto;';

frutas.forEach((fruta) => {
  const li = document.createElement('li');
  li.textContent = fruta;
  li.dataset.nombre = fruta.toLowerCase();
  li.style.cssText = 'padding:4px 6px;border-radius:4px;font-size:12px;cursor:default;';
  ulFrutas.appendChild(li);
});

appFiltro.append(inputFiltro, ulFrutas);
document.body.appendChild(appFiltro);

// Filtrar en tiempo real al escribir
inputFiltro.addEventListener('input', (e) => {
  const termino = e.target.value.toLowerCase();
  let visibles = 0;
  ulFrutas.querySelectorAll('li').forEach((li) => {
    const coincide = li.dataset.nombre.includes(termino);
    li.style.display = coincide ? 'block' : 'none';
    li.style.background = coincide && termino ? '#313244' : '';
    if (coincide) visibles++;
  });
  console.log(`Filtro "${termino}": ${visibles} resultado(s)`);
});

// ─── EJERCICIO 4: Arrastrar y soltar básico ───────────────────
// Implementar drag & drop nativo para reordenar una lista.

console.log('=== Ejercicio 4: Drag & Drop ===');

const appDrag = document.createElement('div');
appDrag.style.cssText = 'position:fixed;bottom:10px;right:10px;background:#1e1e2e;color:#cdd6f4;padding:16px;border-radius:8px;font-family:monospace;z-index:99999;width:200px;';
appDrag.innerHTML = '<h3 style="margin:0 0 8px;font-size:13px;">Reordenar (arrastra)</h3>';

const ulDrag = document.createElement('ul');
ulDrag.style.cssText = 'list-style:none;padding:0;margin:0;';
appDrag.appendChild(ulDrag);
document.body.appendChild(appDrag);

/** Elemento que se está arrastrando actualmente */
let elementoArrastrado = null;

['Primero', 'Segundo', 'Tercero', 'Cuarto'].forEach((nombre) => {
  const li = document.createElement('li');
  li.textContent = `☰ ${nombre}`;
  li.draggable = true;
  li.style.cssText = 'padding:6px 8px;background:#313244;border-radius:4px;margin-bottom:4px;cursor:grab;font-size:12px;border:2px solid transparent;transition:opacity .2s;';

  // Al empezar a arrastrar
  li.addEventListener('dragstart', (e) => {
    elementoArrastrado = li;
    li.style.opacity = '0.4';
    e.dataTransfer.effectAllowed = 'move';
  });

  // Al soltar en otro elemento
  li.addEventListener('dragend', () => {
    li.style.opacity = '1';
    li.style.borderColor = 'transparent';
    elementoArrastrado = null;
    console.log('Nuevo orden:', [...ulDrag.querySelectorAll('li')].map((l) => l.textContent.trim()));
  });

  // Al pasar por encima de un posible destino
  li.addEventListener('dragover', (e) => {
    e.preventDefault();
    if (elementoArrastrado && elementoArrastrado !== li) {
      li.style.borderColor = '#89b4fa';
    }
  });

  li.addEventListener('dragleave', () => {
    li.style.borderColor = 'transparent';
  });

  // Al soltar encima de este elemento
  li.addEventListener('drop', (e) => {
    e.preventDefault();
    if (elementoArrastrado && elementoArrastrado !== li) {
      ulDrag.insertBefore(elementoArrastrado, li);
    }
    li.style.borderColor = 'transparent';
  });

  ulDrag.appendChild(li);
});

console.log('✅ Los 4 ejercicios DOM están listos — mira la página del navegador');
