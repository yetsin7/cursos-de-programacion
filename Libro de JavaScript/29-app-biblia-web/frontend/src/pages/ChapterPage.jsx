/**
 * ChapterPage.jsx
 * Página de lectura de un capítulo de la Biblia.
 * Carga los versículos del capítulo seleccionado y permite marcarlos como favoritos.
 * Incluye botones de navegación al capítulo anterior y siguiente.
 */

import { useEffect, useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { getVerses } from '../api/bibleApi.js';
import { useFavorites } from '../hooks/useFavorites.js';
import VerseTile from '../components/VerseTile.jsx';

/**
 * ChapterPage
 * Lee :bookNumber y :chapter de la URL, carga los versículos
 * y los muestra en una lista con soporte para favoritos.
 *
 * @returns {JSX.Element}
 */
export default function ChapterPage() {
  const { bookNumber, chapter } = useParams();
  const navigate = useNavigate();
  const { isFavorite, addFavorite, removeFavorite } = useFavorites();

  const [verseData, setVerseData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const bookNum = Number(bookNumber);
  const chapterNum = Number(chapter);

  // Recarga los versículos cuando cambia el libro o el capítulo
  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(null);
    setVerseData(null);

    getVerses(bookNum, chapterNum)
      .then((data) => { if (!cancelled) setVerseData(data); })
      .catch((err) => { if (!cancelled) setError(err.message); })
      .finally(() => { if (!cancelled) setLoading(false); });

    // Scroll al inicio al cambiar de capítulo
    window.scrollTo({ top: 0, behavior: 'smooth' });

    return () => { cancelled = true; };
  }, [bookNum, chapterNum]);

  /**
   * Alterna el estado de favorito de un versículo.
   * @param {string} reference - Referencia canónica, ej: "Juan 3:16"
   */
  function handleToggleFavorite(reference) {
    if (isFavorite(reference)) removeFavorite(reference);
    else addFavorite(reference);
  }

  if (loading) return <p style={{ color: 'var(--text-muted)', padding: 32 }}>Cargando versículos...</p>;
  if (error) return <p style={{ color: '#dc2626', padding: 16 }}>Error: {error}</p>;
  if (!verseData) return null;

  const totalChapters = verseData.verses.length > 0 ? null : 0;

  return (
    <div>
      {/* ── Navegación de regreso ── */}
      <Link
        to={`/libro/${bookNum}`}
        style={{ color: 'var(--primary)', fontSize: 14, display: 'inline-block', marginBottom: 16 }}
      >
        ← {verseData.longName}
      </Link>

      {/* ── Encabezado del capítulo ── */}
      <h1 style={{ fontSize: 24, fontWeight: 700, marginBottom: 6 }}>
        {verseData.longName}
      </h1>
      <p style={{ color: 'var(--text-muted)', marginBottom: 24, fontSize: 15 }}>
        Capítulo {chapterNum} · {verseData.verses.length} versículos
      </p>

      {/* ── Lista de versículos ── */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
        {verseData.verses.map((verse) => (
          <VerseTile
            key={verse.verseNumber}
            verse={verse}
            bookName={verseData.longName}
            chapter={chapterNum}
            isFavorite={isFavorite(`${verseData.longName} ${chapterNum}:${verse.verseNumber}`)}
            onToggleFavorite={handleToggleFavorite}
          />
        ))}
      </div>

      {/* ── Navegación anterior / siguiente ── */}
      <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 32, gap: 12 }}>
        <button
          onClick={() => navigate(`/libro/${bookNum}/capitulo/${chapterNum - 1}`)}
          disabled={chapterNum <= 1}
          style={navBtnStyle(chapterNum <= 1)}
        >
          ← Capítulo {chapterNum - 1}
        </button>
        <button
          onClick={() => navigate(`/libro/${bookNum}/capitulo/${chapterNum + 1}`)}
          style={navBtnStyle(false)}
        >
          Capítulo {chapterNum + 1} →
        </button>
      </div>
    </div>
  );
}

/**
 * Genera el estilo del botón de navegación según si está deshabilitado.
 * @param {boolean} disabled
 * @returns {Object} Objeto de estilos inline
 */
function navBtnStyle(disabled) {
  return {
    background: disabled ? 'var(--border)' : 'var(--primary)',
    color: disabled ? 'var(--text-muted)' : '#fff',
    border: 'none', borderRadius: 10, padding: '10px 20px',
    fontSize: 15, fontWeight: 600,
    cursor: disabled ? 'not-allowed' : 'pointer',
    opacity: disabled ? 0.5 : 1,
    transition: 'opacity 0.15s',
  };
}
