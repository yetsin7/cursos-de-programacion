# Lesson 02: Writing a Great GitHub Profile

## Introduccion

Tu perfil de GitHub es tu portafolio como desarrollador. Los reclutadores y otros programadores lo revisan para evaluar tus habilidades reales. Un perfil bien presentado con buenos READMEs y proyectos organizados marca la diferencia.

---

## GitHub Profile README

GitHub permite crear un README especial que aparece en tu perfil. Se crea con un repositorio que tenga tu mismo nombre de usuario.

### Estructura recomendada

```markdown
# Hi there, I'm [Your Name] 👋

## About Me
I'm a mobile developer from [Country] specializing in 
Flutter and cross-platform apps. I'm passionate about 
clean architecture and open source.

- 🔭 I'm currently working on [Project]
- 🌱 I'm currently learning [Technology]
- 💬 Ask me about Flutter, Dart, mobile development
- 📫 How to reach me: your@email.com
- ⚡ Fun fact: [Something interesting about you]

## Tech Stack
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat&logo=typescript)

## GitHub Stats
![Your GitHub stats](https://github-readme-stats.vercel.app/api?username=yourusername)
```

### Secciones opcionales utiles

| Seccion | Que incluir |
|---------|-------------|
| **About Me** | Breve descripcion profesional |
| **Tech Stack** | Badges de tecnologias que usas |
| **Current Projects** | En que estas trabajando ahora |
| **GitHub Stats** | Estadisticas de tu actividad |
| **Recent Blog Posts** | Si tienes un blog tech |
| **How to reach me** | Email, LinkedIn, Twitter |

---

## Pinned Repositories

GitHub te permite fijar hasta 6 repositorios en tu perfil. Estos son los que los reclutadores veran primero.

### Que repositorios fijar

| Prioridad | Tipo de proyecto |
|-----------|-----------------|
| **1** | Tu mejor proyecto personal con buen README |
| **2** | Contribucion a un proyecto open source conocido |
| **3** | Proyecto que demuestre una tecnologia especifica |
| **4** | Herramienta o libreria que creaste |
| **5** | Proyecto de practica con buena documentacion |
| **6** | Algo creativo o experimental |

### Descripciones de repositorios

Las descripciones deben ser concisas y explicar que hace el proyecto:

| Mala descripcion | Buena descripcion |
|-----------------|-------------------|
| "My project" | "A cross-platform task manager built with Flutter and Supabase" |
| "Testing stuff" | "Collection of data structure implementations in Dart" |
| "App" | "Offline-first note-taking app with Markdown support and cloud sync" |
| (vacio) | "CLI tool for generating Flutter clean architecture boilerplate" |

---

## Escribir un buen README para proyectos

Un buen README es la diferencia entre un proyecto que la gente usa y uno que ignora.

### Estructura profesional de un README

```markdown
# Project Name

Brief one-line description of the project.

![Demo](screenshots/demo.gif)

## Features

- ✅ Feature one
- ✅ Feature two  
- ✅ Feature three

## Tech Stack

| Technology | Purpose |
|-----------|---------|
| Flutter | Cross-platform UI |
| Riverpod | State management |
| Hive | Local storage |
| Supabase | Backend & Auth |

## Getting Started

### Prerequisites

- Flutter 3.19+
- Dart 3.3+

### Installation

```bash
git clone https://github.com/username/project.git
cd project
flutter pub get
flutter run
```

## Architecture

This project follows Clean Architecture with the following layers:

```
lib/
├── core/           # Shared utilities, themes, constants
├── data/           # Repositories, data sources, models
├── domain/         # Entities, use cases, repository interfaces
└── presentation/   # Pages, widgets, controllers
```

## Screenshots

| Home | Detail | Settings |
|------|--------|----------|
| ![Home](screenshots/home.png) | ![Detail](screenshots/detail.png) | ![Settings](screenshots/settings.png) |

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md).

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE).
```

### Badges utiles

