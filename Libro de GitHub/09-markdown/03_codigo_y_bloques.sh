#!/bin/bash
# =============================================================================
# ARCHIVO: 03_codigo_y_bloques.sh
# TEMA: Código en línea, bloques de código y resaltado de sintaxis en Markdown
# =============================================================================
#
# Mostrar código es una de las funcionalidades más usadas de Markdown en GitHub.
# Tanto en READMEs como en Issues y PRs, necesitarás mostrar comandos,
# fragmentos de código y archivos de configuración correctamente formateados.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# CÓDIGO EN LÍNEA (INLINE CODE)
# ─────────────────────────────────────────────────────────────────────────────

# El código en línea se rodea con backticks simples (`).
# Se usa para mencionar comandos, funciones, variables o nombres de archivos
# dentro de un párrafo de texto normal.

cat << 'MARKDOWN'
— Código en línea con backticks simples:
Ejecuta `git status` para ver el estado del repositorio.
El archivo `package.json` contiene las dependencias.
La función `main()` es el punto de entrada.
Usa la variable `$HOME` para la ruta del usuario.

— Si necesitas incluir backticks dentro del código, usa doble backtick:
``El backtick (`) es un carácter especial en Markdown.``

— Código en línea dentro de una oración:
Para instalar Flutter, ejecuta `flutter doctor` y verifica que
todo esté en verde. Si ves errores en `Android SDK`, revisa la
configuración con `flutter config --android-studio-dir`.
MARKDOWN

# CUÁNDO USAR CÓDIGO EN LÍNEA:
# - Nombres de comandos: `git push`, `npm install`, `flutter run`
# - Nombres de archivos: `README.md`, `.gitignore`, `pubspec.yaml`
# - Nombres de funciones o variables: `useState()`, `main()`, `$PATH`
# - Valores técnicos: `true`, `false`, `null`, `200 OK`
# - Atajos de teclado: `Ctrl+C`, `Cmd+Shift+P`

echo ""
echo "========================================="
echo "  CÓDIGO EN LÍNEA"
echo "========================================="
echo ""
echo "  Sintaxis: \`comando\`"
echo "  Ejemplo:  Ejecuta \`git status\` para ver cambios."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# BLOQUES DE CÓDIGO (CODE BLOCKS)
# ─────────────────────────────────────────────────────────────────────────────

# Los bloques de código se crean con tres backticks (```) en líneas separadas.
# Son esenciales para mostrar fragmentos de código, comandos de terminal,
# archivos de configuración, etc.

cat << 'MARKDOWN'
— Bloque de código básico (sin resaltado):
```
git init
git add .
git commit -m "primer commit"
```

— Bloque con resaltado de sintaxis (especifica el lenguaje):
```bash
# Comandos de terminal con resaltado de Bash
git clone https://github.com/usuario/repo.git
cd repo
npm install
npm start
```

```javascript
// Código JavaScript con resaltado
function saludar(nombre) {
  return `Hola, ${nombre}!`;
}
console.log(saludar("Mundo"));
```

```python
# Código Python con resaltado
def saludar(nombre):
    return f"Hola, {nombre}!"

print(saludar("Mundo"))
```

```dart
// Código Dart/Flutter con resaltado
void main() {
  var nombre = 'Flutter';
  print('Hola, $nombre!');
}
```
MARKDOWN

# IMPORTANTE: Los tres backticks de apertura y cierre deben estar SOLOS
# en su propia línea, sin ningún otro texto (excepto el nombre del lenguaje
# en la línea de apertura).

echo ""
echo "========================================="
echo "  BLOQUES DE CÓDIGO"
echo "========================================="
echo ""
echo "  \`\`\`lenguaje"
echo "  código aquí"
echo "  \`\`\`"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# LENGUAJES SOPORTADOS PARA RESALTADO
# ─────────────────────────────────────────────────────────────────────────────

# GitHub soporta cientos de lenguajes para resaltado de sintaxis.
# Aquí están los más comunes:

