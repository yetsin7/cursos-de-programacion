/**
 * bibleApi.js
 * Capa de acceso a datos del frontend.
 * Contiene todas las funciones que se comunican con la API REST del backend.
 * Usa el proxy de Vite: /api → http://localhost:3001/api
 */

/** URL base de la API. El proxy de Vite redirige esto al backend. */
const API = '/api';

/**
 * Realiza una petición GET a la URL indicada y retorna el JSON parseado.
 * Lanza un error si la respuesta HTTP no es exitosa (status >= 400).
 *
 * @param {string} url - URL relativa al proxy de Vite
 * @returns {Promise<any>} Datos JSON de la respuesta
 * @throws {Error} Si la respuesta no es OK
 */
async function fetchJSON(url) {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`Error ${response.status}: ${response.statusText} — ${url}`);
  }
  return response.json();
}

/**
 * Obtiene la lista completa de los 66 libros de la Biblia.
 * Cada libro incluye: bookNumber, shortName, longName, isNewTestament, color.
 *
 * @returns {Promise<Array>} Lista de libros
 */
export async function getBooks() {
  return fetchJSON(`${API}/books`);
}

/**
 * Obtiene los números de capítulo disponibles para un libro.
 *
 * @param {number} bookNumber - Número del libro (1-66)
 * @returns {Promise<number[]>} Array de números de capítulo
 */
export async function getChapters(bookNumber) {
  return fetchJSON(`${API}/books/${bookNumber}/chapters`);
}

/**
 * Obtiene todos los versículos de un capítulo específico.
 * Retorna: bookNumber, shortName, longName, chapter, verses[].
 *
 * @param {number} bookNumber - Número del libro
 * @param {number} chapter - Número del capítulo
 * @returns {Promise<Object>} Objeto con metadata del libro y array de versículos
 */
export async function getVerses(bookNumber, chapter) {
  return fetchJSON(`${API}/books/${bookNumber}/chapters/${chapter}/verses`);
}

/**
 * Busca versículos que contengan el texto dado.
 * Retorna máximo 50 resultados con referencia y texto limpio.
 *
 * @param {string} query - Texto a buscar (mínimo 2 caracteres)
 * @returns {Promise<Array>} Lista de resultados con reference y text
 */
export async function searchVerses(query) {
  if (!query || query.trim().length < 2) return [];
  return fetchJSON(`${API}/search?q=${encodeURIComponent(query.trim())}`);
}

/**
 * Obtiene un versículo completamente aleatorio de la Biblia.
 *
 * @returns {Promise<Object>} Versículo con reference y text
 */
export async function getRandomVerse() {
  return fetchJSON(`${API}/verse/random`);
}
