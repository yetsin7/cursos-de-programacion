# Lesson 03: Writing a Developer Resume / CV

## Introduccion

El resume (curriculum vitae) en ingles para desarrolladores tiene un formato especifico que difiere mucho del CV tradicional en espanol. Debe ser conciso (1-2 paginas), enfocado en logros medibles y optimizado para sistemas ATS (Applicant Tracking Systems) que filtran candidatos automaticamente.

---

## Estructura del Resume

| Seccion | Obligatoria | Contenido |
|---------|-------------|-----------|
| **Contact Information** | Si | Nombre, email, telefono, LinkedIn, GitHub |
| **Summary / Profile** | Recomendada | 2-3 oraciones sobre ti |
| **Experience** | Si | Historial laboral con logros |
| **Skills** | Si | Tecnologias y herramientas |
| **Education** | Si | Estudios formales |
| **Projects** | Recomendada | Proyectos personales relevantes |
| **Certifications** | Opcional | Certificaciones relevantes |

### Lo que NO debes incluir (a diferencia del CV en espanol)

| No incluir | Por que |
|-----------|---------|
| Foto | Discriminacion, no se usa en tech |
| Edad / Fecha de nacimiento | Discriminacion |
| Estado civil | Irrelevante |
| Nacionalidad | Innecesario |
| Direccion completa | Solo ciudad y pais |
| "References available upon request" | Se asume, no lo escribas |
| Objetivo generico | Usa un Summary especifico |

---

## Contact Information

```
JOHN DOE
Software Engineer

john.doe@email.com | +1 (555) 123-4567
linkedin.com/in/johndoe | github.com/johndoe
San Francisco, CA (Open to Remote)
```

**Nota:** Incluir "Open to Remote" es muy util para posiciones internacionales.

---

## Summary / Profile

### Formula

```
[Role] with [X years] of experience in [specialization]. 
[Key achievement or expertise]. [What you're looking for].
```

### Ejemplos

```
Mobile developer with 4+ years of experience building 
cross-platform apps with Flutter. Shipped 3 apps with 
100K+ combined downloads. Seeking a senior role at a 
product-focused company.
```

```
Full-stack engineer with 6 years of experience in React 
and Node.js. Led a team that reduced page load times by 
60% for an e-commerce platform serving 2M monthly users.
```

---

## Experience Section

### Formula por bullet point

```
[Action verb] + [what you did] + [using what] + [measurable result]
```

### Action verbs esenciales para developers

| Verbo | Pasado | Uso |
|-------|--------|-----|
| **Design** | Designed | Diseno de arquitectura o sistemas |
| **Implement** | Implemented | Codificar una solucion |
| **Optimize** | Optimized | Mejorar rendimiento |
| **Refactor** | Refactored | Reestructurar codigo existente |
| **Migrate** | Migrated | Mover de una tecnologia a otra |
| **Automate** | Automated | Crear procesos automaticos |
| **Mentor** | Mentored | Guiar a otros desarrolladores |
| **Deliver** | Delivered | Entregar un producto o feature |
| **Ship** | Shipped | Publicar, lanzar |
| **Scale** | Scaled | Escalar un sistema |
| **Integrate** | Integrated | Conectar sistemas |
| **Architect** | Architected | Disenar la arquitectura |
| **Debug** | Debugged | Diagnosticar y corregir errores |
| **Deploy** | Deployed | Poner en produccion |
| **Maintain** | Maintained | Mantener un sistema |
| **Reduce** | Reduced | Reducir (tiempo, costo, errores) |

### Ejemplo completo de Experience

```
SENIOR MOBILE DEVELOPER
TechCorp Inc. | Remote | Jan 2022 - Present

- Developed and maintained a Flutter mobile app with 100K+ 
  downloads across iOS and Android
- Architected an offline-first data sync system using Hive 
  and background workers, enabling usage in areas with 
  limited connectivity
- Reduced app crash rate from 2.1% to 0.3% by implementing 
  structured error handling and Sentry monitoring
- Led the migration from Provider to Riverpod, reducing 
  state management boilerplate by 40%
- Mentored 3 junior developers through weekly code reviews 
  and pair programming sessions
- Implemented CI/CD pipeline with GitHub Actions, cutting 
  release time from 2 hours to 15 minutes

MOBILE DEVELOPER
StartupXYZ | On-site | Jun 2020 - Dec 2021

- Built a cross-platform e-commerce app from scratch using 
  Flutter, serving 10K+ monthly active users
- Integrated Stripe payment processing with support for 
  3 currencies and 2 payment methods
- Designed and implemented a responsive UI following Material 
  Design 3 guidelines
- Wrote 200+ unit and widget tests achieving 85% code coverage
```

