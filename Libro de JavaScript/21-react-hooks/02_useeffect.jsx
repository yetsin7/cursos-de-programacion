// ============================================================
// ARCHIVO: 02_useeffect.jsx
// TEMA: useEffect — efectos secundarios en componentes React
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// ============================================================

import { useState, useEffect } from 'react';

// ─── EJEMPLO 1: Actualizar el título del documento ────────────

/**
 * El título del navegador cambia según el contador.
 * [] vacío → corre solo al montar.
 * [contador] → corre cada vez que contador cambia.
 */
function EjemploTitulo() {
  const [contador, setContador] = useState(0);

  // Dependencia [contador]: el efecto corre después de cada render
  // donde el valor de `contador` haya cambiado
  useEffect(() => {
    document.title = `Contador: ${contador} | React Hooks`;
    // Cleanup opcional: restaurar el título al desmontar
    return () => { document.title = 'React App'; };
  }, [contador]);

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>1. Título del documento</h2>
      <p style={{ color: '#a6adc8', fontSize: '13px' }}>Mira la pestaña del navegador al hacer clic</p>
      <p style={s.valor}>{contador}</p>
      <button style={s.btn} onClick={() => setContador((p) => p + 1)}>Incrementar</button>
    </section>
  );
}

// ─── EJEMPLO 2: Timer con cleanup ────────────────────────────

/**
 * Cronómetro que usa setInterval.
 * La cleanup function cancela el interval al desmontar.
 * Sin cleanup, el interval seguiría corriendo y causaría memory leak.
 */
function Cronometro() {
  const [segundos, setSegundos] = useState(0);
  const [corriendo, setCorriendo] = useState(false);

  useEffect(() => {
    // Si no está corriendo, no hacer nada
    if (!corriendo) return;

    const id = setInterval(() => {
      setSegundos((prev) => prev + 1);
    }, 1000);

    // Cleanup: se ejecuta cuando el componente se desmonta
    // o antes de que el efecto corra nuevamente (cuando corriendo cambia)
    return () => clearInterval(id);
  }, [corriendo]); // Dependencia: re-ejecutar cuando corriendo cambia

  const formatear = (s) => `${String(Math.floor(s / 60)).padStart(2, '0')}:${String(s % 60).padStart(2, '0')}`;

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>2. Cronómetro (con cleanup)</h2>
      <p style={s.valor}>{formatear(segundos)}</p>
      <div style={s.fila}>
        <button style={s.btn} onClick={() => setCorriendo((p) => !p)}>
          {corriendo ? '⏸ Pausar' : '▶ Iniciar'}
        </button>
        <button style={{ ...s.btn, background: '#f38ba8', color: '#1e1e2e' }}
          onClick={() => { setCorriendo(false); setSegundos(0); }}>
          ⏹ Reset
        </button>
      </div>
    </section>
  );
}

// ─── EJEMPLO 3: Fetch con AbortController ────────────────────

/**
 * Fetch de datos de una API pública.
 * Usa AbortController para cancelar la petición si el componente
 * se desmonta antes de que la respuesta llegue — evita actualizar
 * estado en un componente ya desmontado.
 */
function FetchConAbort() {
  const [post, setPost] = useState(null);
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState(null);
  const [postId, setPostId] = useState(1);

  useEffect(() => {
    // AbortController permite cancelar una petición fetch en curso
    const controller = new AbortController();
    setCargando(true);
    setError(null);

    fetch(`https://jsonplaceholder.typicode.com/posts/${postId}`, {
      signal: controller.signal, // Conectar el signal al fetch
    })
      .then((res) => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then((datos) => {
        setPost(datos);
        setCargando(false);
      })
      .catch((err) => {
        // AbortError NO es un error real — es una cancelación intencional
        if (err.name !== 'AbortError') {
          setError(err.message);
          setCargando(false);
        }
      });

    // Cleanup: cancelar la petición si el componente se desmonta
    // o si postId cambia antes de que termine la petición anterior
    return () => controller.abort();
  }, [postId]); // Re-ejecutar cuando cambia el ID del post

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>3. Fetch con AbortController</h2>
      <div style={{ ...s.fila, marginBottom: '12px' }}>
        <button style={s.btn} onClick={() => setPostId((p) => Math.max(1, p - 1))}>←</button>
        <span style={{ color: '#cdd6f4' }}>Post #{postId}</span>
        <button style={s.btn} onClick={() => setPostId((p) => Math.min(100, p + 1))}>→</button>
      </div>
      {cargando && <p style={{ color: '#89b4fa' }}>⏳ Cargando...</p>}
      {error && <p style={{ color: '#f38ba8' }}>❌ Error: {error}</p>}
      {post && !cargando && (
        <div>
          <p style={{ color: '#a6e3a1', fontWeight: 'bold', margin: '4px 0' }}>{post.title}</p>
          <p style={{ color: '#a6adc8', fontSize: '13px', margin: '4px 0' }}>{post.body?.slice(0, 100)}...</p>
        </div>
      )}
    </section>
  );
}

