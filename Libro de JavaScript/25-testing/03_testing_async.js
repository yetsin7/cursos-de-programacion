// =============================================================
// MÓDULO 25 — Testing de código asíncrono
// Archivo: 03_testing_async.js
//
// El código asíncrono requiere técnicas especiales para que
// Jest espere correctamente la resolución o el rechazo.
//
// Ejecutar: npx jest 03_testing_async.js
// =============================================================

// =============================================================
// Funciones asíncronas de ejemplo
// =============================================================

/**
 * Simula obtener el precio de un producto desde una API.
 * Resuelve con el precio o rechaza si el producto no existe.
 * @param {number} productoId
 * @returns {Promise<number>}
 */
function obtenerPrecio(productoId) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (productoId === 1) resolve(299.99);
      else reject(new Error(`Producto ${productoId} no encontrado`));
    }, 50); // 50ms simulados de latencia de red
  });
}

/**
 * Aplica un descuento al precio obtenido.
 * @param {number} productoId
 * @param {number} porcentaje - número entre 0 y 100
 * @returns {Promise<number>}
 */
async function precioConDescuento(productoId, porcentaje) {
  const precio = await obtenerPrecio(productoId);
  return precio * (1 - porcentaje / 100);
}

/**
 * Función que usa callback al estilo Node.js clásico.
 * @param {string} texto
 * @param {Function} callback - (error, resultado)
 */
function procesarTexto(texto, callback) {
  if (!texto || typeof texto !== "string") {
    callback(new Error("Texto inválido"), null);
    return;
  }
  // Simular procesamiento asíncrono
  setTimeout(() => {
    callback(null, texto.toUpperCase());
  }, 30);
}

// =============================================================
// SECCIÓN 1 — Retornar la Promise directamente
// =============================================================

describe("Testear Promises — retornar la promise", () => {
  /**
   * Si retornas la Promise desde el test, Jest espera su resolución.
   * Si no retornas nada, Jest termina antes y el test siempre pasa.
   */
  test("retorna el precio correctamente (retornando la promise)", () => {
    // IMPORTANTE: siempre retorna la promise
    return obtenerPrecio(1).then((precio) => {
      expect(precio).toBe(299.99);
    });
  });

  test("rechaza con error si el producto no existe", () => {
    return expect(obtenerPrecio(99)).rejects.toThrow(
      "Producto 99 no encontrado"
    );
  });
});

// =============================================================
// SECCIÓN 2 — async/await en tests (forma recomendada)
// =============================================================

describe("Testear con async/await", () => {
  /**
   * async/await hace que los tests lean igual que código síncrono.
   * Jest maneja correctamente las funciones async en tests.
   */
  test("obtiene el precio con async/await", async () => {
    const precio = await obtenerPrecio(1);
    expect(precio).toBe(299.99);
  });

  test("aplica descuento correctamente", async () => {
    const precio = await precioConDescuento(1, 10); // 10% de descuento
    expect(precio).toBeCloseTo(269.99, 2); // toBeCloseTo para decimales
  });

  test("captura el rechazo con try/catch", async () => {
    try {
      await obtenerPrecio(55);
      // Si llegamos aquí, el test debe fallar
      fail("Debería haber lanzado un error");
    } catch (error) {
      expect(error.message).toBe("Producto 55 no encontrado");
    }
  });

  test("captura el rechazo con rejects", async () => {
    // Forma más limpia que try/catch para verificar rechazos
    await expect(obtenerPrecio(55)).rejects.toThrow(
      "Producto 55 no encontrado"
    );
  });
});

// =============================================================
// SECCIÓN 3 — expect.assertions(): garantizar que se ejecutan
// =============================================================

describe("expect.assertions() — asegurarse de que los asserts corren", () => {
  /**
   * expect.assertions(n) falla el test si no se ejecutan exactamente
   * n aserciones. Es crucial en código async para evitar falsos positivos
   * donde el test pasa porque el código asíncrono nunca se ejecutó.
   */
  test("verifica que el catch se ejecutó (sin assertions podría pasar vacío)", async () => {
    // Le decimos a Jest que espera exactamente 1 aserción
    expect.assertions(1);

    try {
      await obtenerPrecio(999);
    } catch (error) {
      expect(error.message).toContain("999");
    }
  });

  test("verifica que la resolución se ejecutó", async () => {
    expect.assertions(2); // esperamos que ambos expect se ejecuten

    const precio = await obtenerPrecio(1);
    expect(precio).toBeTruthy();
    expect(typeof precio).toBe("number");
  });
});

// =============================================================
// SECCIÓN 4 — Callbacks con done()
// =============================================================

describe("Testear callbacks con done()", () => {
  /**
   * Para funciones con callbacks, Jest provee el parámetro `done`.
   * Debes llamar done() cuando el test termine, o done(error) si falló.
   * Jest espera hasta que done() sea llamado (con timeout de 5s por defecto).
   */
  test("procesa el texto correctamente", (done) => {
    procesarTexto("hola mundo", (error, resultado) => {
      expect(error).toBeNull();
      expect(resultado).toBe("HOLA MUNDO");
      done(); // avisar a Jest que el test terminó
    });
  });

  test("llama al callback con error si el texto es inválido", (done) => {
    procesarTexto(null, (error, resultado) => {
      expect(error).toBeTruthy();
      expect(error.message).toBe("Texto inválido");
      expect(resultado).toBeNull();
      done();
    });
  });
});

// =============================================================
// SECCIÓN 5 — jest.useFakeTimers(): controlar el tiempo
// =============================================================

describe("jest.useFakeTimers() — controlar setTimeout/setInterval", () => {
  /**
   * Los fake timers reemplazan setTimeout, setInterval, Date, etc.
   * con versiones controladas que puedes avanzar manualmente.
   * Esto hace que los tests sean instantáneos aunque el código
   * tenga delays de segundos.
   */
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers(); // restaurar timers reales
  });

  test("ejecuta un callback después de un delay con fake timers", () => {
    const callback = jest.fn();

    setTimeout(callback, 3000); // delay de 3 segundos

    // En este punto el callback todavía no se ejecutó
    expect(callback).not.toHaveBeenCalled();

    // Avanzar el tiempo ficticio 3 segundos
    jest.advanceTimersByTime(3000);

    // Ahora sí se ejecutó
    expect(callback).toHaveBeenCalledTimes(1);
  });

  test("runAllTimers ejecuta todos los timers pendientes", () => {
    const pasos = [];

    setTimeout(() => pasos.push("primero"), 1000);
    setTimeout(() => pasos.push("segundo"), 2000);
    setTimeout(() => pasos.push("tercero"), 3000);

    jest.runAllTimers();

    expect(pasos).toEqual(["primero", "segundo", "tercero"]);
  });
});
