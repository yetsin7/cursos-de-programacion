// ============================================================
// ARCHIVO: 03_usememo_usecallback.jsx
// TEMA: useMemo, useCallback y React.memo — optimización de renders
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// ============================================================

import { useState, useMemo, useCallback, memo, useRef } from 'react';

// ─── CONTADOR DE RENDERS ──────────────────────────────────────

/**
 * Hook de utilidad para contar cuántas veces se renderiza un componente.
 * Solo útil para depuración y demostraciones educativas.
 * @returns {number} Número de renders acumulados
 */
function useContadorRenders() {
  const ref = useRef(0);
  ref.current += 1;
  return ref.current;
}

// ─── EJEMPLO 1: useMemo — memorizar resultados costosos ───────

/**
 * Simula un cálculo costoso (ordenar una lista grande).
 * En una app real podría ser filtrado de miles de items,
 * cálculos matemáticos pesados, o transformaciones de datos.
 * @param {number[]} numeros - Array de números a ordenar
 * @returns {number[]} Array ordenado
 */
function calcularOrdenado(numeros) {
  console.log('⚙️ Recalculando lista ordenada...');
  // Simular trabajo pesado
  const inicio = performance.now();
  while (performance.now() - inicio < 5) {} // 5ms de bloqueo artificial
  return [...numeros].sort((a, b) => a - b);
}

/** Demostración del problema que resuelve useMemo */
function EjemploUseMemo() {
  const renders = useContadorRenders();
  const [numeros] = useState(() => Array.from({ length: 20 }, () => Math.floor(Math.random() * 100)));
  const [tema, setTema] = useState('claro');

  // SIN useMemo: calcularOrdenado se ejecuta en CADA render,
  // incluso cuando numeros no cambia (ej: al cambiar tema)
  // const ordenados = calcularOrdenado(numeros);

  // CON useMemo: solo recalcula cuando numeros cambia
  // Segundo argumento: array de dependencias (igual que useEffect)
  const ordenados = useMemo(() => calcularOrdenado(numeros), [numeros]);

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>1. useMemo</h2>
      <p style={s.renders}>Renders: {renders}</p>
      <p style={{ color: '#a6adc8', fontSize: '13px', marginBottom: '8px' }}>
        Cambiar el tema NO recalcula la lista ordenada (ver consola)
      </p>
      <button style={{ ...s.btn, marginBottom: '10px' }} onClick={() => setTema((t) => t === 'claro' ? 'oscuro' : 'claro')}>
        Tema: {tema}
      </button>
      <p style={{ color: '#89b4fa', fontSize: '13px' }}>
        Primeros 5 ordenados: {ordenados.slice(0, 5).join(', ')}...
      </p>
    </section>
  );
}

// ─── EJEMPLO 2: React.memo + useCallback ─────────────────────

/**
 * Componente hijo que muestra un item de la lista.
 * React.memo evita re-renders si las props no cambian.
 * Sin React.memo, este componente se re-renderizaría cada vez
 * que el padre se renderice, aunque sus props sean iguales.
 */
const ItemLista = memo(function ItemLista({ texto, onEliminar }) {
  const renders = useContadorRenders();
  return (
    <li style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '6px 10px', background: '#1e1e2e', borderRadius: '6px', marginBottom: '4px' }}>
      <span style={{ color: '#cdd6f4', fontSize: '13px' }}>{texto}</span>
      <span style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
        <span style={{ color: '#6c7086', fontSize: '11px' }}>renders: {renders}</span>
        <button style={{ ...s.btn, padding: '2px 8px', background: '#f38ba8', color: '#1e1e2e', fontSize: '12px' }} onClick={onEliminar}>✕</button>
      </span>
    </li>
  );
});

/**
 * Lista que demuestra cómo React.memo + useCallback previenen renders.
 * Problema: cada vez que el padre se re-renderiza, crea una nueva
 * función onEliminar. Para React.memo, una nueva función = props cambiaron.
 * Solución: useCallback memoriza la referencia de la función.
 */
