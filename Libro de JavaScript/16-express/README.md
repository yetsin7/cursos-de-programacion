# 16 — Express.js

Express es el framework web más popular para Node.js. Permite crear servidores HTTP y APIs REST de forma minimalista con poco código.

## Instalación previa

```bash
npm init -y
npm install express
```

## Contenido

| Archivo | Tema |
|---|---|
| `01_servidor_basico.js` | Crear un servidor y responder peticiones |
| `02_rutas_y_params.js` | Parámetros de ruta, query strings, body |
| `03_middleware.js` | Funciones intermedias y manejo de errores |
| `04_api_rest.js` | API CRUD completa en memoria |

## Cómo ejecutar

```bash
node 01_servidor_basico.js
# Abre http://localhost:3000 en el navegador
# O prueba con: curl http://localhost:3000
```

## Concepto clave

Express sigue el patrón **middleware**: cada petición pasa por una cadena de funciones antes de llegar al handler final. Esto permite separar autenticación, logging, validación, etc.
