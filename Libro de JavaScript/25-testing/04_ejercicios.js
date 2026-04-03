// =============================================================
// MÓDULO 25 — Ejercicios: Suite de tests para Gestor de Tareas
// Archivo: 04_ejercicios.js
//
// Testea las funciones del gestor de tareas (estilo módulo 11).
// Las funciones están definidas aquí mismo para que el archivo
// sea autosuficiente.
//
// Ejecutar: npx jest 04_ejercicios.js
// =============================================================

// =============================================================
// Implementación del Gestor de Tareas (a testear)
// =============================================================

/**
 * Crea una tarea nueva con valores por defecto.
 * @param {string} titulo - Título de la tarea
 * @param {string} [prioridad="media"] - "alta", "media" o "baja"
 * @returns {Object} Objeto tarea
 */
function crearTarea(titulo, prioridad = "media") {
  if (!titulo || typeof titulo !== "string" || titulo.trim() === "") {
    throw new Error("El título de la tarea es obligatorio");
  }
  const prioridadesValidas = ["alta", "media", "baja"];
  if (!prioridadesValidas.includes(prioridad)) {
    throw new Error(`Prioridad inválida: ${prioridad}`);
  }
  return {
    id: Date.now(),
    titulo: titulo.trim(),
    completada: false,
    prioridad,
    creadaEn: new Date().toISOString(),
  };
}

/**
 * Marca una tarea como completada.
 * No muta el original, retorna una copia actualizada.
 * @param {Object} tarea
 * @returns {Object}
 */
function completarTarea(tarea) {
  if (!tarea || typeof tarea !== "object") {
    throw new Error("Se requiere un objeto tarea válido");
  }
  return { ...tarea, completada: true };
}

/**
 * Filtra las tareas pendientes (no completadas).
 * @param {Object[]} tareas
 * @returns {Object[]}
 */
function tareasPendientes(tareas) {
  return tareas.filter((t) => !t.completada);
}

/**
 * Filtra tareas por prioridad.
 * @param {Object[]} tareas
 * @param {string} prioridad
 * @returns {Object[]}
 */
function tareasPorPrioridad(tareas, prioridad) {
  return tareas.filter((t) => t.prioridad === prioridad);
}

/**
 * Ordena las tareas: alta → media → baja, luego pendientes antes que completadas.
 * @param {Object[]} tareas
 * @returns {Object[]}
 */
function ordenarTareas(tareas) {
  const peso = { alta: 0, media: 1, baja: 2 };
  return [...tareas].sort((a, b) => {
    // Primero ordenar por prioridad
    if (peso[a.prioridad] !== peso[b.prioridad]) {
      return peso[a.prioridad] - peso[b.prioridad];
    }
    // Luego pendientes antes que completadas
    return Number(a.completada) - Number(b.completada);
  });
}

/**
 * Elimina una tarea por su ID.
 * @param {Object[]} tareas
 * @param {number} id
 * @returns {Object[]} Nueva lista sin la tarea eliminada
 */
function eliminarTarea(tareas, id) {
  const existe = tareas.some((t) => t.id === id);
  if (!existe) throw new Error(`Tarea con ID ${id} no encontrada`);
  return tareas.filter((t) => t.id !== id);
}

// =============================================================
// TESTS
// =============================================================

describe("crearTarea()", () => {
  test("crea una tarea con valores por defecto", () => {
    const tarea = crearTarea("Estudiar Jest");
    expect(tarea.titulo).toBe("Estudiar Jest");
    expect(tarea.completada).toBe(false);
    expect(tarea.prioridad).toBe("media");
    expect(tarea).toHaveProperty("id");
    expect(tarea).toHaveProperty("creadaEn");
  });

  test("crea tarea con prioridad alta", () => {
    const tarea = crearTarea("Corregir bug crítico", "alta");
    expect(tarea.prioridad).toBe("alta");
  });

  test("recorta espacios del título", () => {
    const tarea = crearTarea("  Tarea con espacios  ");
    expect(tarea.titulo).toBe("Tarea con espacios");
  });

  test("lanza error si el título está vacío", () => {
    expect(() => crearTarea("")).toThrow("El título de la tarea es obligatorio");
  });

  test("lanza error si el título es solo espacios", () => {
    expect(() => crearTarea("   ")).toThrow();
  });

  test("lanza error con prioridad inválida", () => {
    expect(() => crearTarea("Tarea", "urgente")).toThrow("Prioridad inválida");
  });
});

