/**
 * FavoritesPage.jsx
 * Página que muestra todos los versículos marcados como favoritos por el usuario.
 * Permite eliminar favoritos individualmente o limpiar toda la lista de una vez.
 */

import { useFavorites } from '../hooks/useFavorites.js';
import FavoritesList from '../components/FavoritesList.jsx';

/**
 * FavoritesPage
 * Consume el hook useFavorites para acceder a la lista persistida en localStorage
 * y la presenta al usuario con opciones de gestión.
 *
 * @returns {JSX.Element}
 */
export default function FavoritesPage() {
  const { favorites, removeFavorite, clearFavorites } = useFavorites();

  return (
    <div>
      {/* ── Encabezado ── */}
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        marginBottom: 24,
        flexWrap: 'wrap',
        gap: 12,
      }}>
        <h1 style={{ fontSize: 22, fontWeight: 700, color: 'var(--text)', margin: 0 }}>
          Mis favoritos
        </h1>

        {/* Botón para limpiar todos los favoritos — solo visible si hay al menos uno */}
        {favorites.length > 0 && (
          <button
            onClick={clearFavorites}
            style={{
              background: 'none',
              border: '1px solid #fca5a5',
              borderRadius: 8,
              padding: '6px 14px',
              fontSize: 13,
              fontWeight: 600,
              color: '#dc2626',
              cursor: 'pointer',
              transition: 'background 0.15s',
            }}
            onMouseEnter={(e) => { e.currentTarget.style.background = '#fef2f2'; }}
            onMouseLeave={(e) => { e.currentTarget.style.background = 'none'; }}
          >
            🗑 Limpiar todo
          </button>
        )}
      </div>

      {/* Contador de favoritos */}
      {favorites.length > 0 && (
        <p style={{ color: 'var(--text-muted)', fontSize: 13, marginBottom: 16 }}>
          {favorites.length} versículo{favorites.length !== 1 ? 's' : ''} guardado{favorites.length !== 1 ? 's' : ''}
        </p>
      )}

      {/* ── Lista de favoritos ── */}
      <FavoritesList favorites={favorites} onRemove={removeFavorite} />
    </div>
  );
}
