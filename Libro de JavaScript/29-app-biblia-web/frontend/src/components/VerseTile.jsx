/**
 * VerseTile.jsx
 * Componente que renderiza un único versículo bíblico.
 * Muestra el número del versículo, el texto y un botón de favorito.
 */

/**
 * VerseTile
 * Tarjeta de un versículo individual con soporte para favoritos.
 *
 * @param {{
 *   verse: { verseNumber: number, text: string },
 *   bookName: string,
 *   chapter: number,
 *   isFavorite: boolean,
 *   onToggleFavorite: (reference: string) => void,
 * }} props
 * @param {Object}   props.verse              - Datos del versículo
 * @param {number}   props.verse.verseNumber  - Número del versículo
 * @param {string}   props.verse.text         - Texto del versículo limpio
 * @param {string}   props.bookName           - Nombre del libro (ej: "Juan")
 * @param {number}   props.chapter            - Número del capítulo
 * @param {boolean}  props.isFavorite         - Si el versículo está en favoritos
 * @param {function} props.onToggleFavorite   - Callback para agregar/quitar favorito
 * @returns {JSX.Element}
 */
export default function VerseTile({ verse, bookName, chapter, isFavorite, onToggleFavorite }) {
  /** Referencia canónica del versículo, ej: "Juan 3:16" */
  const reference = `${bookName} ${chapter}:${verse.verseNumber}`;

  return (
    <div style={{
      display: 'flex', alignItems: 'flex-start', gap: 12,
      padding: '12px 14px', borderRadius: 10,
      background: 'var(--surface)', border: '1px solid var(--border)',
      transition: 'border-color 0.15s',
    }}>
      {/* Número del versículo */}
      <span style={{
        color: 'var(--primary)', fontWeight: 700, fontSize: 13,
        minWidth: 28, paddingTop: 2, flexShrink: 0,
      }}>
        {verse.verseNumber}
      </span>

      {/* Texto del versículo */}
      <p style={{
        flex: 1, margin: 0, fontSize: 16, lineHeight: 1.75,
        color: 'var(--text)',
      }}>
        {verse.text}
      </p>

      {/* Botón de favorito (corazón) */}
      <button
        onClick={() => onToggleFavorite(reference)}
        title={isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos'}
        aria-label={isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos'}
        style={{
          background: 'none', border: 'none', cursor: 'pointer',
          fontSize: 18, padding: '2px 4px', flexShrink: 0,
          opacity: isFavorite ? 1 : 0.35,
          transition: 'opacity 0.15s, transform 0.15s',
        }}
        onMouseEnter={(e) => {
          e.currentTarget.style.opacity = '1';
          e.currentTarget.style.transform = 'scale(1.2)';
        }}
        onMouseLeave={(e) => {
          e.currentTarget.style.opacity = isFavorite ? '1' : '0.35';
          e.currentTarget.style.transform = 'scale(1)';
        }}
      >
        {isFavorite ? '❤️' : '🤍'}
      </button>
    </div>
  );
}
