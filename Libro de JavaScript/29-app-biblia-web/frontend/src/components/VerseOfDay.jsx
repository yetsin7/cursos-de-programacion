/**
 * VerseOfDay.jsx
 * Muestra un versículo aleatorio de la Biblia a modo de "versículo del día".
 * Permite al usuario solicitar otro versículo con un botón.
 */

import { useState, useEffect } from 'react';
import { getRandomVerse } from '../api/bibleApi.js';

/**
 * VerseOfDay
 * Componente de tarjeta destacada que carga un versículo aleatorio al montarse
 * y cada vez que el usuario hace clic en "Otro versículo".
 *
 * @returns {JSX.Element}
 */
export default function VerseOfDay() {
  const [verse, setVerse] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  /** Carga un versículo aleatorio desde la API */
  async function loadVerse() {
    setLoading(true);
    setError(null);
    try {
      const data = await getRandomVerse();
      setVerse(data);
    } catch (err) {
      setError('No se pudo cargar el versículo del día.');
    } finally {
      setLoading(false);
    }
  }

  // Carga el versículo inicial al montar el componente
  useEffect(() => {
    loadVerse();
  }, []);

  return (
    <div style={{
      background: 'linear-gradient(135deg, var(--primary) 0%, #a855f7 100%)',
      borderRadius: 16, padding: '24px 28px', marginBottom: 32,
      color: '#fff', boxShadow: '0 4px 20px rgba(124,58,237,0.3)',
      position: 'relative', overflow: 'hidden',
    }}>
      {/* Decoración de fondo */}
      <span style={{
        position: 'absolute', right: 20, top: 10,
        fontSize: 72, opacity: 0.12, lineHeight: 1,
      }}>
        ✝
      </span>

      {/* Etiqueta */}
      <p style={{ fontSize: 12, fontWeight: 600, letterSpacing: 1, opacity: 0.85, marginBottom: 12 }}>
        VERSÍCULO DEL DÍA
      </p>

      {/* Estado de carga */}
      {loading && (
        <p style={{ fontSize: 16, opacity: 0.8, fontStyle: 'italic' }}>Cargando versículo...</p>
      )}

      {/* Estado de error */}
      {error && (
        <p style={{ fontSize: 15, opacity: 0.9 }}>{error}</p>
      )}

      {/* Versículo cargado */}
      {!loading && verse && (
        <>
          <blockquote style={{
            fontSize: 18, lineHeight: 1.7, fontStyle: 'italic',
            margin: '0 0 16px 0', fontWeight: 400,
          }}>
            &ldquo;{verse.text}&rdquo;
          </blockquote>
          <p style={{ fontWeight: 700, fontSize: 15, opacity: 0.95 }}>
            — {verse.reference}
          </p>
        </>
      )}

      {/* Botón para obtener otro versículo */}
      <button
        onClick={loadVerse}
        disabled={loading}
        style={{
          marginTop: 16, background: 'rgba(255,255,255,0.2)', border: '1px solid rgba(255,255,255,0.4)',
          color: '#fff', borderRadius: 8, padding: '8px 18px', cursor: 'pointer',
          fontSize: 14, fontWeight: 600, transition: 'background 0.15s',
        }}
        onMouseEnter={(e) => { e.currentTarget.style.background = 'rgba(255,255,255,0.3)'; }}
        onMouseLeave={(e) => { e.currentTarget.style.background = 'rgba(255,255,255,0.2)'; }}
      >
        {loading ? 'Cargando...' : '↺ Otro versículo'}
      </button>
    </div>
  );
}
