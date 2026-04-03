// ============================================================
// ARCHIVO: 01_rutas_basicas.jsx
// TEMA: Rutas básicas con React Router v6
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// DEPENDENCIA: npm install react-router-dom
// ============================================================

import { BrowserRouter, Routes, Route, Link, NavLink, useNavigate, useParams } from 'react-router-dom';

// ─── ESTILOS COMPARTIDOS ──────────────────────────────────────
const s = {
  nav: { display: 'flex', gap: '8px', padding: '12px 20px', background: '#313244', flexWrap: 'wrap' },
  pagina: { padding: '24px 20px', color: '#cdd6f4', fontFamily: 'system-ui, sans-serif' },
  titulo: { color: '#cba6f7', marginTop: 0 },
  btn: { padding: '8px 16px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' },
  card: { background: '#313244', borderRadius: '10px', padding: '16px 20px', marginBottom: '12px', cursor: 'pointer' },
};

// ─── PÁGINAS ──────────────────────────────────────────────────

/** Página de inicio */
function Inicio() {
  // useNavigate devuelve una función para navegar de forma programática
  // Útil para navegar después de una acción (ej: formulario enviado, login exitoso)
  const navegar = useNavigate();

  return (
    <div style={s.pagina}>
      <h1 style={s.titulo}>Inicio</h1>
      <p style={{ color: '#a6adc8' }}>Bienvenido a la demo de React Router v6.</p>
      <div style={{ display: 'flex', gap: '10px', flexWrap: 'wrap' }}>
        {/* Navegación programática: útil tras enviar un formulario, hacer login, etc. */}
        <button style={s.btn} onClick={() => navegar('/sobre-nosotros')}>
          Ir a Sobre Nosotros (programático)
        </button>
        <button style={{ ...s.btn, background: '#a6e3a1' }} onClick={() => navegar('/usuarios/42')}>
          Ver Usuario #42
        </button>
        {/* navigate(-1) es equivalente al botón Atrás del navegador */}
        <button style={{ ...s.btn, background: '#f38ba8', color: '#1e1e2e' }} onClick={() => navegar(-1)}>
          ← Atrás
        </button>
      </div>
    </div>
  );
}

/** Página Sobre Nosotros */
function SobreNosotros() {
  return (
    <div style={s.pagina}>
      <h1 style={s.titulo}>Sobre Nosotros</h1>
      <p style={{ color: '#a6adc8' }}>Aprendiendo React Router v6 en el Libro de JavaScript.</p>
      <p style={{ color: '#89b4fa', fontSize: '14px' }}>
        Ruta actual: <code>/sobre-nosotros</code>
      </p>
    </div>
  );
}

/** Lista de usuarios con links a sus perfiles */
const USUARIOS = [
  { id: 1, nombre: 'Ana García', rol: 'Admin' },
  { id: 2, nombre: 'Carlos López', rol: 'Editor' },
  { id: 3, nombre: 'María Rodríguez', rol: 'Usuario' },
];

/** Página con lista de usuarios */
function Usuarios() {
  return (
    <div style={s.pagina}>
      <h1 style={s.titulo}>Usuarios</h1>
      {USUARIOS.map((u) => (
        // Link es la forma correcta de navegar en React Router
        // Reemplaza <a href> para evitar recarga completa de la página
        <Link key={u.id} to={`/usuarios/${u.id}`} style={{ textDecoration: 'none' }}>
          <div style={s.card}>
            <p style={{ margin: 0, color: '#cdd6f4', fontWeight: 'bold' }}>{u.nombre}</p>
            <p style={{ margin: '4px 0 0', color: '#89b4fa', fontSize: '13px' }}>{u.rol}</p>
          </div>
        </Link>
      ))}
    </div>
  );
}

/**
 * Perfil de usuario individual.
 * useParams lee los segmentos dinámicos de la URL (:id → params.id).
 */
