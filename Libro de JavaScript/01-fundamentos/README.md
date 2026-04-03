# Módulo 01 — Fundamentos de JavaScript

## ¿Qué es JavaScript?

JavaScript (JS) es el lenguaje de programación de la web. Fue creado en 1995 por
Brendan Eich en sólo 10 días mientras trabajaba en Netscape. Su objetivo original
era agregar interactividad a páginas HTML estáticas.

Hoy en día JavaScript es mucho más que eso:

- Es el único lenguaje que los navegadores entienden de forma nativa
- Con **Node.js** (creado en 2009) también corre en el servidor
- Se usa para aplicaciones móviles (React Native), escritorio (Electron),
  APIs REST, herramientas de línea de comandos, videojuegos, IA y más

---

## Breve historia

| Año | Hito |
|-----|------|
| 1995 | Brendan Eich crea JavaScript en Netscape (en 10 días) |
| 1997 | Se estandariza como **ECMAScript** (ECMA-262) |
| 2009 | Node.js permite ejecutar JS fuera del navegador |
| 2015 | **ES6/ES2015** — la revolución moderna: clases, arrow functions, Promises |
| 2016–hoy | Actualizaciones anuales: ES2016, ES2017 ... ES2022, ES2023... |

---

## JavaScript en el navegador

En el navegador, JavaScript puede:

- Manipular el contenido de la página (DOM)
- Responder a eventos del usuario (clics, teclas, formularios)
- Comunicarse con servidores (fetch, AJAX)
- Guardar datos localmente (localStorage, cookies)
- Animar elementos, validar formularios, etc.

```html
<!-- Así se incluye JS en una página HTML -->
<script src="mi-script.js"></script>
```

---

## JavaScript en Node.js

Con **Node.js**, JavaScript sale del navegador y puede:

- Leer y escribir archivos del sistema
- Crear servidores HTTP
- Conectarse a bases de datos
- Ejecutar scripts de automatización
- Construir APIs REST

```bash
# Ejecutar un archivo JS con Node.js
node mi_archivo.js
```

---

## ¿Por qué aprender JavaScript?

1. **Es el lenguaje más usado del mundo** (Stack Overflow 2023)
2. **Versatilidad total**: frontend, backend, mobile, desktop, scripts
3. **Enorme ecosistema**: npm tiene más de 2 millones de paquetes
4. **Alta demanda laboral**: uno de los lenguajes mejor pagados
5. **Comunidad gigante**: tutoriales, libros, videos en todos los idiomas

---

## Archivos de este módulo

| Archivo | Tema |
|---------|------|
| `01_hola_mundo.js` | Tu primer programa, console.log |
| `02_variables.js` | const, let y por qué no var |
| `03_tipos_de_datos.js` | Los 7 tipos primitivos de JS |
| `04_constantes_y_scope.js` | Scope de bloque, hoisting, TDZ |
| `05_template_literals.js` | Strings modernos con backticks |
| `06_ejercicios.js` | Practica lo aprendido |

---

## Cómo ejecutar los archivos

```bash
node 01-fundamentos/01_hola_mundo.js
```

O si ya estás dentro de la carpeta `01-fundamentos/`:

```bash
node 01_hola_mundo.js
```
