export {};

/*
 * Capitulo 05 — Generics y Narrowing
 * Archivo: 01_generics_and_narrowing.ts
 *
 * Este ejemplo muestra como una funcion puede ser reutilizable para distintos
 * tipos sin perder informacion sobre el dato que recibe y devuelve.
 */

function wrapInArray<T>(value: T): T[] {
  return [value];
}

function getFirstElement<T>(items: T[]): T | undefined {
  return items[0];
}

function printLength(value: string | string[]): void {
  if (typeof value === "string") {
    console.log(`Longitud del texto: ${value.length}`);
    return;
  }

  console.log(`Cantidad de elementos: ${value.length}`);
}

const numbers = wrapInArray(42);
const names = wrapInArray("Sofia");

console.log(numbers);
console.log(names);
console.log(getFirstElement(numbers));
console.log(getFirstElement(["uno", "dos", "tres"]));

printLength("TypeScript");
printLength(["a", "b", "c"]);
