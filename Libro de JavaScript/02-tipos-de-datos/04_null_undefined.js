// =============================================================================
// ARCHIVO: 04_null_undefined.js
// TEMA: null, undefined, optional chaining y nullish coalescing
// =============================================================================
//
// null y undefined representan "ausencia de valor" pero de forma diferente.
// Son confusos para principiantes porque ambos parecen iguales, pero tienen
// semántica distinta. Optional chaining (?.) y nullish coalescing (??)
// son las herramientas modernas para trabajar con ellos de forma segura.
//
// CÓMO EJECUTAR:
//   node 04_null_undefined.js
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. undefined — Ausencia no intencional de valor
// ─────────────────────────────────────────────────────────────────────────────

// JavaScript asigna undefined automáticamente en varios casos:
console.log('--- undefined ---');

// Variable declarada pero no inicializada
let variableSinValor;
console.log('Variable sin valor:', variableSinValor); // undefined

// Propiedad que no existe en un objeto
const objeto = { nombre: 'Ana' };
console.log('Propiedad inexistente:', objeto.email); // undefined

// Parámetro de función no proporcionado
const saludar = (nombre, apellido) => {
  console.log(`Nombre: ${nombre}, Apellido: ${apellido}`);
};
saludar('Juan'); // Apellido será undefined

// Función sin return explícito
const sinReturn = () => {
  const x = 42;
  // No hay return
};
console.log('Función sin return:', sinReturn()); // undefined

// Acceso a índice fuera de rango en array
const arr = [1, 2, 3];
console.log('Índice fuera de rango:', arr[10]); // undefined

// ─────────────────────────────────────────────────────────────────────────────
// 2. null — Ausencia INTENCIONAL de valor
// ─────────────────────────────────────────────────────────────────────────────

// null lo asigna el programador para indicar explícitamente "no hay valor".
// Es una decisión deliberada, no un accidente.
console.log('\n--- null ---');

let usuarioSeleccionado = null;  // "no hay usuario seleccionado aún"
let resultadoBusqueda = null;    // "la búsqueda no ha retornado resultado"

console.log('Usuario seleccionado:', usuarioSeleccionado);
console.log('Resultado búsqueda:', resultadoBusqueda);
console.log('typeof null:', typeof null); // 'object' — bug histórico de JS

// Uso práctico: inicializar una variable que después tendrá un objeto
let sesionActual = null;

// Más tarde en el código:
sesionActual = { userId: 123, token: 'abc123', expiresAt: new Date() };
console.log('Sesión activa:', sesionActual.userId);

// Limpiar el valor (cerrar sesión)
sesionActual = null;
console.log('Sesión después de cerrar:', sesionActual); // null

// ─────────────────────────────────────────────────────────────────────────────
// 3. Diferencias clave entre null y undefined
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Comparaciones null vs undefined ---');
console.log(null == undefined);   // true  (igualdad abstracta — se consideran iguales)
console.log(null === undefined);  // false (igualdad estricta — son distintos tipos)
console.log(typeof null);         // 'object' (bug de JS)
console.log(typeof undefined);    // 'undefined'

// Para verificar si algo es exactamente null o exactamente undefined:
const valor = null;
console.log(valor === null);      // true — forma correcta de verificar null
console.log(valor === undefined); // false
console.log(valor == null);       // true — también detecta undefined (útil a veces)

// ─────────────────────────────────────────────────────────────────────────────
// 4. Optional chaining ?. — Acceso seguro a propiedades anidadas
// ─────────────────────────────────────────────────────────────────────────────

// El problema clásico: acceder a propiedades de objetos que pueden ser null
const perfil = {
  nombre: 'Carlos',
  direccion: {
    ciudad: 'Madrid',
    codigoPostal: '28001',
  },
};

const perfilSinDireccion = {
  nombre: 'María',
  // No tiene propiedad "direccion"
};

// Sin optional chaining — necesitas verificar cada nivel
if (perfil.direccion && perfil.direccion.ciudad) {
  console.log('\n--- Optional chaining ---');
  console.log('Ciudad (forma antigua):', perfil.direccion.ciudad);
}

