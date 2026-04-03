// =============================================================================
// ARCHIVO: 02_variables.js
// TEMA: Variables en JavaScript — const, let y por qué no var
// =============================================================================
//
// Las variables son contenedores para almacenar datos. En JavaScript moderno
// usamos const y let. La palabra clave var es obsoleta y causaba muchos bugs
// por su comportamiento impredecible. Aquí aprenderás cuándo usar cada una.
//
// CÓMO EJECUTAR:
//   node 02_variables.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. const — Para valores que NO cambian (usar por defecto)
// ─────────────────────────────────────────────────────────────────────────────

// const declara una variable cuya referencia no puede ser reasignada.
// Úsala siempre que puedas — comunica la intención de que el valor es fijo.
const PI = 3.14159;
const NOMBRE_APP = 'Mi Aplicación';
const MAXIMO_INTENTOS = 3;

console.log('PI:', PI);
console.log('App:', NOMBRE_APP);
console.log('Máx intentos:', MAXIMO_INTENTOS);

// IMPORTANTE: const con objetos y arrays no significa que su CONTENIDO
// sea inmutable — significa que la variable no puede APUNTAR a otro objeto.
const usuario = { nombre: 'Ana', edad: 30 };
usuario.edad = 31; // Esto SÍ funciona: modificamos el contenido del objeto
console.log('Usuario modificado:', usuario);

// usuario = { nombre: 'Luis' }; // ERROR: no puedes reasignar la variable

// ─────────────────────────────────────────────────────────────────────────────
// 2. let — Para valores que SÍ pueden cambiar
// ─────────────────────────────────────────────────────────────────────────────

// let declara una variable que puede ser reasignada.
// Úsala sólo cuando realmente necesitas cambiar el valor.
let puntuacion = 0;
console.log('\nPuntuación inicial:', puntuacion);

puntuacion = puntuacion + 10;
console.log('Tras primer acierto:', puntuacion);

puntuacion += 5; // Operador de asignación compuesta (equivalente a puntuacion = puntuacion + 5)
console.log('Tras segundo acierto:', puntuacion);

let mensaje = 'Jugando...';
mensaje = '¡Ganaste!'; // let permite la reasignación
console.log(mensaje);

// ─────────────────────────────────────────────────────────────────────────────
// 3. Por qué NO usar var
// ─────────────────────────────────────────────────────────────────────────────

// var tiene dos problemas graves:
//
// PROBLEMA 1: Scope de función (no de bloque)
// var ignora los bloques {} de if, for, while, etc. y "escapa" de ellos.
// Esto causaba bugs difíciles de encontrar.

if (true) {
  var escapado = 'Soy var, escapo del bloque'; // Mala práctica
  let encerrado = 'Soy let, me quedo en el bloque';
  const tambienEncerrado = 'Soy const, también me quedo';
}

console.log('\nvar escapa del bloque:', escapado); // Imprime (¡bug potencial!)
// console.log(encerrado);          // Error: encerrado no está definido aquí
// console.log(tambienEncerrado);   // Error: tampoco accesible aquí

// PROBLEMA 2: Hoisting confuso
// var "sube" su declaración al inicio de la función, pero NO su valor.
// Esto significa que puedes "usar" una variable antes de declararla sin error,
// pero su valor será undefined (lo que genera bugs silenciosos).
console.log('\nvar antes de declarar:', typeof varHoisted); // undefined, no error
var varHoisted = 'valor';

// Con let y const esto lanza un ReferenceError claro — mejor comportamiento.

// ─────────────────────────────────────────────────────────────────────────────
// 4. Reglas de nomenclatura para variables
// ─────────────────────────────────────────────────────────────────────────────

// VÁLIDO: camelCase — estándar en JavaScript para variables y funciones
const nombreCompleto = 'Juan García';
const edadUsuario = 25;
const esActivo = true;

// VÁLIDO: puede empezar con _ (convención de "privado") o $
const _valorInterno = 42;
const $elemento = 'jQuery usa esta convención';

// INVÁLIDO (JavaScript lanzará un error):
// const 1numero = 10;     // No puede empezar con número
// const mi-variable = 5;  // No puede tener guión (se interpreta como resta)
// const class = 'algo';   // No puede ser una palabra reservada

// Constantes globales de configuración: SCREAMING_SNAKE_CASE
const BASE_URL = 'https://api.ejemplo.com';
const TIMEOUT_MS = 5000;

console.log('\nEjemplos de nomenclatura:');
console.log('camelCase:', nombreCompleto, edadUsuario, esActivo);
console.log('SCREAMING_SNAKE_CASE:', BASE_URL, TIMEOUT_MS);

// ─────────────────────────────────────────────────────────────────────────────
// 5. Declarar vs Inicializar
// ─────────────────────────────────────────────────────────────────────────────

// DECLARAR: crear la variable (reservar espacio en memoria)
// INICIALIZAR: darle un valor por primera vez

// Con let puedes declarar sin inicializar (el valor será undefined)
let ciudad;
console.log('\nCiudad sin inicializar:', ciudad); // undefined

ciudad = 'Buenos Aires'; // Inicialización tardía
console.log('Ciudad inicializada:', ciudad);

// Con const DEBES inicializar en la misma línea (no hay opción)
// const pais; // Error: const requires an initializer
const pais = 'Argentina';
console.log('País:', pais);

// ─────────────────────────────────────────────────────────────────────────────
// 6. Resumen: cuándo usar cada una
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Regla de oro ---');
console.log('1. Usa const por defecto');
console.log('2. Cambia a let sólo si necesitas reasignar');
console.log('3. Nunca uses var en código moderno');

// =============================================================================
// EXPERIMENTA:
// 1. Intenta reasignar una const y observa el error que lanza Node.js
// 2. Declara variables con let para un contador e incrementa su valor
// 3. Crea un objeto con const y modifica sus propiedades (funciona)
// 4. Observa qué pasa si usas let antes de declararla (TDZ error)
// 5. Nombra variables para: precio de un producto, cantidad en stock,
//    nombre del vendedor, si hay descuento activo
// =============================================================================
