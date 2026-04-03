// ============================================================
// ARCHIVO: gestor_tareas.js
// TEMA: Proyecto integrador — Gestor de Tareas en consola (Node.js puro)
// CÓMO EJECUTAR: node gestor_tareas.js
// ============================================================

const fs       = require("fs");
const path     = require("path");
const readline = require("readline");

// Ruta del archivo de persistencia (mismo directorio que este script)
const ARCHIVO_DATOS = path.join(__dirname, "tareas.json");

// ── Clase Tarea ───────────────────────────────────────────────
/**
 * Representa una tarea individual del gestor.
 * Cada tarea tiene un ID único, título, descripción, estado y fecha de creación.
 */
class Tarea {
  /**
   * @param {string} titulo - Título breve de la tarea
   * @param {string} [descripcion=""] - Descripción detallada opcional
   */
  constructor(titulo, descripcion = "") {
    // ID único usando timestamp — suficiente para uso local offline
    this.id          = Date.now();
    this.titulo      = titulo.trim();
    this.descripcion = descripcion.trim();
    this.completada  = false;
    this.fechaCreacion = new Date().toLocaleString("es");
  }

  /**
   * Retorna una representación de texto de la tarea para mostrar en consola.
   * @returns {string} Línea formateada con el estado y datos de la tarea
   */
  toString() {
    const estado = this.completada ? "✓" : "○";
    const desc   = this.descripcion ? ` — ${this.descripcion}` : "";
    return `[${this.id}] ${estado} ${this.titulo}${desc}`;
  }
}

// ── Clase GestorTareas ────────────────────────────────────────
/**
 * Administra la lista de tareas en memoria.
 * Provee métodos para agregar, completar, eliminar y buscar tareas.
 * La persistencia se maneja externamente con cargar/guardar.
 */
class GestorTareas {
  constructor() {
    /** @type {Tarea[]} Lista de tareas en memoria */
    this.tareas = [];
  }

  /**
   * Agrega una nueva tarea a la lista.
   * @param {string} titulo - Título de la tarea
   * @param {string} [descripcion=""] - Descripción opcional
   * @returns {Tarea} La tarea recién creada
   */
  agregar(titulo, descripcion = "") {
    const tarea = new Tarea(titulo, descripcion);
    this.tareas.push(tarea);
    return tarea;
  }

  /**
   * Marca una tarea como completada por su ID.
   * @param {number} id - ID de la tarea a completar
   * @returns {boolean} true si se encontró y completó, false si no existe
   */
  completar(id) {
    const tarea = this.tareas.find(t => t.id === id);
    if (!tarea) return false;
    tarea.completada = true;
    return true;
  }

  /**
   * Elimina una tarea de la lista por su ID.
   * @param {number} id - ID de la tarea a eliminar
   * @returns {boolean} true si se eliminó, false si no existía
   */
  eliminar(id) {
    const longAntes = this.tareas.length;
    this.tareas = this.tareas.filter(t => t.id !== id);
    return this.tareas.length < longAntes;
  }

  /**
   * Busca tareas cuyo título contenga el texto dado (sin distinción de mayúsculas).
   * @param {string} texto - Texto a buscar en los títulos
   * @returns {Tarea[]} Lista de tareas que coinciden
   */
  buscar(texto) {
    const query = texto.toLowerCase();
    return this.tareas.filter(t => t.titulo.toLowerCase().includes(query));
  }

  /** @returns {Tarea[]} Solo las tareas pendientes (no completadas) */
  listarPendientes() {
    return this.tareas.filter(t => !t.completada);
  }

  /** @returns {Tarea[]} Solo las tareas completadas */
  listarCompletadas() {
    return this.tareas.filter(t => t.completada);
  }
}

// ── Persistencia (fs síncrono) ────────────────────────────────
/**
 * Carga las tareas desde el archivo JSON.
 * Si el archivo no existe, crea las tareas de ejemplo por defecto.
 * @param {GestorTareas} gestor - Instancia del gestor a poblar
 */
function cargarTareas(gestor) {
  try {
    const contenido = fs.readFileSync(ARCHIVO_DATOS, "utf-8");
    const datos = JSON.parse(contenido);
    // Reconstruir instancias de Tarea desde los datos planos del JSON
    gestor.tareas = datos.map(d => Object.assign(new Tarea("_"), d));
  } catch {
    // El archivo no existe o está corrupto → cargar tareas de ejemplo
    gestor.agregar("Estudiar JavaScript",  "Completar el libro de JS módulo por módulo");
    gestor.agregar("Hacer ejercicio",      "30 minutos de actividad física al día");
    gestor.agregar("Leer la Biblia",       "Un capítulo por la mañana y uno por la noche");
  }
}

/**
 * Guarda las tareas actuales en el archivo JSON.
 * @param {GestorTareas} gestor - Instancia del gestor con las tareas
 */
