export {};

/*
 * Capitulo 04 — Objetos, Arreglos y Uniones
 * Archivo: 01_objects_arrays_unions.ts
 *
 * Un union permite declarar que un valor puede tener mas de una forma valida.
 * Luego debemos refinarlo antes de usar operaciones especificas.
 */

type SearchResult = string | string[] | null;

interface Product {
  id: number;
  title: string;
  price: number;
}

const products: Product[] = [
  { id: 1, title: "Teclado", price: 25 },
  { id: 2, title: "Mouse", price: 18 }
];

function printSearchResult(result: SearchResult): void {
  if (result === null) {
    console.log("No hay resultados.");
    return;
  }

  if (typeof result === "string") {
    console.log(`Resultado unico: ${result}`);
    return;
  }

  console.log(`Lista de resultados: ${result.join(", ")}`);
}

function findAffordableProducts(items: Product[], maxPrice: number): Product[] {
  return items.filter((item) => item.price <= maxPrice);
}

printSearchResult("Curso encontrado");
printSearchResult(["TypeScript", "JavaScript"]);
printSearchResult(null);

console.log(findAffordableProducts(products, 20));
