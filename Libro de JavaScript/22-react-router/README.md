# 22 — React Router v6

React Router es la librería estándar para crear aplicaciones de una sola página (SPA) con navegación entre vistas, sin recargar el navegador.

## Instalación

```bash
npm install react-router-dom
```

## Contenido

| Archivo | Tema |
|---|---|
| `01_rutas_basicas.jsx` | BrowserRouter, Routes, Route, Link, NavLink |
| `02_navegacion_avanzada.jsx` | Rutas anidadas, Outlet, búsqueda, rutas privadas |

## Conceptos clave de v6

- `<BrowserRouter>` envuelve toda la app — una sola vez en el árbol
- `<Routes>` agrupa las rutas y renderiza solo la que coincide
- `<Route path="..." element={<Componente />} />` define cada ruta
- `<Link to="/ruta">` reemplaza `<a href>` para navegación sin recarga
- `<NavLink>` es igual que Link pero añade clase `active` automáticamente
- Los parámetros de URL se definen con `:nombre` en el path
