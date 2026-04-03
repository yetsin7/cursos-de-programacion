/**
 * VerseList.jsx
 * Componente que renderiza la lista completa de versículos de un capítulo.
 * Delega el renderizado de cada versículo a VerseTile.
 * Muestra un mensaje si la lista está vacía.
 *
 * @param {Object} props
 * @param {Array<{verseNumber: number, text: string}>} props.verses - Versículos del capítulo
 * @param {string} props.bookName - Nombre del libro (ej: "Juan")
 * @param {number} props.chapter - Número del capítulo actual
 * @param {string[]} props.favorites - Array de referencias favoritas
 * @param {Function} props.onToggleFavorite - Callback al marcar/desmarcar favorito, recibe la referencia
 */
import VerseTile from './VerseTile.jsx';

export default function VerseList({
  verses = [],
  bookName = '',
  chapter = 1,
  favorites = [],
  onToggleFavorite,
}) {
  // Estado vacío: el capítulo no tiene versículos
  if (verses.length === 0) {
    return (
      <p style={{ color: 'var(--text-muted)', textAlign: 'center', padding: 32 }}>
        Este capítulo no tiene versículos disponibles.
      </p>
    );
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
      {verses.map((verse) => {
        // Construye la referencia canónica del versículo
        const reference = `${bookName} ${chapter}:${verse.verseNumber}`;

        return (
          <VerseTile
            key={verse.verseNumber}
            verse={verse}
            bookName={bookName}
            chapter={chapter}
            isFavorite={favorites.includes(reference)}
            onToggleFavorite={onToggleFavorite}
          />
        );
      })}
    </div>
  );
}
