// ============================================================
// ARCHIVO: 01_if_else.js
// TEMA: Condicionales: if/else, switch, ternario, ?. y ??
// CÓMO EJECUTAR: node 01_if_else.js
// ============================================================

// ── if / else if / else ───────────────────────────────────────
// Ejecuta un bloque de código según si la condición es verdadera
console.log("=== if / else if / else ===");

const temperatura = 22;

if (temperatura > 30) {
  console.log("Hace calor");
} else if (temperatura >= 20) {
  console.log("Temperatura agradable"); // se ejecuta este
} else {
  console.log("Hace frío");
}

// Condición con múltiples valores
const hora = 14;
let saludo;

if (hora < 12) {
  saludo = "Buenos días";
} else if (hora < 18) {
  saludo = "Buenas tardes"; // hora 14 → este
} else {
  saludo = "Buenas noches";
}
console.log(saludo); // "Buenas tardes"

// ── Operador ternario ─────────────────────────────────────────
// condicion ? valorSiVerdadero : valorSiFalso
// Ideal para asignaciones simples de una línea
console.log("\n=== Ternario ===");

const edad = 20;
const acceso = edad >= 18 ? "Permitido" : "Denegado";
console.log(acceso); // "Permitido"

// Ternario en JSX / strings template
const puntos = 85;
console.log(`Estado: ${puntos >= 60 ? "Aprobado" : "Reprobado"}`);

// ternario anidado: válido pero evitar más de 2 niveles
const nota = puntos >= 90 ? "Excelente" : puntos >= 70 ? "Bien" : "Regular";
console.log("Nota:", nota); // "Bien"

// ── switch ───────────────────────────────────────────────────
// Útil cuando comparas el mismo valor contra múltiples opciones fijas
console.log("\n=== switch ===");

const diaSemana = 3; // 1=Lunes ... 7=Domingo

switch (diaSemana) {
  case 1:
    console.log("Lunes");
    break;
  case 2:
    console.log("Martes");
    break;
  case 3:
    console.log("Miércoles"); // se ejecuta este
    break;
  case 6:
  case 7:
    // Fall-through intencional: mismo bloque para sábado y domingo
    console.log("Fin de semana");
    break;
  default:
    console.log("Otro día");
}

// ── Fall-through en switch — cómo evitarlo ────────────────────
// Sin break, la ejecución "cae" al siguiente case aunque no coincida
console.log("\n=== Fall-through ===");

const nivel = "B";
switch (nivel) {
  case "A":
    console.log("Nivel A");
    // FALTA break → cae al siguiente
  case "B":
    console.log("Nivel B"); // se ejecuta
    // FALTA break → cae al siguiente
  case "C":
    console.log("Nivel C"); // también se ejecuta (no era intención)
    break;
  default:
    console.log("Sin nivel");
}
// Imprime: "Nivel B" y "Nivel C" → problema por fall-through accidental
// Solución: agregar break al final de cada case

// switch con strings
const comando = "iniciar";
switch (comando) {
  case "iniciar":
    console.log("Iniciando...");
    break;
  case "detener":
    console.log("Deteniendo...");
    break;
  default:
    console.log("Comando desconocido");
}

// ── Optional chaining ?. como alternativa a if (obj && obj.prop) ──
// Evita el clásico "TypeError: Cannot read property of null"
console.log("\n=== Optional chaining ?.  ===");

const usuario = { nombre: "Lucía", direccion: { ciudad: "Lima" } };
const usuarioSinDireccion = { nombre: "Pedro" };

// Forma antigua (verbosa)
const ciudadAntiguo = usuario && usuario.direccion && usuario.direccion.ciudad;
console.log("Antiguo:", ciudadAntiguo); // "Lima"

// Forma moderna con ?.
const ciudad1 = usuario?.direccion?.ciudad;
const ciudad2 = usuarioSinDireccion?.direccion?.ciudad;
console.log("?.:", ciudad1); // "Lima"
console.log("?. sin datos:", ciudad2); // undefined — sin error

// ── Nullish coalescing ?? como alternativa a if (val === null || ...) ──
console.log("\n=== Nullish coalescing ?? ===");

// Forma antigua
function obtenerNombreAntiguo(val) {
  if (val === null || val === undefined) return "Anónimo";
  return val;
}

// Forma moderna con ??
const nombre1 = null ?? "Anónimo";
const nombre2 = undefined ?? "Anónimo";
const nombre3 = "" ?? "Anónimo"; // "" es válido — no se reemplaza
const nombre4 = 0 ?? "Anónimo"; // 0 es válido — no se reemplaza

console.log(nombre1, nombre2, nombre3, nombre4); // Anónimo Anónimo ""  0

// Combinación ?. con ??
const empresa = null;
const nombreEmpresa = empresa?.nombre ?? "Sin empresa";
console.log(nombreEmpresa); // "Sin empresa"

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Reescribe el bloque if/else de temperatura usando switch con rangos
// 2. Prueba un switch sin ningún break para ver el fall-through completo
// 3. Crea un objeto profundamente anidado y accede a 4 niveles con ?.
// 4. Combina ?. y ?? en una sola expresión para obtener un valor por defecto