function guardarTareas(gestor) {
  try {
    fs.writeFileSync(ARCHIVO_DATOS, JSON.stringify(gestor.tareas, null, 2), "utf-8");
  } catch (e) {
    console.error("Error al guardar:", e.message);
  }
}

// ── Interfaz de consola ───────────────────────────────────────
/**
 * Muestra el menú principal con las opciones disponibles.
 */
function mostrarMenu() {
  console.log("\n╔══════════════════════════════════╗");
  console.log("║      GESTOR DE TAREAS v1.0       ║");
  console.log("╠══════════════════════════════════╣");
  console.log("║ 1. Listar todas las tareas       ║");
  console.log("║ 2. Listar pendientes             ║");
  console.log("║ 3. Listar completadas            ║");
  console.log("║ 4. Agregar tarea                 ║");
  console.log("║ 5. Completar tarea               ║");
  console.log("║ 6. Eliminar tarea                ║");
  console.log("║ 7. Buscar por título             ║");
  console.log("║ 0. Salir (guarda automáticamente)║");
  console.log("╚══════════════════════════════════╝");
}

/**
 * Imprime un array de tareas en consola.
 * @param {Tarea[]} lista - Lista de tareas a mostrar
 * @param {string} [titulo=""] - Encabezado opcional
 */
function imprimirTareas(lista, titulo = "") {
  if (titulo) console.log(`\n── ${titulo} ──`);
  if (lista.length === 0) {
    console.log("  (sin tareas)");
    return;
  }
  lista.forEach(t => console.log(" ", t.toString()));
}

// ── Lógica principal del menú ─────────────────────────────────
/**
 * Inicia el bucle interactivo del menú de consola.
 * Procesa la opción elegida por el usuario y repite hasta que elige salir.
 * @param {GestorTareas} gestor - Instancia del gestor de tareas
 */
function iniciarMenu(gestor) {
  const rl = readline.createInterface({
    input:  process.stdin,
    output: process.stdout,
  });

  /**
   * Solicita input al usuario y llama al callback con la respuesta.
   * @param {string} pregunta - Texto a mostrar al usuario
   * @param {Function} callback - Función a llamar con la respuesta
   */
  const preguntar = (pregunta, callback) => rl.question(pregunta, callback);

  /** Ciclo principal: muestra menú y espera elección */
  function ciclo() {
    mostrarMenu();
    preguntar("\nElige una opción: ", (opcion) => {
      console.log();
      switch (opcion.trim()) {
        case "1":
          imprimirTareas(gestor.tareas, "Todas las tareas");
          break;
        case "2":
          imprimirTareas(gestor.listarPendientes(), "Pendientes");
          break;
        case "3":
          imprimirTareas(gestor.listarCompletadas(), "Completadas");
          break;
        case "4":
          preguntar("Título: ", (titulo) => {
            if (!titulo.trim()) { console.log("El título no puede estar vacío"); ciclo(); return; }
            preguntar("Descripción (opcional): ", (desc) => {
              const nueva = gestor.agregar(titulo, desc);
              console.log("Tarea agregada:", nueva.titulo);
              ciclo();
            });
          });
          return; // evitar llamar ciclo() dos veces
        case "5":
          imprimirTareas(gestor.listarPendientes(), "Pendientes");
          preguntar("ID de la tarea a completar: ", (idStr) => {
            const ok = gestor.completar(Number(idStr));
            console.log(ok ? "Tarea completada" : "ID no encontrado");
            ciclo();
          });
          return;
        case "6":
          imprimirTareas(gestor.tareas, "Todas las tareas");
          preguntar("ID de la tarea a eliminar: ", (idStr) => {
            const ok = gestor.eliminar(Number(idStr));
            console.log(ok ? "Tarea eliminada" : "ID no encontrado");
            ciclo();
          });
          return;
        case "7":
          preguntar("Texto a buscar: ", (texto) => {
            const resultados = gestor.buscar(texto);
            imprimirTareas(resultados, `Resultados para "${texto}"`);
            ciclo();
          });
          return;
        case "0":
          guardarTareas(gestor);
          console.log("Tareas guardadas. ¡Hasta pronto!");
          rl.close();
          return; // no llamar ciclo() — terminar
        default:
          console.log("Opción inválida — elige entre 0 y 7");
      }
      ciclo(); // volver al menú para casos sin return temprano
    });
  }

  ciclo(); // arrancar el primer ciclo
}

// ── Punto de entrada ──────────────────────────────────────────
const gestor = new GestorTareas();
cargarTareas(gestor);
iniciarMenu(gestor);

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Agrega la opción de editar el título de una tarea existente
// 2. Agrega prioridad (alta/media/baja) a la clase Tarea y ordena por ella
// 3. Exporta las tareas a un formato CSV con una opción del menú
// 4. Agrega una fecha límite (dueDate) y una opción para ver las tareas vencidas