---

## Skills Section

### Formato recomendado

```
Languages:     Dart, JavaScript, TypeScript, Python, SQL
Frameworks:    Flutter, React, Node.js, Express, Next.js
Databases:     PostgreSQL, MongoDB, Firebase, Supabase, Redis
Tools:         Git, Docker, GitHub Actions, Figma, Jira
Cloud:         AWS (S3, Lambda, EC2), Google Cloud, Vercel
Practices:     Clean Architecture, TDD, Agile/Scrum, CI/CD
```

### ATS Tips para la seccion de Skills

- Usa los **nombres exactos** de las tecnologias (no abreviaturas inventadas)
- Incluye las palabras clave de la oferta de trabajo
- No uses graficos, barras de progreso ni porcentajes para skills
- Lista las tecnologias mas relevantes primero

---

## Education Section

```
BACHELOR'S DEGREE IN COMPUTER SCIENCE
University of Central America | 2016 - 2020
- Relevant coursework: Data Structures, Algorithms, 
  Software Engineering, Database Systems
- GPA: 3.8/4.0 (include only if > 3.5)
```

### Equivalencias de titulos

| Titulo en espanol | Equivalente en ingles |
|-------------------|----------------------|
| Licenciatura / Ingenieria | Bachelor's Degree |
| Maestria | Master's Degree |
| Doctorado | Ph.D. / Doctorate |
| Tecnico | Associate Degree / Technical Diploma |
| Diplomado | Certificate / Diploma |
| Bachillerato (secundaria) | High School Diploma |

---

## Projects Section

```
OFFLINE NOTES APP | Flutter, Hive, Clean Architecture
github.com/username/offline-notes
- Built a fully offline note-taking app with Markdown 
  support and automatic cloud sync
- Implemented Clean Architecture with Riverpod for 
  state management
- 500+ downloads on Google Play Store

TASK MANAGEMENT CLI | Node.js, TypeScript
github.com/username/task-cli
- Created a command-line task manager with priority levels, 
  due dates, and recurring tasks
- Published as an npm package with 200+ weekly downloads
```

---

## ATS Optimization (Applicant Tracking Systems)

Los ATS son sistemas que filtran resumes automaticamente. Si tu resume no pasa el ATS, ningun humano lo vera.

### Reglas para pasar el ATS

| Regla | Razon |
|-------|-------|
| Usa formato simple (no columnas complicadas) | El ATS no lee layouts complejos |
| No uses imagenes ni graficos | El ATS no los procesa |
| Usa fuentes estandar (Arial, Calibri) | Compatibilidad |
| Guarda como PDF (no Word) | Formato consistente |
| Incluye keywords de la oferta | El ATS busca coincidencias |
| No uses headers/footers | Algunos ATS los ignoran |
| Usa texto plano para contacto (no iconos) | El ATS necesita leer el texto |

### Keyword matching

Si la oferta dice:

```
"We're looking for experience with React, TypeScript, 
Node.js, PostgreSQL, and AWS."
```

Tu resume debe incluir exactamente: **React, TypeScript, Node.js, PostgreSQL, AWS** (no "ReactJS", no "TS", no "Amazon Web Services" si dicen "AWS").

---

## Cuantificar logros

| Sin metricas (debil) | Con metricas (fuerte) |
|---------------------|----------------------|
| "Improved performance" | "Reduced API response time by 65%" |
| "Led a team" | "Led a team of 5 engineers" |
| "Built an app" | "Built an app with 50K+ downloads" |
| "Wrote tests" | "Achieved 92% test coverage with 300+ tests" |
| "Managed a project" | "Delivered project 2 weeks ahead of schedule" |
| "Handled deployments" | "Automated deployments, reducing release time from 3h to 20min" |

---

## Resumen

- El resume tech en ingles es de 1-2 paginas, sin foto ni datos personales
- Usa action verbs + metricas en cada bullet point de experiencia
- Optimiza para ATS: formato simple, keywords de la oferta, texto plano
- Cuantifica todo: usuarios, porcentajes, tiempos, tamano de equipo
- Adapta el resume para cada aplicacion usando las keywords de la oferta
