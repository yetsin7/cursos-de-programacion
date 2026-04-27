# Capítulo 10 — .gitignore

Cuando trabajas en un proyecto, no todos los archivos deben subirse al repositorio. Archivos de configuración local, dependencias, binarios compilados y secretos deben quedarse fuera. Para eso existe `.gitignore`.

---

## ¿Qué es .gitignore?

`.gitignore` es un archivo de texto que le dice a Git **qué archivos o carpetas debe ignorar**. Los archivos ignorados no aparecen en `git status`, no se agregan con `git add .` y nunca se suben al repositorio.

---

## ¿Por qué ignorar archivos?

Hay archivos que **nunca** deben estar en un repositorio:

- **Dependencias** (`node_modules/`, `.dart_tool/`, `__pycache__/`) — Se reinstalan con un comando
- **Archivos compilados** (`build/`, `dist/`, `*.class`) — Se regeneran al compilar
- **Secretos** (`.env`, `credentials.json`, keystores) — Contienen contraseñas y API keys
- **Archivos del sistema** (`.DS_Store`, `Thumbs.db`) — Basura del sistema operativo
- **Archivos del IDE** (`.idea/`, `.vscode/settings.json`) — Configuración personal

Subir estos archivos causa problemas:
1. El repositorio se vuelve enorme innecesariamente
2. Expones contraseñas y secretos al público
3. Generas conflictos de merge entre diferentes máquinas
4. Dificultas que otros colaboradores trabajen

---

## Patrones comúnes de .gitignore

| Patrón | Qué ignora |
|--------|-----------|
| `*.log` | Todos los archivos `.log` |
| `build/` | La carpeta `build` y todo su contenido |
| `!important.log` | Excepción: NO ignorar `important.log` |
| `**/temp` | Carpetas `temp` en cualquier nivel |
| `doc/*.pdf` | Archivos `.pdf` solo dentro de `doc/` |

---

## Cómo ejecutar los archivos de este capítulo

```bash
cd "Libro de GitHub/10-gitignore"
bash 01_que_es_gitignore.sh
```

---

## Qué aprenderás en este capítulo

| Archivo | Tema |
|---------|------|
| `01_que_es_gitignore.sh` | Concepto y propósito del .gitignore |
| `02_sintaxis_gitignore.sh` | Patrones: *, **, /, !, comentarios |
| `03_plantillas_comunes.sh` | Plantillas para Node, Python, Flutter, Java y más |
| `04_gitignore_global.sh` | Configuración de gitignore global |
| `05_dejar_de_rastrear.sh` | git rm --cached, dejar de rastrear archivos ya trackeados |
| `06_ejercicios.sh` | Ejercicios prácticos |

---

¡Comienza por `01_que_es_gitignore.sh` y sigue en orden!
