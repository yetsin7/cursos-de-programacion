// =============================================================================
// ARCHIVO: 04_metodos_objeto.js
// TEMA: Métodos estáticos de Object — keys, values, entries, freeze, hasOwn
// =============================================================================
// CÓMO EJECUTAR: node 04_metodos_objeto.js
// =============================================================================

'use strict';

// Objeto de ejemplo para los métodos
const producto = {
  nombre: 'Laptop Pro',
  precio: 1299,
  marca: 'TechCorp',
  stock: 15,
  disponible: true,
};

// -----------------------------------------------------------------------------
// 1. OBJECT.KEYS, VALUES, ENTRIES
// -----------------------------------------------------------------------------

console.log('=== OBJECT.KEYS / VALUES / ENTRIES ===');

// keys(): retorna array con los nombres de las propiedades enumerables
const claves = Object.keys(producto);
console.log('keys():   ', claves);

// values(): retorna array con los valores
const valores = Object.values(producto);
console.log('values(): ', valores);

// entries(): retorna array de pares [clave, valor] — el más versátil
const entradas = Object.entries(producto);
console.log('entries():');
entradas.forEach(([clave, valor]) => {
  console.log(`  ${clave.padEnd(12)}: ${valor}`);
});

// Casos de uso prácticos con entries
const totalCaracteres = Object.values(producto)
  .filter(v => typeof v === 'string')
  .reduce((sum, s) => sum + s.length, 0);
console.log('\nTotal caracteres en strings:', totalCaracteres);

// Filtrar propiedades de un objeto (como filter pero para objetos)
const soloStrings = Object.fromEntries(
  Object.entries(producto).filter(([, v]) => typeof v === 'string')
);
console.log('Solo propiedades string:', soloStrings);

// -----------------------------------------------------------------------------
// 2. OBJECT.FROMENTRIES — RECONSTRUIR DESDE ENTRIES
// -----------------------------------------------------------------------------

console.log('\n=== OBJECT.FROMENTRIES ===');

// Convertir entries de vuelta a objeto
const entries = [['nombre', 'Ana'], ['edad', 30], ['ciudad', 'Lima']];
const objetoDesdeEntries = Object.fromEntries(entries);
console.log('fromEntries:', objetoDesdeEntries);

// Patrón muy útil: transformar un objeto con map
const precios = { laptop: 1200, teclado: 80, mouse: 35, monitor: 400 };

// Aplicar 15% de descuento a todos los precios
const conDescuento = Object.fromEntries(
  Object.entries(precios).map(([producto, precio]) => [
    producto,
    +(precio * 0.85).toFixed(2),
  ])
);
console.log('Precios originales:', precios);
console.log('Con 15% descuento: ', conDescuento);

// Convertir Map a objeto
const mapaConfig = new Map([['tema', 'oscuro'], ['idioma', 'es']]);
const configObjeto = Object.fromEntries(mapaConfig);
console.log('Map → objeto:', configObjeto);

// -----------------------------------------------------------------------------
// 3. OBJECT.FREEZE — OBJETOS INMUTABLES
// -----------------------------------------------------------------------------

console.log('\n=== OBJECT.FREEZE ===');

// freeze(): previene modificaciones al objeto (en modo strict lanza error)
const CONSTANTES = Object.freeze({
  MAX_INTENTOS: 3,
  TIMEOUT_MS: 5000,
  VERSION: '1.0.0',
  ROLES: ['admin', 'usuario', 'moderador'],
});

// Intentar modificar → silencioso en modo no-strict, error en strict
try {
  CONSTANTES.MAX_INTENTOS = 99; // lanza TypeError en 'use strict'
} catch (e) {
  console.log('Error al modificar frozen:', e.message);
}

console.log('CONSTANTES (intactas):', CONSTANTES);

// ADVERTENCIA: freeze es SHALLOW — objetos anidados sí se pueden modificar
CONSTANTES.ROLES.push('superadmin'); // ¡Esto funciona! El array no está frozen
console.log('ROLES (modificado igual):', CONSTANTES.ROLES);

// Para freeze profundo se necesita una función recursiva:
function deepFreeze(obj) {
  Object.freeze(obj);
  Object.values(obj).forEach(val => {
    if (typeof val === 'object' && val !== null && !Object.isFrozen(val)) {
      deepFreeze(val);
    }
  });
  return obj;
}

const config = deepFreeze({ db: { host: 'localhost', port: 5432 } });
try {
  config.db.host = 'remoto'; // ahora sí lanza error
} catch (e) {
  console.log('Deep freeze funcionó:', e.message);
}

// -----------------------------------------------------------------------------
// 4. OBJECT.HASOWN — VERIFICAR PROPIEDAD PROPIA (ES2022)
// -----------------------------------------------------------------------------

console.log('\n=== OBJECT.HASOWN ===');

const animal = { nombre: 'Perro', tipo: 'mamífero' };

// Object.hasOwn(): retorna true si la propiedad es propia del objeto (no heredada)
console.log('hasOwn nombre:  ', Object.hasOwn(animal, 'nombre'));   // true
console.log('hasOwn tipo:    ', Object.hasOwn(animal, 'tipo'));     // true
console.log('hasOwn toString:', Object.hasOwn(animal, 'toString')); // false (heredado)
console.log('hasOwn patas:   ', Object.hasOwn(animal, 'patas'));    // false

// Operador `in`: verifica propiedad propia Y heredada
console.log('\nin operator:');
console.log('in nombre:  ', 'nombre' in animal);   // true
console.log('in toString:', 'toString' in animal); // true (heredado del prototipo)

// Por eso es mejor usar hasOwn para verificar propiedades propias
// (antes se usaba obj.hasOwnProperty() — hasOwn es más seguro y moderno)

// Caso de uso: iterar solo propiedades propias de forma explícita
const objConHerencia = Object.create({ heredado: true });
objConHerencia.propio = 'valor';

console.log('\nPropiedades propias:');
for (const clave in objConHerencia) {
  if (Object.hasOwn(objConHerencia, clave)) {
    console.log(`  ${clave}: ${objConHerencia[clave]}`);
  }
}

// -----------------------------------------------------------------------------
// 5. ITERAR OBJETOS CON FOR...OF + ENTRIES
// -----------------------------------------------------------------------------

console.log('\n=== ITERAR CON FOR...OF ===');

const inventario = {
  manzanas: 150,
  peras: 80,
  uvas: 230,
  naranjas: 95,
};

// for...of con Object.entries — la forma más moderna y limpia
console.log('Inventario completo:');
for (const [fruta, cantidad] of Object.entries(inventario)) {
  const barra = '█'.repeat(Math.floor(cantidad / 20));
  console.log(`  ${fruta.padEnd(10)} ${String(cantidad).padStart(4)} ${barra}`);
}

// Calcular total con for...of
let total = 0;
for (const cantidad of Object.values(inventario)) {
  total += cantidad;
}
console.log(`\nTotal unidades: ${total}`);

// Buscar en objeto como si fuera una tabla hash
const codigosPostales = { Madrid: '28001', Barcelona: '08001', Valencia: '46001' };
const ciudad = 'Barcelona';
console.log(`\nCP de ${ciudad}:`, codigosPostales[ciudad] ?? 'No encontrado');

// =============================================================================
// EXPERIMENTA:
// - Usa Object.entries + fromEntries para renombrar todas las claves de un objeto
// - Crea una función pick(obj, campos[]) que retorne solo esas propiedades
// - Prueba Object.freeze con null como valor y verifica qué pasa
// - Implementa una función omit(obj, campos[]) opuesta a pick
// =============================================================================
