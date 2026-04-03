// ============================================================
// ARCHIVO: 04_componente_completo.jsx
// TEMA: Componente completo de tarjeta de versículo bíblico
// CÓMO EJECUTAR: Usar dentro de un proyecto React (Vite o CRA)
// ============================================================

import React from 'react';

// ─── ESTILOS INLINE (para que el ejemplo sea autocontenido) ───
/** Estilos base de la tarjeta */
const estilos = {
  tarjeta: {
    background: '#1e1e2e',
    color: '#cdd6f4',
    borderRadius: '12px',
    padding: '20px 24px',
    maxWidth: '480px',
    margin: '16px auto',
    boxShadow: '0 4px 16px rgba(0,0,0,0.3)',
    fontFamily: 'Georgia, serif',
    border: '1px solid #313244',
  },
  referencia: {
    fontWeight: 'bold',
    fontSize: '13px',
    color: '#89b4fa',
    marginBottom: '10px',
    letterSpacing: '0.05em',
    textTransform: 'uppercase',
  },
  texto: {
    fontSize: '16px',
    lineHeight: '1.7',
    color: '#cdd6f4',
    marginBottom: '16px',
    fontStyle: 'italic',
  },
  acciones: {
    display: 'flex',
    gap: '10px',
    justifyContent: 'flex-end',
  },
  botonCorazon: (esFavorito) => ({
    background: esFavorito ? '#f38ba8' : 'transparent',
    color: esFavorito ? '#1e1e2e' : '#f38ba8',
    border: `2px solid #f38ba8`,
    borderRadius: '8px',
    padding: '6px 14px',
    cursor: 'pointer',
    fontSize: '14px',
    fontWeight: 'bold',
    transition: 'all 0.2s',
  }),
  botonCopiar: {
    background: 'transparent',
    color: '#a6e3a1',
    border: '2px solid #a6e3a1',
    borderRadius: '8px',
    padding: '6px 14px',
    cursor: 'pointer',
    fontSize: '14px',
    fontWeight: 'bold',
  },
};

// ─── COMPONENTE PRINCIPAL ────────────────────────────────────

/**
 * Tarjeta que muestra un versículo bíblico con acciones.
 *
 * @param {object} props
 * @param {string} props.texto - El texto completo del versículo
 * @param {string} props.referencia - Ej: "Juan 3:16" o "Salmos 23:1"
 * @param {boolean} props.esFavorito - Si está marcado como favorito
 * @param {Function} props.onToggleFavorito - Callback al presionar el corazón
 * @param {Function} props.onCopiar - Callback al presionar el botón de copiar
 */
function TarjetaVersiculo({ texto, referencia, esFavorito, onToggleFavorito, onCopiar }) {
  return (
    <article style={estilos.tarjeta}>
      {/* Referencia del versículo en la parte superior */}
      <p style={estilos.referencia}>{referencia}</p>

      {/* Texto del versículo */}
      <blockquote style={estilos.texto}>"{texto}"</blockquote>

      {/* Botones de acción */}
      <div style={estilos.acciones}>
        {/* Botón favorito — cambia de estilo según el estado */}
        <button
          style={estilos.botonCorazon(esFavorito)}
          onClick={onToggleFavorito}
          aria-label={esFavorito ? 'Quitar de favoritos' : 'Agregar a favoritos'}
          title={esFavorito ? 'Quitar de favoritos' : 'Agregar a favoritos'}
        >
          {esFavorito ? '♥ Favorito' : '♡ Favorito'}
        </button>

        {/* Botón copiar */}
        <button
          style={estilos.botonCopiar}
          onClick={onCopiar}
          aria-label="Copiar versículo"
          title="Copiar al portapapeles"
        >
          📋 Copiar
        </button>
      </div>
    </article>
  );
}

// ─── APP DE EJEMPLO ───────────────────────────────────────────

/** Lista de versículos de muestra */
const versiculosIniciales = [
  {
    id: 1,
    referencia: 'Juan 3:16',
    texto: 'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
    esFavorito: false,
  },
  {
    id: 2,
    referencia: 'Salmos 23:1',
    texto: 'Jehová es mi pastor; nada me faltará.',
    esFavorito: true,
  },
  {
    id: 3,
    referencia: 'Filipenses 4:13',
    texto: 'Todo lo puedo en Cristo que me fortalece.',
    esFavorito: false,
  },
];

/**
 * Aplicación raíz que demuestra el uso de TarjetaVersiculo.
 * Gestiona el estado de favoritos y las acciones de copia.
 */
function App() {
  const [versiculos, setVersiculos] = React.useState(versiculosIniciales);
  const [copiado, setCopiado] = React.useState(null);

  /**
   * Alterna el estado de favorito de un versículo.
   * @param {number} id - ID del versículo a modificar
   */
  const toggleFavorito = (id) => {
    setVersiculos((prev) =>
      prev.map((v) => (v.id === id ? { ...v, esFavorito: !v.esFavorito } : v))
    );
  };

  /**
   * Copia el texto del versículo al portapapeles.
   * @param {object} versiculo - Versículo a copiar
   */
  const copiarVersiculo = async (versiculo) => {
    const textoCompleto = `"${versiculo.texto}" — ${versiculo.referencia}`;
    try {
      await navigator.clipboard.writeText(textoCompleto);
      setCopiado(versiculo.id);
      setTimeout(() => setCopiado(null), 2000);
    } catch {
      console.error('No se pudo copiar al portapapeles');
    }
  };

  return (
    <div style={{ padding: '24px', background: '#181825', minHeight: '100vh' }}>
      <h1 style={{ textAlign: 'center', color: '#cba6f7', fontFamily: 'Georgia, serif', marginBottom: '8px' }}>
        Versículos del Día
      </h1>
      <p style={{ textAlign: 'center', color: '#6c7086', fontSize: '14px', marginBottom: '24px' }}>
        {versiculos.filter((v) => v.esFavorito).length} favorito(s)
        {copiado && ' · ✅ Copiado al portapapeles'}
      </p>

      {versiculos.map((versiculo) => (
        <TarjetaVersiculo
          key={versiculo.id}
          texto={versiculo.texto}
          referencia={versiculo.referencia}
          esFavorito={versiculo.esFavorito}
          onToggleFavorito={() => toggleFavorito(versiculo.id)}
          onCopiar={() => copiarVersiculo(versiculo)}
        />
      ))}
    </div>
  );
}

export default App;
