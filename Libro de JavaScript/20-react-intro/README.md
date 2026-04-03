# Módulo 20 — Introducción a React

## ¿Qué es React?

React es la **librería de UI más popular del mundo** para construir interfaces de usuario. Desarrollada por Meta (Facebook). No es un framework completo — es solo la capa de vista, y se complementa con otras librerías para routing, estado global, etc.

## Conceptos clave

- **Componentes**: bloques de UI reutilizables, como funciones que retornan JSX
- **JSX**: sintaxis que mezcla JavaScript con markup similar a HTML
- **Props**: forma de pasar datos de componentes padre a hijo
- **Estado**: datos que cambian y provocan re-renders

## Para usar estos archivos

Los archivos `.jsx` de este módulo son **ejemplos que requieren un proyecto React**. Para ejecutarlos:

```bash
# Crear proyecto con Vite (la forma moderna)
npm create vite@latest mi-app -- --template react
cd mi-app
npm install
npm run dev
```

Luego copia el contenido de los archivos `.jsx` en `src/App.jsx` o crea nuevos componentes en `src/`.

## Archivos de este módulo

| Archivo | Contenido |
|---------|-----------|
| `01_jsx.jsx` | JSX: diferencias con HTML, expresiones, fragments |
| `02_componentes_props.jsx` | Componentes funcionales, props, children |
| `03_listas_condicional.jsx` | map con key, renderizado condicional |
| `04_componente_completo.jsx` | Tarjeta de versículo bíblico con callbacks |
