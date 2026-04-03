// =============================================================================
// ARCHIVO: 03_listas_condicional.jsx
// TEMA: Renderizado de listas con map y renderizado condicional
// NOTA: Requiere proyecto Vite → npm create vite@latest mi-app -- --template react
// =============================================================================

// ─── 1. Renderizar listas con map ────────────────────────────────────────────

/**
 * La forma correcta de renderizar listas en React es con Array.map().
 * SIEMPRE se necesita una prop key única y estable en cada elemento.
 * @param {Array} libros - Lista de libros a mostrar
 */
function ListaLibros({ libros }) {
  return (
    <ul>
      {libros.map(libro => (
        // key: identificador único y estable — React lo usa internamente
        // para saber qué elementos cambiar, agregar o eliminar eficientemente
        <li key={libro.id}>
          <strong>{libro.titulo}</strong> — {libro.autor} ({libro.anio})
        </li>
      ))}
    </ul>
  );
}

// ─── 2. Por qué NO usar el índice como key ───────────────────────────────────

/**
 * Demostración visual de por qué el índice del array NO es una buena key.
 * El índice cambia cuando se reordena o elimina elementos, lo que confunde
 * al algoritmo de reconciliación de React y puede causar bugs sutiles.
 *
 * REGLA: usa el ID único del dato, no el índice del array.
 */
function MalaKey({ items }) {
  return (
    <ul>
      {items.map((item, index) => (
        // ⚠️ MAL: si se elimina un elemento del centro, los índices cambian
        // React puede reutilizar el nodo DOM incorrecto
        <li key={index}>{item}</li>
      ))}
    </ul>
  );
}

function BuenaKey({ items }) {
  return (
    <ul>
      {items.map(item => (
        // ✓ BIEN: el id es único y no cambia cuando se reordena
        <li key={item.id}>{item.nombre}</li>
      ))}
    </ul>
  );
}

// ─── 3. Renderizado condicional: operador && ──────────────────────────────────

/**
 * El operador && renderiza el elemento de la derecha SOLO si la condición es true.
 * Si es false, React no renderiza nada (null).
 * @param {boolean} estaAutenticado - Si el usuario está logueado
 * @param {string} nombre - Nombre del usuario
 */
function BannerBienvenida({ estaAutenticado, nombre }) {
  return (
    <div>
      {/* Si estaAutenticado es true, muestra el saludo */}
      {estaAutenticado && (
        <div style={{ background: '#d1fae5', padding: '8px', borderRadius: '4px' }}>
          ¡Bienvenido, {nombre}!
        </div>
      )}

      {/* Si NO está autenticado, muestra el botón de login */}
      {!estaAutenticado && (
        <button style={{ background: '#3b82f6', color: 'white', padding: '8px 16px', border: 'none', borderRadius: '4px' }}>
          Iniciar sesión
        </button>
      )}
    </div>
  );
}

// ─── 4. Renderizado condicional: ternario ─────────────────────────────────────

/**
 * El ternario es ideal cuando quieres mostrar A o B según una condición.
 * Más explícito que && cuando hay dos alternativas.
 * @param {boolean} cargando - Estado de carga
 * @param {Array|null} datos - Datos a mostrar cuando no hay carga
 */
function EstadoCarga({ cargando, datos }) {
  return (
    <div>
      {cargando ? (
        // Se muestra mientras cargando = true
        <p style={{ color: '#6b7280' }}>⏳ Cargando datos...</p>
      ) : (
        // Se muestra cuando cargando = false
        <p style={{ color: '#059669' }}>✓ {datos?.length ?? 0} elemento(s) cargados</p>
      )}
    </div>
  );
}

// ─── 5. Renderizado condicional: if antes del return ─────────────────────────

/**
 * Para lógica condicional compleja, se puede usar if/else ANTES del return.
 * Esto mantiene el JSX limpio y fácil de leer.
 * @param {'loading'|'error'|'empty'|'success'} estado - Estado del componente
 * @param {Array} items - Datos a mostrar en estado success
 */
function ListaConEstados({ estado, items }) {
  // Manejar casos especiales antes del JSX principal
  if (estado === 'loading') return <p>Cargando...</p>;
  if (estado === 'error')   return <p style={{ color: 'red' }}>Error al cargar los datos.</p>;
  if (estado === 'empty')   return <p style={{ color: '#6b7280' }}>No hay elementos.</p>;

  // Solo llegamos aquí si estado === 'success'
  return (
    <ul>
      {items.map(item => (
        <li key={item.id}>{item.texto}</li>
      ))}
    </ul>
  );
}

// ─── 6. Retornar null para no renderizar ─────────────────────────────────────

/**
 * Un componente puede retornar null para no renderizar absolutamente nada.
 * Útil para notificaciones que se muestran/ocultan condicionalmente.
 * @param {boolean} visible - Si la alerta debe mostrarse
 * @param {string} mensaje - Texto de la alerta
 */
function Alerta({ visible, mensaje }) {
  // Si no es visible, no renderiza nada en el DOM
  if (!visible) return null;

  return (
    <div style={{ background: '#fef3c7', border: '1px solid #f59e0b', padding: '8px', borderRadius: '4px' }}>
      ⚠️ {mensaje}
    </div>
  );
}

// ─── Datos de ejemplo ────────────────────────────────────────────────────────

const librosEjemplo = [
  { id: 1, titulo: 'Génesis',  autor: 'Moisés',     anio: -1400 },
  { id: 2, titulo: 'Salmos',   autor: 'David',       anio: -1000 },
  { id: 3, titulo: 'Juan',     autor: 'Juan Apóstol', anio: 90  },
  { id: 4, titulo: 'Apocalipsis', autor: 'Juan',     anio: 95   },
];

const itemsConId = [
  { id: 'a1', nombre: 'Elemento Alpha' },
  { id: 'b2', nombre: 'Elemento Beta' },
  { id: 'c3', nombre: 'Elemento Gamma' },
];

// ─── Componente raíz ─────────────────────────────────────────────────────────

/**
 * Componente raíz que agrupa todos los demos del módulo.
 */
export default function ModuloListasCondicional() {
  return (
    <div style={{ fontFamily: 'sans-serif', padding: '20px' }}>
      <h1>Módulo 20 — Listas y Condicional</h1>

      <h2>1. Listas con map + key correcta</h2>
      <ListaLibros libros={librosEjemplo} />

      <h2>2. Buena key vs mala key</h2>
      <p>✓ Con ID único:</p>
      <BuenaKey items={itemsConId} />

      <h2>3. Operador &&</h2>
      <BannerBienvenida estaAutenticado={true} nombre="Ana" />
      <BannerBienvenida estaAutenticado={false} nombre="" />

      <h2>4. Ternario</h2>
      <EstadoCarga cargando={true} datos={null} />
      <EstadoCarga cargando={false} datos={librosEjemplo} />

      <h2>5. if antes del return</h2>
      <ListaConEstados estado="loading" items={[]} />
      <ListaConEstados estado="empty" items={[]} />
      <ListaConEstados estado="success" items={[{ id: 1, texto: 'Ítem cargado' }]} />

      <h2>6. Retornar null</h2>
      <Alerta visible={true} mensaje="Esta alerta es visible" />
      <Alerta visible={false} mensaje="Esta no se verá" />
      <p>La segunda Alerta retornó null — no aparece en el DOM.</p>
    </div>
  );
}
