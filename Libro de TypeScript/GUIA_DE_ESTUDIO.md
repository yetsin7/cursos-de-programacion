# Guía de Estudio — Libro de TypeScript

Esta guía existe para que el libro no se estudie como una simple coleccion de
archivos. TypeScript se entiende mejor cuando relacionas cada concepto con el
problema que resuelve dentro del software.

## Método recomendado

1. Lee el `README.md` del capítulo antes del código.
2. Ejecuta `npx tsc --noEmit` y confirma que todo este limpio.
3. Abre un archivo `.ts` y explica en voz alta que modela.
4. Cambia algo a proposito para provocar un error del compilador.
5. Corrigelo y anota por que el compilador tenia razon o no.
6. Compila con `npx tsc` y compara el `.ts` con el `.js` generado.

## Preguntas que debes hacerte siempre

- ¿Que tipo de dato representa esto en el mundo real?
- ¿Este valor puede faltar o cambiar de forma?
- ¿Necesito `type`, `interface`, `union` o `generic`?
- ¿Estoy usando `any` por necesidad o por prisa?
- ¿Que bug estoy evitando gracias a esta definición?

## Lo que debes observar en cada etapa

### Durante escritura

- autocompletado;
- ayuda contextual del editor;
- errores de firmas o propiedades.

### Durante compilación

- errores de asignación;
- incompatibilidades entre objetos;
- retornos faltantes;
- accesos inseguros a valores opcionales.

### Durante ejecución

- comportamiento real del JavaScript generado;
- necesidad de validar datos externos;
- diferencia entre modelo teorico y datos reales.

## Consejo central

No estudies TypeScript como una lista de palabras reservadas. Estudialo como una
herramienta para pensar mejor el software antes de ejecutarlo.
