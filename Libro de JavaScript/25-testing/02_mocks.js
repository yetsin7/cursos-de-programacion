// =============================================================
// MÓDULO 25 — Mocks en Jest
// Archivo: 02_mocks.js
//
// Los mocks reemplazan dependencias externas durante los tests
// para que puedas probar la lógica sin efectos secundarios.
//
// Ejecutar: npx jest 02_mocks.js
// =============================================================

// =============================================================
// SECCIÓN 1 — jest.fn(): crear funciones mock desde cero
// =============================================================

describe("jest.fn() — funciones mock básicas", () => {
  /**
   * jest.fn() crea una función "espía" que registra cada vez
   * que fue llamada, con qué argumentos, y qué retornó.
   */
  test("registra que fue llamada", () => {
    const mockFn = jest.fn();
    mockFn();
    // toHaveBeenCalled — verifica que se invocó al menos una vez
    expect(mockFn).toHaveBeenCalled();
  });

  test("registra cuántas veces fue llamada", () => {
    const mockFn = jest.fn();
    mockFn();
    mockFn();
    mockFn();
    expect(mockFn).toHaveBeenCalledTimes(3);
  });

  test("registra los argumentos con que fue llamada", () => {
    const mockFn = jest.fn();
    mockFn("hola", 42);
    // toHaveBeenCalledWith — verifica argumentos de la última llamada
    expect(mockFn).toHaveBeenCalledWith("hola", 42);
  });

  test("puede retornar un valor configurado", () => {
    // mockReturnValue define qué retorna la función mock
    const mockFn = jest.fn().mockReturnValue(99);
    expect(mockFn()).toBe(99);
  });

  test("puede retornar valores diferentes en cada llamada", () => {
    const mockFn = jest
      .fn()
      .mockReturnValueOnce("primera")
      .mockReturnValueOnce("segunda");

    expect(mockFn()).toBe("primera");
    expect(mockFn()).toBe("segunda");
    // A partir de aquí retorna undefined (sin más valores configurados)
    expect(mockFn()).toBeUndefined();
  });
});

// =============================================================
// SECCIÓN 2 — Usar mocks para inyectar dependencias
// =============================================================

/**
 * Servicio de notificaciones que depende de una función externa.
 * Al testear, pasamos un mock en lugar del envío real.
 *
 * @param {string} mensaje
 * @param {Function} enviarEmail - función inyectada (testeable)
 */
function notificarUsuario(mensaje, enviarEmail) {
  if (!mensaje) throw new Error("El mensaje no puede estar vacío");
  enviarEmail(mensaje);
  return `Notificación enviada: ${mensaje}`;
}

describe("notificarUsuario()", () => {
  test("llama a enviarEmail con el mensaje correcto", () => {
    const mockEmail = jest.fn();
    notificarUsuario("Bienvenido", mockEmail);
    expect(mockEmail).toHaveBeenCalledWith("Bienvenido");
  });

  test("retorna confirmación de envío", () => {
    const mockEmail = jest.fn();
    const resultado = notificarUsuario("Hola", mockEmail);
    expect(resultado).toBe("Notificación enviada: Hola");
  });

  test("lanza error si el mensaje está vacío", () => {
    const mockEmail = jest.fn();
    expect(() => notificarUsuario("", mockEmail)).toThrow(
      "El mensaje no puede estar vacío"
    );
    // Verificar que NO se llamó a enviarEmail cuando hubo error
    expect(mockEmail).not.toHaveBeenCalled();
  });
});

// =============================================================
// SECCIÓN 3 — jest.spyOn(): espiar métodos de objetos reales
// =============================================================

describe("jest.spyOn() — espiar sin reemplazar", () => {
  /**
   * spyOn envuelve el método original para registrar llamadas,
   * pero por defecto CONSERVA la implementación real.
   * Útil cuando quieres verificar que un método fue llamado
   * sin alterar su comportamiento.
   */
  const calculadora = {
    /**
     * Multiplica dos números.
     */
    multiplicar(a, b) {
      return a * b;
    },
  };

  test("espía una llamada sin cambiar el comportamiento", () => {
    const spy = jest.spyOn(calculadora, "multiplicar");

    const resultado = calculadora.multiplicar(3, 4);

    expect(spy).toHaveBeenCalledWith(3, 4);
    expect(resultado).toBe(12); // la función real sigue funcionando

    // Restaurar el método original después del test
    spy.mockRestore();
  });

  test("puede reemplazar la implementación temporalmente", () => {
    const spy = jest
      .spyOn(calculadora, "multiplicar")
      .mockImplementation(() => 999);

    expect(calculadora.multiplicar(2, 2)).toBe(999);
    spy.mockRestore();
    // Después de restaurar, vuelve al comportamiento real
    expect(calculadora.multiplicar(2, 2)).toBe(4);
  });
});

// =============================================================
// SECCIÓN 4 — Mock de fetch (HTTP)
// =============================================================

/**
 * Función que obtiene datos de un usuario desde una API.
 * @param {number} id
 * @returns {Promise<Object>}
 */
async function obtenerUsuario(id) {
  const respuesta = await fetch(`https://api.ejemplo.com/usuarios/${id}`);
  if (!respuesta.ok) throw new Error("Usuario no encontrado");
  return respuesta.json();
}

describe("Mock de fetch", () => {
  /**
   * En Node.js/Jest, fetch no existe de forma nativa en versiones < 18.
   * La simulamos en el objeto global para tests.
   */
  beforeEach(() => {
    // Reemplazar fetch global con un mock
    global.fetch = jest.fn();
  });

  afterEach(() => {
    // Limpiar el mock entre tests
    jest.resetAllMocks();
  });

  test("retorna datos del usuario cuando la respuesta es exitosa", async () => {
    const datosSimulados = { id: 1, nombre: "Ana García" };

    // Configurar el mock para simular una respuesta HTTP 200
    global.fetch.mockResolvedValue({
      ok: true,
      json: jest.fn().mockResolvedValue(datosSimulados),
    });

    const usuario = await obtenerUsuario(1);
    expect(usuario).toEqual(datosSimulados);
    expect(global.fetch).toHaveBeenCalledWith(
      "https://api.ejemplo.com/usuarios/1"
    );
  });

  test("lanza error si la respuesta no es exitosa", async () => {
    global.fetch.mockResolvedValue({ ok: false });

    await expect(obtenerUsuario(99)).rejects.toThrow("Usuario no encontrado");
  });
});

// =============================================================
// NOTA IMPORTANTE: ¿cuándo usar mocks?
// =============================================================
//
// USA mocks para:
//   - Llamadas HTTP / APIs externas
//   - Lectura/escritura de archivos
//   - Bases de datos
//   - Servicios de terceros (email, SMS, pagos)
//   - El reloj del sistema (Date, setTimeout)
//
// NO uses mocks para:
//   - Lógica interna que puedes probar directamente
//   - Funciones puras sin efectos secundarios
//   - Todo lo que no sea una "dependencia externa"
//
// Regla: si el test se vuelve más complicado con un mock
// que sin él, probablemente no lo necesitas.
