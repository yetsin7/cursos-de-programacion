// ============================================================
// ARCHIVO: 01_usestate.jsx
// TEMA: useState — gestión de estado local en componentes React
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// ============================================================

import { useState } from 'react';

// ─── EJEMPLO 1: Estado simple — contador ─────────────────────

/**
 * Contador básico con incremento, decremento y reset.
 * Demuestra el uso elemental de useState con un valor primitivo.
 */
function Contador() {
  // useState devuelve [valorActual, funcionActualizadora]
  // El argumento es el valor inicial (solo se usa en el primer render)
  const [cuenta, setCuenta] = useState(0);

  // REGLA: nunca mutar el estado directamente
  // MAL:  cuenta = cuenta + 1   ← no dispara re-render
  // BIEN: setCuenta(cuenta + 1) ← React re-renderiza el componente

  // Actualización funcional: usar cuando el nuevo valor depende del anterior
  // Evita problemas si setState se llama múltiples veces seguidas
  const incrementar = () => setCuenta((prev) => prev + 1);
  const decrementar = () => setCuenta((prev) => prev - 1);
  const resetear = () => setCuenta(0);

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>1. Contador</h2>
      <p style={s.valor}>{cuenta}</p>
      <div style={s.fila}>
        <button style={s.btn} onClick={decrementar}>−</button>
        <button style={s.btn} onClick={incrementar}>+</button>
        <button style={{ ...s.btn, background: '#f38ba8' }} onClick={resetear}>Reset</button>
      </div>
    </section>
  );
}

// ─── EJEMPLO 2: Estado con array — lista de items ─────────────

/**
 * Lista dinámica donde se pueden agregar y eliminar items.
 * Demuestra cómo actualizar estado que contiene un array.
 */
function ListaDinamica() {
  const [items, setItems] = useState(['Manzana', 'Banana']);
  const [nuevoItem, setNuevoItem] = useState('');

  /**
   * Agrega un nuevo item al array.
   * NUNCA hacer: items.push(texto) — muta el estado directamente.
   * SIEMPRE crear un nuevo array con spread operator.
   */
  const agregar = () => {
    const texto = nuevoItem.trim();
    if (!texto) return;
    // Crear un nuevo array — no mutar el existente
    setItems((prev) => [...prev, texto]);
    setNuevoItem('');
  };

  /**
   * Elimina un item por su índice.
   * filter crea un nuevo array sin mutar el original.
   * @param {number} indice
   */
  const eliminar = (indice) => {
    setItems((prev) => prev.filter((_, i) => i !== indice));
  };

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>2. Lista dinámica</h2>
      <div style={s.fila}>
        <input
          style={s.input}
          value={nuevoItem}
          onChange={(e) => setNuevoItem(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && agregar()}
          placeholder="Nuevo item..."
        />
        <button style={s.btn} onClick={agregar}>Agregar</button>
      </div>
      <ul style={{ listStyle: 'none', padding: 0, marginTop: '12px' }}>
        {items.map((item, i) => (
          <li key={i} style={{ ...s.fila, justifyContent: 'space-between', marginBottom: '6px' }}>
            <span style={{ color: '#cdd6f4' }}>{item}</span>
            <button
              style={{ ...s.btn, padding: '2px 10px', background: '#f38ba8', color: '#1e1e2e' }}
              onClick={() => eliminar(i)}
            >
              ✕
            </button>
          </li>
        ))}
      </ul>
      <p style={{ color: '#6c7086', fontSize: '13px' }}>Total: {items.length}</p>
    </section>
  );
}

// ─── EJEMPLO 3: Estado con objeto — formulario controlado ─────

/** Valores iniciales del formulario */
const FORM_INICIAL = { nombre: '', email: '', mensaje: '' };

/**
 * Formulario controlado: React controla el valor de cada input.
 * El estado es un objeto con todos los campos del formulario.
 */
function FormularioControlado() {
  const [form, setForm] = useState(FORM_INICIAL);
  const [enviado, setEnviado] = useState(false);

  /**
   * Actualiza un campo del formulario usando el atributo name del input.
   * Un solo handler para todos los campos — evita duplicar código.
   * @param {React.ChangeEvent<HTMLInputElement>} e
   */
  const handleChange = (e) => {
    const { name, value } = e.target;
    // Spread para no perder los demás campos al actualizar uno solo
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  /** Procesa el envío del formulario */
  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Datos del formulario:', form);
    setEnviado(true);
    setTimeout(() => {
      setEnviado(false);
      setForm(FORM_INICIAL);
    }, 2000);
  };

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>3. Formulario controlado</h2>
      {enviado ? (
        <p style={{ color: '#a6e3a1', textAlign: 'center', padding: '20px' }}>
          ✅ Formulario enviado correctamente
        </p>
      ) : (
        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
          <input
            style={s.input}
            name="nombre"
            value={form.nombre}
            onChange={handleChange}
            placeholder="Nombre"
            required
          />
          <input
            style={s.input}
            name="email"
            type="email"
            value={form.email}
            onChange={handleChange}
            placeholder="Email"
            required
          />
          <textarea
            style={{ ...s.input, resize: 'vertical', minHeight: '80px' }}
            name="mensaje"
            value={form.mensaje}
            onChange={handleChange}
            placeholder="Mensaje..."
          />
          <button style={{ ...s.btn, background: '#89b4fa', color: '#1e1e2e' }} type="submit">
            Enviar
          </button>
        </form>
      )}
      <pre style={{ color: '#6c7086', fontSize: '11px', marginTop: '8px' }}>
        Estado actual: {JSON.stringify(form, null, 2)}
      </pre>
    </section>
  );
}

// ─── ESTILOS ──────────────────────────────────────────────────
const s = {
  seccion: { background: '#313244', borderRadius: '10px', padding: '20px', marginBottom: '16px' },
  titulo: { color: '#cba6f7', marginTop: 0, marginBottom: '12px', fontSize: '16px' },
  valor: { fontSize: '48px', textAlign: 'center', color: '#cdd6f4', margin: '8px 0' },
  fila: { display: 'flex', gap: '8px', alignItems: 'center' },
  btn: { padding: '6px 14px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' },
  input: { flex: 1, padding: '8px 12px', background: '#1e1e2e', color: '#cdd6f4', border: '1px solid #45475a', borderRadius: '6px', fontSize: '14px', width: '100%', boxSizing: 'border-box' },
};

/** App raíz que muestra todos los ejemplos de useState */
export default function App() {
  return (
    <div style={{ background: '#181825', minHeight: '100vh', padding: '24px', fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ color: '#cba6f7', textAlign: 'center', marginBottom: '24px' }}>useState</h1>
      <div style={{ maxWidth: '500px', margin: '0 auto' }}>
        <Contador />
        <ListaDinamica />
        <FormularioControlado />
      </div>
    </div>
  );
}
