// =============================================================================
// ARCHIVO: 01_hola_mundo.js
// TEMA: Tu primer programa en JavaScript
// EJECUCION: node 01_hola_mundo.js
// =============================================================================
//
// Esta leccion introduce la idea mas importante de toda programacion:
// escribir instrucciones que otra pieza de software pueda ejecutar.
//
// En este caso, Node.js carga tu archivo, el motor de JavaScript interpreta
// el codigo, reserva memoria para valores y muestra resultados en consola.
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. console.log() — La función más usada en JavaScript
// ─────────────────────────────────────────────────────────────────────────────

// console.log() envia informacion a la salida estandar.
// Dicho simple: le dice al programa que muestre algo en la consola.
console.log('Hola, mundo!');
console.log('Bienvenido a JavaScript');

// Puedes imprimir varios valores separados por comas en una sola llamada.
// JavaScript los separará automáticamente con un espacio.
console.log('Mi nombre es', 'Juan', 'y tengo', 25, 'años');

// Tambien puedes imprimir numeros, booleanos y otros tipos de dato.
console.log(42);
console.log(true);
console.log(3.14);

// ─────────────────────────────────────────────────────────────────────────────
// 2. Otros métodos de console
// ─────────────────────────────────────────────────────────────────────────────

// console.error() usa la salida de error.
// Muchos entornos la muestran diferente porque representa problemas o alertas.
console.error('Esto es un mensaje de error');

// console.warn() comunica una advertencia.
console.warn('Esto es una advertencia');

// console.table() muestra datos en formato de tabla — muy útil para arrays
// y objetos. Hace la información mucho más fácil de leer.
const personas = [
  { nombre: 'Ana', edad: 30 },
  { nombre: 'Luis', edad: 25 },
  { nombre: 'María', edad: 35 },
];
console.log('\n--- console.table() ---');
console.table(personas);

// ─────────────────────────────────────────────────────────────────────────────
// 3. Template literals — Strings modernos con backticks
// ─────────────────────────────────────────────────────────────────────────────

// Los template literals usan backticks (`).
// Su ventaja principal es la interpolacion: insertar variables o expresiones
// dentro del texto sin concatenar manualmente.

const nombre = 'Carlos';
const edad = 28;

// Forma antigua: unir texto y valores con +.
const mensajeAntiguo = 'Hola, ' + nombre + '! Tienes ' + edad + ' años.';
console.log(mensajeAntiguo);

// Forma moderna: un template literal.
const mensajeModerno = `Hola, ${nombre}! Tienes ${edad} años.`;
console.log(mensajeModerno);

// Dentro de ${} puedes poner cualquier expresión JavaScript válida.
const precio = 100;
const descuento = 0.15;
console.log(`Precio final: $${precio * (1 - descuento)}`);
console.log(`2 + 2 = ${2 + 2}`);
console.log(`Mayúsculas: ${nombre.toUpperCase()}`);

// ─────────────────────────────────────────────────────────────────────────────
// 4. Comentarios en JavaScript
// ─────────────────────────────────────────────────────────────────────────────

// Comentario de una sola línea: usa dos barras diagonales //
// Todo lo que venga después en esa línea es ignorado por JavaScript.

/*
  Comentario de múltiples líneas.
  Útil para explicaciones largas, documentación
  o para desactivar bloques de código temporalmente.
*/

// Buenas practicas:
// - comenta la intencion y el contexto;
// - no repitas exactamente lo que ya dice el codigo;
// - actualiza el comentario si el codigo cambia.

// ─────────────────────────────────────────────────────────────────────────────
// 5. Ejemplo completo
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Genera un saludo personalizado para un usuario.
 * Sirve para mostrar que una funcion puede recibir datos de entrada,
 * procesarlos y devolver una salida.
 * @param {string} nombreUsuario - Nombre de la persona a saludar.
 * @param {string} ciudad - Ciudad de origen de la persona.
 * @returns {string} Mensaje listo para imprimirse.
 */
const generarSaludo = (nombreUsuario, ciudad) => {
  return `¡Hola, ${nombreUsuario}! Bienvenido desde ${ciudad}.`;
};

console.log('\n--- Ejemplo completo ---');
console.log(generarSaludo('Sofía', 'Madrid'));
console.log(generarSaludo('Pedro', 'Ciudad de México'));

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - Node.js ejecuta tu archivo JavaScript fuera del navegador.
// - console.log() muestra informacion en la consola.
// - Las variables almacenan referencias a valores en memoria.
// - Un template literal hace mas clara la construccion de mensajes.
// - Una funcion recibe datos, hace algo y devuelve un resultado.
//
// PRACTICA GUIADA
// 1. Cambia el valor de nombre y edad.
// 2. Crea una variable ciudad y usala en un template literal.
// 3. Agrega un nuevo objeto al array personas.
// 4. Escribe una funcion que calcule el area de un rectangulo.
// 5. Explica con tus palabras la diferencia entre console.log y console.error.
// =============================================================================
