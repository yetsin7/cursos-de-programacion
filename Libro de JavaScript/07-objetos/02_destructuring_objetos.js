// =============================================================================
// ARCHIVO: 02_destructuring_objetos.js
// TEMA: Destructuring de objetos — extracción elegante de propiedades
// =============================================================================
// CÓMO EJECUTAR: node 02_destructuring_objetos.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. DESTRUCTURING BÁSICO
// -----------------------------------------------------------------------------

console.log('=== DESTRUCTURING BÁSICO ===');

const producto = {
  nombre: 'Laptop Pro',
  precio: 1299,
  marca: 'TechCorp',
  categoria: 'tecnologia',
  stock: 15,
};

// Sin destructuring — repetitivo
const nombreViejo  = producto.nombre;
const precioViejo  = producto.precio;

// Con destructuring — conciso y legible
// Las variables deben tener el mismo nombre que las claves del objeto
const { nombre, precio, marca } = producto;
console.log('Nombre:', nombre);
console.log('Precio:', precio);
console.log('Marca: ', marca);

// Solo extraer algunas propiedades (el resto queda en el objeto original)
const { categoria, stock } = producto;
console.log('Categoría:', categoria, '| Stock:', stock);

// -----------------------------------------------------------------------------
// 2. RENOMBRAR VARIABLES
// -----------------------------------------------------------------------------

console.log('\n=== RENOMBRAR AL DESTRUCTURAR ===');

const respuestaAPI = {
  user_name: 'juan_perez',
  user_email: 'juan@ejemplo.com',
  user_age: 30,
  is_admin: false,
};

// Sintaxis: { clave: nuevaVariable }
const {
  user_name: userName,
  user_email: userEmail,
  user_age: userAge,
  is_admin: isAdmin,
} = respuestaAPI;

console.log('userName: ', userName);
console.log('userEmail:', userEmail);
console.log('userAge:  ', userAge);
console.log('isAdmin:  ', isAdmin);

// Renombrar a camelCase desde snake_case (patrón muy común con APIs)
const config = { max_retries: 3, timeout_ms: 5000, base_url: 'https://api.com' };
const { max_retries: maxRetries, timeout_ms: timeoutMs, base_url: baseUrl } = config;
console.log('maxRetries:', maxRetries, '| timeoutMs:', timeoutMs);

// -----------------------------------------------------------------------------
// 3. VALORES POR DEFECTO
// -----------------------------------------------------------------------------

console.log('\n=== DEFAULT VALUES ===');

const opciones = {
  color: 'azul',
  tamaño: 'mediano',
  // visible y opacidad no están definidas
};

// Si la propiedad no existe (es undefined), se usa el default
const {
  color,
  tamaño,
  visible = true,       // no existe → usa 'true'
  opacidad = 1.0,       // no existe → usa 1.0
  borde = '1px solid',  // no existe → usa el string
} = opciones;

console.log('color:    ', color);    // 'azul'
console.log('tamaño:   ', tamaño);   // 'mediano'
console.log('visible:  ', visible);  // true (default)
console.log('opacidad: ', opacidad); // 1.0 (default)

// ATENCIÓN: null no activa el default, solo undefined
const { valorNulo = 'defecto' } = { valorNulo: null };
const { valorUndef = 'defecto' } = { valorUndef: undefined };
console.log('null → default:', valorNulo);  // null (¡no activó!)
console.log('undef → default:', valorUndef); // 'defecto' (sí activó)

// Combinando renombrar + default
const { max_items: maxItems = 100 } = {}; // no existe → usa 100 con nombre maxItems
console.log('maxItems (renombrado + default):', maxItems);

// -----------------------------------------------------------------------------
// 4. REST EN DESTRUCTURING DE OBJETOS
// -----------------------------------------------------------------------------

console.log('\n=== REST EN OBJETOS ===');

const usuario = {
  id: 42,
  nombre: 'Sofía',
  email: 'sofia@ejemplo.com',
  password: 'hash_seguro_abc123',
  rol: 'admin',
  fechaCreacion: '2024-01-15',
};

// Extraer password y guardar el resto en un objeto limpio
const { password, ...usuarioPublico } = usuario;
console.log('Password (no exponer):', password);
console.log('Usuario público:      ', usuarioPublico);

// Separar id del resto (patrón común al actualizar registros)
const { id, ...datosActualizar } = usuario;
console.log('ID:', id);
console.log('Datos a actualizar:', Object.keys(datosActualizar));

// -----------------------------------------------------------------------------
// 5. DESTRUCTURING EN PARÁMETROS DE FUNCIÓN
// -----------------------------------------------------------------------------

console.log('\n=== DESTRUCTURING EN PARÁMETROS ===');

// Sin destructuring — accede con objeto.propiedad dentro de la función
function mostrarProductoViejo(prod) {
  console.log(`${prod.nombre} — $${prod.precio}`);
}

// Con destructuring en la firma — más limpio y explícito
function mostrarProducto({ nombre, precio, stock = 0 }) {
  const estado = stock > 0 ? `${stock} disponibles` : 'Agotado';
  console.log(`${nombre} — $${precio} — ${estado}`);
}

mostrarProducto(producto);
mostrarProducto({ nombre: 'Mouse', precio: 35 }); // stock usa default 0

// Función que acepta opciones con defaults
function crearConexion({
  host = 'localhost',
  puerto = 5432,
  ssl = false,
  timeout = 30000,
} = {}) { // el = {} permite llamar la función sin argumentos
  return { host, puerto, ssl, timeout };
}

console.log('Conexión por defecto:', crearConexion());
console.log('Conexión custom:     ', crearConexion({ host: 'db.produccion.com', ssl: true }));

// -----------------------------------------------------------------------------
// 6. DESTRUCTURING ANIDADO
// -----------------------------------------------------------------------------

console.log('\n=== DESTRUCTURING ANIDADO ===');

const pedido = {
  id: 'ORD-001',
  estado: 'enviado',
  cliente: {
    nombre: 'Roberto',
    email: 'roberto@ejemplo.com',
    direccion: {
      calle: 'Calle Mayor 10',
      ciudad: 'Barcelona',
      codigoPostal: '08001',
    },
  },
  items: [
    { producto: 'Teclado', cantidad: 1 },
    { producto: 'Mouse',   cantidad: 2 },
  ],
};

// Destructuring anidado: acceder a propiedades profundas
const {
  id: pedidoId,
  cliente: {
    nombre: clienteNombre,
    direccion: { ciudad, codigoPostal },
  },
} = pedido;

console.log('Pedido ID:      ', pedidoId);
console.log('Cliente:        ', clienteNombre);
console.log('Ciudad:         ', ciudad);
console.log('Código postal:  ', codigoPostal);

// Destruc. anidado con arrays dentro de objetos
const { items: [primerItem, segundoItem] } = pedido;
console.log('Primer item:    ', primerItem);
console.log('Segundo item:   ', segundoItem);

// =============================================================================
// EXPERIMENTA:
// - Crea una función procesarRespuesta({ data, error, loading = false }) = {}
// - Usa destructuring con renombre + default en la misma variable
// - Practica el patrón: const { password: _, ...safe } = user (omitir con _)
// - Anida destructuring de 3 niveles y reflexiona si aún es legible
// =============================================================================
