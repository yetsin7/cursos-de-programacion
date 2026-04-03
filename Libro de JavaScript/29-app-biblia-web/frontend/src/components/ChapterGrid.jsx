/**
 * ChapterGrid.jsx
 * Grilla de botones para seleccionar un capítulo de un libro de la Biblia.
 * Cada botón muestra el número de capítulo y dispara el callback onSelect al hacer clic.
 *
 * @param {Object} props
 * @param {number[]} props.chapters - Array de números de capítulo disponibles
 * @param {number} props.bookNumber - Número del libro (usado como contexto, no se renderiza)
 * @param {Function} props.onSelect - Callback llamado con el número de capítulo seleccionado
 */
export default function ChapterGrid({ chapters = [], bookNumber, onSelect }) {
  // Estado vacío: sin capítulos disponibles
  if (chapters.length === 0) {
    return (
      <p style={{ color: 'var(--text-muted)', textAlign: 'center', padding: 32 }}>
        No hay capítulos disponibles.
      </p>
    );
  }

  return (
    <div style={{
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fill, minmax(60px, 1fr))',
      gap: 8,
    }}>
      {chapters.map((chapter) => (
        <ChapterButton
          key={chapter}
          chapter={chapter}
          onSelect={onSelect}
        />
      ))}
    </div>
  );
}

/**
 * ChapterButton
 * Botón individual que representa un capítulo en la grilla.
 *
 * @param {Object} props
 * @param {number} props.chapter - Número del capítulo
 * @param {Function} props.onSelect - Callback al hacer clic, recibe el número de capítulo
 */
function ChapterButton({ chapter, onSelect }) {
  return (
    <button
      onClick={() => onSelect(chapter)}
      style={{
        background: 'var(--surface)',
        border: '2px solid var(--border)',
        borderRadius: 10,
        padding: '12px 4px',
        fontSize: 17,
        fontWeight: 600,
        cursor: 'pointer',
        color: 'var(--text)',
        transition: 'border-color 0.15s, background 0.15s, color 0.15s',
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.borderColor = 'var(--primary)';
        e.currentTarget.style.color = 'var(--primary)';
        e.currentTarget.style.background = 'var(--primary-light)';
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.borderColor = 'var(--border)';
        e.currentTarget.style.color = 'var(--text)';
        e.currentTarget.style.background = 'var(--surface)';
      }}
    >
      {chapter}
    </button>
  );
}
