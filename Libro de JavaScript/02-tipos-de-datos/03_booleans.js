// =============================================================================
// ARCHIVO: 03_booleans.js
// TEMA: Booleans, truthy/falsy, operadores lógicos y cortocircuito
// =============================================================================
//
// Los booleanos son simples: true o false. Pero JavaScript los hace complejos
// porque CUALQUIER valor puede comportarse como booleano en un contexto lógico.
// Entender qué valores son "truthy" y cuáles son "falsy" es FUNDAMENTAL — es
// uno de los temas más importantes y usados en el desarrollo con JavaScript.
//
// CÓMO EJECUTAR:
//   node 03_booleans.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Booleanos básicos
// ─────────────────────────────────────────────────────────────────────────────

const activo = true;
const bloqueado = false;

console.log('--- Booleanos ---');
console.log(activo, typeof activo);
console.log(bloqueado, typeof bloqueado);

// Las comparaciones retornan booleanos
console.log(5 > 3);      // true
console.log(5 === 5);    // true
console.log(5 !== 3);    // true
console.log(10 < 5);     // false

// ─────────────────────────────────────────────────────────────────────────────
// 2. Valores FALSY — Los 8 valores que se comportan como false
// ─────────────────────────────────────────────────────────────────────────────

// ¡MEMORIZA ESTOS! Son los ÚNICOS 8 valores falsy en JavaScript.
// Cualquier otro valor (incluyendo objetos y arrays vacíos) es truthy.

console.log('\n--- Valores FALSY ---');
const valoresFalsy = [false, 0, -0, 0n, '', "", ``, null, undefined, NaN];
// Nota: NaN es el 9no que los desarrolladores siempre olvidan listar

valoresFalsy.forEach((val) => {
  // !! convierte cualquier valor a su equivalente booleano
  console.log(`${JSON.stringify(val) ?? String(val)} → ${!!val}`);
});

// ─────────────────────────────────────────────────────────────────────────────
// 3. Valores TRUTHY — Todo lo que no es falsy
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Valores TRUTHY (ejemplos) ---');
const valoresTruthy = [true, 1, -1, 'a', ' ', '0', [], {}, function(){}, Infinity];

valoresTruthy.forEach((val) => {
  console.log(`${JSON.stringify(val) ?? String(val)} → ${!!val}`);
});

// TRAMPA COMÚN: '0' y [] son TRUTHY
console.log('\n¡Trampas comunes!');
console.log('"0" es truthy:', !!'0');    // true — string no vacío
console.log('[] es truthy:', !![]);      // true — array vacío = truthy
console.log('{} es truthy:', !!{});      // true — objeto vacío = truthy
console.log('"" es falsy:', !!'');       // false — string vacío = falsy

// ─────────────────────────────────────────────────────────────────────────────
// 4. El operador !! para convertir a boolean explícitamente
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Doble negación !! ---');
// ! niega el booleano. !! lo niega dos veces = conversión a boolean
const nombre = 'Ana';
const sinNombre = '';

console.log(!nombre);   // false (nombre es truthy, negado = false)
console.log(!!nombre);  // true  (truthy → boolean true)
console.log(!!sinNombre); // false (falsy → boolean false)

// Uso práctico: verificar si existe un valor
const usuario = { nombre: 'Luis', email: '' };
console.log('¿Tiene nombre?', !!usuario.nombre);   // true
console.log('¿Tiene email?', !!usuario.email);     // false (string vacío es falsy)

// Boolean() es equivalente a !! pero más legible en algunos contextos
console.log(Boolean(usuario.nombre)); // true
console.log(Boolean(usuario.email));  // false

// ─────────────────────────────────────────────────────────────────────────────
// 5. Operadores lógicos && y ||
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- && (AND) ---');
// && retorna el PRIMER valor FALSY que encuentra, o el último valor si todos son truthy
console.log(true && true);      // true
console.log(true && false);     // false
console.log(1 && 2);            // 2 (ambos truthy → retorna el último)
console.log(0 && 'hola');       // 0 (primer falsy encontrado)
console.log('hola' && 42);      // 42 (ambos truthy → retorna el último)

