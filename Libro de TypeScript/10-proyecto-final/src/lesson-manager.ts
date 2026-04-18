/*
 * Capitulo 10 — Proyecto Final
 * Archivo: lesson-manager.ts
 *
 * Esta clase encapsula la logica para listar y resumir lecciones.
 */

import type { Lesson, LessonStatus } from "./models";

export class LessonManager {
  private lessons: Lesson[];

  constructor(lessons: Lesson[]) {
    this.lessons = lessons;
  }

  getAllLessons(): Lesson[] {
    return this.lessons;
  }

  getLessonsByStatus(status: LessonStatus): Lesson[] {
    return this.lessons.filter((lesson) => lesson.status === status);
  }

  getCompletedCount(): number {
    return this.getLessonsByStatus("completed").length;
  }

  getSummary(): string {
    return `Total: ${this.lessons.length} | completadas: ${this.getCompletedCount()}`;
  }
}
