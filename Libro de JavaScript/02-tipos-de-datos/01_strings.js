// =============================================================================
// ARCHIVO: 01_strings.js
// TEMA: Métodos de String en JavaScript
// =============================================================================
//
// Los strings son inmutables en JavaScript — ningún método modifica el string
// original, todos retornan uno nuevo. Aquí aprenderás los métodos más usados
// en el desarrollo cotidiano, desde los básicos hasta los más modernos de
// ES2019+ como trimStart, trimEnd y at().
//
// CÓMO EJECUTAR:
//   node 01_strings.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Propiedades básicas
// ─────────────────────────────────────────────────────────────────────────────

const texto = '  Hola, JavaScript!  ';
const nombre = 'María Fernández';

console.log('--- Propiedades básicas ---');
console.log('Texto:', JSON.stringify(texto));
// .length retorna el número de caracteres (incluyendo espacios)
console.log('length:', texto.length); // 22

// ─────────────────────────────────────────────────────────────────────────────
// 2. Cambio de mayúsculas y minúsculas
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Mayúsculas / Minúsculas ---');
console.log(nombre.toUpperCase()); // 'MARÍA FERNÁNDEZ'
console.log(nombre.toLowerCase()); // 'maría fernández'

// ─────────────────────────────────────────────────────────────────────────────
// 3. Eliminar espacios en blanco — trim
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Trim ---');
console.log(JSON.stringify(texto.trim()));      // Quita ambos extremos
console.log(JSON.stringify(texto.trimStart())); // Solo el inicio (ES2019)
console.log(JSON.stringify(texto.trimEnd()));   // Solo el final (ES2019)

// ─────────────────────────────────────────────────────────────────────────────
// 4. Buscar dentro de un string
// ─────────────────────────────────────────────────────────────────────────────

const frase = 'El cielo es azul y el mar también es azul';

console.log('\n--- Búsqueda ---');
// .includes() retorna true/false — el más usado para verificar existencia
console.log(frase.includes('azul'));       // true
console.log(frase.includes('verde'));      // false

// .startsWith() y .endsWith() verifican el inicio y final
console.log(frase.startsWith('El'));       // true
console.log(frase.startsWith('el'));       // false (sensible a mayúsculas)
console.log(frase.endsWith('azul'));       // true

// .indexOf() retorna la POSICIÓN de la primera ocurrencia (-1 si no existe)
console.log(frase.indexOf('azul'));        // 14
console.log(frase.indexOf('verde'));       // -1

// .lastIndexOf() retorna la posición de la ÚLTIMA ocurrencia
console.log(frase.lastIndexOf('azul'));    // 38

// ─────────────────────────────────────────────────────────────────────────────
// 5. Extraer partes de un string
// ─────────────────────────────────────────────────────────────────────────────

const url = 'https://www.ejemplo.com/usuarios/perfil';

console.log('\n--- Extracción ---');
// .slice(inicio, fin) — fin no incluido, acepta índices negativos
console.log(url.slice(8));          // 'www.ejemplo.com/usuarios/perfil'
console.log(url.slice(8, 23));      // 'www.ejemplo.com'
console.log(url.slice(-6));         // 'perfil' (desde el final)

// .substring(inicio, fin) — similar a slice pero no acepta negativos
console.log(url.substring(8, 23));  // 'www.ejemplo.com'

// ─────────────────────────────────────────────────────────────────────────────
// 6. Dividir y unir — split y join
// ─────────────────────────────────────────────────────────────────────────────

const csv = 'Juan,María,Carlos,Ana,Luis';

console.log('\n--- Split / Join ---');
// .split(separador) convierte el string en un array de partes
const nombres = csv.split(',');
console.log(nombres); // ['Juan', 'María', 'Carlos', 'Ana', 'Luis']

// .join() es el método inverso — convierte un array en string
console.log(nombres.join(' | ')); // 'Juan | María | Carlos | Ana | Luis'
console.log(nombres.join(''));    // 'JuanMaríaCarlosAnaLuis'

// Dividir cada caracter individualmente
console.log('hola'.split('')); // ['h', 'o', 'l', 'a']

// ─────────────────────────────────────────────────────────────────────────────
// 7. Reemplazar contenido
// ─────────────────────────────────────────────────────────────────────────────

const html = '<p>Hola <b>mundo</b>, este es un <b>ejemplo</b>.</p>';

console.log('\n--- Replace ---');
// .replace() reemplaza sólo la PRIMERA ocurrencia
console.log(html.replace('<b>', '<strong>'));

// .replaceAll() reemplaza TODAS las ocurrencias (ES2021)
console.log(html.replaceAll('<b>', '<strong>').replaceAll('</b>', '</strong>'));

// También acepta expresiones regulares
const texto2 = 'teléfono: 123-456-7890';
console.log(texto2.replace(/-/g, ' ')); // Reemplaza todos los guiones con espacio

// ─────────────────────────────────────────────────────────────────────────────
// 8. Rellenar strings — padStart y padEnd
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Padding ---');
// .padStart(longitud, relleno) rellena al INICIO hasta alcanzar la longitud
console.log('5'.padStart(3, '0'));          // '005' — útil para números con ceros
console.log('42'.padStart(5, '0'));         // '00042'

// .padEnd(longitud, relleno) rellena al FINAL
console.log('Hola'.padEnd(10, '.'));        // 'Hola......'
console.log('Precio'.padEnd(15, ' ') + '$100'); // Alinear texto en tablas

// Ejemplo práctico: formatear horas
const hora = 9;
const minutos = 5;
const horaFormateada = `${String(hora).padStart(2, '0')}:${String(minutos).padStart(2, '0')}`;
console.log('Hora:', horaFormateada); // '09:05'

// ─────────────────────────────────────────────────────────────────────────────
// 9. Repetir y acceder por índice
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Repeat y at() ---');
// .repeat(n) repite el string n veces
console.log('=-'.repeat(20));           // Línea decorativa
console.log('⭐'.repeat(5));            // '⭐⭐⭐⭐⭐'

const cadena = 'JavaScript';
// Acceso por índice clásico
console.log(cadena[0]);                 // 'J' (primer caracter)
console.log(cadena[cadena.length - 1]); // 't' (último — forma antigua)

// .at() es más moderno y acepta índices negativos directamente (ES2022)
console.log(cadena.at(0));              // 'J' (primero)
console.log(cadena.at(-1));             // 't' (último — forma moderna)
console.log(cadena.at(-3));             // 'i' (antepenúltimo)

// =============================================================================
// EXPERIMENTA:
// 1. Toma una dirección email y extrae el dominio con slice y indexOf
// 2. Genera un número de pedido de 8 dígitos usando padStart: '0000001'
// 3. Convierte 'nombre,apellido,email' en un array y luego de vuelta
// 4. Usa replaceAll para censurar una palabra en un texto
// 5. Crea una función que capitalice la primera letra de cada palabra
// =============================================================================