// Con optional chaining — limpio y conciso
// Si cualquier parte de la cadena es null o undefined, retorna undefined sin error
console.log('Ciudad:', perfil?.direccion?.ciudad);              // 'Madrid'
console.log('Ciudad (sin dirección):', perfilSinDireccion?.direccion?.ciudad); // undefined (no da error)
console.log('País:', perfil?.direccion?.pais?.nombre);           // undefined (no da error)

// Optional chaining con métodos
const datos = {
  formatear: () => 'datos formateados',
};
const datosVacio = {};

console.log(datos.formatear?.());     // 'datos formateados'
console.log(datosVacio.formatear?.()); // undefined (no lanza error)

// Optional chaining con arrays
const lista = {
  items: ['manzana', 'pera'],
};
const listaVacia = {};

console.log(lista.items?.[0]);       // 'manzana'
console.log(listaVacia.items?.[0]);  // undefined (no lanza error)

// ─────────────────────────────────────────────────────────────────────────────
// 5. Nullish coalescing ?? — Valor por defecto para null/undefined
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Nullish coalescing ?? ---');

const configuracion = {
  tema: null,
  idioma: undefined,
  volumen: 0,        // Valor válido que el usuario estableció
  velocidad: false,  // Valor válido (falso = lento)
};

// ?? sólo usa el defecto si el valor es null O undefined
// A diferencia de || que usa el defecto para cualquier falsy
console.log('Tema:', configuracion.tema ?? 'claro');         // 'claro' (null → defecto)
console.log('Idioma:', configuracion.idioma ?? 'es');        // 'es' (undefined → defecto)
console.log('Volumen:', configuracion.volumen ?? 50);        // 0 (respeta el 0)
console.log('Velocidad:', configuracion.velocidad ?? true);  // false (respeta el false)

// ─────────────────────────────────────────────────────────────────────────────
// 6. Combinando ?. y ?? — El patrón más poderoso
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- Combinando ?. y ?? ---');

/**
 * Estructura típica de respuesta de una API que puede tener datos incompletos.
 * @type {Object}
 */
const respuestaAPI = {
  datos: {
    usuario: {
      nombre: 'Sofía',
      // No tiene "email"
      // No tiene "preferencias"
    },
  },
};

// Acceder de forma segura con valor por defecto
const email = respuestaAPI?.datos?.usuario?.email ?? 'sin-email@default.com';
const tema = respuestaAPI?.datos?.usuario?.preferencias?.tema ?? 'claro';
const idioma = respuestaAPI?.datos?.usuario?.preferencias?.idioma ?? 'es';

console.log('Email:', email);   // 'sin-email@default.com'
console.log('Tema:', tema);     // 'claro'
console.log('Idioma:', idioma); // 'es'

// ─────────────────────────────────────────────────────────────────────────────
// 7. Nullish assignment ??= — Asignar sólo si es null/undefined
// ─────────────────────────────────────────────────────────────────────────────

console.log('\n--- ??= (nullish assignment) ---');

// ??= asigna el valor SÓLO si la variable es null o undefined
// Es equivalente a: variable = variable ?? valorDefecto

let a = null;
let b = undefined;
let c = 0;       // No es null/undefined
let d = '';      // No es null/undefined

a ??= 'valor para null';
b ??= 'valor para undefined';
c ??= 'valor para 0';    // No se asigna (0 no es null/undefined)
d ??= 'valor para ""';   // No se asigna ("" no es null/undefined)

console.log('a:', a);  // 'valor para null'
console.log('b:', b);  // 'valor para undefined'
console.log('c:', c);  // 0 (sin cambio)
console.log('d:', d);  // '' (sin cambio)

// =============================================================================
// EXPERIMENTA:
// 1. Crea un objeto con propiedades anidadas 4 niveles y usa ?. para acceder
// 2. ¿Qué diferencia hay entre obj?.propiedad y obj && obj.propiedad?
// 3. Usa ??= para inicializar valores en un objeto de configuración
// 4. ¿Qué retorna undefined ?? null? ¿Y null ?? undefined?
// 5. Crea una función que reciba un objeto de usuario y retorne datos con
//    valores por defecto usando ?. y ??
// =============================================================================
