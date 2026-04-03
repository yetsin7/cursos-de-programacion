# Cómo Hacer Buenas Preguntas en Foros Técnicos

## Introducción

La calidad de tus preguntas determina la calidad de las respuestas que
recibirás. En Stack Overflow, GitHub Issues y foros técnicos, una pregunta
bien formulada en inglés se responde rápidamente. Una pregunta vaga se
ignora, se cierra o recibe downvotes.

---

## Anatomía de una buena pregunta

| Parte | Propósito | Ejemplo |
|-------|-----------|---------|
| **Title** | Resumen específico y buscable | "React useEffect runs twice on mount in development" |
| **Context** | Qué estás haciendo y con qué tecnología | "I'm building a Next.js 14 app with TypeScript..." |
| **What you tried** | Intentos previos para resolver el problema | "I've already tried adding a cleanup function..." |
| **Expected vs Actual** | Qué esperabas y qué sucedió | "I expected one API call, but the console shows two" |
| **Code** | Ejemplo mínimo reproducible | Bloque de código relevante |
| **Error message** | Mensaje de error exacto | Stack trace completo |
| **Environment** | Versiones y sistema operativo | "Node 18.17, React 18.2, macOS 14" |

---

## Escribiendo el título

El título es lo más importante. Debe ser **específico y buscable**.

### Buenos títulos

| Título | Por qué es bueno |
|--------|-----------------|
| "TypeError: Cannot read property 'map' of undefined in React component" | Incluye el error exacto y contexto |
| "How to handle 401 responses globally in Axios interceptors" | Específico sobre qué y dónde |
| "PostgreSQL query with JOIN returns duplicate rows" | Describe el problema concreto |
| "Flutter Navigator.push not working inside onPressed callback" | Tecnología + función + contexto |

### Malos títulos

| Título | Problema |
|--------|----------|
| "Help me please" | No dice nada del problema |
| "Error in my code" | Demasiado vago |
| "React not working" | No es específico |
| "URGENT!!!" | No describe el problema |
| "Noob question" | Innecesario y no buscable |

---

## Escribiendo el cuerpo de la pregunta

### Paso 1: Contexto

```markdown
I'm building a REST API with Express.js and TypeScript.
I'm using Prisma as the ORM with a PostgreSQL database.
```

Frases útiles:

| Frase | Uso |
|-------|-----|
| I'm building... | Describir el proyecto |
| I'm trying to... | Describir lo que intentas hacer |
| I'm working on... | Describir en qué trabajas |
| I'm using... | Describir las tecnologías |
| I have a... that needs to... | Describir el componente y su propósito |

### Paso 2: El problema

```markdown
When I send a POST request to /api/users, I get a 500
Internal Server Error. The error occurs only when the
email field contains special characters (like +).
```

Frases útiles:

| Frase | Uso |
|-------|-----|
| I'm getting... | Describir el error |
| I get the following error: | Introducir mensaje de error |
| The error occurs when... | Describir cuándo sucede |
| The app crashes when... | Describir el crash |
| This happens every time I... | Describir reproducibilidad |
| This only happens when... | Describir condición específica |
| It works fine for X but fails for Y | Comparar casos |

### Paso 3: Lo que intentaste

```markdown
I've already tried:
- URL-encoding the email before sending
- Adding `express.urlencoded({ extended: true })` middleware
- Wrapping the handler in a try-catch block

None of these solved the issue.
```

Frases útiles:

| Frase | Uso |
|-------|-----|
| I've already tried... | Listar intentos previos |
| I've looked at... but... | Mencionar recursos consultados |
| I followed the docs but... | Indicar que seguiste documentación |
| I found a similar question on SO, but... | Referencia a pregunta similar |
| The solution in [link] didn't work because... | Explicar por qué no funcionó |

### Paso 4: Resultado esperado vs actual

