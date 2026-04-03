// ============================================================
// ARCHIVO: 04_break_continue.js
// TEMA: break, continue, labels para bucles anidados
// CÓMO EJECUTAR: node 04_break_continue.js
// ============================================================

// ── break: salir del bucle completamente ─────────────────────
// Termina la ejecución del bucle inmediatamente
// Control regresa a la instrucción siguiente al bucle
console.log("=== break ===");

const numeros = [1, 4, 7, 3, 9, 2, 8, 5];

// Encontrar el primer número mayor a 6
let encontrado = null;
for (const num of numeros) {
  if (num > 6) {
    encontrado = num;
    break; // sale del bucle al encontrar el primero
  }
}
console.log("Primer número > 6:", encontrado); // 7

// break en while
let i = 0;
while (true) {
  if (i >= 5) break;
  process.stdout.write(i + " ");
  i++;
}
console.log();

// break en switch (ya visto, pero importante recordarlo)
const estado = "activo";
switch (estado) {
  case "activo":
    console.log("Sistema activo");
    break; // sin este break, caería al siguiente case
  case "inactivo":
    console.log("Sistema inactivo");
    break;
}

// ── continue: saltar a la siguiente iteración ────────────────
// No termina el bucle — omite el resto del código en esa iteración
// y salta directamente a la siguiente
console.log("\n=== continue ===");

// Imprimir solo números pares
for (let n = 0; n < 10; n++) {
  if (n % 2 !== 0) continue; // salta los impares
  process.stdout.write(n + " ");
}
console.log(); // 0 2 4 6 8

// Procesar lista ignorando valores inválidos
const valores = [10, null, 20, undefined, 30, NaN, 40];
const procesados = [];
for (const val of valores) {
  if (val == null || Number.isNaN(val)) continue; // salta nulos y NaN
  procesados.push(val * 2);
}
console.log("Procesados:", procesados); // [20, 40, 60, 80]

// ── Labels: controlar bucles anidados ────────────────────────
// Un label es un identificador seguido de ":" antes de un bucle
// Permite que break y continue apunten a un bucle específico
console.log("\n=== Labels ===");

// Problema sin labels: break solo sale del bucle INTERNO
console.log("Sin label — break solo sale del bucle interno:");
for (let fila = 0; fila < 3; fila++) {
  for (let col = 0; col < 3; col++) {
    if (fila === 1 && col === 1) break; // sale del for interno
    process.stdout.write(`(${fila},${col}) `);
  }
}
console.log();

// ── break label: salir de un bucle externo ───────────────────
console.log("\nCon break label — sale del bucle EXTERNO:");

// El label se escribe antes del bucle que queremos controlar
bucleExterno: for (let fila = 0; fila < 3; fila++) {
  for (let col = 0; col < 3; col++) {
    if (fila === 1 && col === 1) break bucleExterno; // sale del bucle externo
    process.stdout.write(`(${fila},${col}) `);
  }
}
console.log();

// ── continue label: saltar iteración del bucle externo ───────
console.log("\nCon continue label — salta iteración del bucle EXTERNO:");

bucleFilas: for (let fila = 0; fila < 3; fila++) {
  for (let col = 0; col < 3; col++) {
    if (col === 1) continue bucleFilas; // salta al siguiente fila
    process.stdout.write(`(${fila},${col}) `);
  }
}
console.log();
// Solo imprime col=0 de cada fila porque al llegar a col=1 salta a la siguiente fila

// ── Cuándo preferir métodos funcionales ──────────────────────
// Los métodos de array suelen ser más claros y evitan la necesidad de break/continue
console.log("\n=== Alternativas funcionales a break/continue ===");

const productos = [
  { nombre: "Manzana", precio: 1.5, disponible: true },
  { nombre: "Naranja", precio: 2.0, disponible: false },
  { nombre: "Pera", precio: 1.8, disponible: true },
  { nombre: "Uva", precio: 3.0, disponible: true },
];

// Equivalente a for + continue (filtrar no disponibles)
const disponibles = productos.filter(p => p.disponible);
console.log("Disponibles:", disponibles.map(p => p.nombre));

// Equivalente a for + break (encontrar el primero que cumple)
const primeroCaro = productos.find(p => p.precio > 2.0);
console.log("Primero con precio > 2:", primeroCaro?.nombre);

// Consejo: usa métodos funcionales cuando el código sea más claro
// Usa break/continue cuando necesites control preciso o el bucle es complejo

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Usa break label para salir de 3 niveles de bucles anidados
// 2. Reescribe el ejemplo de "valores procesados" usando filter() y map()
// 3. Compara legibilidad: for + continue vs filter() para el mismo problema
// 4. Crea una tabla de multiplicar 5x5 y usa continue label para saltar la diagonal