function EjemploUseCallback() {
  const renders = useContadorRenders();
  const [items, setItems] = useState(['Primer item', 'Segundo item', 'Tercer item']);
  const [contador, setContador] = useState(0);

  // SIN useCallback: nueva función en cada render → ItemLista siempre re-renderiza
  // const eliminar = (i) => setItems((prev) => prev.filter((_, idx) => idx !== i));

  // CON useCallback: misma referencia de función → React.memo detecta que props no cambiaron
  const eliminar = useCallback((indice) => {
    setItems((prev) => prev.filter((_, i) => i !== indice));
  }, []); // Dependencias vacías: la función nunca necesita reconstruirse

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>2. React.memo + useCallback</h2>
      <p style={s.renders}>Renders del padre: {renders}</p>
      <button style={{ ...s.btn, marginBottom: '12px' }} onClick={() => setContador((p) => p + 1)}>
        Re-renderizar padre ({contador})
      </button>
      <p style={{ color: '#a6adc8', fontSize: '12px', marginBottom: '8px' }}>
        El contador de cada item no debe aumentar al hacer clic en "Re-renderizar padre"
      </p>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {items.map((item, i) => (
          <ItemLista key={item} texto={item} onEliminar={() => eliminar(i)} />
        ))}
      </ul>
    </section>
  );
}

// ─── EJEMPLO 3: Advertencia — no optimizar prematuramente ────

/**
 * Panel de advertencia: useMemo y useCallback tienen un costo propio.
 * Solo usar cuando hay un problema de rendimiento medible.
 */
function AdvertenciaOptimizacion() {
  return (
    <section style={{ ...s.seccion, border: '1px solid #fab387' }}>
      <h2 style={{ ...s.titulo, color: '#fab387' }}>⚠️ No optimizar prematuramente</h2>
      <div style={{ color: '#a6adc8', fontSize: '13px', lineHeight: '1.6' }}>
        <p style={{ margin: '0 0 8px' }}><strong style={{ color: '#fab387' }}>useMemo y useCallback no son gratis.</strong> Tienen un costo de memoria y complejidad.</p>
        <p style={{ margin: '0 0 8px' }}>Solo usar cuando:</p>
        <ul style={{ paddingLeft: '16px', margin: '0 0 8px' }}>
          <li>El cálculo es <strong>mediblemente lento</strong> (usar React DevTools Profiler)</li>
          <li>El componente hijo usa <strong>React.memo</strong> y recibe la función como prop</li>
          <li>La función se usa como <strong>dependencia de useEffect</strong></li>
        </ul>
        <p style={{ margin: 0 }}>Para la mayoría de componentes, React ya es suficientemente rápido sin estas optimizaciones.</p>
      </div>
    </section>
  );
}

// ─── ESTILOS ──────────────────────────────────────────────────
const s = {
  seccion: { background: '#313244', borderRadius: '10px', padding: '20px', marginBottom: '16px' },
  titulo: { color: '#cba6f7', marginTop: 0, marginBottom: '12px', fontSize: '16px' },
  renders: { color: '#a6e3a1', fontSize: '13px', margin: '0 0 10px', padding: '4px 8px', background: '#1e1e2e', borderRadius: '4px', display: 'inline-block' },
  btn: { padding: '6px 14px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' },
};

/** App raíz con todos los ejemplos de optimización */
export default function App() {
  return (
    <div style={{ background: '#181825', minHeight: '100vh', padding: '24px', fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ color: '#cba6f7', textAlign: 'center', marginBottom: '4px' }}>useMemo · useCallback · React.memo</h1>
      <p style={{ color: '#6c7086', textAlign: 'center', fontSize: '13px', marginBottom: '24px' }}>Abre la consola del navegador para ver los logs</p>
      <div style={{ maxWidth: '540px', margin: '0 auto' }}>
        <EjemploUseMemo />
        <EjemploUseCallback />
        <AdvertenciaOptimizacion />
      </div>
    </div>
  );
}
