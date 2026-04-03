/**
 * ThemeToggle.jsx
 * Botón que alterna entre modo claro y modo oscuro.
 * Muestra un ícono de sol (claro) o luna (oscuro) según el estado actual.
 */

/**
 * ThemeToggle
 * Botón circular para cambiar el tema de la aplicación.
 *
 * @param {{ dark: boolean, onToggle: () => void }} props
 * @param {boolean} props.dark - Indica si el modo oscuro está activo
 * @param {function} props.onToggle - Callback que se llama al hacer clic
 * @returns {JSX.Element}
 */
export default function ThemeToggle({ dark, onToggle }) {
  return (
    <button
      onClick={onToggle}
      title={dark ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro'}
      aria-label={dark ? 'Activar modo claro' : 'Activar modo oscuro'}
      style={{
        background: 'var(--primary-light)',
        border: 'none',
        borderRadius: '50%',
        width: 36,
        height: 36,
        cursor: 'pointer',
        fontSize: 18,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transition: 'background 0.2s, transform 0.15s',
        flexShrink: 0,
      }}
      onMouseEnter={(e) => { e.currentTarget.style.transform = 'scale(1.1)'; }}
      onMouseLeave={(e) => { e.currentTarget.style.transform = 'scale(1)'; }}
    >
      {dark ? '☀️' : '🌙'}
    </button>
  );
}
