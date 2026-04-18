/*
 * Capitulo 10 — Proyecto Final
 * Archivo: main.ts
 *
 * Este es el punto de entrada del proyecto final. Une tipos, clase y datos para
 * mostrar una salida clara en consola.
 */

import { LessonManager } from "./lesson-manager";
import { sampleLessons } from "./sample-data";

const manager = new LessonManager(sampleLessons);

console.log("Resumen general:");
console.log(manager.getSummary());

console.log("\nLecciones completadas:");

for (const lesson of manager.getLessonsByStatus("completed")) {
  console.log(`- ${lesson.title} (${lesson.durationMinutes} min)`);
}
