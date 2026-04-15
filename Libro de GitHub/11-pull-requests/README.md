# Capítulo 11 — Pull Requests

Los Pull Requests (PRs) son el corazón de la colaboración en GitHub. Son la forma en que propones cambios, los revisas, los discutes y los integras al proyecto. Si quieres trabajar en equipo o contribuir a proyectos open source, dominar los PRs es indispensable.

---

## ¿Qué es un Pull Request?

Un **Pull Request** es una solicitud para fusionar los cambios de una rama en otra. Es como decir: "Hice estos cambios en mi rama, ¿pueden revisarlos e integrarlos a la rama principal?"

Un PR no es solo un merge — es un **espacio de discusión** donde:
- Se revisa el código línea por línea
- Se sugieren mejoras
- Se discuten decisiones técnicas
- Se verifica que todo funcione antes de integrar

---

## ¿Por qué existen los Pull Requests?

Sin PRs, cualquiera podría hacer push directamente a `main` sin revisión. Esto causa:
- Bugs que nadie detectó
- Código de mala calidad
- Conflictos entre el trabajo de diferentes personas
- Pérdida de contexto sobre por qué se hicieron cambios

Con PRs, cada cambio pasa por un proceso de **revisión y aprobación** antes de integrarse.

---

## Cultura de Code Review

Un buen code review:
- **Es constructivo**, no destructivo — El objetivo es mejorar el código, no criticar a la persona
- **Es específico** — "Esta función debería manejar el caso null" es mejor que "Esto está mal"
- **Reconoce lo bueno** — Si algo está bien hecho, dilo
- **Es oportuno** — No dejes PRs esperando días sin revisión

---

## Flujo típico de un Pull Request

1. Crear una rama desde `main`
2. Hacer commits con tus cambios
3. Hacer push de la rama al remoto
4. Crear el Pull Request en GitHub
5. Revisión de código por compañeros
6. Hacer ajustes si hay feedback
7. Aprobación y merge

---

## Cómo ejecutar los archivos de este capítulo

```bash
cd "Libro de GitHub/11-pull-requests"
bash 01_que_es_pull_request.sh
```

---

## Qué aprenderás en este capítulo

| Archivo | Tema |
|---------|------|
| `01_que_es_pull_request.sh` | Concepto y propósito de los Pull Requests |
| `02_crear_pull_request.sh` | Paso a paso para crear un PR |
| `03_revisar_pull_request.sh` | Code review: comentarios, sugerencias, aprobaciones |
| `04_actualizar_pull_request.sh` | Agregar commits a un PR existente, resolver feedback |
| `05_merge_pull_request.sh` | Estrategias de merge: merge commit, squash, rebase |
| `06_plantillas_pr.sh` | Plantillas de PR, PULL_REQUEST_TEMPLATE.md |
| `07_ejercicios.sh` | Ejercicios prácticos |

---

¡Comienza por `01_que_es_pull_request.sh` y sigue en orden!
