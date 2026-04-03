# Lesson 03: Reading Changelogs and Semantic Versioning

## Introduccion

Cada vez que actualizas una dependencia en tu proyecto, necesitas saber que cambio. Los changelogs y el versionado semantico te dan esa informacion. Leerlos correctamente en ingles es una habilidad esencial para evitar sorpresas desagradables en produccion.

---

## Semantic Versioning (SemVer)

El versionado semantico es el estandar para numerar versiones de software. Se define en semver.org.

### Formato: MAJOR.MINOR.PATCH

```
v2.4.1
│ │ │
│ │ └── PATCH: correccion de bugs (backward compatible)
│ └──── MINOR: nueva funcionalidad (backward compatible)
└────── MAJOR: cambios que rompen compatibilidad (breaking changes)
```

### Ejemplos practicos

| Version | Tipo de cambio | Significado |
|---------|---------------|-------------|
| 1.0.0 → 1.0.1 | **PATCH** | Se corrigio un bug, actualiza sin miedo |
| 1.0.0 → 1.1.0 | **MINOR** | Se agrego funcionalidad nueva, tu codigo sigue funcionando |
| 1.0.0 → 2.0.0 | **MAJOR** | Hay breaking changes, revisa antes de actualizar |
| 0.x.x | **Pre-release** | Cualquier cambio puede romper cosas |

### Vocabulario de SemVer

| Termino | Significado |
|---------|-------------|
| **Backward compatible** | Compatible con versiones anteriores |
| **Breaking change** | Cambio que rompe el codigo existente |
| **Pre-release** | Version previa al lanzamiento estable |
| **Release candidate (RC)** | Candidato a version final |
| **Stable release** | Version estable |
| **Long-term support (LTS)** | Soporte a largo plazo |
| **End of life (EOL)** | Fin del soporte |
| **Latest** | La version mas reciente |
| **Nightly build** | Compilacion automatica diaria (inestable) |
| **Alpha / Beta** | Versiones de prueba tempranas / avanzadas |

### Sufijos de version

```
2.0.0-alpha.1    → Version alpha (muy temprana, inestable)
2.0.0-beta.3     → Version beta (funcionalidades completas, puede tener bugs)
2.0.0-rc.1       → Release candidate (casi lista para produccion)
2.0.0             → Stable release (lista para produccion)
```

---

## Formatos de Changelog

### Keep a Changelog (keepachangelog.com)

El formato mas popular. Organiza cambios por tipo:

```markdown
# Changelog

## [2.1.0] - 2025-03-15

### Added
- New `dark mode` theme option for the dashboard
- Support for WebSocket connections in the API client
- Spanish translation for all error messages

### Changed
- Upgraded database driver from v3 to v4
- Improved response time for search queries by 40%

### Deprecated
- The `legacyAuth()` method will be removed in v3.0
- XML response format (use JSON instead)

### Fixed
- Fixed memory leak in connection pool handler
- Resolved race condition in concurrent file uploads
- Corrected timezone calculation for UTC-negative zones

### Removed
- Dropped support for Node.js 14 (EOL)
- Removed deprecated `v1/users` endpoint

### Security
- Patched XSS vulnerability in comment rendering
- Updated dependencies to address CVE-2025-1234
```

### Significado de cada seccion

| Seccion | Significado | Accion necesaria |
|---------|-------------|-----------------|
| **Added** | Funcionalidades nuevas | No requiere cambios en tu codigo |
| **Changed** | Cambios en funcionalidades existentes | Revisa si te afecta |
| **Deprecated** | Marcado para futura eliminacion | Planifica migracion |
| **Fixed** | Correccion de bugs | Actualiza para obtener la correccion |
| **Removed** | Funcionalidades eliminadas | Debes actualizar tu codigo |
| **Security** | Correcciones de seguridad | Actualiza inmediatamente |

---

## GitHub Releases

GitHub tiene su propio formato de releases que complementa el changelog.

### Estructura tipica de un GitHub Release

```markdown
# v3.0.0 🎉

## Highlights
This major release brings a complete rewrite of the rendering engine,
resulting in 3x faster page loads.

## Breaking Changes ⚠️
- `render()` now returns a Promise instead of a string
- Minimum Node.js version is now 18
- The `config.legacy` option has been removed

## New Features ✨
- Added server-side rendering support
- New plugin system for custom transformers
- Built-in TypeScript support (no extra config needed)

## Bug Fixes 🐛
- Fixed #234: Memory leak when processing large files
- Fixed #256: Incorrect encoding for non-ASCII characters

## Migration Guide
See MIGRATION.md for step-by-step upgrade instructions.

## Contributors
Thanks to @developer1, @developer2, and @developer3 for their
contributions to this release!
```

### Emojis comunes en releases

