# 21 — React Hooks

Los hooks son funciones que permiten usar estado y otras carácterísticas de React dentro de componentes funcionales. Fueron introducidos en React 16.8 y son la forma moderna de escribir React.

## Reglas de los hooks

1. **Solo llamar hooks en el nivel superior** — nunca dentro de condicionales, bucles o funciones anidadas.
2. **Solo llamar hooks desde componentes React o custom hooks** — no desde funciones JavaScript normales.
3. **Los custom hooks deben empezar con `use`** — ej: `useLocalStorage`, `useFetch`.

## Contenido

| Archivo | Hook(s) |
|---|---|
| `01_usestate.jsx` | `useState` — estado local |
| `02_useeffect.jsx` | `useEffect` — efectos secundarios |
| `03_usememo_usecallback.jsx` | `useMemo`, `useCallback`, `React.memo` |
| `04_custom_hooks.jsx` | Custom hooks reutilizables |

## Cómo ejecutar

Estos archivos requieren un proyecto React. La forma más rápida:

```bash
npm create vite@latest hooks-demo -- --template react
cd hooks-demo
npm install
# Reemplazar src/App.jsx con el contenido de cualquier archivo
npm run dev
```
