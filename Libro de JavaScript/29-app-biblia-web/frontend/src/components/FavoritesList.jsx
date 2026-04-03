/**
 * FavoritesList.jsx
 * Componente que muestra la lista de versículos marcados como favoritos.
 * Si no hay favoritos, muestra un mensaje informativo al usuario.
 *
 * @param {Object} props
 * @param {string[]} props.favorites - Array de referencias favoritas, ej: ["Juan 3:16"]
 * @param {Function} props.onRemove - Función llamada al eliminar un favorito, recibe la referencia
 */
export default function FavoritesList({ favorites = [], onRemove }) {
  // Estado vacío: no hay favoritos guardados aún
  if (favorites.length === 0) {
    return (
      <div style={{
        textAlign: 'center',
        padding: '48px 16px',
        color: 'var(--text-muted)',
      }}>
        {/* Ícono decorativo */}
        <div style={{ fontSize: 48, marginBottom: 16 }}>🤍</div>
        <p style={{ fontSize: 16, fontWeight: 500 }}>
          No tienes versículos favoritos aún
        </p>
        <p style={{ fontSize: 14, marginTop: 8 }}>
          Toca el ícono ♡ en cualquier versículo para guardarlo aquí.
        </p>
      </div>
    );
  }

  return (
    <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: 10 }}>
      {favorites.map((ref) => (
        <FavoriteItem key={ref} reference={ref} onRemove={onRemove} />
      ))}
    </ul>
  );
}

/**
 * FavoriteItem
 * Elemento individual de la lista de favoritos.
 * Muestra la referencia y un botón para eliminarla.
 *
 * @param {Object} props
 * @param {string} props.reference - Referencia del versículo, ej: "Juan 3:16"
 * @param {Function} props.onRemove - Función que recibe la referencia al presionar eliminar
 */
function FavoriteItem({ reference, onRemove }) {
  return (
    <li style={{
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      background: 'var(--surface)',
      border: '1px solid var(--border)',
      borderRadius: 10,
      padding: '12px 16px',
      gap: 12,
    }}>
      {/* Referencia del versículo */}
      <span style={{ fontWeight: 600, fontSize: 15, color: 'var(--text)' }}>
        ❤️ {reference}
      </span>

      {/* Botón para eliminar el favorito */}
      <button
        onClick={() => onRemove(reference)}
        title="Eliminar de favoritos"
        style={{
          background: 'none',
          border: 'none',
          cursor: 'pointer',
          fontSize: 18,
          color: 'var(--text-muted)',
          padding: '2px 6px',
          borderRadius: 6,
          transition: 'color 0.15s',
          flexShrink: 0,
        }}
        onMouseEnter={(e) => { e.currentTarget.style.color = '#dc2626'; }}
        onMouseLeave={(e) => { e.currentTarget.style.color = 'var(--text-muted)'; }}
      >
        ✕
      </button>
    </li>
  );
}
