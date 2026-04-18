/*
 * Capitulo 10 — Proyecto Final
 * Archivo: models.ts
 *
 * Este modulo define los tipos base del proyecto. Aqui se modela la forma de
 * una leccion y el tipo de estado que puede tener.
 */

export type LessonStatus = "pending" | "in-progress" | "completed";

export interface Lesson {
  id: number;
  title: string;
  durationMinutes: number;
  status: LessonStatus;
}
