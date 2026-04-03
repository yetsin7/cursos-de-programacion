// =============================================================================
// ARCHIVO: 03_spread_y_merge.js
// TEMA: Spread, merge de objetos, shallow vs deep copy, structuredClone
// =============================================================================
// CÓMO EJECUTAR: node 03_spread_y_merge.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. SPREAD PARA COPIAR OBJETOS (SHALLOW COPY)
// -----------------------------------------------------------------------------

console.log('=== SPREAD — COPIA SHALLOW ===');

const original = {
  nombre: 'Ana',
  edad: 28,
  ciudad: 'Madrid',
};

// Spread: crea un nuevo objeto con las mismas propiedades
const copia = { ...original };
copia.nombre = 'Carlos'; // modifica solo la copia

console.log('Original:', original); // 'Ana' — no se modificó
console.log('Copia:   ', copia);    // 'Carlos'

// Demostrar que las propiedades primitivas son independientes
console.log('¿Son el mismo objeto?', original === copia); // false

// ADVERTENCIA: es copia SHALLOW — objetos anidados siguen siendo la misma referencia
const conObjeto = {
  nombre: 'Eva',
  config: { tema: 'oscuro', idioma: 'es' },
};
const copiaShallow = { ...conObjeto };
copiaShallow.config.tema = 'claro'; // ¡modifica el original también!
copiaShallow.nombre = 'Luis';       // esto sí es independiente

console.log('\nPeligro shallow:');
console.log('Original:', conObjeto);    // config.tema cambió a 'claro'
console.log('Copia:   ', copiaShallow);

// -----------------------------------------------------------------------------
// 2. MERGE DE OBJETOS CON SPREAD
// -----------------------------------------------------------------------------

console.log('\n=== MERGE DE OBJETOS ===');

const base = { color: 'azul', tamaño: 'M', precio: 20 };
const extras = { descuento: 0.1, envioGratis: true, precio: 18 };

// Merge: propiedades del último objeto GANAN en caso de duplicado
const merged = { ...base, ...extras };
console.log('Base:   ', base);
console.log('Extras: ', extras);
console.log('Merged: ', merged); // precio será 18 (de extras)

// Patrón: aplicar cambios parciales (immutable update)
const usuario = { id: 1, nombre: 'María', email: 'maria@test.com', rol: 'user' };
const usuarioActualizado = { ...usuario, rol: 'admin', email: 'maria@empresa.com' };
console.log('\nUsuario original:    ', usuario);
console.log('Usuario actualizado: ', usuarioActualizado);

// Merge de múltiples fuentes
const defaults = { timeout: 5000, retries: 3, verbose: false };
const entorno  = { timeout: 10000 };
const usuario2 = { verbose: true };
const configFinal = { ...defaults, ...entorno, ...usuario2 };
console.log('Config final:', configFinal);

// -----------------------------------------------------------------------------
// 3. OBJECT.ASSIGN COMO ALTERNATIVA
// -----------------------------------------------------------------------------

console.log('\n=== OBJECT.ASSIGN ===');

// Object.assign(destino, ...fuentes) — MUTA el destino
const destino = { a: 1 };
const fuente1 = { b: 2 };
const fuente2 = { c: 3, a: 99 }; // 'a' sobreescribe destino.a
Object.assign(destino, fuente1, fuente2);
console.log('Destino mutado:', destino);

// Para NO mutar, usar {} como destino
const resultado = Object.assign({}, base, extras);
console.log('Sin mutar:', resultado);
console.log('base original intacto:', base);

// Diferencia con spread: Object.assign activa setters, spread no
// En la práctica para objetos simples son equivalentes
// Preferir spread { ...a, ...b } por ser más moderno y legible

// -----------------------------------------------------------------------------
// 4. STRUCTUREDCLONE — COPIA PROFUNDA NATIVA (ES2022)
// -----------------------------------------------------------------------------

console.log('\n=== STRUCTUREDCLONE — DEEP COPY ===');

const datos = {
  usuario: {
    nombre: 'Pedro',
    preferencias: {
      tema: 'oscuro',
      notificaciones: true,
    },
  },
  items: [{ id: 1, nombre: 'Teclado' }, { id: 2, nombre: 'Mouse' }],
};

// structuredClone: copia profunda completa — no comparte referencias
const clonarProfundo = structuredClone(datos);
clonarProfundo.usuario.nombre = 'modificado';
clonarProfundo.usuario.preferencias.tema = 'claro';
clonarProfundo.items[0].nombre = 'Monitor';

console.log('Original (intacto):');
console.log('  nombre:     ', datos.usuario.nombre);            // 'Pedro'
console.log('  tema:       ', datos.usuario.preferencias.tema); // 'oscuro'
console.log('  items[0]:   ', datos.items[0].nombre);           // 'Teclado'

console.log('Clon (modificado):');
console.log('  nombre:     ', clonarProfundo.usuario.nombre);
console.log('  tema:       ', clonarProfundo.usuario.preferencias.tema);
console.log('  items[0]:   ', clonarProfundo.items[0].nombre);

// structuredClone también clona arrays, fechas, Maps, Sets, etc.
const conFecha = { nombre: 'Evento', fecha: new Date('2025-01-01') };
const clonFecha = structuredClone(conFecha);
clonFecha.fecha.setFullYear(2030);
console.log('\nFecha original:', conFecha.fecha.getFullYear());  // 2025
console.log('Fecha clonada: ', clonFecha.fecha.getFullYear());   // 2030

// LIMITACIONES de structuredClone: no puede clonar funciones, clases, DOM
// Para esos casos: librerías como Lodash (_.cloneDeep)

// -----------------------------------------------------------------------------
// 5. RESUMEN: SHALLOW VS DEEP COPY
// -----------------------------------------------------------------------------

console.log('\n=== RESUMEN SHALLOW vs DEEP ===');

const objeto = {
  primitivo: 42,         // número → copia por valor
  texto: 'hola',         // string → copia por valor
  objeto: { x: 1 },     // objeto → referencia compartida en shallow
  array: [1, 2, 3],      // array → referencia compartida en shallow
};

const shallow = { ...objeto };
const deep    = structuredClone(objeto);

// Modificar valores primitivos: independiente en ambos casos
shallow.primitivo = 99;
deep.primitivo    = 77;
console.log('Original primitivo:  ', objeto.primitivo);  // 42 (intacto)

// Modificar objetos anidados: shallow comparte referencia, deep no
shallow.objeto.x = 999;
deep.objeto.x    = 888;
console.log('Original objeto.x:   ', objeto.objeto.x);   // 999 — shallow afectó al original
console.log('Deep objeto.x:       ', deep.objeto.x);     // 888 — deep es independiente

console.log('\nCuándo usar cada uno:');
console.log('  { ...obj } o Object.assign: objetos planos sin anidamiento profundo');
console.log('  structuredClone:            objetos con anidamiento, arrays de objetos');

// =============================================================================
// EXPERIMENTA:
// - Prueba spread con 3 niveles de anidamiento y observa cuál nivel se comparte
// - Intenta structuredClone con una función adentro y mira el error
// - Construye una función merge(defaults, user) que nunca mute los argumentos
// - Verifica que structuredClone clona correctamente un Set y un Map
// =============================================================================
