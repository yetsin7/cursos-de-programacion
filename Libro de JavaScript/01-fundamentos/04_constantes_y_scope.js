// =============================================================================
// ARCHIVO: 04_constantes_y_scope.js
// TEMA: Scope de bloque, hoisting y Temporal Dead Zone
// =============================================================================
//
// El scope (alcance) determina desde dónde en el código puedes acceder a una
// variable. Entender el scope es crucial para evitar bugs sutiles. También
// veremos el hoisting (cómo JS procesa las declaraciones antes de ejecutar)
// y la Temporal Dead Zone, que protege const y let de usos accidentales.
//
// CÓMO EJECUTAR:
//   node 04_constantes_y_scope.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Scope global
// ─────────────────────────────────────────────────────────────────────────────

// Las variables declaradas fuera de cualquier función o bloque
// tienen scope global — son accesibles desde cualquier parte del archivo.
const APP_VERSION = '1.0.0';
let contadorGlobal = 0;

// En Node.js el scope "global" es en realidad el módulo (el archivo).
// En el navegador, var global se añade a window, pero const y let no.
console.log('Versión:', APP_VERSION);

// ─────────────────────────────────────────────────────────────────────────────
// 2. Scope de bloque con const y let
// ─────────────────────────────────────────────────────────────────────────────

// Un bloque es cualquier par de llaves {}.
// const y let sólo existen dentro del bloque donde se declaran.

{
  const dentroDelBloque = 'Solo existo aquí';
  let otraVariable = 42;
  console.log('\nDentro del bloque:');
  console.log(dentroDelBloque);
  console.log(otraVariable);
}

// Aquí afuera, las variables del bloque ya no existen.
// Intentar acceder causaría: ReferenceError: dentroDelBloque is not defined
console.log('\nFuera del bloque (las variables de adentro no existen aquí)');

// Lo mismo aplica a bloques de if, for, while, etc.
if (true) {
  const soloEnElIf = 'Existo en este if';
  console.log('\nDentro del if:', soloEnElIf);
}
// console.log(soloEnElIf); // Error si se descomenta

// ─────────────────────────────────────────────────────────────────────────────
// 3. Scope local en funciones
// ─────────────────────────────────────────────────────────────────────────────

// Las variables declaradas dentro de una función son locales a esa función.
// No son accesibles desde afuera (incluso con var, en este caso).

/**
 * Demuestra que las variables locales no son accesibles fuera de la función.
 */
const demostrarScopeLocal = () => {
  const variableLocal = 'Soy local a esta función';
  contadorGlobal += 1; // Sí puede acceder a variables globales
  console.log('\nDentro de la función:', variableLocal);
  console.log('Contador global modificado:', contadorGlobal);
};

demostrarScopeLocal();
console.log('Contador global desde afuera:', contadorGlobal);
// console.log(variableLocal); // Error: variableLocal is not defined

// ─────────────────────────────────────────────────────────────────────────────
// 4. Shadowing — Una variable local "tapa" a una global con el mismo nombre
// ─────────────────────────────────────────────────────────────────────────────

const color = 'azul'; // Variable global

const pintarPared = () => {
  // Esta variable local tiene el mismo nombre que la global.
  // Dentro de esta función, "color" se refiere a la local, no a la global.
  const color = 'rojo'; // Shadow — tapa la global dentro de esta función
  console.log('\nColor dentro de la función (shadow):', color); // "rojo"
};

pintarPared();
console.log('Color global (sin cambios):', color); // "azul"
// Nota: el shadowing no modifica la variable global, sólo la oculta localmente.

// ─────────────────────────────────────────────────────────────────────────────
// 5. Hoisting — Qué "sube" y qué no
// ─────────────────────────────────────────────────────────────────────────────

// JavaScript procesa las declaraciones en dos fases:
// FASE 1 (compilación): registra todas las declaraciones
// FASE 2 (ejecución): ejecuta el código línea por línea
//
// Este proceso hace que ciertas cosas "suban" al inicio del scope.

// Las FUNCTION DECLARATIONS se suben completamente — se pueden llamar antes
// de donde aparecen en el código fuente.
console.log('\n--- Hoisting ---');
console.log(saludar('mundo')); // Funciona aunque saludar está declarada abajo

function saludar(quien) {
  return `Hola, ${quien}!`;
}

// Las function expressions (const/let) NO se suben.
// llamarFlecha(); // Error: Cannot access before initialization
const llamarFlecha = () => 'soy una arrow function';
console.log(llamarFlecha()); // Sí funciona después de la declaración

// var SI se sube pero sólo la declaración, no el valor → valor es undefined
console.log(typeof varConHoisting); // "undefined" (existe pero sin valor)
var varConHoisting = 'valor asignado';
console.log(varConHoisting); // "valor asignado"

// ─────────────────────────────────────────────────────────────────────────────
// 6. Temporal Dead Zone (TDZ)
// ─────────────────────────────────────────────────────────────────────────────

// const y let también se "suben" al inicio del scope durante la compilación,
// pero NO se pueden usar hasta que el código llega a su declaración.
// Este período de "existir pero no poderse usar" se llama TDZ.

// El TDZ protege de bugs: si intentas usar una variable antes de declararla
// con let o const, JavaScript lanza un ReferenceError inmediato.
// Con var, sólo obtienes undefined silenciosamente (más peligroso).

const demostrarTDZ = () => {
  // Aquí la TDZ de "variableTDZ" comienza
  // console.log(variableTDZ); // ReferenceError: Cannot access before initialization
  const variableTDZ = 'Ahora sí existo'; // Fin de la TDZ
  console.log('\nVariable después de TDZ:', variableTDZ);
};

demostrarTDZ();

// ─────────────────────────────────────────────────────────────────────────────
// 7. Regla práctica para el scope
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Resumen de scope ---');
console.log('const/let → scope de bloque (viven dentro de {})');
console.log('var       → scope de función (se escapa de bloques)');
console.log('global    → accesible en todo el archivo');
console.log('Usa siempre const/let para predecir dónde viven tus variables');

// =============================================================================
// EXPERIMENTA:
// 1. Declara una variable con let dentro de un for loop e intenta accederla
//    fuera del loop — observa el error
// 2. Llama una function declaration antes de declararla — funciona
// 3. Intenta llamar una arrow function antes de declararla — falla
// 4. Crea dos funciones con una variable local del mismo nombre y verifica
//    que no se interfieren entre sí
// 5. ¿Puedes modificar una variable global desde dentro de una función?
// =============================================================================
