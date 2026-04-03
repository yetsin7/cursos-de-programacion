// =============================================================================
// ARCHIVO: 02_interfaces_y_types.ts
// TEMA: Interfaces, type aliases, propiedades opcionales y readonly
// =============================================================================

// ─── 1. Interface: la forma de un objeto ─────────────────────────────────────

// interface define la "forma" (shape) que debe tener un objeto
// Es la forma recomendada para tipar objetos en TypeScript
interface Usuario {
  id: number;
  nombre: string;
  email: string;
}

// Crear un objeto que cumpla la interfaz
const usuario1: Usuario = {
  id: 1,
  nombre: 'Ana López',
  email: 'ana@ejemplo.com',
};

console.log('=== INTERFACE BÁSICA ===');
console.log(usuario1);

// ─── 2. Propiedades opcionales y readonly ────────────────────────────────────

// ?: hace la propiedad opcional (puede estar o no)
// readonly: la propiedad solo se puede asignar una vez (en creación)
interface Producto {
  readonly id: number;      // no se puede cambiar después de crear
  nombre: string;
  precio: number;
  descripcion?: string;     // opcional: puede estar o no
  categoria?: string;       // opcional
}

const producto1: Producto = {
  id: 101,
  nombre: 'Teclado mecánico',
  precio: 89.99,
  // descripcion y categoria no son obligatorios
};

const producto2: Producto = {
  id: 102,
  nombre: 'Monitor 4K',
  precio: 399.99,
  descripcion: 'Monitor UltraWide con HDR',
  categoria: 'Periféricos',
};

// producto1.id = 999; // Error: Cannot assign to 'id' because it is read-only

console.log('\n=== PROPIEDADES OPCIONALES Y READONLY ===');
console.log(producto1);
console.log(producto2);

// ─── 3. Extender interfaces ───────────────────────────────────────────────────

// Una interfaz puede heredar de otra con "extends"
// Útil para modelar jerarquías sin duplicar propiedades
interface Persona {
  nombre: string;
  edad: number;
}

interface Empleado extends Persona {
  empresa: string;
  salario: number;
  departamento?: string;
}

// Empleado hereda nombre y edad de Persona
const empleado1: Empleado = {
  nombre: 'Carlos Ruiz',
  edad: 32,
  empresa: 'TechCorp',
  salario: 45000,
};

console.log('\n=== EXTENDER INTERFACES ===');
console.log(empleado1);

// ─── 4. type alias: más flexible que interface ────────────────────────────────

// type puede representar CUALQUIER tipo, no solo objetos
// Para objetos simples: preferir interface
// Para unions, intersections o tipos complejos: usar type
type Punto = { x: number; y: number };
type Color = 'rojo' | 'verde' | 'azul';       // union de literales
type Resultado = 'exito' | 'error' | 'pendiente';

// type para union de tipos
type IdRecurso = string | number;

const punto: Punto = { x: 10, y: 20 };
const color: Color = 'azul';
const id: IdRecurso = 'uuid-abc-123';

console.log('\n=== TYPE ALIAS ===');
console.log(punto, color, id);

// ─── 5. Intersection types: combinar varios tipos ────────────────────────────

// El operador & combina dos tipos en uno que debe cumplir AMBOS
type Auditable = {
  creadoEn: Date;
  actualizadoEn: Date;
};

type ProductoAuditable = Producto & Auditable;

const prodConAuditoria: ProductoAuditable = {
  id: 200,
  nombre: 'Laptop',
  precio: 1299.99,
  creadoEn: new Date('2024-01-01'),
  actualizadoEn: new Date('2024-06-15'),
};

console.log('\n=== INTERSECTION TYPES ===');
console.log(prodConAuditoria);

// ─── 6. interface vs type: ¿cuándo usar cada uno? ────────────────────────────

// REGLA GENERAL:
// • interface → para definir la forma de objetos (clases, entidades, DTOs)
// • type     → para unions, intersections, alias de primitivos, tipos complejos

// interface admite "declaration merging" (se puede declarar dos veces y se fusionan)
interface Configuracion {
  tema: string;
}
interface Configuracion {
  idioma: string;
}
// Ahora Configuracion tiene tanto 'tema' como 'idioma'
const config: Configuracion = { tema: 'oscuro', idioma: 'es' };

console.log('\n=== INTERFACE MERGING ===');
console.log(config);

// type NO permite esto — daría error de identificador duplicado

// ─── 7. Funciones con interfaces ─────────────────────────────────────────────

// Las interfaces también pueden describir la firma de funciones
interface Formateador {
  (valor: number, decimales: number): string;
}

const formatearMoneda: Formateador = (valor, decimales) =>
  `$${valor.toFixed(decimales)}`;

console.log('\n=== INTERFACE PARA FUNCIONES ===');
console.log(formatearMoneda(1234.5678, 2));
