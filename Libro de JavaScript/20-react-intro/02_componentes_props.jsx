// =============================================================================
// ARCHIVO: 02_componentes_props.jsx
// TEMA: Componentes funcionales, props, children y reutilización
// NOTA: Requiere proyecto Vite → npm create vite@latest mi-app -- --template react
// =============================================================================

// ─── 1. Functional component básico ─────────────────────────────────────────

/**
 * El componente más simple posible: una función que retorna JSX.
 * Por convención, los componentes empiezan con letra MAYÚSCULA.
 */
function Saludo() {
  return <h2>¡Hola desde un componente!</h2>;
}

// ─── 2. Props: pasar datos de padre a hijo ───────────────────────────────────

/**
 * Las props son el mecanismo para pasar datos de un componente padre al hijo.
 * Se desestructuran directamente en los parámetros de la función.
 * Son de solo lectura — el hijo NO debe modificar sus props.
 * @param {string} nombre - Nombre del usuario
 * @param {number} edad - Edad del usuario
 * @param {string} [ciudad='No especificada'] - Ciudad (opcional con default)
 */
function TarjetaUsuario({ nombre, edad, ciudad = 'No especificada' }) {
  return (
    <div style={estilos.tarjeta}>
      <h3>{nombre}</h3>
      <p>Edad: {edad} años</p>
      <p>Ciudad: {ciudad}</p>
    </div>
  );
}

// ─── 3. Props por defecto con parámetros default ─────────────────────────────

/**
 * Componente de botón reutilizable con variantes.
 * Usa valores por defecto en la desestructuración para props opcionales.
 * @param {string} texto - Texto del botón
 * @param {'primario'|'secundario'|'peligro'} [variante='primario'] - Estilo visual
 * @param {boolean} [deshabilitado=false] - Si el botón está deshabilitado
 * @param {Function} [onClick] - Callback al hacer clic
 */
function Boton({ texto, variante = 'primario', deshabilitado = false, onClick }) {
  const colores = {
    primario:   { background: '#3b82f6', color: 'white' },
    secundario: { background: '#6b7280', color: 'white' },
    peligro:    { background: '#ef4444', color: 'white' },
  };

  return (
    <button
      onClick={onClick}
      disabled={deshabilitado}
      style={{ ...estilos.boton, ...colores[variante] }}
    >
      {texto}
    </button>
  );
}

// ─── 4. Children: composición de componentes ─────────────────────────────────

/**
 * children es una prop especial que representa el contenido JSX
 * que se anida entre las etiquetas del componente:
 * <Contenedor><p>Esto es children</p></Contenedor>
 * Es la base de la composición en React.
 * @param {string} titulo - Título de la tarjeta
 * @param {React.ReactNode} children - Contenido JSX anidado
 */
function Tarjeta({ titulo, children }) {
  return (
    <div style={estilos.tarjeta}>
      <h3 style={{ marginTop: 0, borderBottom: '1px solid #e5e7eb', paddingBottom: '8px' }}>
        {titulo}
      </h3>
      {/* children se renderiza donde se coloca */}
      <div>{children}</div>
    </div>
  );
}

// ─── 5. Componente reutilizable con variantes ────────────────────────────────

/**
 * Badge (etiqueta) reutilizable que cambia de color según el tipo.
 * Ejemplo de componente pequeño altamente reutilizable.
 * @param {string} texto - Texto de la etiqueta
 * @param {'info'|'exito'|'advertencia'|'error'} [tipo='info'] - Variante de color
 */
function Badge({ texto, tipo = 'info' }) {
  const coloresBadge = {
    info:        { background: '#dbeafe', color: '#1e40af' },
    exito:       { background: '#d1fae5', color: '#065f46' },
    advertencia: { background: '#fef3c7', color: '#92400e' },
    error:       { background: '#fee2e2', color: '#991b1b' },
  };

  return (
    <span style={{ ...estilos.badge, ...coloresBadge[tipo] }}>
      {texto}
    </span>
  );
}

// ─── Estilos inline (en proyectos reales: CSS modules o Tailwind) ─────────────
const estilos = {
  tarjeta: {
    border: '1px solid #e5e7eb',
    borderRadius: '8px',
    padding: '16px',
    marginBottom: '16px',
    maxWidth: '400px',
  },
  boton: {
    padding: '8px 16px',
    border: 'none',
    borderRadius: '6px',
    cursor: 'pointer',
    marginRight: '8px',
    fontSize: '14px',
  },
  badge: {
    padding: '2px 8px',
    borderRadius: '9999px',
    fontSize: '12px',
    fontWeight: 'bold',
    marginRight: '4px',
  },
};

// ─── Componente raíz que muestra todos los demos ─────────────────────────────

/**
 * Componente de demostración que compone todos los ejemplos del módulo.
 */
export default function ModuloComponentes() {
  return (
    <div style={{ fontFamily: 'sans-serif', padding: '20px' }}>
      <h1>Módulo 20 — Componentes y Props</h1>

      <h2>1. Componente básico</h2>
      <Saludo />

      <h2>2. Props</h2>
      {/* Pasar props como atributos JSX */}
      <TarjetaUsuario nombre="Ana García" edad={28} ciudad="Madrid" />
      <TarjetaUsuario nombre="Luis Pérez" edad={35} />  {/* sin ciudad → usa default */}

      <h2>3. Botones reutilizables</h2>
      <Boton texto="Guardar" variante="primario" onClick={() => alert('Guardado')} />
      <Boton texto="Cancelar" variante="secundario" />
      <Boton texto="Eliminar" variante="peligro" />
      <Boton texto="Deshabilitado" deshabilitado={true} />

      <h2>4. Children y composición</h2>
      <Tarjeta titulo="Información del pedido">
        {/* Esto es children */}
        <p>Pedido #1234 — En camino</p>
        <Badge texto="Enviado" tipo="exito" />
        <Badge texto="Express" tipo="info" />
      </Tarjeta>

      <h2>5. Badges</h2>
      <Badge texto="Nuevo" tipo="info" />
      <Badge texto="Activo" tipo="exito" />
      <Badge texto="Pendiente" tipo="advertencia" />
      <Badge texto="Error" tipo="error" />
    </div>
  );
}
