/*
 * Capitulo 10 — Proyecto Final
 * Archivo: sample-data.ts
 *
 * Este modulo concentra datos de ejemplo para evitar mezclarlos con la logica.
 */

import type { Lesson } from "./models";

export const sampleLessons: Lesson[] = [
  { id: 1, title: "Introduccion a TypeScript", durationMinutes: 20, status: "completed" },
  { id: 2, title: "Tipos primitivos", durationMinutes: 25, status: "completed" },
  { id: 3, title: "Funciones e interfaces", durationMinutes: 30, status: "in-progress" },
  { id: 4, title: "Generics", durationMinutes: 35, status: "pending" }
];
