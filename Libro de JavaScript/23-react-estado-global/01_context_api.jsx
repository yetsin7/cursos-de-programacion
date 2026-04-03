// ============================================================
// ARCHIVO: 01_context_api.jsx
// TEMA: Context API — estado global con createContext y useContext
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// ============================================================

import { createContext, useContext, useState, useCallback } from 'react';

// ─── CONTEXTO 1: TEMA (claro/oscuro) ─────────────────────────

/**
 * Contexto para gestionar el tema visual de la aplicación.
 * Se crea fuera del componente para que sea estable entre renders.
 */
const TemaContext = createContext(null);

/**
 * Hook personalizado para consumir el TemaContext.
 * Lanzar un error descriptivo si se usa fuera del Provider
 * ayuda a detectar errores de uso temprano.
 * @returns {{ tema: string, toggleTema: Function, colores: object }}
 */
function useTema() {
  const context = useContext(TemaContext);
  if (!context) {
    throw new Error('useTema debe usarse dentro de <TemaProvider>');
  }
  return context;
}

/**
 * Provider del tema. Envuelve la parte de la app que necesita acceder al tema.
 * @param {{ children: React.ReactNode }} props
 */
function TemaProvider({ children }) {
  const [tema, setTema] = useState('oscuro');

  const toggleTema = useCallback(() => {
    setTema((t) => t === 'oscuro' ? 'claro' : 'oscuro');
  }, []);

  // Paleta de colores según el tema actual
  const colores = tema === 'oscuro'
    ? { fondo: '#181825', superficie: '#313244', texto: '#cdd6f4', acento: '#cba6f7', secundario: '#6c7086' }
    : { fondo: '#eff1f5', superficie: '#e6e9ef', texto: '#4c4f69', acento: '#7287fd', secundario: '#9ca0b0' };

  // value: lo que los consumidores van a recibir al llamar useContext
  return (
    <TemaContext.Provider value={{ tema, toggleTema, colores }}>
      {children}
    </TemaContext.Provider>
  );
}

// ─── CONTEXTO 2: USUARIO AUTENTICADO ─────────────────────────

/** Contexto para el usuario de la sesión actual */
const UsuarioContext = createContext(null);

function useUsuario() {
  const context = useContext(UsuarioContext);
  if (!context) throw new Error('useUsuario debe usarse dentro de <UsuarioProvider>');
  return context;
}

function UsuarioProvider({ children }) {
  const [usuario, setUsuario] = useState(null);

  const iniciarSesion = useCallback((nombre) => {
    setUsuario({ nombre, rol: 'usuario', avatar: nombre[0].toUpperCase() });
  }, []);

  const cerrarSesion = useCallback(() => setUsuario(null), []);

  return (
    <UsuarioContext.Provider value={{ usuario, iniciarSesion, cerrarSesion }}>
      {children}
    </UsuarioContext.Provider>
  );
}

// ─── COMPONENTES CONSUMIDORES ─────────────────────────────────

/**
 * Barra de navegación superior.
 * Consume AMBOS contextos para mostrar tema y usuario.
 * No necesita recibir props — obtiene todo del contexto directamente.
 */
