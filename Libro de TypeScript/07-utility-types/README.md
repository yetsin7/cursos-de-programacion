# Capítulo 07 — Utility Types

Los utility types son herramientas ya construidas por TypeScript para transformar
y reutilizar tipos existentes. Son muy utiles cuando un mismo dato necesita
varias versiones: completa, parcial, resumida o indexada por claves.

## Que aprenderas

- que hacen `Partial`, `Required`, `Pick`, `Omit` y `Record`;
- como adaptar tipos sin duplicar codigo;
- por que esto mejora formularios, APIs y configuraciones;
- como pensar versiones distintas del mismo modelo.

## Que pasa dentro del software

Estos tipos no crean estructuras nuevas en tiempo de ejecucion. Siguen siendo
reglas para el compilador. Su poder esta en ayudarte a modelar cambios de forma
sin repetir definiciones manuales.

## Ideas clave

- `Partial<T>` vuelve opcionales las propiedades de `T`
- `Required<T>` vuelve obligatorias todas las propiedades
- `Pick<T, K>` selecciona algunas claves
- `Omit<T, K>` excluye algunas claves
- `Record<K, V>` crea un objeto indexado por claves conocidas

## Archivo de este capítulo

| Archivo | Descripción |
|---|---|
| `01_utility_types.ts` | Uso practico de utility types para remodelar datos |
