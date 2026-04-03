/**
 * BookPage.jsx
 * Página que muestra la grilla de capítulos de un libro de la Biblia.
 * El usuario puede hacer clic en un capítulo para leer sus versículos.
 */

import { useEffect, useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { getChapters, getBooks } from '../api/bibleApi.js';

/**
 * BookPage
 * Lee el parámetro :bookNumber de la URL, carga el nombre del libro
 * y la lista de capítulos disponibles, luego los muestra en una grilla.
 *
 * @returns {JSX.Element}
 */
export default function BookPage() {
  const { bookNumber } = useParams();
  const navigate = useNavigate();

  const [bookInfo, setBookInfo] = useState(null);
  const [chapters, setChapters] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(null);

    // Carga en paralelo: lista de libros (para el nombre) y capítulos del libro
    Promise.all([getBooks(), getChapters(Number(bookNumber))])
      .then(([books, chapterList]) => {
        if (cancelled) return;
        const found = books.find((b) => b.bookNumber === Number(bookNumber));
        setBookInfo(found || null);
        setChapters(chapterList);
      })
      .catch((err) => { if (!cancelled) setError(err.message); })
      .finally(() => { if (!cancelled) setLoading(false); });

    return () => { cancelled = true; };
  }, [bookNumber]);

  if (loading) return <p style={{ color: 'var(--text-muted)', padding: 32 }}>Cargando capítulos...</p>;
  if (error) return <p style={{ color: '#dc2626', padding: 16 }}>Error: {error}</p>;

  return (
    <div>
      {/* ── Navegación de regreso ── */}
      <Link to="/" style={{ color: 'var(--primary)', fontSize: 14, display: 'inline-block', marginBottom: 16 }}>
        ← Volver a todos los libros
      </Link>

      {/* ── Encabezado del libro ── */}
      <div style={{
        background: bookInfo?.color || 'var(--primary)',
        borderRadius: 14, padding: '20px 24px', marginBottom: 24,
        color: '#fff',
      }}>
        <h1 style={{ fontSize: 26, fontWeight: 700, margin: 0 }}>
          {bookInfo?.longName || `Libro ${bookNumber}`}
        </h1>
        <p style={{ margin: '4px 0 0', opacity: 0.85, fontSize: 14 }}>
          {bookInfo?.isNewTestament ? 'Nuevo Testamento' : 'Antiguo Testamento'}
          {' · '}{chapters.length} capítulos
        </p>
      </div>

      {/* ── Grilla de capítulos ── */}
      <h2 style={{ fontSize: 17, fontWeight: 600, marginBottom: 14, color: 'var(--text-muted)' }}>
        Selecciona un capítulo
      </h2>
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(60px, 1fr))',
        gap: 8,
      }}>
        {chapters.map((ch) => (
          <button
            key={ch}
            onClick={() => navigate(`/libro/${bookNumber}/capitulo/${ch}`)}
            style={{
              background: 'var(--surface)', border: '2px solid var(--border)',
              borderRadius: 10, padding: '12px 4px', fontSize: 17, fontWeight: 600,
              cursor: 'pointer', color: 'var(--text)',
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
            {ch}
          </button>
        ))}
      </div>
    </div>
  );
}
