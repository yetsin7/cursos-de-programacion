// ============================================================
// ARCHIVO: 02_navegacion_avanzada.jsx
// TEMA: Rutas anidadas, Outlet, búsqueda, rutas privadas
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// DEPENDENCIA: npm install react-router-dom
// ============================================================

import {
  BrowserRouter, Routes, Route, Link, NavLink, Outlet,
  Navigate, useNavigate, useLocation, useSearchParams,
} from 'react-router-dom';
import { useState } from 'react';

// ─── SIMULACIÓN DE AUTENTICACIÓN ─────────────────────────────

/**
 * Estado global de autenticación simulado (en app real usaría Context/Zustand).
 * No usar variables globales así en producción — solo para la demo.
 */
let usuarioAutenticado = null;

// ─── LAYOUT COMPARTIDO ────────────────────────────────────────

/** Estilos reutilizables */
const s = {
  pagina: { padding: '20px', color: '#cdd6f4', fontFamily: 'system-ui, sans-serif' },
  titulo: { color: '#cba6f7', marginTop: 0 },
  nav: { display: 'flex', gap: '8px', padding: '12px 20px', background: '#313244', flexWrap: 'wrap', alignItems: 'center' },
  subnav: { display: 'flex', gap: '8px', padding: '8px 20px', background: '#1e1e2e', borderBottom: '1px solid #45475a' },
  btn: { padding: '6px 14px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold', fontSize: '13px' },
};

const estiloNavLink = ({ isActive }) => ({
  padding: '5px 12px', background: isActive ? '#cba6f7' : '#45475a',
  color: isActive ? '#1e1e2e' : '#cdd6f4', borderRadius: '6px',
  textDecoration: 'none', fontSize: '13px', fontWeight: isActive ? 'bold' : 'normal',
});

// ─── LAYOUT CON OUTLET ────────────────────────────────────────

/**
 * Layout de la sección "Dashboard" con navegación interna.
 * Outlet renderiza el componente hijo que coincide con la sub-ruta actual.
 * Permite que el header/nav del dashboard persista entre sus sub-páginas.
 */
function LayoutDashboard() {
  return (
    <div>
      {/* Sub-navegación del dashboard — persiste entre sub-rutas */}
      <nav style={s.subnav}>
        <span style={{ color: '#6c7086', fontSize: '12px', marginRight: '4px' }}>Dashboard:</span>
        <NavLink to="/dashboard" end style={estiloNavLink}>Resumen</NavLink>
        <NavLink to="/dashboard/perfil" style={estiloNavLink}>Perfil</NavLink>
        <NavLink to="/dashboard/configuracion" style={estiloNavLink}>Config</NavLink>
      </nav>
      {/* Outlet: aquí se renderiza la sub-ruta activa (/dashboard/perfil, etc.) */}
      <Outlet />
    </div>
  );
}

