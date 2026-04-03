/**
 * routes/bible.js
 * Define todos los endpoints REST para acceder a los datos de la Biblia RV60.
 * Usa better-sqlite3 para consultas síncronas a la base de datos SQLite.
 */

import { Router } from 'express';
import Database from 'better-sqlite3';
import path from 'path';

const router = Router();

// ─── Conexión a la base de datos ─────────────────────────────────────────────

/**
 * Ruta relativa a la BD SQLite desde este archivo.
 * Estructura: backend/routes/bible.js → ../../../datos/biblia_rv60.sqlite3
 */
const DB_PATH = path.join(import.meta.dirname, '../../../datos/biblia_rv60.sqlite3');

let db;
try {
  db = new Database(DB_PATH, { readonly: true });
  console.log('Base de datos biblia_rv60.sqlite3 conectada correctamente.');
} catch (err) {
  console.error('No se pudo abrir la base de datos:', err.message);
  process.exit(1);
}

// ─── Utilidades ──────────────────────────────────────────────────────────────

/**
 * Elimina las marcas Strong's del texto bíblico.
 * Ejemplo: "En el principio<S>7225</S>" → "En el principio"
 *
 * @param {string} text - Texto con posibles marcas <S>número</S>
 * @returns {string} Texto limpio sin marcas
 */
function cleanText(text) {
  if (!text) return '';
  return text.replace(/<S>\d+<\/S>/g, '').trim();
}

/**
 * Mapeo de colores por libro (para las tarjetas en el frontend).
 * Cada libro tiene un color representativo según su género literario.
 */
const BOOK_COLORS = [
  '#B45309','#D97706','#CA8A04','#65A30D','#16A34A','#059669',
  '#0D9488','#0891B2','#0284C7','#2563EB','#4F46E5','#7C3AED',
  '#9333EA','#C026D3','#DB2777','#E11D48','#DC2626','#EA580C',
  '#D97706','#84CC16','#22C55E','#14B8A6','#06B6D4','#3B82F6',
  '#6366F1','#8B5CF6','#A855F7','#EC4899','#F43F5E','#EF4444',
  '#F97316','#EAB308','#A3E635','#4ADE80','#34D399','#2DD4BF',
  '#38BDF8','#60A5FA','#818CF8','#A78BFA',
  // NT
  '#7C3AED','#6D28D9','#5B21B6','#4C1D95','#3730A3','#1E40AF',
  '#1E3A8A','#1D4ED8','#2563EB','#1E40AF','#0369A1','#0E7490',
  '#065F46','#166534','#14532D','#365314','#713F12','#7C2D12',
  '#7F1D1D','#4C0519','#1E1B4B','#0F172A','#172554','#083344',
  '#042F2E','#064E3B',
];

// ─── Endpoints ───────────────────────────────────────────────────────────────

/**
 * GET /api/books
 * Retorna la lista de los 66 libros de la Biblia.
 * Incluye el campo isNewTestament (true si bookNumber > 39).
 */
router.get('/books', (_req, res, next) => {
  try {
    const books = db.prepare(`
      SELECT DISTINCT b AS bookNumber, n AS shortName, l AS longName
      FROM bible
      ORDER BY b
    `).all();

    const result = books.map((book) => ({
      bookNumber: book.bookNumber,
      shortName: book.shortName,
      longName: book.longName,
      isNewTestament: book.bookNumber > 39,
      color: BOOK_COLORS[(book.bookNumber - 1) % BOOK_COLORS.length],
    }));

    res.json(result);
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/books/:bookNumber/chapters
 * Retorna la lista de números de capítulo disponibles para un libro.
 *
 * @param {string} bookNumber - Número del libro (1-66)
 */
router.get('/books/:bookNumber/chapters', (req, res, next) => {
  try {
    const { bookNumber } = req.params;
    const chapters = db.prepare(`
      SELECT DISTINCT c AS chapter
      FROM bible
      WHERE b = ?
      ORDER BY c
    `).all(Number(bookNumber));

    res.json(chapters.map((row) => row.chapter));
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/books/:bookNumber/chapters/:chapter/verses
 * Retorna todos los versículos de un capítulo específico, con texto limpio.
 *
 * @param {string} bookNumber - Número del libro
 * @param {string} chapter - Número del capítulo
 */
router.get('/books/:bookNumber/chapters/:chapter/verses', (req, res, next) => {
  try {
    const { bookNumber, chapter } = req.params;
    const bookInfo = db.prepare(`
      SELECT DISTINCT n AS shortName, l AS longName
      FROM bible WHERE b = ? LIMIT 1
    `).get(Number(bookNumber));

    const verses = db.prepare(`
      SELECT v AS verseNumber, t AS text
      FROM bible
      WHERE b = ? AND c = ?
      ORDER BY v
    `).all(Number(bookNumber), Number(chapter));

    res.json({
      bookNumber: Number(bookNumber),
      shortName: bookInfo?.shortName || '',
      longName: bookInfo?.longName || '',
      chapter: Number(chapter),
      verses: verses.map((v) => ({
        verseNumber: v.verseNumber,
        text: cleanText(v.text),
      })),
    });
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/search?q=texto
 * Busca versículos que contengan el texto dado (case-insensitive LIKE).
 * Retorna máximo 50 resultados con referencia y texto limpio.
 *
 * @query {string} q - Texto a buscar
 */
router.get('/search', (req, res, next) => {
  try {
    const { q } = req.query;
    if (!q || q.trim().length < 2) {
      return res.json([]);
    }

    const results = db.prepare(`
      SELECT b AS bookNumber, n AS shortName, l AS longName,
             c AS chapter, v AS verseNumber, t AS text
      FROM bible
      WHERE t LIKE ?
      ORDER BY b, c, v
      LIMIT 50
    `).all(`%${q.trim()}%`);

    res.json(results.map((row) => ({
      bookNumber: row.bookNumber,
      shortName: row.shortName,
      longName: row.longName,
      chapter: row.chapter,
      verseNumber: row.verseNumber,
      reference: `${row.longName} ${row.chapter}:${row.verseNumber}`,
      text: cleanText(row.text),
    })));
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/verse/random
 * Retorna un versículo completamente aleatorio de la Biblia, con texto limpio.
 */
router.get('/verse/random', (_req, res, next) => {
  try {
    const verse = db.prepare(`
      SELECT b AS bookNumber, n AS shortName, l AS longName,
             c AS chapter, v AS verseNumber, t AS text
      FROM bible
      ORDER BY RANDOM()
      LIMIT 1
    `).get();

    if (!verse) return res.status(404).json({ error: 'No se encontró versículo' });

    res.json({
      bookNumber: verse.bookNumber,
      shortName: verse.shortName,
      longName: verse.longName,
      chapter: verse.chapter,
      verseNumber: verse.verseNumber,
      reference: `${verse.longName} ${verse.chapter}:${verse.verseNumber}`,
      text: cleanText(verse.text),
    });
  } catch (err) {
    next(err);
  }
});

export default router;
