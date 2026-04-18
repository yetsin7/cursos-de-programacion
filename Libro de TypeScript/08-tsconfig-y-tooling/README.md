# Capítulo 08 — tsconfig y Tooling

Un proyecto TypeScript serio no depende solo de escribir tipos. Tambien necesita
una configuracion clara para que el compilador, el editor y los scripts de
trabajo sigan las mismas reglas.

## Que aprenderas

- para que sirve `tsconfig.json`;
- que significan opciones como `strict` y `noImplicitReturns`;
- por que una configuracion buena evita errores acumulados;
- como pensar el tooling como parte del software.

## Que pasa dentro del software

`tsconfig.json` le dice al compilador que archivos revisar, como interpretar
modulos, a que version de JavaScript generar salida y que nivel de rigor usar.

Una mala configuracion puede dejar pasar errores peligrosos. Una buena
configuracion obliga a construir una base mas sana desde el principio.

## Archivo de este capítulo

| Archivo | Descripción |
|---|---|
| `01_tsconfig_explained.ts` | Ejemplo corto para entender el impacto de strict mode |
