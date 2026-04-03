/**
 * BookCard.jsx
 * Tarjeta visual que representa un libro de la Biblia.
 * Muestra el nombre corto, nombre largo y un badge AT/NT.
 * Al hacer clic navega a la página de capítulos del libro.
 */

import { useNavigate } from 'react-router-dom';

/**
 * BookCard
 * Tarjeta interactiva para un libro de la Biblia.
 *
 * @param {{ book: Object }} props
 * @param {number}  props.book.bookNumber     - Número del libro (1-66)
 * @param {string}  props.book.shortName      - Nombre corto (ej: "Gén")
 * @param {string}  props.book.longName       - Nombre completo (ej: "Génesis")
 * @param {boolean} props.book.isNewTestament - true si es del Nuevo Testamento
 * @param {string}  props.book.color          - Color hexadecimal de la tarjeta
 * @returns {JSX.Element}
 */
export default function BookCard({ book }) {
  const navigate = useNavigate();

  return (
    <button
      onClick={() => navigate(`/libro/${book.bookNumber}`)}
      title={book.longName}
      style={{
        background: book.color,
        border: 'none',
        borderRadius: 12,
        padding: '14px 10px',
        cursor: 'pointer',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: 4,
        transition: 'transform 0.15s, box-shadow 0.15s',
        boxShadow: '0 2px 8px rgba(0,0,0,0.15)',
        minWidth: 0,
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.transform = 'translateY(-3px)';
        e.currentTarget.style.boxShadow = '0 6px 16px rgba(0,0,0,0.22)';
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.transform = 'translateY(0)';
        e.currentTarget.style.boxShadow = '0 2px 8px rgba(0,0,0,0.15)';
      }}
    >
      {/* Nombre corto del libro */}
      <span style={{ color: '#fff', fontWeight: 700, fontSize: 15, letterSpacing: 0.3 }}>
        {book.shortName}
      </span>

      {/* Nombre largo del libro (truncado si es muy largo) */}
      <span style={{
        color: 'rgba(255,255,255,0.85)', fontSize: 10,
        textAlign: 'center', lineHeight: 1.2,
        overflow: 'hidden', textOverflow: 'ellipsis',
        whiteSpace: 'nowrap', width: '100%',
      }}>
        {book.longName}
      </span>

      {/* Badge AT o NT */}
      <span style={{
        background: 'rgba(0,0,0,0.25)', color: '#fff',
        fontSize: 9, fontWeight: 600, borderRadius: 4,
        padding: '1px 5px', letterSpacing: 0.5,
      }}>
        {book.isNewTestament ? 'NT' : 'AT'}
      </span>
    </button>
  );
}
