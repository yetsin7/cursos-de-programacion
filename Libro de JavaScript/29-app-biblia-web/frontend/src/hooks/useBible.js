/**
 * useBible.js
 * Custom hook para gestionar la carga de datos de la Biblia desde la API.
 * Encapsula el estado de libros, capítulos, versículos, carga y errores.
 */

import { useState, useEffect } from 'react';
import { getBooks, getChapters, getVerses } from '../api/bibleApi.js';

/**
 * useBible
 * Proporciona funciones y estado para navegar por la Biblia:
 * cargar libros, capítulos de un libro y versículos de un capítulo.
 *
 * @returns {{
 *   books: Array,
 *   chapters: number[],
 *   verseData: Object|null,
 *   loading: boolean,
 *   error: string|null,
 *   loadChapters: (bookNumber: number) => void,
 *   loadVerses: (bookNumber: number, chapter: number) => void,
 * }}
 */
export function useBible() {
  const [books, setBooks] = useState([]);
  const [chapters, setChapters] = useState([]);
  const [verseData, setVerseData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Carga los 66 libros al montar el hook por primera vez
  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(null);

    getBooks()
      .then((data) => { if (!cancelled) setBooks(data); })
      .catch((err) => { if (!cancelled) setError(err.message); })
      .finally(() => { if (!cancelled) setLoading(false); });

    return () => { cancelled = true; };
  }, []);

  /**
   * Carga los capítulos disponibles de un libro específico.
   *
   * @param {number} bookNumber - Número del libro (1-66)
   */
  async function loadChapters(bookNumber) {
    setLoading(true);
    setError(null);
    setChapters([]);
    try {
      const data = await getChapters(bookNumber);
      setChapters(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  /**
   * Carga los versículos de un capítulo específico.
   *
   * @param {number} bookNumber - Número del libro
   * @param {number} chapter - Número del capítulo
   */
  async function loadVerses(bookNumber, chapter) {
    setLoading(true);
    setError(null);
    setVerseData(null);
    try {
      const data = await getVerses(bookNumber, chapter);
      setVerseData(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return { books, chapters, verseData, loading, error, loadChapters, loadVerses };
}
