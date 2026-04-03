/**
 * HomePage.jsx
 * Página principal de la aplicación Biblia RV60.
 * Muestra el versículo del día y la lista completa de los 66 libros.
 */

import { useBible } from '../hooks/useBible.js';
import VerseOfDay from '../components/VerseOfDay.jsx';
import BookList from '../components/BookList.jsx';

/**
 * HomePage
 * Carga los libros de la Biblia con el hook useBible
 * y renderiza el versículo del día seguido de la grilla de libros.
 *
 * @returns {JSX.Element}
 */
export default function HomePage() {
  const { books, loading, error } = useBible();

  return (
    <div>
      {/* ── Versículo del día ── */}
      <VerseOfDay />

      {/* ── Lista de libros ── */}
      <h1 style={{
        fontSize: 22, fontWeight: 700, marginBottom: 20,
        color: 'var(--text)',
      }}>
        Libros de la Biblia
      </h1>

      {/* Estado de error al cargar libros */}
      {error && (
        <div style={{
          background: '#fef2f2', border: '1px solid #fca5a5',
          borderRadius: 10, padding: '14px 18px', color: '#dc2626',
          marginBottom: 20,
        }}>
          <strong>Error:</strong> {error}
          <br />
          <small>Asegúrate de que el backend está corriendo en http://localhost:3001</small>
        </div>
      )}

      {/* Indicador de carga */}
      {loading && !error && (
        <p style={{ color: 'var(--text-muted)', textAlign: 'center', padding: 32 }}>
          Cargando libros...
        </p>
      )}

      {/* Lista de libros cuando están disponibles */}
      {!loading && !error && <BookList books={books} />}
    </div>
  );
}
