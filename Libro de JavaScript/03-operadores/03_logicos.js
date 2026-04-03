// ============================================================
// ARCHIVO: 03_logicos.js
// TEMA: Operadores lógicos, short-circuit y nullish coalescing
// CÓMO EJECUTAR: node 03_logicos.js
// ============================================================

// ── Operadores lógicos básicos ────────────────────────────────
console.log("=== && || ! básicos ===");
console.log(true && true);   // true
console.log(true && false);  // false
console.log(false || true);  // true
console.log(false || false); // false
console.log(!true);          // false
console.log(!false);         // true

// ── Short-circuit evaluation (evaluación en cortocircuito) ────
// JS no evalúa el segundo operando si el resultado ya está determinado

// &&: si el primero es falsy → devuelve ESE valor sin evaluar el segundo
// ||: si el primero es truthy → devuelve ESE valor sin evaluar el segundo

console.log("\n=== Short-circuit ===");
// && devuelve el primer valor falsy, o el último si todos son truthy
console.log(0 && "hola");       // 0      — 0 es falsy, se detiene aquí
console.log("" && "mundo");     // ""     — string vacío es falsy
console.log(null && "algo");    // null
console.log("hola" && "mundo"); // "mundo" — "hola" es truthy, sigue y devuelve el último
console.log(1 && 2 && 3);       // 3      — todos truthy → devuelve el último

// || devuelve el primer valor truthy, o el último si todos son falsy
console.log("\n");
console.log(0 || "hola");       // "hola"  — 0 es falsy, busca el siguiente
console.log("" || "default");   // "default"
console.log(null || undefined); // undefined — ambos falsy, devuelve el último
console.log("hola" || "mundo"); // "hola"  — "hola" es truthy, se detiene

// Uso práctico: valores por defecto con ||
const nombre = "" || "Anónimo";
console.log("\nNombre con ||:", nombre); // "Anónimo" — OJO: "" también activa el fallback

// ── Nullish Coalescing ?? ─────────────────────────────────────
// ?? solo activa el fallback si el valor es null o undefined
// DIFERENCIA CLAVE con ||: 0, "" y false NO activan el fallback en ??

console.log("\n=== ?? Nullish Coalescing ===");
const valorA = 0 ?? "default";
const valorB = 0 || "default";
console.log("0 ?? 'default':", valorA);   // 0       — 0 no es null/undefined
console.log("0 || 'default':", valorB);   // "default" — 0 es falsy, activa ||

const valorC = "" ?? "vacío";
const valorD = "" || "vacío";
console.log('"" ?? "vacío":', valorC);   // ""       — string vacío no es null/undefined
console.log('"" || "vacío":', valorD);   // "vacío"  — string vacío activa ||

const valorE = null ?? "por defecto";
console.log("null ??:", valorE);          // "por defecto" — null sí activa ??

const valorF = undefined ?? "fallback";
console.log("undefined ??:", valorF);     // "fallback"

// Regla: usa ?? cuando 0 o "" son valores válidos que no quieres reemplazar

// ── Logical Assignment Operators (ES2021) ─────────────────────
// Combinan una operación lógica con asignación
console.log("\n=== Logical Assignment ===");

// &&= : asigna solo si el valor actual es truthy
let usuario = { nombre: "Ana", activo: true };
usuario.nombre &&= "Ana García"; // nombre es truthy → se asigna
console.log("&&= truthy:", usuario.nombre); // "Ana García"

let sinNombre = { nombre: "" };
sinNombre.nombre &&= "Otro"; // nombre es falsy → NO se asigna
console.log("&&= falsy:", sinNombre.nombre); // "" — sin cambio

// ||= : asigna solo si el valor actual es falsy
let config = { tema: "" };
config.tema ||= "claro"; // tema es "" (falsy) → se asigna
console.log("||=:", config.tema); // "claro"

let config2 = { tema: "oscuro" };
config2.tema ||= "claro"; // tema es truthy → NO se asigna
console.log("||= no cambia:", config2.tema); // "oscuro"

// ??= : asigna solo si el valor actual es null o undefined
let opciones = { timeout: 0 };
opciones.timeout ??= 3000; // 0 no es null/undefined → NO se asigna
console.log("??= no cambia 0:", opciones.timeout); // 0

let opciones2 = { timeout: null };
opciones2.timeout ??= 3000; // null → sí se asigna
console.log("??= null:", opciones2.timeout); // 3000

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Usa && para ejecutar una función solo si un objeto existe: obj && obj.guardar()
// 2. Compara ?? con || cuando el valor es false
// 3. Combina ?? con ?.: obj?.propiedad ?? "sin valor"
// 4. Usa ??= para inicializar propiedades de configuración de forma segura