cat << 'MARKDOWN'
Lenguajes más usados para resaltado en GitHub:

| Identificador | Lenguaje |
|---------------|----------|
| `bash` o `sh` | Bash/Shell |
| `javascript` o `js` | JavaScript |
| `typescript` o `ts` | TypeScript |
| `python` o `py` | Python |
| `dart` | Dart/Flutter |
| `java` | Java |
| `kotlin` | Kotlin |
| `swift` | Swift |
| `html` | HTML |
| `css` | CSS |
| `json` | JSON |
| `yaml` o `yml` | YAML |
| `xml` | XML |
| `sql` | SQL |
| `c` | C |
| `cpp` | C++ |
| `csharp` o `cs` | C# |
| `go` | Go |
| `rust` | Rust |
| `ruby` | Ruby |
| `php` | PHP |
| `markdown` o `md` | Markdown |
| `diff` | Diferencias (git diff) |
| `dockerfile` | Dockerfile |
MARKDOWN

echo ""
echo "  Tip: usa 'diff' para mostrar cambios con + y -"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# BLOQUES DE CÓDIGO ESPECIALES: DIFF
# ─────────────────────────────────────────────────────────────────────────────

# El resaltado de tipo 'diff' es muy útil en code reviews y explicaciones
# de cambios. Las líneas con + se muestran en verde y las con - en rojo.

cat << 'MARKDOWN'
```diff
- const nombre = "valor antiguo";
+ const nombre = "valor nuevo";

- import { ComponenteViejo } from './viejo';
+ import { ComponenteNuevo } from './nuevo';
```
MARKDOWN

# Esto es extremadamente útil cuando explicas cambios en un Issue o PR.
# Visualmente muestra exactamente qué se eliminó y qué se agregó.

# ─────────────────────────────────────────────────────────────────────────────
# BLOQUES DE CÓDIGO CON INDENTACIÓN (ALTERNATIVA)
# ─────────────────────────────────────────────────────────────────────────────

# Otra forma de crear bloques de código es indentar con 4 espacios.
# Sin embargo, esta forma NO soporta resaltado de sintaxis.
# Se recomienda siempre usar los tres backticks.

cat << 'MARKDOWN'
— Con indentación de 4 espacios (sin resaltado):

    git status
    git add .
    git commit -m "mensaje"

— Es equivalente a usar ```, pero sin poder especificar el lenguaje.
— RECOMENDACIÓN: Siempre usa ``` con el lenguaje especificado.
MARKDOWN

# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLOS PRÁCTICOS PARA READMES
# ─────────────────────────────────────────────────────────────────────────────

cat << 'MARKDOWN'
— Sección típica de "Instalación" en un README:

## Instalación

```bash
# Clona el repositorio
git clone https://github.com/usuario/mi-proyecto.git

# Entra al directorio
cd mi-proyecto

# Instala las dependencias
npm install

# Inicia el servidor de desarrollo
npm run dev
```

— Sección típica de "Variables de entorno":

## Configuración

Crea un archivo `.env` basado en `.env.example`:

```bash
cp .env.example .env
```

Configura las siguientes variables:

```env
DATABASE_URL=postgresql://usuario:password@localhost:5432/midb
API_KEY=tu-api-key-aqui
PORT=3000
```

— Sección típica de "Uso de la API":

## Uso

```javascript
const respuesta = await fetch('/api/usuarios', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ nombre: 'Juan', email: 'juan@email.com' })
});
const datos = await respuesta.json();
```
MARKDOWN

echo ""
echo "========================================="
echo "  RESUMEN"
echo "========================================="
echo ""
echo "  \`código en línea\`       → dentro de un párrafo"
echo "  \`\`\`lenguaje ... \`\`\`      → bloque con resaltado"
echo "  \`\`\`diff +/- ... \`\`\`     → mostrar cambios"
echo ""
echo "  ¡Siempre especifica el lenguaje en los bloques de código!"
echo ""
