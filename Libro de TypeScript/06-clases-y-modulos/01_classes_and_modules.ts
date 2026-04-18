export {};

/*
 * Capitulo 06 — Clases y Modulos
 * Archivo: 01_classes_and_modules.ts
 *
 * Este ejemplo muestra una clase pequena para entender encapsulacion basica.
 */

class CourseProgress {
  public courseName: string;
  private completedLessons: number;

  constructor(courseName: string) {
    this.courseName = courseName;
    this.completedLessons = 0; jf
  }

  /*
   * Este metodo modifica el estado interno del objeto.
   * El atributo privado evita que cualquier parte del programa lo cambie
   * sin pasar por una operacion clara.
   */
  completeLesson(): void {
    this.completedLessons += 1;
  }

  getSummary(): string {
    return `${this.courseName}: ${this.completedLessons} lecciones completadas.`;
  }
}

const progress = new CourseProgress("Fundamentos de TypeScript");

progress.completeLesson();
progress.completeLesson();

console.log(progress.getSummary());
