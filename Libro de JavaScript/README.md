# Libro de JavaScript — De cero a PRO

Repositorio de aprendizaje de JavaScript diseñado para llevarte desde los fundamentos
básicos hasta un nivel profesional, con código moderno (ES2022+), comentarios en español
y ejemplos ejecutables con Node.js.

---

## ¿Para quién es este libro?

- Personas que nunca han programado en JavaScript
- Desarrolladores de otros lenguajes que quieren aprender JS
- Quienes quieren actualizar su conocimiento al estándar moderno (ES2022+)

---

## Requisitos

- **Node.js** v18 o superior instalado → [nodejs.org](https://nodejs.org)
- **VS Code** recomendado → [code.visualstudio.com](https://code.visualstudio.com)
- Extensión de VS Code: **ESLint** (opcional pero recomendada)

### Verificar instalación de Node.js

```bash
node --version
# Debe mostrar algo como: v20.x.x o superior
```

---

## Cómo usar este repositorio

1. Clona o descarga el repositorio
2. Abre la carpeta en VS Code
3. Navega al módulo que te interese
4. Ejecuta cualquier archivo con:

```bash
node nombre_del_archivo.js
```

Ejemplo:

```bash
node 01-fundamentos/01_hola_mundo.js
```

Lee los comentarios en el código — son la lección.

---

## Estructura del repositorio

| Nivel | Módulo | Tema | Archivos |
|-------|--------|------|----------|
| 🟢 **Básico** | `01-fundamentos/` | Variables, tipos, template literals | 01–06 |
| 🟢 **Básico** | `02-tipos-de-datos/` | Strings, numbers, booleans, null/undefined | 01–05 |
| 🟢 **Básico** | `03-operadores/` | Aritmética, comparación, lógicos, spread | 01–05 |
| 🟢 **Básico** | `04-control-de-flujo/` | if/else, for, while, break/continue | 01–05 |
| 🟢 **Básico** | `05-funciones/` | Declaradas, arrows, closures, HOF | 01–06 |
| 🟡 **Medio** | `06-arrays/` | Métodos de array, desestructuración | 01–05 |
| 🟡 **Medio** | `07-objetos/` | Objetos, prototipos, clases ES6+ | 01–05 |
| 🟡 **Medio** | `08-async/` | Callbacks, Promises, async/await | 01–05 |
| 🟡 **Medio** | `09-modulos/` | import/export, CommonJS, ES Modules | 01–04 |
| 🟡 **Medio** | `10-dom/` | Manipulación del DOM, eventos | 01–05 |
| 🟡 **Medio** | `11-apis/` | fetch, REST APIs, JSON | 01–04 |
| 🔴 **Avanzado** | `12-node-fs/` | File system, streams, buffers | 01–04 |
| 🔴 **Avanzado** | `13-express/` | Servidor HTTP, rutas, middlewares | 01–05 |
| 🔴 **Avanzado** | `14-typescript/` | Tipos, interfaces, generics | 01–05 |
| 🔴 **Avanzado** | `15-testing/` | Jest, unit tests, mocks | 01–04 |
| 🔴 **Avanzado** | `16-react-intro/` | Componentes, hooks, estado | 01–05 |
| 🔴 **Avanzado** | `17-patrones/` | Design patterns en JS | 01–05 |

---

## Instalar Node.js

### Windows
1. Ve a [nodejs.org](https://nodejs.org)
2. Descarga la versión **LTS** (recomendada para producción)
3. Ejecuta el instalador y sigue los pasos
4. Abre una terminal nueva y ejecuta `node --version`

### macOS (con Homebrew)
```bash
brew install node
```

### Linux (Ubuntu/Debian)
```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

---

## Consejos para aprender bien

1. **No copies y pegues** — escribe el código a mano para que lo memorices
2. **Ejecuta cada archivo** y observa la salida antes de seguir
3. **Haz los ejercicios** del final de cada módulo antes de ver la solución
4. **Experimenta** cambiando valores, rompiendo el código y arreglándolo
5. **Lee los comentarios** — son la explicación del concepto
6. **Revisa el README** de cada módulo antes de empezar los archivos
7. **Practica todos los días** — aunque sea 20 minutos

---

## Carpeta `datos/`

Contiene una base de datos SQLite con la Biblia (RV60) para practicar
consultas reales con Node.js. Ver `datos/README.md` para detalles.

---

## Licencia

Este repositorio es de uso libre para fines educativos.
Puedes compartirlo, modificarlo y usarlo como quieras.
