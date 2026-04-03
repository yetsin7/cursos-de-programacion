// =============================================================================
// ARCHIVO: 05_ejercicios.ts
// TEMA: Ejercicios prácticos integrando tipos, interfaces, generics y clases
// =============================================================================

// ─── Ejercicio 1: Sistema de biblioteca ──────────────────────────────────────

// Modelar una biblioteca con libros y usuarios
interface Libro {
  readonly id: number;
  titulo: string;
  autor: string;
  anio: number;
  disponible: boolean;
  genero?: string;
}

interface LectorBiblioteca {
  id: number;
  nombre: string;
  librosprestados: number[];  // IDs de libros prestados
}

/**
 * Busca libros por autor (coincidencia parcial, sin distinción de mayúsculas).
 * @param catalogo - Lista de libros disponibles
 * @param autor - Nombre del autor a buscar
 * @returns Lista de libros que coinciden
 */
function buscarPorAutor(catalogo: Libro[], autor: string): Libro[] {
  const autorNorm = autor.toLowerCase();
  return catalogo.filter(l => l.autor.toLowerCase().includes(autorNorm));
}

/**
 * Filtra libros por disponibilidad.
 * @param catalogo - Lista completa de libros
 * @param soloDisponibles - true para solo disponibles, false para todos
 * @returns Lista filtrada
 */
function filtrarLibros(catalogo: Libro[], soloDisponibles: boolean): Libro[] {
  return soloDisponibles ? catalogo.filter(l => l.disponible) : catalogo;
}

const catalogo: Libro[] = [
  { id: 1, titulo: 'Don Quijote', autor: 'Cervantes', anio: 1605, disponible: true, genero: 'Novela' },
  { id: 2, titulo: 'Cien años de soledad', autor: 'García Márquez', anio: 1967, disponible: false },
  { id: 3, titulo: 'El alquimista', autor: 'Paulo Coelho', anio: 1988, disponible: true },
  { id: 4, titulo: 'Ficciones', autor: 'Borges', anio: 1944, disponible: true, genero: 'Cuentos' },
];

console.log('=== EJERCICIO 1: BIBLIOTECA ===');
console.log('Disponibles:', filtrarLibros(catalogo, true).map(l => l.titulo));
console.log('Búsqueda "Borges":', buscarPorAutor(catalogo, 'borges').map(l => l.titulo));

// ─── Ejercicio 2: Generic Stack (pila) ───────────────────────────────────────

/**
 * Implementación genérica de una pila (LIFO: Last In, First Out).
 * Funciona con cualquier tipo de dato.
 * @template T - El tipo de elementos que almacena la pila
 */
class Stack<T> {
  private elementos: T[] = [];

  /** Agrega un elemento al tope de la pila */
  push(elemento: T): void {
    this.elementos.push(elemento);
  }

  /** Elimina y retorna el elemento del tope; undefined si está vacía */
  pop(): T | undefined {
    return this.elementos.pop();
  }

  /** Retorna el elemento del tope sin eliminarlo */
  peek(): T | undefined {
    return this.elementos[this.elementos.length - 1];
  }

  /** Retorna true si la pila está vacía */
  estaVacia(): boolean {
    return this.elementos.length === 0;
  }

  get tamanio(): number {
    return this.elementos.length;
  }
}

console.log('\n=== EJERCICIO 2: GENERIC STACK ===');
const pilaNumeros = new Stack<number>();
pilaNumeros.push(10);
pilaNumeros.push(20);
pilaNumeros.push(30);
console.log('Tope:', pilaNumeros.peek());    // 30
console.log('Pop:', pilaNumeros.pop());      // 30
console.log('Tamaño:', pilaNumeros.tamanio); // 2

const pilaTextos = new Stack<string>();
pilaTextos.push('primero');
pilaTextos.push('segundo');
console.log('Pop texto:', pilaTextos.pop()); // segundo

// ─── Ejercicio 3: Utility types en práctica ──────────────────────────────────

interface ConfiguracionApp {
  nombre: string;
  version: string;
  debug: boolean;
  maxConexiones: number;
  apiUrl: string;
}

// Simular función de actualización parcial usando Partial<T>
function actualizarConfig(
  config: ConfiguracionApp,
  cambios: Partial<ConfiguracionApp>
): ConfiguracionApp {
  return { ...config, ...cambios };
}

const configBase: ConfiguracionApp = {
  nombre: 'MiApp',
  version: '1.0.0',
  debug: false,
  maxConexiones: 10,
  apiUrl: 'https://api.miapp.com',
};

const configActualizada = actualizarConfig(configBase, {
  debug: true,
  maxConexiones: 25,
});

console.log('\n=== EJERCICIO 3: UTILITY TYPES ===');
console.log('Original:', configBase.debug, configBase.maxConexiones);
console.log('Actualizada:', configActualizada.debug, configActualizada.maxConexiones);

// ─── Ejercicio 4: Enum para estados de formulario ────────────────────────────

enum EstadoFormulario {
  Vacio = 'VACIO',
  Editando = 'EDITANDO',
  Enviando = 'ENVIANDO',
  Exito = 'EXITO',
  Error = 'ERROR',
}

interface FormularioContacto {
  nombre: string;
  email: string;
  mensaje: string;
  estado: EstadoFormulario;
}

/**
 * Simula la transición de estados de un formulario de contacto.
 * @param form - Estado actual del formulario
 * @param nuevoEstado - Estado al que se quiere transicionar
 * @returns Formulario con el nuevo estado aplicado
 */
function transicionarEstado(
  form: FormularioContacto,
  nuevoEstado: EstadoFormulario
): FormularioContacto {
  return { ...form, estado: nuevoEstado };
}

let formulario: FormularioContacto = {
  nombre: 'Pedro',
  email: 'pedro@test.com',
  mensaje: 'Hola desde TypeScript',
  estado: EstadoFormulario.Vacio,
};

formulario = transicionarEstado(formulario, EstadoFormulario.Editando);
formulario = transicionarEstado(formulario, EstadoFormulario.Enviando);
formulario = transicionarEstado(formulario, EstadoFormulario.Exito);

console.log('\n=== EJERCICIO 4: ENUM ESTADOS ===');
console.log('Estado final:', formulario.estado); // EXITO