function PerfilUsuario() {
  // useParams devuelve un objeto con todos los parámetros de la ruta
  // Para la ruta /usuarios/:id con URL /usuarios/2 → params = { id: '2' }
  const { id } = useParams();
  const usuario = USUARIOS.find((u) => u.id === parseInt(id));

  if (!usuario) {
    return (
      <div style={s.pagina}>
        <h1 style={{ ...s.titulo, color: '#f38ba8' }}>Usuario no encontrado</h1>
        <p style={{ color: '#a6adc8' }}>No existe un usuario con id: {id}</p>
        <Link to="/usuarios" style={{ color: '#89b4fa' }}>← Volver a la lista</Link>
      </div>
    );
  }

  return (
    <div style={s.pagina}>
      <h1 style={s.titulo}>{usuario.nombre}</h1>
      <p style={{ color: '#a6adc8' }}>ID: {id} | Rol: {usuario.rol}</p>
      <Link to="/usuarios" style={{ color: '#89b4fa', fontSize: '14px' }}>← Todos los usuarios</Link>
    </div>
  );
}

/** Página 404 para rutas no definidas */
function PaginaNoEncontrada() {
  const navegar = useNavigate();
  return (
    <div style={{ ...s.pagina, textAlign: 'center', paddingTop: '60px' }}>
      <p style={{ fontSize: '64px', margin: '0 0 8px' }}>🔍</p>
      <h1 style={{ ...s.titulo, fontSize: '28px' }}>404 — Página no encontrada</h1>
      <p style={{ color: '#a6adc8', marginBottom: '20px' }}>La ruta que buscas no existe en esta aplicación.</p>
      <button style={s.btn} onClick={() => navegar('/')}>Ir al inicio</button>
    </div>
  );
}

// ─── BARRA DE NAVEGACIÓN ──────────────────────────────────────

/**
 * Barra de navegación con NavLink.
 * NavLink aplica la clase "active" automáticamente a la ruta activa.
 * Se puede estilizar con la prop style={(({ isActive }) => ...) }
 */
function BarraNav() {
  // Estilos del link de navegación según si está activo o no
  const estiloLink = ({ isActive }) => ({
    padding: '6px 14px',
    background: isActive ? '#cba6f7' : '#45475a',
    color: isActive ? '#1e1e2e' : '#cdd6f4',
    borderRadius: '6px',
    textDecoration: 'none',
    fontWeight: isActive ? 'bold' : 'normal',
    fontSize: '14px',
    transition: 'all 0.15s',
  });

  return (
    <nav style={s.nav}>
      {/* NavLink añade clase "active" automáticamente cuando la ruta coincide */}
      <NavLink to="/" end style={estiloLink}>Inicio</NavLink>
      <NavLink to="/sobre-nosotros" style={estiloLink}>Sobre Nosotros</NavLink>
      <NavLink to="/usuarios" style={estiloLink}>Usuarios</NavLink>
      <NavLink to="/ruta-inexistente" style={estiloLink}>404 Demo</NavLink>
    </nav>
  );
}

// ─── APP PRINCIPAL ────────────────────────────────────────────

/**
 * App raíz con todas las rutas configuradas.
 * BrowserRouter debe envolver toda la app exactamente una vez.
 */
export default function App() {
  return (
    // BrowserRouter habilita la navegación basada en el historial del navegador
    <BrowserRouter>
      <div style={{ background: '#181825', minHeight: '100vh', fontFamily: 'system-ui, sans-serif' }}>
        <BarraNav />

        {/* Routes renderiza SOLO la primera Route que coincide con la URL actual */}
        <Routes>
          {/* end en NavLink y exact equivalente en Route: coincidencia exacta */}
          <Route path="/" element={<Inicio />} />
          <Route path="/sobre-nosotros" element={<SobreNosotros />} />
          <Route path="/usuarios" element={<Usuarios />} />

          {/* Ruta con parámetro dinámico: :id captura cualquier segmento */}
          <Route path="/usuarios/:id" element={<PerfilUsuario />} />

          {/* Ruta 404: path="*" captura cualquier ruta no definida — SIEMPRE al final */}
          <Route path="*" element={<PaginaNoEncontrada />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}
