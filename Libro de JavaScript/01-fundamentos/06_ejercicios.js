// =============================================================================
// ARCHIVO: 06_ejercicios.js
// TEMA: Ejercicios del Módulo 01 — Fundamentos
// =============================================================================
//
// Practica lo aprendido en los archivos 01 al 05. Intenta resolver cada
// ejercicio antes de mirar la solución. Los ejercicios están ordenados de
// menor a mayor dificultad. Ejecuta el archivo para ver las soluciones.
//
// CÓMO EJECUTAR:
//   node 06_ejercicios.js
//
// =============================================================================

console.log('╔════════════════════════════════════════╗');
console.log('║   EJERCICIOS — MÓDULO 01 FUNDAMENTOS   ║');
console.log('╚════════════════════════════════════════╝\n');

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Presentación personal
// ─────────────────────────────────────────────────────────────────────────────
//
// Crea variables para tu nombre, edad, ciudad y profesión.
// Luego imprime una presentación usando un template literal.
// Usa const para los datos que no van a cambiar.

console.log('─── EJERCICIO 1: Presentación personal ───');

// Solución:
const miNombre = 'Alejandro';
const miEdad = 30;
const miCiudad = 'Lima';
const miProfesion = 'Desarrollador de software';

const presentacion = `Me llamo ${miNombre}, tengo ${miEdad} años.
Vivo en ${miCiudad} y trabajo como ${miProfesion}.`;

console.log(presentacion);

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Calculadora básica
// ─────────────────────────────────────────────────────────────────────────────
//
// Crea dos variables numéricas (a y b).
// Imprime los resultados de: suma, resta, multiplicación, división,
// módulo y potencia. Muestra también si a es mayor que b.

console.log('\n─── EJERCICIO 2: Calculadora básica ───');

// Solución:
const a = 15;
const b = 4;

console.log(`a = ${a}, b = ${b}`);
console.log(`Suma:           ${a} + ${b} = ${a + b}`);
console.log(`Resta:          ${a} - ${b} = ${a - b}`);
console.log(`Multiplicación: ${a} × ${b} = ${a * b}`);
console.log(`División:       ${a} / ${b} = ${a / b}`);
console.log(`Módulo:         ${a} % ${b} = ${a % b} (resto de la división entera)`);
console.log(`Potencia:       ${a} ** ${b} = ${a ** b}`);
console.log(`¿a > b?         ${a > b}`);

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3: Inspector de tipos
// ─────────────────────────────────────────────────────────────────────────────
//
// Crea un arreglo con valores de diferentes tipos:
// un string, un number, un boolean, null, undefined y un objeto.
// Itera e imprime cada valor junto con su tipo usando typeof.

console.log('\n─── EJERCICIO 3: Inspector de tipos ───');

// Solución:
const valores = [
  'texto',
  42,
  true,
  null,
  undefined,
  { clave: 'valor' },
];

valores.forEach((val, indice) => {
  // typeof null devuelve "object" (bug histórico de JS)
  const tipo = typeof val;
  // Verificación especial para null ya que typeof null === "object"
  const tipoReal = val === null ? 'null' : tipo;
  console.log(`valores[${indice}] = ${JSON.stringify(val)} → tipo: ${tipoReal}`);
});

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4: Conversor de temperatura
// ─────────────────────────────────────────────────────────────────────────────
//
// Crea una función que convierta grados Celsius a Fahrenheit.
// Fórmula: F = (C × 9/5) + 32
// Pruébala con: 0°C, 100°C, -40°C, 37°C

console.log('\n─── EJERCICIO 4: Conversor de temperatura ───');

/**
 * Convierte grados Celsius a Fahrenheit.
 * @param {number} celsius - Temperatura en grados Celsius.
 * @returns {number} Temperatura equivalente en grados Fahrenheit.
 */
const celsiusAFahrenheit = (celsius) => (celsius * 9) / 5 + 32;

const temperaturas = [0, 100, -40, 37];

temperaturas.forEach((c) => {
  const f = celsiusAFahrenheit(c);
  console.log(`${c}°C = ${f}°F`);
});

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5: Tarjeta de presentación
// ─────────────────────────────────────────────────────────────────────────────
//
// Genera una "tarjeta de presentación" de texto usando un template literal
// multilínea. Debe incluir: nombre, título, empresa, email y sitio web.
// Usa variables para todos los datos y dibuja bordes con caracteres ASCII.

console.log('\n─── EJERCICIO 5: Tarjeta de presentación ───');

// Solución:
const cardNombre = 'María González';
const cardTitulo = 'Ingeniería de Software';
const cardEmpresa = 'TechCorp S.A.';
const cardEmail = 'maria.gonzalez@techcorp.com';
const cardWeb = 'www.techcorp.com/maria';

const tarjeta = `
┌──────────────────────────────────────────┐
│                                          │
│  ${cardNombre.padEnd(40)}│
│  ${cardTitulo.padEnd(40)}│
│                                          │
│  🏢 ${cardEmpresa.padEnd(37)}│
│  📧 ${cardEmail.padEnd(37)}│
│  🌐 ${cardWeb.padEnd(37)}│
│                                          │
└──────────────────────────────────────────┘
`.trim();

console.log(tarjeta);

// ─────────────────────────────────────────────────────────────────────────────
// RESUMEN DE CONCEPTOS PRACTICADOS
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n═══ Conceptos practicados en este módulo ═══');
console.log('✅ console.log, console.error, console.table');
console.log('✅ const y let (sin var)');
console.log('✅ Tipos de datos: string, number, boolean, null, undefined');
console.log('✅ typeof para verificar tipos');
console.log('✅ Template literals con ${}');
console.log('✅ Template literals multilínea');
console.log('✅ Arrow functions básicas');

// =============================================================================
// EXPERIMENTA:
// 1. Modifica el ejercicio 1 con tus datos reales
// 2. En el ejercicio 2, agrega división entera: Math.floor(a / b)
// 3. En el ejercicio 4, crea también la función inversa (Fahrenheit → Celsius)
// 4. En el ejercicio 5, agrega más datos a la tarjeta (teléfono, LinkedIn)
// 5. Crea un ejercicio propio: genera una factura con productos y precios
// =============================================================================
