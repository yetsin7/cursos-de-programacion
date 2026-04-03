// =============================================================================
// ARCHIVO: 05_template_literals.js
// TEMA: Template literals — Strings modernos con backticks
// =============================================================================
//
// Los template literals (introducidos en ES2015) son strings delimitados por
// backticks (`) que permiten incrustar expresiones JS con ${}, escribir texto
// multilínea sin caracteres de escape, y crear tagged templates para casos
// avanzados. Son la forma moderna y recomendada de construir strings en JS.
//
// CÓMO EJECUTAR:
//   node 05_template_literals.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Comparación: concatenación vs template literals
// ─────────────────────────────────────────────────────────────────────────────

const nombre = 'Laura';
const edad = 27;
const ciudad = 'Bogotá';

// Forma antigua — concatenación con + (difícil de leer y propenso a errores)
const mensajeAntiguo =
  'Hola, me llamo ' + nombre + ', tengo ' + edad + ' años y vivo en ' + ciudad + '.';
console.log('Concatenación:   ', mensajeAntiguo);

// Forma moderna — template literal (limpio y natural)
const mensajeModerno = `Hola, me llamo ${nombre}, tengo ${edad} años y vivo en ${ciudad}.`;
console.log('Template literal:', mensajeModerno);

// ─────────────────────────────────────────────────────────────────────────────
// 2. Interpolación de expresiones — Cualquier JS válido va dentro de ${}
// ─────────────────────────────────────────────────────────────────────────────

const precio = 250;
const cantidad = 3;

// Operaciones matemáticas
console.log('\n--- Expresiones en ${} ---');
console.log(`Total a pagar: $${precio * cantidad}`);

// Operador ternario (condicional)
const stock = 0;
console.log(`Estado del producto: ${stock > 0 ? 'Disponible' : 'Agotado'}`);

// Llamadas a métodos
console.log(`Nombre en mayúsculas: ${nombre.toUpperCase()}`);
console.log(`Longitud del nombre: ${nombre.length} caracteres`);

// Expresiones complejas
const numeros = [1, 2, 3, 4, 5];
console.log(`Suma de [${numeros}]: ${numeros.reduce((a, b) => a + b, 0)}`);

// ─────────────────────────────────────────────────────────────────────────────
// 3. Strings multilínea — Sin \n, sin concatenación
// ─────────────────────────────────────────────────────────────────────────────

// Forma antigua con concatenación — difícil de mantener
const emailAntiguo =
  'Estimado usuario,\n\n' +
  'Su pedido ha sido confirmado.\n' +
  'Gracias por su compra.\n\n' +
  'Atentamente,\n' +
  'El equipo de ventas';

// Forma moderna con template literal — refleja visualmente el texto real
const emailModerno = `Estimado usuario,

Su pedido ha sido confirmado.
Gracias por su compra.

Atentamente,
El equipo de ventas`;

console.log('\n--- String multilínea ---');
console.log(emailModerno);

// Template literal multilínea con variables
const numeroPedido = 'ORD-2024-001';
const producto = 'Auriculares inalámbricos';
const emailConfirmacion = `
===========================================
CONFIRMACIÓN DE PEDIDO #${numeroPedido}
===========================================
Producto: ${producto}
Precio unitario: $${precio}
Cantidad: ${cantidad}
Total: $${precio * cantidad}
===========================================
`.trim(); // .trim() quita el salto de línea inicial y final

console.log('\n--- Email de confirmación ---');
console.log(emailConfirmacion);

// ─────────────────────────────────────────────────────────────────────────────
// 4. Template literals con lógica más compleja
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Genera un HTML de tarjeta de usuario.
 * @param {Object} usuario - Datos del usuario.
 * @param {string} usuario.nombre - Nombre del usuario.
 * @param {string} usuario.rol - Rol en el sistema.
 * @param {boolean} usuario.activo - Si el usuario está activo.
 * @returns {string} HTML de la tarjeta.
 */
const generarTarjetaHTML = ({ nombre: nom, rol, activo }) => `
<div class="tarjeta ${activo ? 'activo' : 'inactivo'}">
  <h2>${nom}</h2>
  <p>Rol: ${rol}</p>
  <span class="badge">${activo ? '✅ Activo' : '❌ Inactivo'}</span>
</div>
`.trim();

const admin = { nombre: 'Carlos', rol: 'Administrador', activo: true };
const invitado = { nombre: 'Ana', rol: 'Invitado', activo: false };

console.log('\n--- HTML generado ---');
console.log(generarTarjetaHTML(admin));
console.log(generarTarjetaHTML(invitado));

// ─────────────────────────────────────────────────────────────────────────────
// 5. Tagged templates — Mención avanzada
// ─────────────────────────────────────────────────────────────────────────────

// Un tagged template llama a una función que recibe el string
// descompuesto en partes. Se usa en librerías como:
// - styled-components (CSS en JS)
// - gql`...` de Apollo GraphQL
// - sql`...` para consultas SQL seguras
// - html`...` para sanitizar HTML

/**
 * Tag de ejemplo que resalta las variables interpoladas.
 * @param {TemplateStringsArray} strings - Partes literales del template.
 * @param {...any} valores - Valores interpolados.
 * @returns {string} String procesado con valores entre corchetes.
 */
const resaltar = (strings, ...valores) => {
  return strings.reduce((resultado, parte, indice) => {
    const valor = valores[indice - 1];
    return resultado + (valor !== undefined ? `[${valor}]` : '') + parte;
  });
};

const producto2 = 'Laptop';
const precio2 = 1500;
const resultado = resaltar`El producto ${producto2} cuesta $${precio2} dólares.`;

console.log('\n--- Tagged template ---');
console.log(resultado);
// Salida: "El producto [Laptop] cuesta $[1500] dólares."

// =============================================================================
// EXPERIMENTA:
// 1. Crea un template literal que genere una tabla de multiplicar del 1 al 10
// 2. Genera un string multilínea con los datos de una factura
// 3. Usa un ternario dentro de ${} para mostrar distintos mensajes según
//    si un número es par o impar
// 4. Investiga styled-components y cómo usa tagged templates para CSS en React
// 5. Crea un tag que convierta todos los valores a mayúsculas
// =============================================================================
