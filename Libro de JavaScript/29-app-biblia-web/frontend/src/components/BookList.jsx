/**
 * BookList.jsx
 * Muestra la lista completa de los 66 libros de la Biblia
 * dividida en dos secciones: Antiguo Testamento y Nuevo Testamento.
 */

import BookCard from './BookCard.jsx';

/** Estilos compartidos para la grilla de libros */
const gridStyle = {
  display: 'grid',
  gridTemplateColumns: 'repeat(auto-fill, minmax(88px, 1fr))',
  gap: 10,
  marginTop: 12,
};

/**
 * SectionTitle
 * Encabezado de sección con línea decorativa.
 *
 * @param {{ children: React.ReactNode }} props
 */
function SectionTitle({ children }) {
  return (
    <h2 style={{
      fontSize: 18, fontWeight: 700, color: 'var(--primary)',
      borderBottom: '2px solid var(--primary-light)',
      paddingBottom: 6, marginBottom: 4,
    }}>
      {children}
    </h2>
  );
}

/**
 * BookList
 * Recibe el array completo de libros y los divide en AT y NT.
 * Renderiza una grilla de BookCard para cada testamento.
 *
 * @param {{ books: Array }} props
 * @param {Array} props.books - Lista de libros obtenida de la API
 * @returns {JSX.Element}
 */
export default function BookList({ books }) {
  // Libros del Antiguo Testamento: bookNumber 1-39
  const oldTestament = books.filter((b) => !b.isNewTestament);
  // Libros del Nuevo Testamento: bookNumber 40-66
  const newTestament = books.filter((b) => b.isNewTestament);

  if (books.length === 0) {
    return (
      <p style={{ color: 'var(--text-muted)', textAlign: 'center', padding: 32 }}>
        Cargando libros...
      </p>
    );
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 28 }}>
      {/* ── Antiguo Testamento ── */}
      <section>
        <SectionTitle>Antiguo Testamento ({oldTestament.length} libros)</SectionTitle>
        <div style={gridStyle}>
          {oldTestament.map((book) => (
            <BookCard key={book.bookNumber} book={book} />
          ))}
        </div>
      </section>

      {/* ── Nuevo Testamento ── */}
      <section>
        <SectionTitle>Nuevo Testamento ({newTestament.length} libros)</SectionTitle>
        <div style={gridStyle}>
          {newTestament.map((book) => (
            <BookCard key={book.bookNumber} book={book} />
          ))}
        </div>
      </section>
    </div>
  );
}
