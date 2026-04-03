// =============================================================================
// ARCHIVO: 01_hola_mundo.js
// TEMA: Tu primer programa en JavaScript
// =============================================================================
//
// En este archivo aprenderás a imprimir mensajes en la consola, que es lo
// primero que todo programador hace al aprender un nuevo lenguaje. También
// verás los diferentes métodos de console y cómo usar template literals.
//
// CÓMO EJECUTAR:
//   node 01_hola_mundo.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. console.log() — La función más usada en JavaScript
// ─────────────────────────────────────────────────────────────────────────────

// console.log() imprime un mensaje en la consola estándar (stdout).
// Es el equivalente a print() en Python o System.out.println() en Java.
console.log('Hola, mundo!');
console.log('Bienvenido a JavaScript');

// Puedes imprimir varios valores separados por comas en una sola llamada.
// JavaScript los separará automáticamente con un espacio.
console.log('Mi nombre es', 'Juan', 'y tengo', 25, 'años');

// También puedes imprimir números, booleanos y cualquier tipo de dato.
console.log(42);
console.log(true);
console.log(3.14);

// ─────────────────────────────────────────────────────────────────────────────
// 2. Otros métodos de console
// ─────────────────────────────────────────────────────────────────────────────

// console.error() imprime en rojo (stderr). Útil para reportar errores.
console.error('Esto es un mensaje de error');

// console.warn() imprime una advertencia (en amarillo en muchos terminales).
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

// Los template literals usan backticks (`) en lugar de comillas simples o dobles.
// Su ventaja principal es la interpolación: insertar variables directamente
// dentro del string usando ${variable}.

const nombre = 'Carlos';
const edad = 28;

// Forma antigua (concatenación con +) — difícil de leer
const mensajeAntiguo = 'Hola, ' + nombre + '! Tienes ' + edad + ' años.';
console.log(mensajeAntiguo);

// Forma moderna (template literal) — más clara y limpia
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

// Buenas prácticas para comentarios:
// - Comenta el "por qué", no el "qué" (el código ya dice el qué)
// - Evita comentarios obvios: no escribas // suma a y b antes de a + b
// - Mantén los comentarios actualizados cuando cambias el código

// ─────────────────────────────────────────────────────────────────────────────
// 5. Ejemplo completo
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Genera un saludo personalizado para un usuario.
 * @param {string} nombreUsuario - El nombre de la persona a saludar.
 * @param {string} ciudad - La ciudad de donde es la persona.
 * @returns {string} El mensaje de saludo completo.
 */
const generarSaludo = (nombreUsuario, ciudad) => {
  return `¡Hola, ${nombreUsuario}! Bienvenido desde ${ciudad}.`;
};

console.log('\n--- Ejemplo completo ---');
console.log(generarSaludo('Sofía', 'Madrid'));
console.log(generarSaludo('Pedro', 'Ciudad de México'));

// =============================================================================
// EXPERIMENTA:
// 1. Cambia el valor de la variable nombre e imprime el mensaje de nuevo
// 2. Crea tu propia función generarSaludo con más parámetros (país, idioma)
// 3. Prueba console.table() con un array de tus propios objetos
// 4. Escribe un template literal que calcule el área de un rectángulo
// 5. Usa console.error() y console.warn() y observa cómo se ven distintos
// =============================================================================
