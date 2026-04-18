export {};

/*
 * Capitulo 01 — Introduccion a TypeScript
 * Archivo: 01_hello_typescript.ts
 *
 * Este ejemplo muestra la idea central del lenguaje:
 * TypeScript revisa el codigo antes de ejecutarlo y luego lo transforma
 * a JavaScript para que Node.js o el navegador puedan correrlo.
 */

/* Una variable con tipo inferido. TypeScript deduce que es string. */
const courseName = "Libro de TypeScript";

/* Una variable con tipo anotado manualmente. */
const currentLesson: number = 1;

/*
 * Esta funcion recibe texto y devuelve texto.
 * El compilador verifica que la usemos de forma correcta.
 */
function buildMessage(name: string, lesson: number): string {
  return `Bienvenido a ${name}. Estas estudiando la leccion ${lesson}.`;
}

console.log(buildMessage(courseName, currentLesson));

/*
 * Si descomentas la linea de abajo, TypeScript mostrara un error
 * porque espera un numero y estamos enviando un string.
 */
// console.log(buildMessage(courseName, "uno"));

/*
 * Idea importante:
 * El error aparece en desarrollo, antes de que el software llegue a
 * ejecutarse y antes de que un usuario final sufra el fallo.
 */
