# Capítulo 09 — Markdown

Markdown es el lenguaje de formato que GitHub usa en **todo**: READMEs, Issues, Pull Requests, comentarios, wikis y más. Si quieres comunicarte bien en GitHub, necesitas dominar Markdown.

---

## ¿Qué es Markdown?

**Markdown** es un lenguaje de marcado ligero creado por John Gruber en 2004. Su objetivo es permitir escribir texto con formato usando una sintaxis simple y legible incluso sin renderizar.

GitHub usa una variante llamada **GitHub Flavored Markdown (GFM)** que extiende Markdown estándar con:

- Tablas
- Listas de tareas (checkboxes)
- Bloques de código con resaltado de sintaxis
- Autoenlaces a Issues, PRs y commits
- Alertas y secciones colapsables
- Diagramas Mermaid
- Expresiones matemáticas LaTeX

---

## ¿Por qué importa Markdown en GitHub?

Markdown es la forma principal de comunicación escrita en GitHub:

- **README.md** — La primera impresión de tu proyecto
- **Issues y PRs** — Reportar bugs, proponer cambios, revisar código
- **Wikis** — Documentación extensa del proyecto
- **Discusiones** — Conversaciones en la comunidad
- **Perfil README** — Tu carta de presentación como desarrollador

Un desarrollador que escribe buen Markdown se comunica mejor, documenta mejor y colabora mejor.

---

## ¿Cómo renderiza GitHub el Markdown?

Cuando subes un archivo `.md` a GitHub, automáticamente lo convierte en HTML formateado. El archivo `README.md` en la raíz de un repositorio se muestra directamente en la página principal del repo.

GitHub también renderiza Markdown en:
- Comentarios de Issues y Pull Requests
- Descripciones de releases
- Archivos `.md` en cualquier carpeta del repositorio
- Wikis del proyecto

---

## Cómo ejecutar los archivos de este capítulo

Los archivos `.sh` de este capítulo son principalmente **educativos** — contienen la sintaxis de Markdown dentro de comentarios y ejemplos con `echo` y `cat`. No necesitas ejecutarlos para aprender, pero puedes hacerlo para ver los ejemplos:

```bash
cd "Libro de GitHub/09-markdown"
bash 01_sintaxis_basica.sh
```

---

## Qué aprenderás en este capítulo

| Archivo | Tema |
|---------|------|
| `01_sintaxis_basica.sh` | Encabezados, negrita, cursiva, enlaces, imágenes |
| `02_listas_y_tablas.sh` | Listas ordenadas, no ordenadas, de tareas y tablas |
| `03_codigo_y_bloques.sh` | Código en línea, bloques de código con sintaxis resaltada |
| `04_elementos_avanzados.sh` | Secciones colapsables, alertas, notas al pie, matemáticas, diagramas |
| `05_escribir_buen_readme.sh` | Mejores prácticas para README, secciones esenciales, badges |
| `06_perfil_readme.sh` | Crear un README de perfil (repo especial username/username) |
| `07_ejercicios.sh` | Ejercicios prácticos para dominar Markdown |

---

¡Comienza por `01_sintaxis_basica.sh` y sigue en orden!
