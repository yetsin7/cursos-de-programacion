export {};

/*
 * Capitulo 03 — Funciones e Interfaces
 * Archivo: 01_functions_and_interfaces.ts
 *
 * Aqui modelamos un estudiante y usamos funciones tipadas para
 * describir acciones claras sobre esos datos.
 */

interface Student {
  name: string;
  score: number;
  email?: string;
}

/*
 * Esta funcion recibe un estudiante y devuelve una descripcion legible.
 * TypeScript obliga a que el objeto tenga al menos name y score.
 */
function describeStudent(student: Student): string {
  const emailText = student.email ?? "sin correo registrado";
  return `${student.name} tiene ${student.score} puntos y ${emailText}.`;
}

/*
 * Parametro opcional:
 * punctuation puede llegar o no. Si no llega, usamos un valor por defecto.
 */
function greet(name: string, punctuation: string = "!"): string {
  return `Hola, ${name}${punctuation}`;
}

const firstStudent: Student = {
  name: "Luis",
  score: 95,
  email: "luis@example.com"
};

const secondStudent: Student = {
  name: "Marta",
  score: 88
};

console.log(greet(firstStudent.name));
console.log(describeStudent(firstStudent));
console.log(describeStudent(secondStudent));