```markdown
![Build Status](https://img.shields.io/github/actions/workflow/status/user/repo/ci.yml)
![License](https://img.shields.io/github/license/user/repo)
![Flutter](https://img.shields.io/badge/Flutter-3.19-blue)
![Stars](https://img.shields.io/github/stars/user/repo)
![Issues](https://img.shields.io/github/issues/user/repo)
```

| Badge | Proposito |
|-------|-----------|
| **Build Status** | Muestra que el CI pasa |
| **License** | Tipo de licencia |
| **Version** | Version del framework o lenguaje |
| **Stars** | Popularidad del proyecto |
| **Issues** | Issues abiertos |
| **Coverage** | Porcentaje de test coverage |

---

## Contribution Graph

El grafico de contribuciones muestra tu actividad diaria. Los reclutadores si lo miran.

### Como mantenerlo activo

| Actividad | Genera contribuciones? |
|-----------|----------------------|
| Commits a tus repos | Si |
| Pull requests a otros repos | Si |
| Issues creados | Si |
| Code reviews | Si |
| Commits a repos privados | Si (con config) |
| Stars a otros repos | No |
| Forks | No |

### Consejos

- La **consistencia** importa mas que la cantidad
- Unos pocos commits diarios es mejor que 50 commits un dia y nada la semana siguiente
- No hagas commits vacios solo para llenar el grafico: los reclutadores serios lo notan

---

## Vocabulario de GitHub

| Termino | Significado |
|---------|-------------|
| **Repository (repo)** | Proyecto/repositorio |
| **Star** | Marcar como favorito |
| **Fork** | Copiar un repositorio |
| **Clone** | Descargar una copia local |
| **Branch** | Rama de desarrollo |
| **Commit** | Guardar cambios en el historial |
| **Pull Request (PR)** | Solicitud para fusionar cambios |
| **Issue** | Reporte de problema o solicitud |
| **Release** | Version publicada |
| **Tag** | Etiqueta para marcar una version |
| **Actions** | CI/CD de GitHub |
| **Gist** | Fragmento de codigo compartido |
| **Wiki** | Documentacion del proyecto |
| **Pages** | Sitio web estatico gratuito |
| **Sponsor** | Apoyar economicamente un proyecto |

---

## Frases para descripciones de repos

| Tipo de proyecto | Frases utiles |
|-----------------|---------------|
| **App** | "A [adjective] [type] app built with [tech]" |
| **Libreria** | "A lightweight library for [purpose]" |
| **CLI Tool** | "A command-line tool that [action]" |
| **API** | "RESTful API for [purpose] built with [tech]" |
| **Template** | "Boilerplate template for [framework] projects" |
| **Learning** | "Implementation of [concept] in [language]" |

### Ejemplos

```
"A fast, offline-first todo app built with Flutter and Hive"
"Lightweight state management library for Dart applications"
"CLI tool for scaffolding clean architecture Flutter projects"
"RESTful API for managing inventory built with Node.js and PostgreSQL"
"Flutter starter template with authentication, theming, and i18n"
```

---

## Open Source Portfolio

### Como construir un portafolio open source

| Nivel | Accion |
|-------|--------|
| **Principiante** | Corregir typos en documentacion de proyectos grandes |
| **Intermedio** | Resolver issues etiquetados como "good first issue" |
| **Avanzado** | Contribuir features completas a proyectos populares |
| **Experto** | Crear y mantener tus propias librerias open source |

### Donde encontrar proyectos para contribuir

- GitHub Explore: github.com/explore
- Good First Issues: goodfirstissue.dev
- Up For Grabs: up-for-grabs.net
- First Timers Only: firsttimersonly.com

---

## Resumen

- Tu GitHub profile README es tu carta de presentacion tecnica
- Fija los 6 mejores repositorios con descripciones claras
- Cada proyecto necesita un README profesional con: descripcion, tech stack, instalacion, screenshots
- La consistencia en el contribution graph importa mas que la cantidad
- Usa badges para mostrar build status, licencia y tecnologias
- Construye un portafolio open source progresivamente
