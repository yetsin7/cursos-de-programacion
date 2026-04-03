// =============================================================================
// ARCHIVO: 03_funciones_genericos.ts
// TEMA: Funciones tipadas, generics y utility types de TypeScript
// =============================================================================

// ─── 1. Funciones con tipos ───────────────────────────────────────────────────

// TypeScript permite anotar los parámetros y el tipo de retorno
function sumar(a: number, b: number): number {
  return a + b;
}

// Función con parámetro opcional y valor por defecto
function saludar(nombre: string, titulo: string = 'Sr./Sra.'): string {
  return `Hola, ${titulo} ${nombre}`;
}

// Función que no retorna nada (void)
function registrarError(mensaje: string): void {
  console.error(`[ERROR] ${mensaje}`);
}

console.log('=== FUNCIONES TIPADAS ===');
console.log(sumar(3, 4));
console.log(saludar('García'));
console.log(saludar('Rodríguez', 'Dra.'));

// ─── 2. Generics: la T de TypeScript ─────────────────────────────────────────

// Generic: un tipo "variable" que se resuelve cuando se usa la función
// Permite escribir funciones que funcionan con CUALQUIER tipo sin perder seguridad
function identity<T>(arg: T): T {
  return arg;
}

// TypeScript infiere T automáticamente
console.log('\n=== GENERICS BÁSICOS ===');
console.log(identity('texto'));    // T = string
console.log(identity(42));         // T = number
console.log(identity(true));       // T = boolean

// Generic con arrays
function primerElemento<T>(arr: T[]): T | undefined {
  return arr[0];
}

console.log(primerElemento([10, 20, 30]));  // number
console.log(primerElemento(['a', 'b']));     // string

// Generic con múltiples parámetros de tipo
function par<K, V>(clave: K, valor: V): [K, V] {
  return [clave, valor];
}

console.log(par('edad', 28));
console.log(par(1, { nombre: 'Ana' }));

// ─── 3. Bounded generics: restringir el tipo genérico ────────────────────────

// extends restringe qué tipos acepta T
// Aquí T debe ser string o number
function ordenar<T extends string | number>(arr: T[]): T[] {
  return [...arr].sort((a, b) => (a < b ? -1 : a > b ? 1 : 0));
}

console.log('\n=== BOUNDED GENERICS ===');
console.log(ordenar([3, 1, 4, 1, 5, 9, 2, 6]));
console.log(ordenar(['banana', 'apple', 'cherry']));

// Generic con interfaz como constraint
interface TieneId {
  id: number;
}

function buscarPorId<T extends TieneId>(items: T[], id: number): T | undefined {
  return items.find(item => item.id === id);
}

const usuarios = [
  { id: 1, nombre: 'Ana' },
  { id: 2, nombre: 'Luis' },
];

console.log(buscarPorId(usuarios, 2)); // { id: 2, nombre: 'Luis' }

// ─── 4. Utility Types incorporados en TypeScript ─────────────────────────────

interface Config {
  host: string;
  puerto: number;
  debug: boolean;
  apiKey: string;
}

// Partial<T>: hace TODAS las propiedades opcionales
// Útil para funciones de actualización parcial
type ConfigParcial = Partial<Config>;
const actualizacion: ConfigParcial = { debug: true }; // no necesita todas

// Required<T>: hace TODAS las propiedades obligatorias (lo opuesto de Partial)
type ConfigCompleta = Required<Config>;

// Pick<T, K>: selecciona solo ciertas propiedades
type ConfigPublica = Pick<Config, 'host' | 'puerto'>;
const configPublica: ConfigPublica = { host: 'localhost', puerto: 3000 };

// Omit<T, K>: excluye ciertas propiedades (lo opuesto de Pick)
type ConfigSinApiKey = Omit<Config, 'apiKey'>;
const configSinKey: ConfigSinApiKey = { host: 'prod.server.com', puerto: 443, debug: false };

// Readonly<T>: hace todas las propiedades readonly
type ConfigFija = Readonly<Config>;
const configFija: ConfigFija = { host: 'server.com', puerto: 8080, debug: false, apiKey: 'secret' };
// configFija.debug = true; // Error: Cannot assign to 'debug' - it's readonly

console.log('\n=== UTILITY TYPES ===');
console.log('Partial:', actualizacion);
console.log('Pick:', configPublica);
console.log('Omit:', configSinKey);

// ─── 5. Record<K, V>: objeto con claves dinámicas ────────────────────────────

// Record crea un tipo de objeto donde todas las claves son de tipo K
// y todos los valores son de tipo V
type Inventario = Record<string, number>;

const stock: Inventario = {
  manzanas: 50,
  peras: 30,
  uvas: 100,
};

// Record con union literal como clave — muy común para mapas de configuración
type Idioma = 'es' | 'en' | 'fr';
type Traducciones = Record<Idioma, string>;

const saludo: Traducciones = {
  es: 'Hola',
  en: 'Hello',
  fr: 'Bonjour',
};

console.log('\n=== RECORD ===');
console.log('Stock:', stock);
console.log('Saludo:', saludo);

// ─── Resumen ──────────────────────────────────────────────────────────────────
console.log('\n=== RESUMEN ===');
console.log('function f(a: T): R   → función tipada');
console.log('<T>                   → generic (tipo variable)');
console.log('<T extends U>         → bounded generic');
console.log('Partial / Required    → todas opcionales / obligatorias');
console.log('Pick / Omit           → seleccionar / excluir propiedades');
console.log('Readonly              → solo lectura');
console.log('Record<K,V>           → objeto con claves dinámicas');