// ─── EJEMPLO 4: Los 3 patrones de dependencias ───────────────

/**
 * Panel que explica visualmente los 3 patrones de useEffect.
 * Cuenta cuántas veces corre cada tipo de efecto.
 */
function PatronesDeEfecto() {
  const [valor, setValor] = useState(0);
  const [conteos, setConteos] = useState({ sinDeps: 0, vacio: 0, conDeps: 0 });

  // Sin array de dependencias → corre en CADA render
  // Raro en la práctica; suele causar bucles infinitos si actualiza estado
  useEffect(() => {
    setConteos((prev) => ({ ...prev, sinDeps: prev.sinDeps + 1 }));
  }); // eslint-disable-line react-hooks/exhaustive-deps

  // [] vacío → corre UNA sola vez al montar el componente
  // Equivalente a componentDidMount en clases
  useEffect(() => {
    setConteos((prev) => ({ ...prev, vacio: prev.vacio + 1 }));
  }, []);

  // [valor] → corre cuando valor cambia
  useEffect(() => {
    setConteos((prev) => ({ ...prev, conDeps: prev.conDeps + 1 }));
  }, [valor]);

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>4. Patrones de dependencias</h2>
      <button style={{ ...s.btn, marginBottom: '12px' }} onClick={() => setValor((p) => p + 1)}>
        Cambiar valor ({valor})
      </button>
      <div style={{ display: 'grid', gap: '8px' }}>
        <div style={s.chip}>
          <code style={s.code}>useEffect(fn)</code>
          <span style={{ color: '#f38ba8' }}>Cada render: {conteos.sinDeps}x</span>
        </div>
        <div style={s.chip}>
          <code style={s.code}>useEffect(fn, [])</code>
          <span style={{ color: '#a6e3a1' }}>Al montar: {conteos.vacio}x</span>
        </div>
        <div style={s.chip}>
          <code style={s.code}>useEffect(fn, [valor])</code>
          <span style={{ color: '#89b4fa' }}>Cuando valor cambia: {conteos.conDeps}x</span>
        </div>
      </div>
    </section>
  );
}

// ─── ESTILOS ──────────────────────────────────────────────────
const s = {
  seccion: { background: '#313244', borderRadius: '10px', padding: '20px', marginBottom: '16px' },
  titulo: { color: '#cba6f7', marginTop: 0, marginBottom: '12px', fontSize: '16px' },
  valor: { fontSize: '40px', textAlign: 'center', color: '#cdd6f4', margin: '8px 0' },
  fila: { display: 'flex', gap: '8px', alignItems: 'center' },
  btn: { padding: '6px 14px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' },
  chip: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', background: '#1e1e2e', padding: '8px 12px', borderRadius: '6px' },
  code: { color: '#fab387', fontSize: '12px', background: '#181825', padding: '2px 6px', borderRadius: '4px' },
};

/** App raíz con todos los ejemplos de useEffect */
export default function App() {
  return (
    <div style={{ background: '#181825', minHeight: '100vh', padding: '24px', fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ color: '#cba6f7', textAlign: 'center', marginBottom: '24px' }}>useEffect</h1>
      <div style={{ maxWidth: '540px', margin: '0 auto' }}>
        <EjemploTitulo />
        <Cronometro />
        <FetchConAbort />
        <PatronesDeEfecto />
      </div>
    </div>
  );
}
