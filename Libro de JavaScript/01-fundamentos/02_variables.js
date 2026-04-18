// =============================================================================
// ARCHIVO: 02_variables.js
// TEMA: Variables en JavaScript
// EJECUCION: node 02_variables.js
// =============================================================================
//
// Una variable es un nombre para acceder a un valor mientras el programa se
// ejecuta. Ese valor vive en memoria y tu codigo lo usa para leer, calcular,
// comparar o mostrar informacion.
//
// En JavaScript moderno usamos const y let.
// var existe por compatibilidad historica, pero hoy conviene evitarlo.
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. const — Para valores que NO cambian (usar por defecto)
// ─────────────────────────────────────────────────────────────────────────────

// const declara una referencia que no puede apuntar a otro valor despues.
// Es la mejor opcion por defecto porque hace el codigo mas claro y seguro.
const PI = 3.14159;
const NOMBRE_APP = 'Mi Aplicación';
const MAXIMO_INTENTOS = 3;

console.log('PI:', PI);
console.log('App:', NOMBRE_APP);
console.log('Máx intentos:', MAXIMO_INTENTOS);

// IMPORTANTE:
// const no congela automaticamente el contenido de objetos o arrays.
// Lo que no puede cambiar es la referencia guardada en la variable.
const usuario = { nombre: 'Ana', edad: 30 };
usuario.edad = 31; // Esto SÍ funciona: modificamos el contenido del objeto
console.log('Usuario modificado:', usuario);

// usuario = { nombre: 'Luis' }; // ERROR: no puedes reasignar la variable

// ─────────────────────────────────────────────────────────────────────────────
// 2. let — Para valores que SÍ pueden cambiar
// ─────────────────────────────────────────────────────────────────────────────

// let declara una variable que si puede cambiar de valor.
// Se usa cuando la logica necesita reasignacion.
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

// var tiene problemas historicos que generaban bugs dificiles de rastrear.
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
// var participa en un hoisting confuso.
// La declaracion se eleva, pero el valor no, y eso produce undefined.
console.log('\nvar antes de declarar:', typeof varHoisted); // undefined, no error
var varHoisted = 'valor';

// Con let y const el error es mas claro, y eso ayuda a depurar mejor.

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

// Declarar es crear el nombre de la variable.
// Inicializar es darle un valor por primera vez.

// Si declaras con let sin valor, JavaScript la deja en undefined.
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
// QUE DEBERIAS ENTENDER AL TERMINAR
// - const y let nombran valores que el programa usa en memoria.
// - const es la opcion por defecto.
// - let se usa cuando necesitas reasignar.
// - var genera comportamientos historicos poco claros.
// - Un nombre bien elegido mejora mucho la lectura del codigo.
//
// PRACTICA GUIADA
// 1. Intenta reasignar una const.
// 2. Crea un contador con let.
// 3. Declara un objeto con const y cambia una propiedad.
// 4. Escribe tres nombres de variables claros para un carrito de compras.
// =============================================================================