/** Sub-página del dashboard: resumen */
function DashboardResumen() {
  const location = useLocation();
  return (
    <div style={s.pagina}>
      <h2 style={s.titulo}>Dashboard — Resumen</h2>
      <p style={{ color: '#a6e3a1', fontSize: '13px' }}>Ruta actual: {location.pathname}</p>
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
        {[['Visitas', '1,234'], ['Ventas', '56'], ['Usuarios', '89'], ['Ingresos', '$4,200']].map(([k, v]) => (
          <div key={k} style={{ background: '#313244', borderRadius: '8px', padding: '14px', textAlign: 'center' }}>
            <p style={{ color: '#6c7086', fontSize: '12px', margin: '0 0 4px' }}>{k}</p>
            <p style={{ color: '#cba6f7', fontSize: '22px', fontWeight: 'bold', margin: 0 }}>{v}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

/** Sub-página del dashboard: perfil */
function DashboardPerfil() {
  return (
    <div style={s.pagina}>
      <h2 style={s.titulo}>Dashboard — Perfil</h2>
      <p style={{ color: '#a6adc8' }}>Información del perfil de {usuarioAutenticado?.nombre || 'Usuario'}.</p>
    </div>
  );
}

/** Sub-página del dashboard: configuración */
function DashboardConfig() {
  return (
    <div style={s.pagina}>
      <h2 style={s.titulo}>Dashboard — Configuración</h2>
      <p style={{ color: '#a6adc8' }}>Ajustes de la cuenta y preferencias.</p>
    </div>
  );
}

// ─── useSearchParams — QUERY STRINGS ─────────────────────────

/**
 * Página de búsqueda que lee y escribe query params en la URL.
 * useSearchParams funciona igual que useState pero persiste en la URL.
 * Esto permite compartir URLs con el estado de búsqueda incluido.
 */
function Busqueda() {
  // useSearchParams es como useState pero sincronizado con ?q=...&categoria=...
  const [params, setParams] = useSearchParams();
  const q = params.get('q') || '';
  const categoria = params.get('categoria') || 'todos';

  const PRODUCTOS = [
    { id: 1, nombre: 'Teclado mecánico', categoria: 'periféricos' },
    { id: 2, nombre: 'Monitor 4K', categoria: 'monitores' },
    { id: 3, nombre: 'Mouse gaming', categoria: 'periféricos' },
    { id: 4, nombre: 'Monitor curvo', categoria: 'monitores' },
    { id: 5, nombre: 'Auriculares USB', categoria: 'audio' },
  ];

  const filtrados = PRODUCTOS.filter((p) => {
    const coincideTexto = p.nombre.toLowerCase().includes(q.toLowerCase());
    const coincideCategoria = categoria === 'todos' || p.categoria === categoria;
    return coincideTexto && coincideCategoria;
  });

  /**
   * Actualiza los query params sin navegar a otra página.
   * @param {string} clave
   * @param {string} valor
   */
  const actualizarParam = (clave, valor) => {
    setParams((prev) => {
      const nuevo = new URLSearchParams(prev);
      if (valor) nuevo.set(clave, valor);
      else nuevo.delete(clave);
      return nuevo;
    });
  };

  return (
    <div style={s.pagina}>
      <h2 style={s.titulo}>Búsqueda (useSearchParams)</h2>
      <p style={{ color: '#6c7086', fontSize: '12px', marginBottom: '12px' }}>
        URL actual: <code style={{ color: '#89b4fa' }}>?q={q}&categoria={categoria}</code>
      </p>
      <input
        style={{ padding: '8px 12px', background: '#313244', color: '#cdd6f4', border: '1px solid #45475a', borderRadius: '6px', width: '100%', boxSizing: 'border-box', marginBottom: '10px' }}
        value={q} onChange={(e) => actualizarParam('q', e.target.value)} placeholder="Buscar productos..." />
      <div style={{ display: 'flex', gap: '6px', marginBottom: '16px', flexWrap: 'wrap' }}>
        {['todos', 'periféricos', 'monitores', 'audio'].map((cat) => (
          <button key={cat} style={{ ...s.btn, background: categoria === cat ? '#cba6f7' : '#45475a', color: categoria === cat ? '#1e1e2e' : '#cdd6f4' }}
            onClick={() => actualizarParam('categoria', cat === 'todos' ? '' : cat)}>
            {cat}
          </button>
        ))}
      </div>
      {filtrados.length === 0 ? (
        <p style={{ color: '#6c7086' }}>Sin resultados</p>
      ) : (
        filtrados.map((p) => (
          <div key={p.id} style={{ background: '#313244', borderRadius: '8px', padding: '12px', marginBottom: '8px' }}>
            <p style={{ margin: 0, color: '#cdd6f4' }}>{p.nombre}</p>
            <p style={{ margin: '2px 0 0', color: '#89b4fa', fontSize: '12px' }}>{p.categoria}</p>
          </div>
        ))
      )}
    </div>
  );
}

// ─── RUTA PRIVADA ─────────────────────────────────────────────

/**
 * Componente que protege rutas que requieren autenticación.
 * Si el usuario NO está autenticado, redirige al login.
 * Si SÍ está autenticado, renderiza el contenido (children o Outlet).
 *
 * @param {{ children: React.ReactNode }} props
 */
function RutaPrivada({ children }) {
  const location = useLocation();

  if (!usuarioAutenticado) {
    // Navigate redirige de forma declarativa.
    // state={{ desde: location }} guarda la ruta original para redirigir
    // después del login (UX amigable).
    return <Navigate to="/login" state={{ desde: location }} replace />;
  }

  return children;
}

/** Página de Login */
function Login() {
  const navegar = useNavigate();
  const location = useLocation();
  const [form, setForm] = useState({ usuario: '', contrasena: '' });

  // Ruta a la que redirigir después del login (guardada por RutaPrivada)
  const desde = location.state?.desde?.pathname || '/dashboard';

  const handleLogin = (e) => {
    e.preventDefault();
    if (form.usuario && form.contrasena) {
      usuarioAutenticado = { nombre: form.usuario };
      navegar(desde, { replace: true }); // replace: no guardar /login en el historial
    }
  };

  return (
    <div style={{ ...s.pagina, maxWidth: '360px', margin: '40px auto' }}>
      <h2 style={s.titulo}>Iniciar Sesión</h2>
      {location.state?.desde && (
        <p style={{ color: '#fab387', fontSize: '13px' }}>
          Debes iniciar sesión para acceder a: {location.state.desde.pathname}
        </p>
      )}
      <form onSubmit={handleLogin} style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
        <input style={{ padding: '8px 12px', background: '#313244', color: '#cdd6f4', border: '1px solid #45475a', borderRadius: '6px' }}
          value={form.usuario} onChange={(e) => setForm({ ...form, usuario: e.target.value })} placeholder="Usuario" required />
        <input style={{ padding: '8px 12px', background: '#313244', color: '#cdd6f4', border: '1px solid #45475a', borderRadius: '6px' }}
          type="password" value={form.contrasena} onChange={(e) => setForm({ ...form, contrasena: e.target.value })} placeholder="Contraseña" required />
        <button style={{ ...s.btn, background: '#a6e3a1', padding: '10px' }} type="submit">Entrar</button>
      </form>
    </div>
  );
}

// ─── NAVEGACIÓN PRINCIPAL ─────────────────────────────────────

function NavPrincipal() {
  const navegar = useNavigate();
  return (
    <nav style={s.nav}>
      <NavLink to="/" end style={estiloNavLink}>Inicio</NavLink>
      <NavLink to="/busqueda" style={estiloNavLink}>Búsqueda</NavLink>
      <NavLink to="/dashboard" style={estiloNavLink}>Dashboard (privado)</NavLink>
      <NavLink to="/login" style={estiloNavLink}>Login</NavLink>
      {usuarioAutenticado && (
        <button style={{ ...s.btn, background: '#f38ba8', marginLeft: 'auto' }}
          onClick={() => { usuarioAutenticado = null; navegar('/login'); }}>
          Cerrar sesión ({usuarioAutenticado.nombre})
        </button>
      )}
    </nav>
  );
}

function Inicio() {
  return (
    <div style={s.pagina}>
      <h1 style={s.titulo}>Navegación Avanzada</h1>
      <ul style={{ color: '#a6adc8', lineHeight: '2' }}>
        <li><strong>Búsqueda</strong> — useSearchParams: estado en la URL</li>
        <li><strong>Dashboard</strong> — rutas anidadas con Outlet (requiere login)</li>
        <li><strong>Login</strong> — RutaPrivada con Navigate y useLocation</li>
      </ul>
    </div>
  );
}

/** App principal con configuración completa de rutas */
export default function App() {
  return (
    <BrowserRouter>
      <div style={{ background: '#181825', minHeight: '100vh' }}>
        <NavPrincipal />
        <Routes>
          <Route path="/" element={<Inicio />} />
          <Route path="/busqueda" element={<Busqueda />} />
          <Route path="/login" element={<Login />} />

          {/* Ruta privada: envuelve el layout en RutaPrivada */}
          <Route path="/dashboard" element={<RutaPrivada><LayoutDashboard /></RutaPrivada>}>
            {/* Rutas anidadas: el path es relativo al padre (/dashboard) */}
            <Route index element={<DashboardResumen />} />
            <Route path="perfil" element={<DashboardPerfil />} />
            <Route path="configuracion" element={<DashboardConfig />} />
          </Route>

          <Route path="*" element={
            <div style={{ ...s.pagina, textAlign: 'center', paddingTop: '60px' }}>
              <h1 style={{ ...s.titulo, fontSize: '28px' }}>404</h1>
              <Link to="/" style={{ color: '#89b4fa' }}>Volver al inicio</Link>
            </div>
          } />
        </Routes>
      </div>
    </BrowserRouter>
  );
}
