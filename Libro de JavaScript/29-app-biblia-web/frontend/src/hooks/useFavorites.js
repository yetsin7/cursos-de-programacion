/**
 * useFavorites.js
 * Custom hook para gestionar los versículos favoritos del usuario.
 * Los favoritos se persisten en localStorage como un array de strings
 * con el formato de referencia: "Juan 3:16".
 */

import { useState, useEffect } from 'react';

/** Clave usada en localStorage para almacenar los favoritos */
const STORAGE_KEY = 'biblia-favorites';

/**
 * useFavorites
 * Permite agregar, quitar y consultar versículos favoritos.
 * Los cambios se persisten automáticamente en localStorage.
 *
 * @returns {{
 *   favorites: string[],
 *   addFavorite: (reference: string) => void,
 *   removeFavorite: (reference: string) => void,
 *   isFavorite: (reference: string) => boolean,
 *   clearFavorites: () => void,
 * }}
 */
export function useFavorites() {
  const [favorites, setFavorites] = useState(() => {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      return stored ? JSON.parse(stored) : [];
    } catch {
      return [];
    }
  });

  // Persiste los favoritos en localStorage cada vez que cambian
  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(favorites));
  }, [favorites]);

  /**
   * Agrega una referencia a la lista de favoritos si no existe ya.
   *
   * @param {string} reference - Referencia del versículo, ej: "Juan 3:16"
   */
  function addFavorite(reference) {
    setFavorites((prev) =>
      prev.includes(reference) ? prev : [...prev, reference]
    );
  }

  /**
   * Elimina una referencia de la lista de favoritos.
   *
   * @param {string} reference - Referencia a eliminar
   */
  function removeFavorite(reference) {
    setFavorites((prev) => prev.filter((r) => r !== reference));
  }

  /**
   * Verifica si una referencia está en la lista de favoritos.
   *
   * @param {string} reference - Referencia a consultar
   * @returns {boolean} true si está en favoritos
   */
  function isFavorite(reference) {
    return favorites.includes(reference);
  }

  /**
   * Elimina todos los favoritos de la lista.
   */
  function clearFavorites() {
    setFavorites([]);
  }

  return { favorites, addFavorite, removeFavorite, isFavorite, clearFavorites };
}