describe("completarTarea()", () => {
  let tarea;
  beforeEach(() => {
    tarea = crearTarea("Revisar PR");
  });

  test("retorna la tarea con completada = true", () => {
    const completada = completarTarea(tarea);
    expect(completada.completada).toBe(true);
  });

  test("no muta la tarea original (inmutabilidad)", () => {
    completarTarea(tarea);
    expect(tarea.completada).toBe(false); // el original no cambió
  });

  test("conserva todos los demás campos", () => {
    const completada = completarTarea(tarea);
    expect(completada.titulo).toBe(tarea.titulo);
    expect(completada.prioridad).toBe(tarea.prioridad);
    expect(completada.id).toBe(tarea.id);
  });

  test("lanza error si no se pasa un objeto válido", () => {
    expect(() => completarTarea(null)).toThrow();
  });
});

describe("tareasPendientes() y tareasPorPrioridad()", () => {
  let tareas;
  beforeEach(() => {
    tareas = [
      { id: 1, titulo: "A", completada: false, prioridad: "alta" },
      { id: 2, titulo: "B", completada: true, prioridad: "media" },
      { id: 3, titulo: "C", completada: false, prioridad: "baja" },
      { id: 4, titulo: "D", completada: false, prioridad: "alta" },
    ];
  });

  test("filtra solo las tareas pendientes", () => {
    const pendientes = tareasPendientes(tareas);
    expect(pendientes).toHaveLength(3);
    pendientes.forEach((t) => expect(t.completada).toBe(false));
  });

  test("retorna arreglo vacío si todas están completadas", () => {
    const todas = tareas.map((t) => ({ ...t, completada: true }));
    expect(tareasPendientes(todas)).toHaveLength(0);
  });

  test("filtra por prioridad alta", () => {
    const altas = tareasPorPrioridad(tareas, "alta");
    expect(altas).toHaveLength(2);
    altas.forEach((t) => expect(t.prioridad).toBe("alta"));
  });
});

describe("ordenarTareas()", () => {
  test("ordena alta antes que media antes que baja", () => {
    const tareas = [
      { id: 1, titulo: "Baja", completada: false, prioridad: "baja" },
      { id: 2, titulo: "Alta", completada: false, prioridad: "alta" },
      { id: 3, titulo: "Media", completada: false, prioridad: "media" },
    ];
    const ordenadas = ordenarTareas(tareas);
    expect(ordenadas[0].prioridad).toBe("alta");
    expect(ordenadas[1].prioridad).toBe("media");
    expect(ordenadas[2].prioridad).toBe("baja");
  });

  test("no muta el arreglo original", () => {
    const original = [
      { id: 1, titulo: "X", completada: false, prioridad: "baja" },
      { id: 2, titulo: "Y", completada: false, prioridad: "alta" },
    ];
    ordenarTareas(original);
    expect(original[0].prioridad).toBe("baja"); // sin cambios
  });
});

describe("eliminarTarea()", () => {
  let tareas;
  beforeEach(() => {
    tareas = [
      { id: 10, titulo: "Tarea 10", completada: false, prioridad: "media" },
      { id: 20, titulo: "Tarea 20", completada: false, prioridad: "alta" },
    ];
  });

  test("elimina la tarea con el ID dado", () => {
    const resultado = eliminarTarea(tareas, 10);
    expect(resultado).toHaveLength(1);
    expect(resultado[0].id).toBe(20);
  });

  test("no muta el arreglo original", () => {
    eliminarTarea(tareas, 10);
    expect(tareas).toHaveLength(2);
  });

  test("lanza error si el ID no existe", () => {
    expect(() => eliminarTarea(tareas, 999)).toThrow(
      "Tarea con ID 999 no encontrada"
    );
  });
});
