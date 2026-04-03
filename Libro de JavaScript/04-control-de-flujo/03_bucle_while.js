// ============================================================
// ARCHIVO: 03_bucle_while.js
// TEMA: while, do...while, cuándo usarlos, bucles infinitos, every/some
// CÓMO EJECUTAR: node 03_bucle_while.js
// ============================================================

// ── while ────────────────────────────────────────────────────
// Repite mientras la condición sea verdadera
// La condición se evalúa ANTES de ejecutar el cuerpo
// Si la condición es falsa desde el inicio, el cuerpo NO se ejecuta
console.log("=== while ===");

let contador = 0;
while (contador < 5) {
  process.stdout.write(contador + " ");
  contador++; // importante: avanzar para no crear bucle infinito
}
console.log();

// Consumir elementos de un array con while
const tareas = ["tarea1", "tarea2", "tarea3"];
while (tareas.length > 0) {
  const tarea = tareas.shift(); // elimina y retorna el primer elemento
  console.log("Procesando:", tarea);
}
console.log("Tareas restantes:", tareas.length); // 0

// ── do...while ───────────────────────────────────────────────
// Ejecuta el cuerpo AL MENOS UNA VEZ y luego verifica la condición
// Útil cuando necesitas que el código se ejecute antes de la primera verificación
console.log("\n=== do...while ===");

let intentos = 0;
do {
  intentos++;
  console.log("Intento número:", intentos);
} while (intentos < 3);
// Se ejecuta 3 veces

// Ejemplo claro: el cuerpo se ejecuta aunque la condición sea false desde el inicio
let ejecutado = false;
do {
  console.log("do...while ejecuta aunque la condición sea falsa");
  ejecutado = true;
} while (false); // condición siempre falsa — pero el cuerpo se ejecutó una vez

// ── Cuándo usar while vs for ──────────────────────────────────
// for: cuando conoces el número de iteraciones de antemano
// while: cuando la condición depende de algo que puede cambiar de formas impredecibles

console.log("\n=== while vs for: cuándo usar cada uno ===");

// for: recorrer 10 elementos — sabemos la cantidad
for (let i = 0; i < 10; i++) {
  process.stdout.write(i + " ");
}
console.log();

// while: leer hasta encontrar un valor especial — no sabemos cuándo
const datos = [3, 7, 2, 9, -1, 5, 8]; // -1 indica fin de datos
let indice = 0;
let suma = 0;
while (datos[indice] !== -1) {
  suma += datos[indice];
  indice++;
}
console.log("Suma hasta -1:", suma); // 3+7+2+9 = 21

// ── Bucles infinitos con while(true) ─────────────────────────
// while(true) es un bucle que nunca termina por sí solo
// Tiene sentido cuando: servidores, event loops, juegos, CLI interactivo
// SIEMPRE debe tener un break interno para salir

console.log("\n=== while(true) con break ===");

let numero = 1;
while (true) {
  if (numero > 5) break; // condición de salida explícita
  process.stdout.write(numero + " ");
  numero++;
}
console.log();

// Patrón común: reintentar hasta éxito (simulado)
let exito = false;
let intentosConexion = 0;
while (true) {
  intentosConexion++;
  // Simula que tiene éxito al 3er intento
  if (intentosConexion === 3) exito = true;
  if (exito) {
    console.log("Conectado en el intento:", intentosConexion);
    break;
  }
  console.log("Reintentando... intento", intentosConexion);
}

// ── Array.every() y Array.some() como alternativas declarativas ──
// Evitan bucles explícitos cuando solo necesitas verificar una condición
console.log("\n=== every() y some() como alternativas ===");

const edades = [22, 31, 19, 45, 28];

// every(): retorna true si TODOS los elementos cumplen la condición
// Equivale a un while que busca el primer falso
const todosMayores = edades.every(edad => edad >= 18);
console.log("Todos mayores de 18:", todosMayores); // true

// some(): retorna true si AL MENOS UNO cumple la condición
// Equivale a un while que busca el primer verdadero
const algunoJoven = edades.some(edad => edad < 25);
console.log("Alguno menor de 25:", algunoJoven); // true

// Sin every/some — forma imperativa equivalente (menos clara)
let todosMayoresImperativo = true;
for (const edad of edades) {
  if (edad < 18) {
    todosMayoresImperativo = false;
    break;
  }
}
console.log("Imperativo:", todosMayoresImperativo); // mismo resultado, más código

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea un do...while que pida números hasta recibir 0 (simula la entrada)
// 2. Usa while(true) con break para encontrar el primer número primo > 100
// 3. Reescribe el bucle "suma hasta -1" usando findIndex() de arrays
// 4. Combina every() y some() para validar que todos los emails tienen "@"
