// ============================================================
// ARCHIVO: 04_custom_hooks.jsx
// TEMA: Custom Hooks — lógica reutilizable encapsulada
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// ============================================================

import { useState, useEffect, useCallback } from 'react';

// ─────────────────────────────────────────────────────────────
// REGLA: los custom hooks siempre deben empezar con "use"
// Esto permite que React y ESLint apliquen las reglas de hooks.
// ─────────────────────────────────────────────────────────────

// ─── HOOK 1: useLocalStorage ──────────────────────────────────

/**
 * Estado persistido en localStorage.
 * Se comporta igual que useState pero sobrevive al recargar la página.
 *
 * @template T
 * @param {string} clave - Clave de localStorage donde se guarda el valor
 * @param {T} valorInicial - Valor por defecto si no hay datos guardados
 * @returns {[T, Function]} Par [valor, setter] igual que useState
 */
function useLocalStorage(clave, valorInicial) {
  // Inicializar leyendo localStorage — lazy initializer evita leer en cada render
  const [valor, setValor] = useState(() => {
    try {
      const guardado = localStorage.getItem(clave);
      return guardado !== null ? JSON.parse(guardado) : valorInicial;
    } catch {
      // Si hay error de parsing, usar el valor inicial
      return valorInicial;
    }
  });

  /**
   * Actualiza el valor en el estado y en localStorage simultáneamente.
   * Acepta tanto un valor directo como una función actualizadora (igual que useState).
   * @param {T | Function} nuevoValor
   */
  const guardar = useCallback((nuevoValor) => {
    setValor((prev) => {
      const valorFinal = typeof nuevoValor === 'function' ? nuevoValor(prev) : nuevoValor;
      try {
        localStorage.setItem(clave, JSON.stringify(valorFinal));
      } catch (e) {
        console.error(`useLocalStorage: no se pudo guardar en "${clave}"`, e);
      }
      return valorFinal;
    });
  }, [clave]);

  return [valor, guardar];
}

// ─── HOOK 2: useFetch ─────────────────────────────────────────

/**
 * Fetch de datos con estados loading, data y error.
 * Cancela peticiones en vuelo cuando la URL cambia o el componente desmonta.
 *
 * @param {string|null} url - URL a fetchear. Si es null/undefined, no hace nada.
 * @returns {{ data: any, cargando: boolean, error: string|null, refetch: Function }}
 */
function useFetch(url) {
  const [data, setData] = useState(null);
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState(null);

  /** Función que dispara el fetch manualmente (para refetch) */
  const fetchDatos = useCallback(async (signal) => {
    if (!url) return;
    setCargando(true);
    setError(null);
    try {
      const res = await fetch(url, { signal });
      if (!res.ok) throw new Error(`HTTP ${res.status}: ${res.statusText}`);
      const json = await res.json();
      setData(json);
    } catch (e) {
      if (e.name !== 'AbortError') setError(e.message);
    } finally {
      setCargando(false);
    }
  }, [url]);

  useEffect(() => {
    const controller = new AbortController();
    fetchDatos(controller.signal);
    return () => controller.abort();
  }, [fetchDatos]);

  // refetch sin signal — para llamadas manuales del usuario
  const refetch = useCallback(() => fetchDatos(new AbortController().signal), [fetchDatos]);

  return { data, cargando, error, refetch };
}

// ─── HOOK 3: useDebounce ──────────────────────────────────────

/**
 * Retrasa la actualización de un valor hasta que el usuario para de cambiar.
 * Ideal para búsquedas: no lanzar una petición por cada tecla pulsada.
 *
 * @template T
 * @param {T} valor - Valor que se quiere debouncear
 * @param {number} delay - Tiempo en ms de espera tras el último cambio
 * @returns {T} Valor retrasado
 */
function useDebounce(valor, delay = 500) {
  const [valorRetrasado, setValorRetrasado] = useState(valor);

  useEffect(() => {
    // Programar la actualización del valor retrasado
    const timer = setTimeout(() => {
      setValorRetrasado(valor);
    }, delay);

    // Cancelar el timer si el valor cambia antes de que pase el delay
    return () => clearTimeout(timer);
  }, [valor, delay]);

  return valorRetrasado;
}

// ─── DEMOS ────────────────────────────────────────────────────

/** Demo de useLocalStorage: tema y nombre del usuario */
function DemoLocalStorage() {
  const [tema, setTema] = useLocalStorage('tema', 'oscuro');
  const [nombre, setNombre] = useLocalStorage('nombre-usuario', '');

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>1. useLocalStorage</h2>
      <p style={{ color: '#a6adc8', fontSize: '12px', marginBottom: '12px' }}>
        Los valores persisten al recargar la página (F5)
      </p>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
        <div style={s.fila}>
          <span style={s.etiqueta}>Tema:</span>
          <button style={s.btn} onClick={() => setTema((t) => t === 'claro' ? 'oscuro' : 'claro')}>
            {tema === 'oscuro' ? '🌙 Oscuro' : '☀️ Claro'}
          </button>
        </div>
        <div style={s.fila}>
          <span style={s.etiqueta}>Nombre:</span>
          <input style={s.input} value={nombre} onChange={(e) => setNombre(e.target.value)} placeholder="Tu nombre..." />
        </div>
        {nombre && <p style={{ color: '#a6e3a1', fontSize: '14px' }}>¡Hola, {nombre}! 👋</p>}
      </div>
    </section>
  );
}

