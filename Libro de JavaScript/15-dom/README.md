# 15 — DOM (Document Object Model)

El DOM es la representación en memoria de un documento HTML. JavaScript puede leer y modificar el DOM para cambiar lo que el usuario ve, sin recargar la página.

## Requisito

Estos archivos **requieren un navegador**. No funcionan con `node archivo.js`.

## Cómo usar

**Opción A — Consola del navegador (más rápido):**
1. Abre cualquier página web en Chrome o Firefox
2. Presiona `F12` → pestaña **Consola**
3. Copia y pega el código del archivo
4. Presiona Enter

**Opción B — Archivo HTML con script:**
```html
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>DOM</title></head>
<body>
  <div id="app"></div>
  <script src="01_selectores.js"></script>
</body>
</html>
```
Luego abre el HTML en el navegador (doble clic o extensión Live Server en VS Code).

## Contenido

| Archivo | Tema |
|---|---|
| `01_selectores.js` | Cómo encontrar elementos en el HTML |
| `02_manipular_dom.js` | Leer y modificar elementos |
| `03_eventos.js` | Responder a acciones del usuario |
| `04_ejercicios.js` | Ejercicios prácticos |
