// =============================================================================
// ARCHIVO: 02_numbers.js
// TEMA: Números en JavaScript — Enteros, decimales, Math y precisión
// =============================================================================
//
// En JavaScript todos los números son de tipo "number" y se representan como
// flotantes de 64 bits (IEEE 754). No hay un tipo entero separado. Esto trae
// ventajas (simplicidad) pero también el famoso problema de precisión flotante.
// Aquí aprenderás todo lo que necesitas saber para trabajar con números.
//
// CÓMO EJECUTAR:
//   node 02_numbers.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Enteros y decimales — Todo es el mismo tipo
// ─────────────────────────────────────────────────────────────────────────────

const entero = 42;
const decimal = 3.14159;
const negativo = -273.15;
const grande = 1_000_000;     // Separador visual (ES2021) — mejora la lectura
const cientifico = 1.5e3;     // 1500 en notación científica
const hex = 0xFF;             // 255 en hexadecimal
const binario = 0b1010;       // 10 en binario
const octal = 0o17;           // 15 en octal

console.log('--- Tipos de números ---');
console.log(entero, typeof entero);
console.log(decimal, typeof decimal);
console.log('Un millón con separador:', grande);
console.log('1.5e3 =', cientifico);
console.log('0xFF (hex) =', hex);
console.log('0b1010 (binario) =', binario);
console.log('0o17 (octal) =', octal);

// ─────────────────────────────────────────────────────────────────────────────
// 2. Valores especiales — Infinity y NaN
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Valores especiales ---');
console.log(1 / 0);          // Infinity
console.log(-1 / 0);         // -Infinity
console.log(0 / 0);          // NaN
console.log(Infinity + 1);   // Infinity
console.log(Infinity - Infinity); // NaN

// Límites del tipo number
console.log('\nLímites:');
console.log('MAX_SAFE_INTEGER:', Number.MAX_SAFE_INTEGER); // 2^53 - 1
console.log('MIN_SAFE_INTEGER:', Number.MIN_SAFE_INTEGER); // -(2^53 - 1)
console.log('MAX_VALUE:', Number.MAX_VALUE);               // ~1.8e+308
console.log('MIN_VALUE:', Number.MIN_VALUE);               // ~5e-324 (más cercano a 0)
console.log('EPSILON:', Number.EPSILON);                   // 2.22e-16 (menor diferencia entre 1 y siguiente float)

// ─────────────────────────────────────────────────────────────────────────────
// 3. Parsear strings a números
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Parseo ---');
// Number.parseInt() convierte a entero (descarta decimales, no redondea)
console.log(Number.parseInt('42'));        // 42
console.log(Number.parseInt('42.9'));      // 42 (trunca, no redondea)
console.log(Number.parseInt('42px'));      // 42 (ignora sufijos no numéricos)
console.log(Number.parseInt('px42'));      // NaN (no puede parsear)
console.log(Number.parseInt('0xFF', 16)); // 255 (segundo arg: base)

// Number.parseFloat() convierte a decimal
console.log(Number.parseFloat('3.14'));    // 3.14
console.log(Number.parseFloat('3.14abc')); // 3.14 (ignora el sufijo)

// Number() es más estricto — no acepta sufijos
console.log(Number('42'));     // 42
console.log(Number('42px'));   // NaN

// ─────────────────────────────────────────────────────────────────────────────
// 4. Verificar tipos de número
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Verificaciones ---');
console.log(Number.isInteger(42));      // true
console.log(Number.isInteger(42.5));    // false
console.log(Number.isFinite(42));       // true
console.log(Number.isFinite(Infinity)); // false
console.log(Number.isFinite(NaN));      // false
console.log(Number.isNaN(NaN));         // true
console.log(Number.isNaN(42));          // false
console.log(Number.isSafeInteger(Number.MAX_SAFE_INTEGER));     // true
console.log(Number.isSafeInteger(Number.MAX_SAFE_INTEGER + 1)); // false

