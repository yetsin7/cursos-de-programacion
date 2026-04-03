// ============================================================
// ARCHIVO: 02_comparacion.js
// TEMA: Operadores de comparación en JavaScript
// CÓMO EJECUTAR: node 02_comparacion.js
// ============================================================

// ── Igualdad débil (==) vs igualdad estricta (===) ───────────
// == realiza coerción de tipos antes de comparar → resultados inesperados
// === compara valor Y tipo → SIEMPRE preferir esta

console.log("=== == vs === ===");
console.log(1 == "1");      // true  — coerción convierte "1" a número
console.log(1 === "1");     // false — tipos distintos: number vs string
console.log(0 == false);    // true  — false se convierte a 0
console.log(0 === false);   // false — number vs boolean
console.log(null == undefined);  // true  — caso especial de ==
console.log(null === undefined); // false — tipos distintos

// Regla de oro: usa SIEMPRE === salvo que explícitamente necesites coerción
// (raro en código real)

// ── Desigualdad != vs !== ─────────────────────────────────────
console.log("\n=== != vs !== ===");
console.log(1 != "1");   // false — coerción dice que son "iguales"
console.log(1 !== "1");  // true  — diferentes tipos → son distintos
console.log(5 != 10);    // true
console.log(5 !== 10);   // true

// ── Comparadores relacionales < > <= >= ───────────────────────
console.log("\n=== Relacionales ===");
console.log(5 > 3);    // true
console.log(5 < 3);    // false
console.log(5 >= 5);   // true
console.log(4 <= 3);   // false

// Con números mixtos (JS hace coerción con < > también)
console.log("10" > 9);  // true — "10" se convierte a número
console.log("10" > "9"); // false — comparación de strings: '1' < '9' en Unicode

// ── Comparación de strings con < y > ─────────────────────────
// JS compara strings carácter a carácter usando códigos Unicode (UTF-16)
console.log("\n=== Comparación de strings ===");
console.log("a" < "b");   // true  — código de 'a' es 97, 'b' es 98
console.log("z" > "a");   // true
console.log("B" < "a");   // true  — mayúsculas tienen códigos menores que minúsculas
console.log("banana" > "apple"); // true — 'b' > 'a'

// Problema: el orden Unicode no sirve para idiomas naturales con acentos
const palabras = ["árbol", "zapato", "ángel", "casa"];
console.log("\nOrden incorrecto (Unicode):");
console.log([...palabras].sort()); // orden incorrecto para español

// ── localeCompare(): comparación correcta para idiomas naturales ──
// localeCompare toma en cuenta acentos, ñ, mayúsculas/minúsculas según el idioma
console.log("\nOrden correcto con localeCompare (español):");
const ordenCorrecto = [...palabras].sort((a, b) =>
  a.localeCompare(b, "es", { sensitivity: "base" })
);
console.log(ordenCorrecto); // ['ángel', 'árbol', 'casa', 'zapato']

// Comparar dos strings individuales con localeCompare
console.log("\n'árbol' vs 'casa':");
console.log("árbol".localeCompare("casa", "es")); // número negativo → árbol va antes

// ── Object.is(): comparación especial para casos raros ────────
// Object.is(a, b) es como === pero maneja correctamente NaN y -0
console.log("\n=== Object.is() — casos especiales ===");

// Caso 1: NaN
console.log(NaN === NaN);        // false — NaN no es igual a nada, ni a sí mismo
console.log(Object.is(NaN, NaN)); // true  — Object.is lo maneja correctamente

// Caso 2: cero negativo (-0)
console.log(-0 === 0);            // true  — === no distingue -0 de +0
console.log(Object.is(-0, 0));    // false — Object.is sí los distingue
console.log(Object.is(-0, -0));   // true

// Resumen: cuándo usar cada uno
// ===         → uso general, siempre preferir sobre ==
// ==          → evitar; solo en casos muy específicos (ej: chequear null/undefined juntos)
// localeCompare → comparar strings para ordenamiento natural/idiomático
// Object.is   → cuando necesitas distinguir NaN o -0 explícitamente

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Prueba comparar [] == false, [] === false
// 2. ¿Qué devuelve null > 0, null == 0, null >= 0? (resultado sorprendente)
// 3. Ordena un array de nombres con tildes usando localeCompare
// 4. Usa Number.isNaN() como alternativa a Object.is(NaN, val)