| Emoji | Significado |
|-------|-------------|
| ⚠️ | Breaking changes / Advertencia |
| ✨ | Nueva funcionalidad |
| 🐛 | Correccion de bug |
| 🔒 | Correccion de seguridad |
| 📝 | Documentacion |
| 🚀 | Mejora de rendimiento |
| ♻️ | Refactorizacion |
| 🗑️ | Funcionalidad eliminada |
| 📦 | Dependencias actualizadas |

---

## Como evaluar el impacto de una actualizacion

### Paso 1: Identifica el tipo de version

```bash
# Version actual en tu proyecto
"express": "^4.18.2"

# Nueva version disponible
"express": "5.0.0"
```

Cambio de MAJOR (4 → 5): **hay breaking changes. Lee el changelog completo.**

### Paso 2: Busca breaking changes

Palabras clave que indican breaking changes:

| Frase | Significado |
|-------|-------------|
| **"Breaking:"** | Cambio que rompe compatibilidad |
| **"BREAKING CHANGE:"** | Lo mismo, formato de Conventional Commits |
| **"This is a breaking change"** | Explicacion directa |
| **"No longer supports..."** | Ya no soporta algo |
| **"Has been removed"** | Fue eliminado |
| **"Now requires..."** | Ahora requiere algo nuevo |
| **"Default changed from X to Y"** | El valor por defecto cambio |
| **"Renamed from X to Y"** | Fue renombrado |
| **"Replaced X with Y"** | X fue reemplazado por Y |
| **"Minimum version is now..."** | La version minima cambio |

### Paso 3: Evalua el riesgo

| Pregunta | Si la respuesta es SI |
|----------|----------------------|
| Hay breaking changes? | Lee la guia de migracion |
| Usas funcionalidades deprecated? | Planifica la migracion |
| Hay security fixes? | Actualiza lo antes posible |
| Solo hay bug fixes? | Actualiza con confianza |
| Es una version pre-release? | No uses en produccion |

### Paso 4: Lee la guia de migracion

```markdown
## Migration from v2 to v3

### Step 1: Update the package
npm install mypackage@3

### Step 2: Update imports
// Before (v2)
import { oldFunction } from 'mypackage';

// After (v3)
import { newFunction } from 'mypackage';

### Step 3: Update configuration
// Before (v2)
{ legacy: true, mode: 'compat' }

// After (v3)
{ mode: 'standard' }

### Step 4: Run the codemod (optional)
npx mypackage-codemod@latest
```

---

## Conventional Commits

Muchos proyectos usan Conventional Commits para sus mensajes de commit, lo que facilita generar changelogs automaticamente.

```
feat: add dark mode support
fix: resolve memory leak in auth module
docs: update API reference for v3
style: format code with prettier
refactor: simplify database connection logic
perf: optimize image loading pipeline
test: add unit tests for payment service
chore: update CI/CD pipeline configuration
build: upgrade webpack to v5

BREAKING CHANGE: the `authenticate()` method now requires a token
```

| Prefijo | Significado | Efecto en version |
|---------|-------------|-------------------|
| **feat** | Nueva funcionalidad | MINOR bump |
| **fix** | Correccion de bug | PATCH bump |
| **docs** | Solo documentacion | No bump |
| **style** | Formato, no afecta logica | No bump |
| **refactor** | Refactorizacion | No bump |
| **perf** | Mejora de rendimiento | PATCH bump |
| **test** | Tests | No bump |
| **chore** | Mantenimiento | No bump |
| **BREAKING CHANGE** | Cambio que rompe compatibilidad | MAJOR bump |

---

## Frases comunes en changelogs

| Frase en ingles | Significado |
|-----------------|-------------|
| **"Closes #123"** | Resuelve el issue numero 123 |
| **"This supersedes..."** | Esto reemplaza/supera a... |
| **"Backported from..."** | Portado desde una version mas nueva |
| **"Cherry-picked from..."** | Seleccionado de otra rama |
| **"Reverted due to..."** | Revertido debido a... |
| **"Hot fix for..."** | Correccion urgente para... |
| **"Pinned dependency..."** | Fijada la version de la dependencia |
| **"Bumped X to Y"** | Actualizado X a la version Y |
| **"Shipped in..."** | Incluido en la version... |
| **"Rolled back..."** | Revertido... |

---

## Resumen

- El versionado semantico (MAJOR.MINOR.PATCH) te dice el tipo de cambio de un vistazo
- Los changelogs organizan los cambios en: Added, Changed, Deprecated, Fixed, Removed, Security
- Siempre busca "Breaking Changes" antes de actualizar una version MAJOR
- Las correcciones de seguridad (Security) deben aplicarse lo antes posible
- Conventional Commits facilitan entender el historial de cambios de un proyecto
- Evalua el riesgo de cada actualizacion antes de aplicarla en produccion
