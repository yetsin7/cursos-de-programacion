// =============================================================================
// ARCHIVO: 01_tipos_basicos.ts
// TEMA: Tipos básicos de TypeScript
// =============================================================================

// ─── 1. Tipos primitivos con anotación explícita ─────────────────────────────

// TypeScript permite anotar el tipo junto a la variable
const nombre: string = 'Ana';
const edad: number = 28;
const activo: boolean = true;

// Los valores null y undefined tienen sus propios tipos
const sinValor: null = null;
const noDefinido: undefined = undefined;

console.log('=== TIPOS PRIMITIVOS ===');
console.log(nombre, edad, activo);

// ─── 2. Tipado inferido ───────────────────────────────────────────────────────

// TypeScript INFIERE el tipo si no lo declaras explícitamente
// Prefiere la inferencia cuando es obvia — no anotar de más
const ciudad = 'Madrid';       // TypeScript infiere: string
const temperatura = 22.5;      // TypeScript infiere: number
const esDeDia = false;         // TypeScript infiere: boolean

// Esto causaría error en compilación:
// ciudad = 42; // Error: Type 'number' is not assignable to type 'string'

console.log('\n=== TIPADO INFERIDO ===');
console.log(`${ciudad} | ${temperatura}°C | día: ${esDeDia}`);

// ─── 3. any, unknown, never ───────────────────────────────────────────────────

// any: desactiva el sistema de tipos — EVITAR siempre que sea posible
// Usar solo cuando migras código JS a TS o con librerías sin tipos
let cualquierCosa: any = 'hola';
cualquierCosa = 42;        // OK (pero peligroso)
cualquierCosa = true;      // OK (pero peligroso)

// unknown: la alternativa segura a any
// TypeScript OBLIGA a verificar el tipo antes de usarlo
let valorDesconocido: unknown = 'puede ser cualquier cosa';
// Sin la verificación, esto daría error:
if (typeof valorDesconocido === 'string') {
  console.log('\nunknown verificado:', valorDesconocido.toUpperCase());
}

// never: el tipo de funciones que NUNCA retornan (lanzan error o bucle infinito)
function lanzarError(mensaje: string): never {
  throw new Error(mensaje);
}

console.log('\n=== any / unknown / never ===');
console.log('any:', cualquierCosa);

// ─── 4. Arrays ────────────────────────────────────────────────────────────────

// Dos sintaxis equivalentes para arrays tipados
const frutas: string[] = ['manzana', 'pera', 'uva'];
const numeros: Array<number> = [1, 2, 3, 4, 5];

// Array de objetos
const puntos: Array<{ x: number; y: number }> = [
  { x: 0, y: 0 },
  { x: 10, y: 20 },
];

console.log('\n=== ARRAYS ===');
console.log('Frutas:', frutas);
console.log('Números:', numeros);
console.log('Puntos:', puntos);

// ─── 5. Tuplas ────────────────────────────────────────────────────────────────

// Tupla: array con longitud y tipos FIJOS en cada posición
const coordenada: [number, number] = [40.4168, -3.7038]; // lat, lng
const persona: [string, number, boolean] = ['Carlos', 35, true];

// Desestructuración de tupla
const [lat, lng] = coordenada;
const [nombrePersona, edadPersona] = persona;

console.log('\n=== TUPLAS ===');
console.log(`Coordenada: lat=${lat}, lng=${lng}`);
console.log(`Persona: ${nombrePersona}, ${edadPersona} años`);

// ─── 6. Union types ───────────────────────────────────────────────────────────

// Union type: la variable puede ser de uno de varios tipos
// Se usa el operador | (pipe)
let identificador: string | number;
identificador = 'abc-123';  // OK
identificador = 42;          // OK
// identificador = true;     // Error

// Función que acepta string o number
function formatearId(id: string | number): string {
  // Con union types, TypeScript fuerza a manejar cada caso (type narrowing)
  if (typeof id === 'number') {
    return `ID-${id.toString().padStart(6, '0')}`;
  }
  return `ID-${id.toUpperCase()}`;
}

console.log('\n=== UNION TYPES ===');
console.log(formatearId(42));
console.log(formatearId('abc'));

// ─── 7. Type aliases ──────────────────────────────────────────────────────────

// type: crea un alias (nombre) para cualquier tipo
// Mejora la legibilidad y permite reutilizar tipos complejos
type NombreCompleto = string;
type Edad = number;
type EstadoCivil = 'soltero' | 'casado' | 'divorciado' | 'viudo';
type Coordenadas = [number, number];

const miNombre: NombreCompleto = 'Laura García';
const miEdad: Edad = 30;
const estado: EstadoCivil = 'casado';
const posicion: Coordenadas = [19.4326, -99.1332]; // Ciudad de México

console.log('\n=== TYPE ALIASES ===');
console.log(miNombre, miEdad, estado, posicion);

// ─── Resumen ──────────────────────────────────────────────────────────────────
console.log('\n=== RESUMEN ===');
console.log('string / number / boolean → tipos primitivos');
console.log('any     → evitar | unknown → seguro | never → no retorna');
console.log('T[]     → array tipado');
console.log('[T, U]  → tupla de tipos fijos');
console.log('T | U   → union type');
console.log('type N  → alias de tipo');