/** Demo de useFetch: cargar posts de JSONPlaceholder */
function DemoFetch() {
  const [postId, setPostId] = useState(1);
  const { data, cargando, error, refetch } = useFetch(
    `https://jsonplaceholder.typicode.com/posts/${postId}`
  );

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>2. useFetch</h2>
      <div style={{ ...s.fila, marginBottom: '12px' }}>
        <button style={s.btn} onClick={() => setPostId((p) => Math.max(1, p - 1))}>←</button>
        <span style={{ color: '#cdd6f4', minWidth: '60px', textAlign: 'center' }}>Post #{postId}</span>
        <button style={s.btn} onClick={() => setPostId((p) => Math.min(100, p + 1))}>→</button>
        <button style={{ ...s.btn, background: '#a6e3a1' }} onClick={refetch}>↻</button>
      </div>
      {cargando && <p style={{ color: '#89b4fa' }}>⏳ Cargando...</p>}
      {error && <p style={{ color: '#f38ba8' }}>❌ {error}</p>}
      {data && !cargando && (
        <div>
          <p style={{ color: '#cba6f7', fontWeight: 'bold', margin: '0 0 6px', fontSize: '14px' }}>{data.title}</p>
          <p style={{ color: '#a6adc8', fontSize: '12px', margin: 0 }}>{data.body?.slice(0, 120)}...</p>
        </div>
      )}
    </section>
  );
}

/** Demo de useDebounce: búsqueda con retraso */
function DemoDebounce() {
  const [busqueda, setBusqueda] = useState('');
  const terminoRetrasado = useDebounce(busqueda, 600);
  const { data, cargando } = useFetch(
    terminoRetrasado.length > 2
      ? `https://jsonplaceholder.typicode.com/posts?title_like=${terminoRetrasado}&_limit=3`
      : null
  );

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>3. useDebounce</h2>
      <p style={{ color: '#a6adc8', fontSize: '12px', marginBottom: '10px' }}>
        La búsqueda espera 600ms tras la última tecla pulsada
      </p>
      <input style={{ ...s.input, width: '100%', boxSizing: 'border-box', marginBottom: '8px' }}
        value={busqueda} onChange={(e) => setBusqueda(e.target.value)} placeholder="Buscar posts (mín 3 letras)..." />
      <p style={{ color: '#6c7086', fontSize: '12px', marginBottom: '8px' }}>
        Escribiendo: "{busqueda}" | Buscando: "{terminoRetrasado}"
      </p>
      {cargando && <p style={{ color: '#89b4fa', fontSize: '13px' }}>⏳ Buscando...</p>}
      {data?.map((p) => (
        <p key={p.id} style={{ color: '#cdd6f4', fontSize: '12px', borderLeft: '2px solid #cba6f7', paddingLeft: '8px', margin: '4px 0' }}>{p.title}</p>
      ))}
      {data?.length === 0 && <p style={{ color: '#6c7086', fontSize: '13px' }}>Sin resultados</p>}
    </section>
  );
}

// ─── ESTILOS ──────────────────────────────────────────────────
const s = {
  seccion: { background: '#313244', borderRadius: '10px', padding: '20px', marginBottom: '16px' },
  titulo: { color: '#cba6f7', marginTop: 0, marginBottom: '12px', fontSize: '16px' },
  fila: { display: 'flex', gap: '8px', alignItems: 'center' },
  etiqueta: { color: '#a6adc8', fontSize: '13px', minWidth: '60px' },
  btn: { padding: '6px 14px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' },
  input: { flex: 1, padding: '8px 10px', background: '#1e1e2e', color: '#cdd6f4', border: '1px solid #45475a', borderRadius: '6px', fontSize: '13px' },
};

export default function App() {
  return (
    <div style={{ background: '#181825', minHeight: '100vh', padding: '24px', fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ color: '#cba6f7', textAlign: 'center', marginBottom: '4px' }}>Custom Hooks</h1>
      <p style={{ color: '#6c7086', textAlign: 'center', fontSize: '13px', marginBottom: '24px' }}>useLocalStorage · useFetch · useDebounce</p>
      <div style={{ maxWidth: '520px', margin: '0 auto' }}>
        <DemoLocalStorage />
        <DemoFetch />
        <DemoDebounce />
      </div>
    </div>
  );
}
