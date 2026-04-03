# Módulo 13 — Sistema de archivos con Node.js

## ¿Por qué es importante?

El módulo `fs` (File System) de Node.js permite interactuar con archivos y directorios del sistema operativo. Es fundamental para construir herramientas CLI, servidores, scripts de automatización, y cualquier app que necesite persistir datos localmente.

## API síncrona vs asíncrona

Node.js ofrece tres estilos para trabajar con el sistema de archivos:

| Estilo | Ejemplo | Cuándo usar |
|---|---|---|
| Síncrono | `fs.readFileSync()` | Scripts simples, inicialización |
| Callback | `fs.readFile()` | Código legacy, compatibilidad |
| Promesas | `fs.promises.readFile()` | **Recomendado** — async/await |

**Regla práctica**: usa siempre `fs.promises.*` con `async/await` en código nuevo. Solo usa el estilo síncrono para scripts de inicialización donde bloquear el hilo no importa.

## Archivos del módulo

- `01_leer_archivos.js` — Leer archivos de texto y JSON
- `02_escribir_archivos.js` — Escribir, crear directorios, copiar archivos
- `03_listar_directorios.js` — Listar, filtrar y recorrer directorios
- `04_ejercicios.js` — Ejercicios prácticos

## Consideraciones importantes

- Siempre especificar el encoding `'utf8'` al leer texto
- Usar `path.join()` para construir rutas (compatibilidad entre SO)
- Las operaciones asíncronas nunca bloquean el event loop
- `fs.existsSync()` es conveniente pero puede causar condiciones de carrera
