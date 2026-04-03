/**
 * SearchPage.jsx
 * Página de búsqueda de versículos de la Biblia.
 * Permite al usuario escribir una frase o palabra y obtener versículos relevantes.
 * Soporta búsqueda desde el query param "?q=" para llegar desde la navegación.
 */

import { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { searchVerses } from '../api/bibleApi.js';
import SearchBar from '../components/SearchBar.jsx';
import SearchResults from '../components/SearchResults.jsx';

/**
 * SearchPage
 * Orquesta la búsqueda: lee el parámetro de URL, lanza la petición
 * a la API y pasa los resultados al componente SearchResults.
 *
 * @returns {JSX.Element}
 */
export default function SearchPage() {
  // Lee el parámetro de búsqueda desde la URL (?q=texto)
  const [searchParams, setSearchParams] = useSearchParams();
  const queryParam = searchParams.get('q') || '';

  const [query, setQuery] = useState(queryParam);
  const [results, setResults] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  // Si hay un parámetro en la URL al montar, lanza la búsqueda automáticamente
  useEffect(() => {
    if (queryParam) {
      handleSearch(queryParam);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  /**
   * Ejecuta la búsqueda en la API y actualiza los estados.
   *
   * @param {string} searchQuery - Texto a buscar
   */
  async function handleSearch(searchQuery) {
    const trimmed = searchQuery.trim();
    setQuery(trimmed);

    // Actualiza el query param en la URL sin recargar la página
    if (trimmed) {
      setSearchParams({ q: trimmed });
    } else {
      setSearchParams({});
      setResults([]);
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const data = await searchVerses(trimmed);
      setResults(data);
    } catch (err) {
      setError(err.message);
      setResults([]);
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div>
      {/* ── Encabezado de la página ── */}
      <h1 style={{ fontSize: 22, fontWeight: 700, marginBottom: 20, color: 'var(--text)' }}>
        Buscar versículos
      </h1>

      {/* ── Barra de búsqueda ── */}
      <div style={{ marginBottom: 24 }}>
        <SearchBar initialValue={query} onSearch={handleSearch} />
      </div>

      {/* ── Mensaje de error de la API ── */}
      {error && (
        <div style={{
          background: '#fef2f2', border: '1px solid #fca5a5',
          borderRadius: 10, padding: '12px 16px', color: '#dc2626',
          marginBottom: 20, fontSize: 14,
        }}>
          <strong>Error al buscar:</strong> {error}
        </div>
      )}

      {/* ── Resultados de la búsqueda ── */}
      <SearchResults results={results} query={query} isLoading={isLoading} />
    </div>
  );
}
