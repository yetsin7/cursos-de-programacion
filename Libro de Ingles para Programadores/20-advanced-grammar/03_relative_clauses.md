# Cláusulas Relativas en Contexto de Programación

## Introducción

Las cláusulas relativas nos permiten dar información adicional sobre un
sustantivo. Son esenciales para describir código, componentes, personas
y sistemas con precisión. Usamos pronombres relativos como **who, which,
that, where, when** y **whose**.

---

## Pronombres relativos: Cuándo usar cada uno

| Pronombre | Se usa para | Ejemplo |
|-----------|------------|---------|
| **who** | Personas | The developer **who** wrote this... |
| **which** | Cosas, conceptos | The function **which** handles auth... |
| **that** | Personas o cosas | The file **that** contains the routes... |
| **where** | Lugares (físicos o abstractos) | The module **where** we define routes... |
| **when** | Momentos en el tiempo | The moment **when** the server starts... |
| **whose** | Posesión (de personas o cosas) | The class **whose** constructor takes... |

---

## who — Para personas

Describe personas en el contexto de programación.

| Ejemplo | Traducción |
|---------|------------|
| The developer **who** wrote this module left the company. | El desarrollador que escribió este módulo dejó la empresa. |
| The PM **who** manages our team is on vacation. | El PM que gestiona nuestro equipo está de vacaciones. |
| Developers **who** use TypeScript catch more bugs. | Los desarrolladores que usan TypeScript atrapan más bugs. |
| The intern **who** fixed the bug got promoted. | El interno que arregló el bug fue promovido. |
| Anyone **who** has access can deploy. | Cualquiera que tenga acceso puede desplegar. |

---

## which — Para cosas y conceptos

Describe objetos, tecnologías, conceptos y procesos.

| Ejemplo | Traducción |
|---------|------------|
| The function **which** handles authentication needs refactoring. | La función que maneja autenticación necesita refactorización. |
| React, **which** was created by Facebook, is widely used. | React, que fue creado por Facebook, es ampliamente usado. |
| The bug, **which** was found yesterday, has been fixed. | El bug, que fue encontrado ayer, ha sido corregido. |
| The database **which** stores user data is PostgreSQL. | La base de datos que almacena datos de usuario es PostgreSQL. |
| Node.js, **which** uses V8, runs JavaScript on the server. | Node.js, que usa V8, ejecuta JavaScript en el servidor. |

---

## that — Para personas y cosas (cláusulas definitorias)

**that** es el más versátil y el más común en inglés informal y técnico.

| Ejemplo | Traducción |
|---------|------------|
| The file **that** contains the routes is in `/src/routes`. | El archivo que contiene las rutas está en `/src/routes`. |
| The function **that** handles auth is broken. | La función que maneja auth está rota. |
| The developer **that** reviewed my PR approved it. | El desarrollador que revisó mi PR lo aprobó. |
| The query **that** runs on login takes 3 seconds. | La consulta que se ejecuta al login toma 3 segundos. |
| The package **that** we installed has a vulnerability. | El paquete que instalamos tiene una vulnerabilidad. |

---

## where — Para lugares (físicos y abstractos)

En programación, "lugar" incluye archivos, módulos, servidores y secciones de código.

| Ejemplo | Traducción |
|---------|------------|
| The file **where** we define the routes. | El archivo donde definimos las rutas. |
| The server **where** the database runs. | El servidor donde corre la base de datos. |
| The module **where** authentication is handled. | El módulo donde se maneja la autenticación. |
| The line **where** the error occurs. | La línea donde ocurre el error. |
| The environment **where** we test. | El entorno donde probamos. |
| The repository **where** the code lives. | El repositorio donde vive el código. |

---

## when — Para momentos en el tiempo

| Ejemplo | Traducción |
|---------|------------|
| The moment **when** the server starts up. | El momento cuando el servidor arranca. |
| The sprint **when** we refactored the API. | El sprint cuando refactorizamos la API. |
| The release **when** we introduced dark mode. | El release cuando introdujimos dark mode. |
| The time **when** the database crashed. | El momento cuando la base de datos se cayó. |

---

## whose — Para posesión

Indica a quién pertenece algo. Funciona para personas y cosas.

| Ejemplo | Traducción |
|---------|------------|
| The class **whose** constructor takes three arguments. | La clase cuyo constructor toma tres argumentos. |
| The developer **whose** PR was rejected. | El desarrollador cuyo PR fue rechazado. |
| The module **whose** tests are failing. | El módulo cuyos tests están fallando. |
| The user **whose** account was compromised. | El usuario cuya cuenta fue comprometida. |
| The service **whose** response time exceeds 5 seconds. | El servicio cuyo tiempo de respuesta excede 5 segundos. |

---

## Cláusulas definitorias vs no definitorias

Esta es una distinción importante en inglés.

### Definitorias (Defining / Restrictive)

Identifican de **qué** persona o cosa hablamos. Son esenciales
para el significado. **No llevan comas.** Pueden usar **that**.

```
The function that handles authentication is broken.
(¿Cuál función? La que maneja autenticación.)

Developers who write tests ship fewer bugs.
(¿Cuáles developers? Los que escriben tests.)
```

### No definitorias (Non-defining / Non-restrictive)

Agregan información **extra** que no es esencial. **Siempre llevan comas.**
**No pueden usar "that"**, solo who/which.

```
React, which was created by Facebook, is widely used.
(Ya sabemos cuál es React. La info entre comas es extra.)

John, who joined last month, fixed the critical bug.
(Ya sabemos quién es John. La info es adicional.)
```

### Comparación directa

```
# Definitoria (identifica cuál)
The developers who attended the meeting voted yes.
(Solo los que asistieron votaron.)

# No definitoria (info extra)
The developers, who attended the meeting, voted yes.
(Todos los developers asistieron y votaron.)
```

---

## Omitir el pronombre relativo

En cláusulas definitorias, puedes omitir el pronombre cuando
es **objeto** (no sujeto) de la cláusula:

```
# Con pronombre (correcto)
The package that we installed has a bug.
The developer who I mentioned is leaving.

# Sin pronombre (también correcto, más natural)
The package we installed has a bug.
The developer I mentioned is leaving.
```

**No puedes omitirlo cuando es sujeto:**

```
# Correcto (sujeto — no se puede omitir)
The function that returns null needs a fix.

# Incorrecto
The function returns null needs a fix. ✗
```

---

## Uso en documentación técnica

```markdown
# README Example
This is a middleware **that** validates JWT tokens.

The `UserService` class, **which** handles all user-related
operations, requires a database connection.

The `/config` directory is **where** all configuration
files are stored.

The `Logger` class, **whose** methods are all static,
can be used without instantiation.

Developers **who** contribute to this project should
read the CONTRIBUTING.md file first.
```

---

## Resumen rápido

| Pregunta | Pronombre | Ejemplo |
|----------|-----------|---------|
| ¿Quién? (persona) | who / that | The dev **who** wrote this |
| ¿Cuál? (cosa) | which / that | The API **that** we use |
| ¿Dónde? | where | The file **where** routes live |
| ¿Cuándo? | when | The sprint **when** we shipped |
| ¿De quién? | whose | The class **whose** tests fail |

> **Consejo práctico:** En escritura técnica informal (Slack, PR comments),
> **that** es el más usado para cosas. **which** se reserva más para
> cláusulas no definitorias (con comas). En la duda, usa **that**.
