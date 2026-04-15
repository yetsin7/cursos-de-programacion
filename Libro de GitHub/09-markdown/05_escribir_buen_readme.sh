#!/bin/bash
# =============================================================================
# ARCHIVO: 05_escribir_buen_readme.sh
# TEMA: Mejores prácticas para escribir un buen README.md
# =============================================================================
#
# El README.md es la PRIMERA cosa que alguien ve al visitar tu repositorio.
# Es tu carta de presentación, tu documentación y tu guía de inicio.
# Un buen README puede ser la diferencia entre que alguien use tu proyecto
# o lo ignore completamente.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# ¿POR QUÉ IMPORTA EL README?
# ─────────────────────────────────────────────────────────────────────────────

# El README.md es:
# - Lo primero que ve cualquier visitante en tu repositorio
# - La documentación mínima de tu proyecto
# - Tu oportunidad de explicar qué hace tu proyecto y por qué importa
# - Un factor decisivo para que otros usen, contribuyan o contraten

# Un repositorio sin README es como una tienda sin letrero.
# Un README malo es como un letrero con errores ortográficos.

echo "========================================="
echo "  ¿POR QUÉ IMPORTA EL README?"
echo "========================================="
echo ""
echo "  - Es la primera impresión de tu proyecto"
echo "  - Define si alguien lo usa o lo ignora"
echo "  - Demuestra profesionalismo y cuidado"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# SECCIONES ESENCIALES DE UN README
# ─────────────────────────────────────────────────────────────────────────────

# Un buen README tiene una estructura clara y predecible.
# Aquí están las secciones que todo buen README debería incluir:

cat << 'MARKDOWN'
# Nombre del Proyecto

Descripción corta y clara de qué hace el proyecto (1-2 oraciones).

![Demo del proyecto](./screenshots/demo.gif)

## Características

- Característica principal 1
- Característica principal 2
- Característica principal 3

## Requisitos previos

- Node.js 18+
- npm o yarn
- Cuenta de API (si aplica)

## Instalación

```bash
git clone https://github.com/usuario/proyecto.git
cd proyecto
npm install
```

## Configuración

```bash
cp .env.example .env
# Edita .env con tus credenciales
```

## Uso

```bash
npm run dev
```

Abre http://localhost:3000 en tu navegador.

## Capturas de pantalla

| Vista móvil | Vista escritorio |
|:-----------:|:----------------:|
| ![Móvil](./screenshots/mobile.png) | ![Desktop](./screenshots/desktop.png) |

## Tecnologías

- [Nuxt 4](https://nuxt.com/) — Framework web
- [Tailwind CSS](https://tailwindcss.com/) — Estilos
- [Supabase](https://supabase.com/) — Backend

## Estructura del proyecto

```
src/
├── components/    # Componentes reutilizables
├── pages/         # Páginas de la aplicación
├── composables/   # Lógica reutilizable
├── services/      # Servicios y API calls
└── types/         # Tipos TypeScript
```

## Contribuir

1. Haz fork del proyecto
2. Crea tu rama (`git checkout -b feature/nueva-funcion`)
3. Haz commit de tus cambios (`git commit -m 'Agregar nueva función'`)
4. Haz push a la rama (`git push origin feature/nueva-funcion`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](./LICENSE) para más detalles.

## Autor

**Tu Nombre** — [@tu-usuario](https://github.com/tu-usuario)
MARKDOWN

# ─────────────────────────────────────────────────────────────────────────────
# BADGES (INSIGNIAS)
# ─────────────────────────────────────────────────────────────────────────────

# Los badges son pequeñas imágenes que muestran información del proyecto
# de un vistazo: estado del build, versión, licencia, cobertura, etc.
# Se colocan al inicio del README, justo después del título.

cat << 'MARKDOWN'
— Badges comunes usando shields.io:

![Build Status](https://img.shields.io/github/actions/workflow/status/usuario/repo/ci.yml)
![License](https://img.shields.io/github/license/usuario/repo)
![Version](https://img.shields.io/github/v/release/usuario/repo)
![Stars](https://img.shields.io/github/stars/usuario/repo)
![Issues](https://img.shields.io/github/issues/usuario/repo)
![Last Commit](https://img.shields.io/github/last-commit/usuario/repo)

— Badge personalizado:
![Custom Badge](https://img.shields.io/badge/hecho_con-Flutter-02569B?logo=flutter)
![Custom Badge](https://img.shields.io/badge/estado-en_desarrollo-yellow)

— Ejemplo real al inicio de un README:
# Mi Proyecto

![Build](https://img.shields.io/github/actions/workflow/status/user/repo/ci.yml?branch=main)
![License](https://img.shields.io/github/license/user/repo)
![Version](https://img.shields.io/npm/v/mi-paquete)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](./CONTRIBUTING.md)

— Sitio web para generar badges:
https://shields.io/
https://badgen.net/
MARKDOWN

# CONSEJO: No pongas demasiados badges — 3 a 5 es ideal.
# Elige los más relevantes: build status, versión, licencia.

echo ""
echo "========================================="
echo "  BADGES (INSIGNIAS)"
echo "========================================="
echo ""
echo "  Sitio principal: https://shields.io/"
echo "  Formato: ![texto](https://img.shields.io/badge/...)"
echo "  Recomendación: 3-5 badges máximo"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ERRORES COMUNES EN READMES
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo "========================================="
echo "  ERRORES COMUNES EN READMES"
echo "========================================="
echo ""
echo "  1. No tener README en absoluto"
echo "  2. README con solo el nombre del proyecto"
echo "  3. No explicar cómo instalar o ejecutar"
echo "  4. Instrucciones desactualizadas que ya no funcionan"
echo "  5. No incluir capturas de pantalla o demo"
echo "  6. Texto en un solo idioma cuando el público es global"
echo "  7. No mencionar requisitos previos"
echo "  8. No incluir licencia"
echo "  9. Demasiada información sin estructura"
echo "  10. README copiado de un template sin personalizar"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CONSEJOS PROFESIONALES
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  CONSEJOS PROFESIONALES"
echo "========================================="
echo ""
echo "  - Incluye un GIF o captura del proyecto funcionando"
echo "  - Las instrucciones de instalación deben funcionar copy-paste"
echo "  - Actualiza el README cada vez que cambies algo importante"
echo "  - Si el proyecto está en desarrollo, dilo claramente"
echo "  - Usa la sección 'Contribuir' si aceptas colaboraciones"
echo "  - Incluye un enlace al demo en vivo si existe"
echo "  - Revisa READMEs de proyectos populares para inspirarte"
echo ""
