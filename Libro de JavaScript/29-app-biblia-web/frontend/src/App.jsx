/**
 * App.jsx
 * Componente raíz de la aplicación Biblia RV60.
 * Configura el enrutamiento con react-router-dom v6,
 * el estado global del modo oscuro y el layout principal.
 */

import { useState, useEffect } from 'react';
import { Routes, Route, Link, useNavigate } from 'react-router-dom';
import HomePage from './pages/HomePage.jsx';
import BookPage from './pages/BookPage.jsx';
import ChapterPage from './pages/ChapterPage.jsx';
import SearchPage from './pages/SearchPage.jsx';
import FavoritesPage from './pages/FavoritesPage.jsx';
import ThemeToggle from './components/ThemeToggle.jsx';

// ─── Estilos base inyectados globalmente ─────────────────────────────────────
const globalStyles = `
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  :root {
    --bg: #f8f7f2; --surface: #ffffff; --border: #e5e0d5;
    --text: #1a1a1a; --text-muted: #6b6b6b; --primary: #7c3aed;
    --primary-light: #ede9fe; --nav-bg: #ffffff; --shadow: rgba(0,0,0,0.08);
  }
  html.dark {
    --bg: #0f0e17; --surface: #1a1929; --border: #2e2b45;
    --text: #f0eefc; --text-muted: #9d9ab8; --primary: #a78bfa;
    --primary-light: #2e1f6e; --nav-bg: #1a1929; --shadow: rgba(0,0,0,0.4);
  }
  body { background: var(--bg); color: var(--text); font-family: system-ui, sans-serif;
    font-size: 16px; line-height: 1.6; transition: background 0.2s, color 0.2s; }
  a { color: inherit; text-decoration: none; }
`;

/**
 * App
 * Componente principal que orquesta navegación, tema y layout.
 * El modo oscuro se aplica añadiendo la clase "dark" a <html>
 * y se persiste en localStorage bajo la clave "biblia-theme".
 *
 * @returns {JSX.Element}
 */
export default function App() {
  const [darkMode, setDarkMode] = useState(() => {
    return localStorage.getItem('biblia-theme') === 'dark';
  });

  const navigate = useNavigate();

  // Sincroniza la clase "dark" en <html> y persiste en localStorage
  useEffect(() => {
    if (darkMode) {
      document.documentElement.classList.add('dark');
      localStorage.setItem('biblia-theme', 'dark');
    } else {
      document.documentElement.classList.remove('dark');
      localStorage.setItem('biblia-theme', 'light');
    }
  }, [darkMode]);

  /** Maneja la búsqueda desde la barra del header */
  function handleSearch(query) {
    if (query.trim()) navigate(`/buscar?q=${encodeURIComponent(query.trim())}`);
  }

  return (
    <>
      {/* Estilos globales inyectados en un <style> en el head */}
      <style>{globalStyles}</style>

      {/* ── Header / Nav ── */}
      <header style={{
        background: 'var(--nav-bg)', borderBottom: '1px solid var(--border)',
        position: 'sticky', top: 0, zIndex: 100,
        boxShadow: '0 1px 8px var(--shadow)',
      }}>
        <nav style={{
          maxWidth: 900, margin: '0 auto', padding: '0 16px',
          display: 'flex', alignItems: 'center', gap: 24, height: 56,
        }}>
          <Link to="/" style={{ fontWeight: 700, fontSize: 20, color: 'var(--primary)' }}>
            📖 Biblia RV60
          </Link>
          <div style={{ flex: 1 }} />
          <NavLink to="/">Inicio</NavLink>
          <NavLink to="/buscar">Buscar</NavLink>
          <NavLink to="/favoritos">Favoritos</NavLink>
          <ThemeToggle dark={darkMode} onToggle={() => setDarkMode((d) => !d)} />
        </nav>
      </header>

      {/* ── Contenido principal ── */}
      <main style={{ maxWidth: 900, margin: '0 auto', padding: '24px 16px' }}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/libro/:bookNumber" element={<BookPage />} />
          <Route path="/libro/:bookNumber/capitulo/:chapter" element={<ChapterPage />} />
          <Route path="/buscar" element={<SearchPage />} />
          <Route path="/favoritos" element={<FavoritesPage />} />
        </Routes>
      </main>
    </>
  );
}

/**
 * NavLink
 * Enlace de navegación estilizado para el header.
 *
 * @param {{ to: string, children: React.ReactNode }} props
 */
function NavLink({ to, children }) {
  return (
    <Link to={to} style={{
      color: 'var(--text-muted)', fontWeight: 500, fontSize: 15,
      padding: '4px 8px', borderRadius: 6,
      transition: 'color 0.15s',
    }}
      onMouseEnter={(e) => { e.target.style.color = 'var(--primary)'; }}
      onMouseLeave={(e) => { e.target.style.color = 'var(--text-muted)'; }}
    >
      {children}
    </Link>
  );
}
