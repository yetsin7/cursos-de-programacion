// =============================================================================
// ARCHIVO: 01_objetos_basico.js
// TEMA: Objetos en JavaScript — creación, acceso, métodos, shorthand, computed
// =============================================================================
// CÓMO EJECUTAR: node 01_objetos_basico.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. CREAR OBJETOS CON LITERALES {}
// -----------------------------------------------------------------------------

console.log('=== CREACIÓN DE OBJETOS ===');

// Objeto básico con diferentes tipos de valores
const persona = {
  nombre: 'Ana García',
  edad: 28,
  activo: true,
  hobbies: ['leer', 'programar'],
  direccion: {
    ciudad: 'Madrid',
    pais: 'España',
  },
};

console.log('Persona:', persona);

// Objeto vacío — se pueden agregar propiedades después
const config = {};
config.tema = 'oscuro';
config.idioma = 'es';
console.log('Config:', config);

// -----------------------------------------------------------------------------
// 2. ACCESO CON PUNTO Y CON CORCHETES
// -----------------------------------------------------------------------------

console.log('\n=== ACCESO A PROPIEDADES ===');

// Acceso con punto: la forma más común y legible
console.log('Nombre: ', persona.nombre);
console.log('Ciudad: ', persona.direccion.ciudad);

// Acceso con corchetes: necesario cuando la clave es dinámica o tiene espacios
console.log('Con []:  ', persona['edad']);

// Caso de uso real: clave dinámica desde una variable
const campo = 'activo';
console.log('Campo dinámico:', persona[campo]); // persona.activo

// Acceso a propiedad inexistente retorna undefined (no lanza error)
console.log('Propiedad inexistente:', persona.telefono); // undefined

// -----------------------------------------------------------------------------
// 3. MÉTODOS DENTRO DE OBJETOS
// -----------------------------------------------------------------------------

console.log('\n=== MÉTODOS EN OBJETOS ===');

const calculadora = {
  historial: [],

  // Método con sintaxis abreviada (ES6+) — recomendado
  sumar(a, b) {
    const resultado = a + b;
    this.historial.push(`${a} + ${b} = ${resultado}`);
    return resultado;
  },

  // Método como arrow function — CUIDADO: this no funciona igual
  // Las arrow functions NO tienen su propio `this`
  describir: () => 'Calculadora básica',

  mostrarHistorial() {
    return this.historial.length === 0
      ? 'Sin operaciones'
      : this.historial.join(', ');
  },
};

console.log('Suma 5+3:', calculadora.sumar(5, 3));
console.log('Suma 10+7:', calculadora.sumar(10, 7));
console.log('Historial:', calculadora.mostrarHistorial());
console.log('Describe:', calculadora.describir());

// -----------------------------------------------------------------------------
// 4. PROPERTY SHORTHAND
// -----------------------------------------------------------------------------

console.log('\n=== PROPERTY SHORTHAND ===');

const nombre = 'Carlos';
const edad = 35;
const ciudad = 'Bogotá';

// Sin shorthand — repetitivo
const sinShorthand = { nombre: nombre, edad: edad, ciudad: ciudad };

// Con shorthand (ES6+) — cuando la variable tiene el mismo nombre que la clave
const conShorthand = { nombre, edad, ciudad };

console.log('Sin shorthand:', sinShorthand);
console.log('Con shorthand:', conShorthand); // idéntico resultado

// Útil en funciones que retornan objetos
function crearUsuario(nombre, email, rol = 'usuario') {
  const id = Math.random().toString(36).slice(2, 8);
  const fechaCreacion = new Date().toISOString().slice(0, 10);
  return { id, nombre, email, rol, fechaCreacion }; // shorthand
}

const nuevoUsuario = crearUsuario('María López', 'maria@ejemplo.com', 'admin');
console.log('Nuevo usuario:', nuevoUsuario);

// -----------------------------------------------------------------------------
// 5. COMPUTED PROPERTY NAMES — CLAVES DINÁMICAS
// -----------------------------------------------------------------------------

console.log('\n=== COMPUTED PROPERTY NAMES ===');

// Las claves entre [] se evalúan como expresiones
const clave = 'precio';
const producto = {
  nombre: 'Laptop',
  [clave]: 1200,              // equivale a precio: 1200
  [`${clave}Descuento`]: 999, // claves dinámicas con template literals
};
console.log('Producto:', producto);

// Caso real: crear objeto desde array de pares
const campos = ['nombre', 'email', 'telefono'];
const formulario = campos.reduce((obj, campo) => {
  obj[campo] = ''; // cada campo empieza vacío
  return obj;
}, {});
console.log('Formulario vacío:', formulario);

// Indexed object (clave numérica dinámica)
const respuestas = {};
[1, 2, 3].forEach(pregunta => {
  respuestas[`pregunta_${pregunta}`] = null;
});
console.log('Respuestas vacías:', respuestas);

// -----------------------------------------------------------------------------
// 6. OPTIONAL CHAINING — ACCESO SEGURO A PROPIEDADES ANIDADAS
// -----------------------------------------------------------------------------

console.log('\n=== OPTIONAL CHAINING ===');

const usuarios = {
  activo: {
    perfil: {
      avatar: 'https://ejemplo.com/foto.jpg',
    },
  },
  inactivo: null,
};

// Sin optional chaining — puede lanzar TypeError
// const avatar = usuarios.inactivo.perfil.avatar; // ¡Error!

// Con optional chaining — retorna undefined sin lanzar error
const avatarActivo   = usuarios.activo?.perfil?.avatar;
const avatarInactivo = usuarios.inactivo?.perfil?.avatar;
const avatarSinPerfil = usuarios.activo?.configuracion?.tema;

console.log('Avatar activo:    ', avatarActivo);
console.log('Avatar inactivo:  ', avatarInactivo);   // undefined (no error)
console.log('Avatar sin perfil:', avatarSinPerfil);  // undefined (no error)

// Combinado con nullish coalescing (??) para dar un valor por defecto
const temaUsuario = usuarios.activo?.configuracion?.tema ?? 'claro';
console.log('Tema (con default):', temaUsuario); // 'claro'

// Optional chaining también funciona con métodos y corchetes
const arr = null;
console.log('arr?.[0]:         ', arr?.[0]);        // undefined
console.log('arr?.map(x=>x):   ', arr?.map(x => x)); // undefined

// =============================================================================
// EXPERIMENTA:
// - Crea un objeto con una clave que tenga espacios y accede con corchetes
// - Usa computed property names para crear un objeto de traducción dinámico
// - Prueba qué pasa al llamar un método usando arrow function con `this`
// - Encadena varios optional chaining en datos de API simulados con null
// =============================================================================
