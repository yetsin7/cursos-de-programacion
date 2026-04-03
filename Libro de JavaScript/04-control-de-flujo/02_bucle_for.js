// ============================================================
// ARCHIVO: 02_bucle_for.js
// TEMA: Bucles for clásico, for...of, for...in, forEach, for await...of
// CÓMO EJECUTAR: node 02_bucle_for.js
// ============================================================

// ── for clásico ───────────────────────────────────────────────
// Útil cuando necesitas el índice o control preciso sobre la iteración
console.log("=== for clásico ===");

for (let i = 0; i < 5; i++) {
  process.stdout.write(i + " "); // 0 1 2 3 4
}
console.log();

// Recorrer un array con índice
const colores = ["rojo", "verde", "azul"];
for (let i = 0; i < colores.length; i++) {
  console.log(`[${i}] ${colores[i]}`);
}

// Iterar en reversa
for (let i = colores.length - 1; i >= 0; i--) {
  process.stdout.write(colores[i] + " ");
}
console.log();

// ── for...of ─────────────────────────────────────────────────
// Itera sobre los VALORES de cualquier iterable
// Preferir sobre el for clásico cuando no necesitas el índice
console.log("\n=== for...of ===");

// Con arrays
for (const color of colores) {
  process.stdout.write(color + " ");
}
console.log();

// Con strings (itera carácter a carácter)
for (const char of "Hola") {
  process.stdout.write(char + "-");
}
console.log();

// Con entries() para tener índice y valor juntos
for (const [indice, valor] of colores.entries()) {
  console.log(`${indice}: ${valor}`);
}

// Con Map
const mapa = new Map([["a", 1], ["b", 2], ["c", 3]]);
for (const [clave, valor] of mapa) {
  console.log(`${clave} → ${valor}`);
}

// Con Set (valores únicos)
const conjunto = new Set([10, 20, 30, 20, 10]);
for (const num of conjunto) {
  process.stdout.write(num + " "); // 10 20 30 — sin duplicados
}
console.log();

// ── for...in ─────────────────────────────────────────────────
// Itera sobre las CLAVES enumerables de un objeto
// ADVERTENCIA: no usar con arrays — el orden no está garantizado
//              y recorre también propiedades heredadas del prototipo
console.log("\n=== for...in ===");

const persona = { nombre: "Carlos", edad: 28, ciudad: "Medellín" };
for (const clave in persona) {
  console.log(`${clave}: ${persona[clave]}`);
}

// Uso seguro: filtrar propiedades propias vs heredadas
for (const clave in persona) {
  if (Object.hasOwn(persona, clave)) {
    // Solo propiedades propias del objeto, no del prototipo
    console.log("Propia:", clave);
  }
}

// Preferir Object.keys() si solo necesitas las claves propias
console.log("Claves con Object.keys:", Object.keys(persona));

// ── Array.forEach() ───────────────────────────────────────────
// Alternativa funcional al for clásico — ejecuta una función por cada elemento
// LIMITACIÓN: no se puede usar break ni continue; no retorna valores
console.log("\n=== forEach ===");

const numeros = [1, 2, 3, 4, 5];
numeros.forEach((num, indice) => {
  process.stdout.write(`[${indice}]${num} `);
});
console.log();

// forEach no retorna nada (siempre undefined)
const resultado = numeros.forEach(n => n * 2);
console.log("forEach retorna:", resultado); // undefined

// Para transformar datos usa map() en su lugar:
const dobles = numeros.map(n => n * 2);
console.log("map retorna:", dobles);

// ── Diferencia práctica for...of vs for...in ──────────────────
console.log("\n=== for...of vs for...in con arrays ===");

const letras = ["x", "y", "z"];

console.log("for...of (valores):");
for (const val of letras) {
  process.stdout.write(val + " "); // x y z
}
console.log();

console.log("for...in (claves/índices):");
for (const idx in letras) {
  process.stdout.write(idx + " "); // 0 1 2
}
console.log();
// → for...of da los valores, for...in da los índices como strings

// ── for await...of — adelanto de asincronía ───────────────────
// Itera sobre un iterable asíncrono (streams, generadores async, etc.)
// Se profundizará en el módulo 10-async-js
console.log("\n=== for await...of (adelanto) ===");

// Función auxiliar que simula un generador asíncrono
async function* generadorAsync() {
  yield 1;
  yield 2;
  yield 3;
}

// Se debe llamar dentro de una función async
async function demostrarForAwait() {
  for await (const valor of generadorAsync()) {
    process.stdout.write(valor + " ");
  }
  console.log();
}

demostrarForAwait();

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Usa for...of con entries() para mostrar índice y valor de un string
// 2. Agrega una propiedad al prototipo de Object y observa que for...in la recorre
// 3. Intenta usar break dentro de forEach — observa que lanza error
// 4. Reescribe el forEach anterior usando for...of y verifica si puedes hacer break