function BarraNavegacion() {
  const { tema, toggleTema, colores } = useTema();
  const { usuario, cerrarSesion } = useUsuario();

  return (
    <header style={{ background: colores.superficie, padding: '12px 20px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: `1px solid ${colores.secundario}` }}>
      <span style={{ color: colores.acento, fontWeight: 'bold' }}>Mi App</span>
      <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
        {usuario ? (
          <>
            <span style={{ color: colores.texto, fontSize: '13px' }}>👤 {usuario.nombre}</span>
            <button style={boton(colores, '#f38ba8')} onClick={cerrarSesion}>Salir</button>
          </>
        ) : (
          <span style={{ color: colores.secundario, fontSize: '13px' }}>Sin sesión</span>
        )}
        <button style={boton(colores)} onClick={toggleTema}>
          {tema === 'oscuro' ? '☀️ Claro' : '🌙 Oscuro'}
        </button>
      </div>
    </header>
  );
}

/** Tarjeta que muestra info del tema actual — consume TemaContext */
function TarjetaTema() {
  const { tema, colores } = useTema();
  return (
    <div style={{ background: colores.superficie, borderRadius: '10px', padding: '16px', marginBottom: '12px' }}>
      <h3 style={{ color: colores.acento, marginTop: 0, fontSize: '15px' }}>Tema activo: {tema}</h3>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '8px' }}>
        {Object.entries(colores).map(([nombre, hex]) => (
          <div key={nombre} style={{ textAlign: 'center' }}>
            <div style={{ background: hex, height: '32px', borderRadius: '6px', border: '1px solid #45475a' }} />
            <p style={{ color: colores.secundario, fontSize: '10px', margin: '3px 0 0' }}>{nombre}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

/** Formulario de login — consume UsuarioContext */
function FormularioLogin() {
  const { usuario, iniciarSesion } = useUsuario();
  const { colores } = useTema();
  const [nombre, setNombre] = useState('');

  if (usuario) {
    return (
      <div style={{ background: colores.superficie, borderRadius: '10px', padding: '16px', marginBottom: '12px' }}>
        <h3 style={{ color: colores.acento, marginTop: 0, fontSize: '15px' }}>Sesión activa</h3>
        <p style={{ color: colores.texto, margin: 0 }}>
          Bienvenido, <strong>{usuario.nombre}</strong> — Rol: {usuario.rol}
        </p>
      </div>
    );
  }

  return (
    <div style={{ background: colores.superficie, borderRadius: '10px', padding: '16px', marginBottom: '12px' }}>
      <h3 style={{ color: colores.acento, marginTop: 0, fontSize: '15px' }}>Iniciar Sesión</h3>
      <div style={{ display: 'flex', gap: '8px' }}>
        <input
          style={{ flex: 1, padding: '8px 12px', background: colores.fondo, color: colores.texto, border: `1px solid ${colores.secundario}`, borderRadius: '6px' }}
          value={nombre} onChange={(e) => setNombre(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && nombre && iniciarSesion(nombre)}
          placeholder="Tu nombre..." />
        <button style={boton(colores, '#a6e3a1')} onClick={() => nombre && iniciarSesion(nombre)}>
          Entrar
        </button>
      </div>
    </div>
  );
}

/**
 * Aviso sobre el problema de re-renders con Context.
 * PROBLEMA: cuando el valor del contexto cambia, TODOS los consumidores
 * se re-renderizan, aunque solo hayan cambiado datos que no les afectan.
 * SOLUCIÓN: separar contextos por responsabilidad (tema, usuario, carrito, etc.)
 */
function AdvertenciaContexto() {
  const { colores } = useTema();
  return (
    <div style={{ background: colores.superficie, borderRadius: '10px', padding: '16px', border: `1px solid #fab387` }}>
      <h3 style={{ color: '#fab387', marginTop: 0, fontSize: '15px' }}>⚠️ Problema de Context API</h3>
      <p style={{ color: colores.texto, fontSize: '13px', lineHeight: '1.6', margin: 0 }}>
        Cuando el <em>value</em> del Provider cambia, <strong>todos los consumidores se re-renderizan</strong>, incluso los que no usan el dato que cambió. Esta demo usa contextos separados (TemaContext y UsuarioContext) para minimizar re-renders innecesarios. Para estado más complejo, considera Zustand (ver archivo 02).
      </p>
    </div>
  );
}

/** Helper para estilos de botón */
const boton = (colores, bg = '#89b4fa') => ({
  padding: '6px 12px', background: bg, color: '#1e1e2e',
  border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold', fontSize: '13px',
});

// ─── APP RAÍZ ────────────────────────────────────────────────

/**
 * App con múltiples Providers anidados.
 * El orden importa: el Provider exterior puede ser consumido por los interiores.
 */
export default function App() {
  return (
    // Composición de providers: cada uno es independiente y tiene su propia responsabilidad
    <TemaProvider>
      <UsuarioProvider>
        <PaginaPrincipal />
      </UsuarioProvider>
    </TemaProvider>
  );
}

/** Página principal — accede a los contextos a través de los hooks personalizados */
function PaginaPrincipal() {
  const { colores } = useTema();
  return (
    <div style={{ background: colores.fondo, minHeight: '100vh', fontFamily: 'system-ui, sans-serif' }}>
      <BarraNavegacion />
      <div style={{ maxWidth: '540px', margin: '0 auto', padding: '20px' }}>
        <h1 style={{ color: colores.acento, marginTop: 0 }}>Context API</h1>
        <TarjetaTema />
        <FormularioLogin />
        <AdvertenciaContexto />
      </div>
    </div>
  );
}
