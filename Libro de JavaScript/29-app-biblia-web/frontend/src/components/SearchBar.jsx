/**
 * SearchBar.jsx
 * Barra de búsqueda de texto para buscar versículos en toda la Biblia.
 * Llama al callback onSearch al enviar el formulario.
 */

import { useState } from 'react';

/**
 * SearchBar
 * Input de búsqueda con botón de envío e ícono de lupa.
 * Controla su propio estado interno del texto ingresado.
 *
 * @param {{
 *   onSearch: (query: string) => void,
 *   initialValue?: string,
 *   placeholder?: string,
 * }} props
 * @param {function} props.onSearch      - Callback que recibe el texto de búsqueda
 * @param {string}   props.initialValue  - Valor inicial del input (opcional)
 * @param {string}   props.placeholder   - Texto de placeholder (opcional)
 * @returns {JSX.Element}
 */
export default function SearchBar({
  onSearch,
  initialValue = '',
  placeholder = 'Buscar versículos... (ej: Juan 3:16, amor, fe)',
}) {
  const [query, setQuery] = useState(initialValue);

  /** Previene el comportamiento por defecto del formulario y llama al callback */
  function handleSubmit(e) {
    e.preventDefault();
    if (query.trim()) onSearch(query.trim());
  }

  return (
    <form onSubmit={handleSubmit} style={{ display: 'flex', gap: 8, marginBottom: 24 }}>
      <div style={{ flex: 1, position: 'relative' }}>
        {/* Ícono de lupa */}
        <span style={{
          position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)',
          fontSize: 18, pointerEvents: 'none', opacity: 0.5,
        }}>
          🔍
        </span>

        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder={placeholder}
          autoFocus
          style={{
            width: '100%', padding: '12px 16px 12px 42px',
            fontSize: 16, borderRadius: 10,
            border: '2px solid var(--border)', background: 'var(--surface)',
            color: 'var(--text)', outline: 'none',
            transition: 'border-color 0.15s',
          }}
          onFocus={(e) => { e.target.style.borderColor = 'var(--primary)'; }}
          onBlur={(e) => { e.target.style.borderColor = 'var(--border)'; }}
        />
      </div>

      <button
        type="submit"
        disabled={!query.trim()}
        style={{
          background: 'var(--primary)', color: '#fff', border: 'none',
          borderRadius: 10, padding: '0 20px', fontSize: 15, fontWeight: 600,
          cursor: query.trim() ? 'pointer' : 'not-allowed',
          opacity: query.trim() ? 1 : 0.5,
          transition: 'opacity 0.15s, background 0.15s',
        }}
      >
        Buscar
      </button>
    </form>
  );
}
