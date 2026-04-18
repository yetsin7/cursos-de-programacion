export {};

/*
 * Capitulo 09 — Async y Fetch
 * Archivo: 01_async_and_fetch.ts
 *
 * Este ejemplo simula una llamada remota. Se usa una promesa local para no
 * depender de internet y mantener el libro estable y reproducible.
 */

interface LessonResponse {
  id: number;
  title: string;
  completed: boolean;
}

function fetchLessonMock(): Promise<LessonResponse> {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        id: 9,
        title: "Async en TypeScript",
        completed: true
      });
    }, 100);
  });
}

async function printLessonStatus(): Promise<void> {
  const lesson = await fetchLessonMock();
  const statusText = lesson.completed ? "completada" : "pendiente";
  console.log(`Leccion ${lesson.id}: ${lesson.title} -> ${statusText}`);
}

void printLessonStatus();
