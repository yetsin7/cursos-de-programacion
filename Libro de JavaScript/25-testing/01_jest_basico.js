// =============================================================
// MÓDULO 25 — Testing con Jest
// Archivo: 01_jest_basico.js
//
// Requisito: npm install -D jest
// Ejecutar:  npx jest 01_jest_basico.js
// =============================================================

// -------------------------------------------------------------
// Funciones puras que vamos a testear
// (En un proyecto real estarían en archivos separados)
// -------------------------------------------------------------

/**
 * Suma dos números.
 * @param {number} a
 * @param {number} b
 * @returns {number}
 */
function sumar(a, b) {
  return a + b;
}

/**
 * Devuelve el cuadrado de un número.
 * @param {number} n
 * @returns {number}
 */
function cuadrado(n) {
  return n * n;
}

/**
 * Filtra los números pares de un arreglo.
 * @param {number[]} arr
 * @returns {number[]}
 */
function soloParEs(arr) {
  return arr.filter((n) => n % 2 === 0);
}

/**
 * Busca un usuario por ID en una lista.
 * Retorna null si no existe.
 * @param {Object[]} usuarios
 * @param {number} id
 * @returns {Object|null}
 */
function buscarUsuario(usuarios, id) {
  return usuarios.find((u) => u.id === id) ?? null;
}

/**
 * Divide dos números. Lanza un error si el divisor es cero.
 * @param {number} a
 * @param {number} b
 * @returns {number}
 */
function dividir(a, b) {
  if (b === 0) throw new Error("No se puede dividir por cero");
  return a / b;
}

// =============================================================
// SUITE DE TESTS
// =============================================================

// -------------------------------------------------------------
// Variables compartidas entre tests del mismo describe
// -------------------------------------------------------------
let usuarios;

// beforeAll: se ejecuta UNA vez antes de todos los tests del bloque
beforeAll(() => {
  console.log("Iniciando suite de tests...");
});

// afterAll: se ejecuta UNA vez después de todos los tests del bloque
afterAll(() => {
  console.log("Suite finalizada.");
});

// -------------------------------------------------------------
// describe: agrupa tests relacionados bajo un nombre común
// -------------------------------------------------------------
describe("sumar()", () => {
  // beforeEach: se ejecuta antes de CADA test individual
  beforeEach(() => {
    // Aquí podríamos resetear estado si fuera necesario
  });

  // afterEach: se ejecuta después de CADA test individual
  afterEach(() => {
    // Limpieza post-test
  });

  // test() e it() son sinónimos — usa el que lea más natural
  test("suma dos números positivos", () => {
    expect(sumar(2, 3)).toBe(5);
  });

  it("suma un número positivo y uno negativo", () => {
    expect(sumar(10, -3)).toBe(7);
  });

  test("suma con cero devuelve el mismo número", () => {
    expect(sumar(5, 0)).toBe(5);
  });
});

// -------------------------------------------------------------
// Matcher: toEqual — comparación profunda (objetos/arrays)
// -------------------------------------------------------------
describe("soloParEs()", () => {
  test("filtra solo los pares de un arreglo mixto", () => {
    // toBe usa === (referencia); toEqual compara valor por valor
    expect(soloParEs([1, 2, 3, 4, 5, 6])).toEqual([2, 4, 6]);
  });

  test("retorna arreglo vacío si no hay pares", () => {
    expect(soloParEs([1, 3, 5])).toEqual([]);
  });

  // toHaveLength — verifica longitud de arreglos o strings
  test("el resultado tiene la longitud correcta", () => {
    expect(soloParEs([2, 4, 6, 8])).toHaveLength(4);
  });

  // toContain — verifica que un arreglo contiene un valor
  test("el resultado contiene el número 4", () => {
    expect(soloParEs([1, 2, 3, 4])).toContain(4);
  });
});

// -------------------------------------------------------------
// Matchers de veracidad
// -------------------------------------------------------------
describe("buscarUsuario()", () => {
  beforeEach(() => {
    // Datos frescos antes de cada test para evitar contaminación
    usuarios = [
      { id: 1, nombre: "Ana" },
      { id: 2, nombre: "Luis" },
      { id: 3, nombre: "María" },
    ];
  });

  test("encuentra un usuario existente", () => {
    const resultado = buscarUsuario(usuarios, 2);
    // toBeTruthy — verdadero en contexto booleano
    expect(resultado).toBeTruthy();
    expect(resultado.nombre).toBe("Luis");
  });

  test("retorna null si el usuario no existe", () => {
    const resultado = buscarUsuario(usuarios, 99);
    // toBeNull — exactamente null
    expect(resultado).toBeNull();
  });

  test("el resultado es un objeto con propiedad 'nombre'", () => {
    const resultado = buscarUsuario(usuarios, 1);
    // toEqual para comparar objetos completos
    expect(resultado).toEqual({ id: 1, nombre: "Ana" });
  });
});

// -------------------------------------------------------------
// Matcher: toThrow — verificar que una función lanza un error
// -------------------------------------------------------------
describe("dividir()", () => {
  test("divide correctamente dos números", () => {
    expect(dividir(10, 2)).toBe(5);
  });

  test("lanza error al dividir por cero", () => {
    // toThrow debe recibir una función que envuelva la llamada
    expect(() => dividir(10, 0)).toThrow("No se puede dividir por cero");
  });

  test("lanza una instancia de Error", () => {
    expect(() => dividir(5, 0)).toThrow(Error);
  });
});

// -------------------------------------------------------------
// Matcher: cuadrado — pruebas adicionales con números
// -------------------------------------------------------------
describe("cuadrado()", () => {
  test("cuadrado de 4 es 16", () => {
    expect(cuadrado(4)).toBe(16);
  });

  test("cuadrado de 0 es 0", () => {
    expect(cuadrado(0)).toBe(0);
  });

  test("cuadrado de número negativo es positivo", () => {
    expect(cuadrado(-3)).toBe(9);
  });
});

// -------------------------------------------------------------
// Exportar funciones para que Jest pueda importarlas si se
// usan en otros archivos de test
// -------------------------------------------------------------
module.exports = { sumar, cuadrado, soloParEs, buscarUsuario, dividir };