// ─────────────────────────────────────────────────────────────────────────────
// 5. Formatear números — toFixed, toPrecision, toLocaleString
// ─────────────────────────────────────────────────────────────────────────────

const precio = 1234.5678;

console.log('\n--- Formateo ---');
// .toFixed(n) retorna string con n decimales (redondea)
console.log(precio.toFixed(2));   // '1234.57'
console.log(precio.toFixed(0));   // '1235'

// .toPrecision(n) controla el total de dígitos significativos
console.log(precio.toPrecision(6)); // '1234.57'

// .toLocaleString() formatea según la región del usuario
console.log(precio.toLocaleString('es-MX')); // '1,234.568' (México)
console.log(precio.toLocaleString('de-DE')); // '1.234,568' (Alemania — coma decimal)

// Formateo de moneda con Intl.NumberFormat (la forma más robusta)
const formateador = new Intl.NumberFormat('es-CO', {
  style: 'currency',
  currency: 'COP',
});
console.log(formateador.format(1500000)); // '$\u20031.500.000,00'

// ─────────────────────────────────────────────────────────────────────────────
// 6. Objeto Math — Funciones matemáticas
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Math ---');
console.log('abs(-5):', Math.abs(-5));          // 5 — valor absoluto
console.log('ceil(4.1):', Math.ceil(4.1));       // 5 — redondear hacia arriba
console.log('floor(4.9):', Math.floor(4.9));     // 4 — redondear hacia abajo
console.log('round(4.5):', Math.round(4.5));     // 5 — redondear al más cercano
console.log('trunc(4.9):', Math.trunc(4.9));     // 4 — truncar (quitar decimales)
console.log('sqrt(16):', Math.sqrt(16));         // 4 — raíz cuadrada
console.log('pow(2,10):', Math.pow(2, 10));      // 1024 (equivalente a 2**10)
console.log('max(1,5,3):', Math.max(1, 5, 3));   // 5
console.log('min(1,5,3):', Math.min(1, 5, 3));   // 1
console.log('PI:', Math.PI);                     // 3.14159...

// Math.random() genera un decimal aleatorio entre 0 (incluido) y 1 (excluido)
const aleatorio = Math.random();
console.log('random() entre 0 y 1:', aleatorio);

// Número entero aleatorio entre min y max (incluidos)
const min = 1;
const max = 6; // Simula un dado
const dado = Math.floor(Math.random() * (max - min + 1)) + min;
console.log(`Dado (${min}-${max}):`, dado);

// ─────────────────────────────────────────────────────────────────────────────
// 7. El problema de precisión flotante
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Precisión flotante ---');
// Este es el bug más famoso de JavaScript (y de todos los lenguajes con IEEE 754)
console.log(0.1 + 0.2);           // 0.30000000000000004 (no 0.3!)
console.log(0.1 + 0.2 === 0.3);   // false

// Soluciones:
// 1. Usar toFixed para mostrar
console.log((0.1 + 0.2).toFixed(1));                     // '0.3'

// 2. Comparar con tolerancia usando Number.EPSILON
const sonIguales = Math.abs((0.1 + 0.2) - 0.3) < Number.EPSILON;
console.log('¿Son iguales con EPSILON?', sonIguales); // true

// 3. Para dinero: trabajar en centavos (enteros)
const precio1 = 10; // $0.10 representado como 10 centavos
const precio2 = 20; // $0.20 representado como 20 centavos
const total = (precio1 + precio2) / 100; // Dividir al mostrar
console.log('Total en centavos:', precio1 + precio2, '→ $', total); // 30 → $ 0.3

// =============================================================================
// EXPERIMENTA:
// 1. ¿Qué da 0.1 + 0.2 + 0.3? ¿Y 0.1 + 0.1 + 0.1?
// 2. Genera 10 números aleatorios entre 1 y 100
// 3. Crea una función que calcule el área de un círculo dado su radio
// 4. Usa toLocaleString para formatear un número con tu moneda local
// 5. ¿Qué diferencia hay entre Math.floor(-4.5) y Math.trunc(-4.5)?
// =============================================================================
