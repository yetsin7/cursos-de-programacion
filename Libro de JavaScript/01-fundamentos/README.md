# Módulo 01 — Fundamentos de JavaScript

Este módulo te introduce a JavaScript desde la base correcta: entender como se
ejecuta el código, que hace la consola y por que variables, tipos y scope son
tan importantes desde el primer dia.

---

## ¿Que es JavaScript?

JavaScript es el lenguaje principal de la web. Nacio para dar interactividad a
las páginas, pero hoy también funciona en servidores, scripts, apps moviles,
herramientas de escritorio y automatizacion.

---

## ¿Que aprenderas en este módulo?

Al terminar deberias poder explicar:

- que es JavaScript;
- que diferencia hay entre navegador y Node.js;
- como mostrar resultados en consola;
- como guardar datos en variables;
- por que `const` y `let` son mejores que `var`;
- como construir texto dinámico con template literals.

---

## JavaScript en el navegador y en Node.js

### En el navegador

JavaScript puede:

- modificar el DOM;
- responder a eventos del usuario;
- comunicarse con servidores;
- guardar datos localmente;
- actualizar la interfaz en pantalla.

### En Node.js

JavaScript puede:

- leer y escribir archivos;
- crear servidores;
- conectarse a bases de datos;
- ejecutar scripts de consola;
- automatizar tareas.

---

## ¿Que pasa cuando ejecutas un archivo .js?

Cuando corres `node archivo.js`:

1. Node abre el archivo;
2. el motor de JavaScript analiza el código;
3. crea variables y funciones en memoria;
4. ejecuta las instrucciones;
5. muestra resultados en consola o interactua con el sistema.

---

## Archivos de este módulo

| Archivo | Tema |
|---------|------|
| `01_hola_mundo.js` | Primera salida en consola |
| `02_variables.js` | `const`, `let` y por que evitar `var` |
| `03_tipos_de_datos.js` | Tipos primitivos de JS |
| `04_constantes_y_scope.js` | Scope, hoisting y TDZ |
| `05_template_literals.js` | Texto dinámico con backticks |
| `06_ejercicios.js` | Practica guiada |

---

## Errores comúnes del principiante

- pensar que JavaScript solo sirve en páginas web;
- confundir Node.js con el lenguaje;
- usar `var` por costumbre vieja;
- no revisar la salida de la consola;
- memorizar sin experimentar.

---

## Como estudiar este módulo

1. Ejecuta cada archivo.
2. Lee los comentarios como parte de la leccion.
3. Cambia valores y vuelve a ejecutar.
4. Intenta romper algo y observa el error.
5. Explica que paso antes de avanzar.

---

## Cómo ejecutar los archivos

```bash
node 01-fundamentos/01_hola_mundo.js
```

O si ya estas dentro de la carpeta:

```bash
node 01_hola_mundo.js
```
