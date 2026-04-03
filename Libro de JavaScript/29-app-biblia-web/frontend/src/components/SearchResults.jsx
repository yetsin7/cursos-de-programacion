/**
 * SearchResults.jsx
 * Componente que muestra los resultados de una búsqueda de versículos.
 * Maneja tres estados: cargando, sin query, sin resultados y con resultados.
 *
 * @param {Object} props
 * @param {Array<{bookName: string, chapter: number, verse: number, text: string}>} props.results
 * @param {string} props.query - Texto que el usuario buscó
 * @param {boolean} props.isLoading - Indica si la búsqueda está en curso
 */
export default function SearchResults({ results = [], query = '', isLoading = false }) {
  // Estado: búsqueda en progreso
  if (isLoading) {
    return (
      <p style={{ color: 'var(--text-muted)', textAlign: 'center', padding: 32 }}>
        🔍 Buscando...
      </p>
    );
  }

  // Estado: no hay texto en el buscador aún
  if (!query) {
    return (
      <div style={{ textAlign: 'center', padding: '48px 16px', color: 'var(--text-muted)' }}>
        <div style={{ fontSize: 48, marginBottom: 16 }}>🔎</div>
        <p style={{ fontSize: 15 }}>Escribe algo para buscar versículos</p>
      </div>
    );
  }

  // Estado: búsqueda realizada pero sin resultados
  if (results.length === 0) {
    return (
      <div style={{ textAlign: 'center', padding: '48px 16px', color: 'var(--text-muted)' }}>
        <div style={{ fontSize: 48, marginBottom: 16 }}>😔</div>
        <p style={{ fontSize: 15 }}>
          No se encontraron resultados para: <strong>"{query}"</strong>
        </p>
        <p style={{ fontSize: 13, marginTop: 8 }}>
          Intenta con palabras más cortas o diferentes.
        </p>
      </div>
    );
  }

  return (
    <div>
      {/* Contador de resultados */}
      <p style={{ color: 'var(--text-muted)', fontSize: 13, marginBottom: 16 }}>
        {results.length} resultado{results.length !== 1 ? 's' : ''} para "{query}"
      </p>

      {/* Lista de resultados */}
      <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: 10 }}>
        {results.map((item, index) => (
          <SearchResultItem key={index} item={item} query={query} />
        ))}
      </ul>
    </div>
  );
}

/**
 * SearchResultItem
 * Tarjeta individual para un resultado de búsqueda.
 *
 * @param {Object} props
 * @param {{ bookName: string, chapter: number, verse: number, text: string }} props.item
 * @param {string} props.query - Texto buscado (para resaltar coincidencias)
 */
function SearchResultItem({ item }) {
  // Referencia canónica del versículo: "Génesis 1:1"
  const reference = `${item.bookName} ${item.chapter}:${item.verse}`;

  return (
    <li style={{
      background: 'var(--surface)',
      border: '1px solid var(--border)',
      borderRadius: 10,
      padding: '14px 16px',
    }}>
      {/* Referencia del versículo */}
      <p style={{
        fontWeight: 700,
        fontSize: 13,
        color: 'var(--primary)',
        marginBottom: 6,
        textTransform: 'uppercase',
        letterSpacing: '0.04em',
      }}>
        {reference}
      </p>

      {/* Texto del versículo */}
      <p style={{ fontSize: 15, color: 'var(--text)', lineHeight: 1.6, margin: 0 }}>
        {item.text}
      </p>
    </li>
  );
}