console.log('\n--- || (OR) ---');
// || retorna el PRIMER valor TRUTHY que encuentra, o el último si todos son falsy
console.log(false || true);     // true
console.log(false || false);    // false
console.log(0 || 'hola');       // 'hola' (primer truthy)
console.log('' || 42);          // 42 (primer truthy)
console.log(null || undefined); // undefined (ambos falsy → retorna el último)

// ─────────────────────────────────────────────────────────────────────────────
// 6. Short-circuit (cortocircuito) — Evaluación perezosa
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Short-circuit ---');

// && deja de evaluar cuando encuentra un falsy (no ejecuta lo que sigue)
// Uso común: ejecutar algo SÓLO SI una condición es verdadera
const estaLogueado = true;
estaLogueado && console.log('Usuario logueado — mostrar dashboard');

const sinPermiso = false;
sinPermiso && console.log('Esto NO se imprime'); // No se ejecuta

// || deja de evaluar cuando encuentra un truthy (no evalúa lo que sigue)
// Uso común: valor por defecto
const nombreUsuario = null;
const nombreMostrado = nombreUsuario || 'Invitado';
console.log('Nombre a mostrar:', nombreMostrado); // 'Invitado'

// ─────────────────────────────────────────────────────────────────────────────
// 7. Nullish coalescing ?? — Diferencia crucial con ||
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- ?? (Nullish coalescing) ---');
// ?? solo activa el valor por defecto si el lado izquierdo es NULL o UNDEFINED
// || activa el valor por defecto si el lado izquierdo es CUALQUIER FALSY

const config = {
  volumen: 0,      // El usuario estableció 0 intencionalmente
  nombre: '',      // El usuario dejó el nombre en blanco intencionalmente
  tema: null,      // No configurado
};

// PROBLEMA con ||: 0 y '' son falsy, así que usa el valor por defecto
// aunque el usuario los haya establecido intencionalmente
console.log('Volumen con ||:', config.volumen || 50);   // 50 ← incorrecto!
console.log('Nombre con ||:', config.nombre || 'Sin nombre'); // 'Sin nombre' ← incorrecto!

// SOLUCIÓN con ??: sólo usa el defecto si es null o undefined
console.log('Volumen con ??:', config.volumen ?? 50);   // 0 ← correcto!
console.log('Nombre con ??:', config.nombre ?? 'Sin nombre'); // '' ← correcto!
console.log('Tema con ??:', config.tema ?? 'claro');    // 'claro' ← null → usa defecto

// ─────────────────────────────────────────────────────────────────────────────
// 8. Logical assignment operators (ES2021)
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Logical assignment (&&=, ||=, ??=) ---');

let a = true;
let b = false;
let c = null;
let d = 0;

// &&= asigna el lado derecho SÓLO SI el lado izquierdo es truthy
a &&= 'nuevo valor'; // a era true (truthy) → se asigna
b &&= 'nuevo valor'; // b era false (falsy) → no se asigna
console.log('a &&= :', a); // 'nuevo valor'
console.log('b &&= :', b); // false (sin cambio)

// ||= asigna SÓLO SI el lado izquierdo es falsy
let x = null;
let y = 'valor existente';
x ||= 'default';
y ||= 'default';
console.log('x ||= :', x); // 'default'
console.log('y ||= :', y); // 'valor existente' (sin cambio)

// ??= asigna SÓLO SI el lado izquierdo es null o undefined
c ??= 'valor para null';
d ??= 'valor para 0'; // 0 no es null ni undefined
console.log('c ??= :', c); // 'valor para null'
console.log('d ??= :', d); // 0 (sin cambio — 0 no es null/undefined)

// =============================================================================
// EXPERIMENTA:
// 1. ¿Por qué [] == false evalúa a true? Investiga la coerción de tipos
// 2. Usa && para ejecutar una función sólo si un array no está vacío
// 3. Usa ?? para proporcionar valores por defecto en un objeto de configuración
// 4. ¿Qué diferencia hay entre !null y !!null?
// 5. Crea una función que reciba un valor y retorne 'truthy' o 'falsy'
// =============================================================================
