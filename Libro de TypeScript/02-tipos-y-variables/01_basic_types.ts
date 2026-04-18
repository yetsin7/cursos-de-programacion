export {};

/*
 * Capitulo 02 — Tipos y Variables
 * Archivo: 01_basic_types.ts
 *
 * Este archivo muestra como TypeScript describe datos comunes y como
 * la inferencia ayuda a no repetir tipos innecesariamente.
 */

const studentName: string = "Ana";
const studentAge: number = 19;
const isActive: boolean = true;

/* TypeScript infiere que tags es un arreglo de string. */
const tags = ["typescript", "tipos", "aprendizaje"];

/*
 * unknown obliga a validar antes de usar el valor.
 * Es mucho mas seguro que any cuando el dato viene de una fuente externa.
 */
let externalValue: unknown = "42";

if (typeof externalValue === "string") {
  console.log(`Valor externo como texto: ${externalValue.toUpperCase()}`);
}

/*
 * any desactiva casi toda la ayuda del compilador.
 * Se muestra aqui solo para entender por que no deberiamos abusar de el.
 */
let dangerousValue: any = 10;
dangerousValue = "ahora soy texto";

console.log("Nombre:", studentName);
console.log("Edad:", studentAge);
console.log("Activo:", isActive);
console.log("Etiquetas:", tags.join(", "));
console.log("Valor any:", dangerousValue);
