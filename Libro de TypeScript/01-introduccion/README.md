# Capítulo 01 — Introducción a TypeScript

TypeScript es una capa de desarrollo sobre JavaScript. Su trabajo principal es
revisar tipos antes de ejecutar el programa para ayudarte a detectar errores
antes de tiempo.

## Que aprenderas

- que es TypeScript;
- por que no reemplaza a JavaScript;
- que hace el compilador;
- como se transforma un archivo `.ts` en `.js`;
- por que esto ayuda al software y al equipo humano.

## Que esta pasando dentro del software

Cuando escribes un archivo `.ts`, el compilador analiza nombres, tipos, firmas
de funciones y relaciones entre objetos. Si detecta algo incoherente, te avisa
antes de generar JavaScript o antes de que ejecutes el programa.

Luego genera JavaScript compatible con el entorno configurado. Node.js o el
navegador no ejecutan "TypeScript puro": ejecutan JavaScript generado.

## Idea clave

TypeScript mejora el momento de desarrollo.
JavaScript sigue siendo el lenguaje que corre realmente.

## Errores comunes

- pensar que TypeScript valida automaticamente datos que vienen de internet;
- creer que los tipos existen en tiempo de ejecucion;
- usar `any` demasiado pronto;
- no leer los mensajes del compilador.

## Archivo de este capítulo

| Archivo | Descripción |
|---|---|
| `01_hello_typescript.ts` | Primer ejemplo y comparacion entre desarrollo y ejecucion |
