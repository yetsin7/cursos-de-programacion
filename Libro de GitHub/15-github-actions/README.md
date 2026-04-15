# Capítulo 15 — GitHub Actions

## CI/CD y automatización con GitHub Actions

GitHub Actions es el sistema de automatización integrado en GitHub. Te permite
ejecutar tareas automáticamente cuando ocurren eventos en tu repositorio:
al hacer push, crear un Pull Request, publicar un release, o en un horario.

### ¿Qué es CI/CD?

```
CI (Integración Continua)          CD (Despliegue Continuo)
─────────────────────────          ─────────────────────────
Push código                        Código aprobado
    ↓                                  ↓
Tests automáticos                  Build automático
    ↓                                  ↓
Linting / Análisis                 Deploy a producción
    ↓                                  ↓
Resultado: ✅ o ❌                 App actualizada
```

- **CI**: cada vez que subes código, se ejecutan tests y verificaciones automáticas
- **CD**: si todo pasa, el código se despliega automáticamente a producción

### Conceptos clave de GitHub Actions

| Concepto | Descripción |
|----------|-------------|
| **Workflow** | Un proceso automatizado definido en un archivo YAML |
| **Event** | El disparador que inicia el workflow (push, PR, schedule) |
| **Job** | Un conjunto de pasos que se ejecutan en la misma máquina |
| **Step** | Una tarea individual dentro de un job |
| **Action** | Un paso reutilizable creado por la comunidad o por ti |
| **Runner** | La máquina virtual que ejecuta los jobs |

### Estructura de un workflow

```yaml
name: Mi Workflow          # Nombre descriptivo
on: push                   # Evento que lo dispara
jobs:                      # Los trabajos a ejecutar
  build:                   # Nombre del job
    runs-on: ubuntu-latest # Sistema operativo
    steps:                 # Pasos del job
      - uses: actions/checkout@v4  # Acción de la comunidad
      - run: npm install           # Comando de terminal
      - run: npm test              # Otro comando
```

---

## Archivos de este capítulo

| Archivo | Tema |
|---------|------|
| `01_que_son_actions.sh` | Concepto de CI/CD y GitHub Actions |
| `02_primer_workflow.sh` | Crear tu primer workflow YAML |
| `03_triggers.sh` | Eventos: push, pull_request, schedule, dispatch |
| `04_jobs_y_steps.sh` | Jobs, steps, runs-on, uses, run |
| `05_variables_y_secretos.sh` | Variables de entorno y secretos |
| `06_matrices_y_cache.sh` | Estrategia de matrices y caché |
| `07_actions_marketplace.sh` | Usar acciones de la comunidad |
| `08_workflow_flutter.sh` | Ejemplo: CI para un proyecto Flutter |
| `09_workflow_node.sh` | Ejemplo: CI para un proyecto Node.js |
| `10_ejercicios.sh` | Ejercicios de práctica |

---

## Cómo usar estos archivos

```bash
# Los archivos .sh contienen YAML de ejemplo dentro de comentarios y
# comandos de configuración. Léelos y copia los YAML a tu proyecto.
bash 15-github-actions/01_que_son_actions.sh
```