```markdown
**Expected behavior:**
The API should accept emails with special characters
and return a 201 Created response.

**Actual behavior:**
The server returns a 500 error with the message:
"PrismaClientKnownRequestError: Unique constraint failed"
```

### Paso 5: Código mínimo reproducible

```markdown
Here's the relevant code:

```typescript
app.post('/api/users', async (req, res) => {
  const { email, name } = req.body;
  const user = await prisma.user.create({
    data: { email, name }
  });
  res.status(201).json(user);
});
```

### Paso 6: Entorno

```markdown
**Environment:**
- Node.js 18.17.0
- Express 4.18.2
- Prisma 5.7.0
- PostgreSQL 15
- OS: Ubuntu 22.04
```

---

## Ejemplo completo de una buena pregunta

```markdown
# Prisma create() fails with unique constraint error for emails with "+"

I'm building a REST API with Express.js and Prisma (PostgreSQL).
When a user tries to register with an email containing a `+`
character (like `user+test@gmail.com`), the create operation
fails with a unique constraint error, even though no user with
that email exists in the database.

## What I've tried

- Verified the email doesn't exist: `SELECT * FROM users WHERE
  email = 'user+test@gmail.com'` returns 0 rows
- Added `@unique` to the email field in the Prisma schema
- Tried URL-encoding the email
- Cleared the database and ran fresh migrations

## Code

```typescript
// schema.prisma
model User {
  id    Int    @id @default(autoincrement())
  email String @unique
  name  String
}

// route handler
app.post('/api/users', async (req, res) => {
  const user = await prisma.user.create({
    data: { email: req.body.email, name: req.body.name }
  });
  res.status(201).json(user);
});
```

## Error

```
PrismaClientKnownRequestError:
Unique constraint failed on the fields: (`email`)
```

## Expected behavior

The user should be created successfully with the
email `user+test@gmail.com`.

## Environment

- Node.js 18.17, Prisma 5.7.0, PostgreSQL 15, Ubuntu 22.04
```

---

## Preguntas en GitHub Issues

Los GitHub Issues tienen un enfoque ligeramente diferente: reportar bugs
o solicitar features en un proyecto específico.

### Bug report

```markdown
## Bug: Login fails silently on Safari 17

### Description
The login button does nothing when clicked on Safari 17.
No error in the console. Works fine on Chrome and Firefox.

### Steps to reproduce
1. Open the app in Safari 17 on macOS Sonoma
2. Enter valid credentials
3. Click "Log In"
4. Nothing happens — no redirect, no error message

### Expected behavior
User should be redirected to the dashboard after login.

### Screenshots
[Screenshot of the console with no errors]

### Environment
- Browser: Safari 17.1
- OS: macOS 14.1 (Sonoma)
- App version: 2.3.1
```

### Feature request

```markdown
## Feature Request: Dark mode support

### Problem
The current light-only UI causes eye strain during
nighttime usage. Several users have requested this
in the feedback form.

### Proposed solution
Add a dark mode toggle in the settings page that
switches the color scheme. Respect the system
preference by default (`prefers-color-scheme`).

### Alternatives considered
- Browser extension for dark mode (inconsistent results)
- CSS-only solution (limited customization)
```

---

## Errores comunes al preguntar

| Error | Problema | Solución |
|-------|----------|----------|
| "It doesn't work" | No dice qué falla ni cómo | Describe el error exacto |
| Pegar todo el código | Demasiado para leer | Ejemplo mínimo reproducible |
| No incluir versiones | Puede ser un bug de versión | Siempre incluir entorno |
| No mostrar lo que intentaste | Parece que no investigaste | Lista tus intentos |
| Preguntar múltiples cosas | Confuso, difícil de responder | Una pregunta por post |
| Usar imágenes de código | No se puede copiar ni buscar | Usar bloques de código |

> **Regla de oro:** Antes de preguntar, intenta resolver el problema tú mismo.
> Luego, escribe la pregunta como si la leyera alguien sin contexto de tu proyecto.
