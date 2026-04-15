# Capítulo 01 — Introducción a Git

Bienvenido al primer capítulo. Aquí entenderás qué es Git, qué es GitHub,
por qué existen y por qué son herramientas fundamentales para cualquier programador.
Sin estos conceptos, nada de lo que viene después tiene sentido. Tómate tu tiempo.

---

## ¿Qué es el control de versiones?

Imagina que estás escribiendo un documento importante. Cada vez que haces un cambio
grande, guardas una copia con un nombre diferente:

```
documento_v1.txt
documento_v2.txt
documento_v3_final.txt
documento_v3_final_DEFINITIVO.txt
```

Eso es control de versiones... pero manual y caótico. Un **sistema de control de
versiones** automatiza este proceso: guarda cada cambio que haces, quién lo hizo,
cuándo lo hizo y por qué. Y te permite volver a cualquier versión anterior.

---

## ¿Qué es Git?

Git es un **sistema de control de versiones distribuido**. Fue creado en 2005 por
**Linus Torvalds** (el mismo creador de Linux) porque necesitaba una herramienta
rápida y confiable para manejar el código fuente de Linux.

Git te permite:
- Guardar un historial completo de todos los cambios en tu proyecto
- Volver a cualquier punto anterior en el tiempo
- Trabajar en nuevas funciones sin afectar el código principal
- Colaborar con otras personas sin pisarse el trabajo mutuamente

Git funciona **en tu computadora local**. No necesitas internet para usarlo.

---

## ¿Qué es GitHub?

GitHub es una **plataforma web** que aloja repositorios de Git en la nube.
Piensa en Git como el motor y en GitHub como el garaje donde estacionas tu auto
para que otros lo vean y colaboren.

GitHub agrega funcionalidades que Git solo no tiene:
- Interfaz web para ver tu código
- Pull Requests para revisar cambios antes de aceptarlos
- Issues para reportar bugs y organizar tareas
- GitHub Actions para automatización
- GitHub Pages para publicar sitios web gratis

---

## Git vs GitHub — ¿Cuál es la diferencia?

| Git | GitHub |
|---|---|
| Software que instalas en tu computadora | Plataforma web (sitio en internet) |
| Funciona sin internet | Requiere internet |
| Controla versiones de archivos | Aloja repositorios Git en la nube |
| Herramienta de línea de comandos | Interfaz gráfica + herramientas extras |
| Creado por Linus Torvalds (2005) | Creado por Tom Preston-Werner (2008) |
| Es gratuito y open source | Tiene plan gratuito y planes de pago |

**Resumen:** Git es la herramienta. GitHub es el servicio que usa Git por debajo.
Puedes usar Git sin GitHub, pero no puedes usar GitHub sin Git.

---

## Breve historia

- **2005** — Linus Torvalds crea Git para el desarrollo del kernel de Linux
- **2008** — Se funda GitHub, facilitando la colaboración con Git
- **2018** — Microsoft adquiere GitHub por $7.5 mil millones
- **Hoy** — GitHub tiene más de 100 millones de desarrolladores y es la plataforma
  de código más grande del mundo

---

## Archivos de este capítulo

Ábrelos en este orden:

| Archivo | Qué aprenderás |
|---|---|
| `01_que_es_git.sh` | Verificar que Git existe y ver conceptos básicos en acción |
| `02_terminologia_basica.sh` | Los términos clave que usarás todos los días |
| `03_como_funciona_git.sh` | Las 3 áreas de Git: working directory, staging area, repository |

---

## Conceptos clave de este capítulo

- **Control de versiones** — sistema para rastrear cambios en archivos a lo largo del tiempo
- **Git** — software de control de versiones distribuido que funciona en tu computadora
- **GitHub** — plataforma web para alojar repositorios Git y colaborar con otros
- **Repositorio** — carpeta de proyecto gestionada por Git
- **Commit** — una "foto" del estado de tu proyecto en un momento dado

---

> ✅ Cuando termines todos los archivos de esta carpeta, pasa a `02-instalacion-y-configuracion/`
