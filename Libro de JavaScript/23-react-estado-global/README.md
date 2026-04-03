# 23 — Estado Global en React

El estado global es compartido entre componentes que no tienen relación directa de padre-hijo, sin necesidad de pasar props manualmente por toda la jerarquía (prop drilling).

## ¿Cuándo usar estado global?

- El estado se comparte entre muchos componentes en distintos niveles del árbol
- Pasarlo por props es tedioso o imposible (prop drilling profundo)
- El estado persiste entre navegaciones (carrito, usuario autenticado, tema)

## Opciones disponibles

| Solución | Cuándo usar |
|---|---|
| **useState + props** | Estado local o entre padre e hijo directo |
| **Context API** | Estado simple compartido (tema, idioma, usuario) |
| **Zustand** | Estado complejo, múltiple, frecuente o con acciones |
| **Redux Toolkit** | Apps muy grandes con equipos grandes |

## Contenido

| Archivo | Tema |
|---|---|
| `01_context_api.jsx` | createContext, useContext, Provider |
| `02_zustand.jsx` | Zustand — estado global simple y potente |

## Instalación de Zustand

```bash
npm install zustand
```
