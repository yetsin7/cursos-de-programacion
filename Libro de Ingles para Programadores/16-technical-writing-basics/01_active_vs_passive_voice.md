# Voz Activa vs Voz Pasiva en Documentación Técnica

## Introducción

En la escritura técnica en inglés, la **voz activa** es preferida porque es más directa,
clara y fácil de entender. Sin embargo, la **voz pasiva** tiene su lugar en ciertos contextos.
Dominar ambas te permitirá escribir documentación profesional.

---

## ¿Qué es la voz activa?

En voz activa, el **sujeto realiza la acción**. La estructura es:

```
Sujeto + Verbo + Objeto
```

### Ejemplos en contexto de programación

| Voz Activa (Preferida) | Traducción |
|------------------------|------------|
| The function returns a value | La función retorna un valor |
| The server sends a response | El servidor envía una respuesta |
| The user clicks the button | El usuario hace clic en el botón |
| The middleware validates the token | El middleware valida el token |
| The compiler throws an error | El compilador lanza un error |
| The test suite covers all edge cases | La suite de tests cubre todos los casos límite |

---

## ¿Qué es la voz pasiva?

En voz pasiva, el **sujeto recibe la acción**. La estructura es:

```
Sujeto + to be + Participio pasado (+ by + agente)
```

### Ejemplos en contexto de programación

| Voz Pasiva | Traducción |
|-----------|------------|
| A value is returned by the function | Un valor es retornado por la función |
| A response is sent by the server | Una respuesta es enviada por el servidor |
| The button is clicked by the user | El botón es clicado por el usuario |
| The token is validated by the middleware | El token es validado por el middleware |
| An error is thrown by the compiler | Un error es lanzado por el compilador |

---

## ¿Por qué se prefiere la voz activa?

| Razón | Ejemplo Pasivo (Evitar) | Ejemplo Activo (Preferir) |
|-------|------------------------|--------------------------|
| Más corta | The file is read by the parser | The parser reads the file |
| Más clara | The request is handled | The controller handles the request |
| Más directa | The data should be validated | Validate the data |
| Menos ambigua | Errors are logged | The logger records all errors |

### En instrucciones y guías

La voz activa funciona especialmente bien en instrucciones:

```markdown
# Malo (pasivo)
The package should be installed by running npm install.
The configuration file should be created in the root directory.

# Bueno (activo)
Install the package by running npm install.
Create the configuration file in the root directory.
```

---

## ¿Cuándo SÍ usar voz pasiva?

La voz pasiva es apropiada cuando:

### 1. El agente es desconocido o irrelevante

```markdown
The data is stored in the database.
(No importa quién lo almacena, importa dónde está)

The password is hashed before storage.
(No importa qué componente lo hashea)

The log file is rotated every 24 hours.
(El proceso automático no es relevante)
```

### 2. El foco está en el objeto, no en el agente

```markdown
The configuration can be overridden by environment variables.
(El foco es la configuración, no las variables)

Deprecated methods will be removed in version 3.0.
(El foco son los métodos, no el equipo que los elimina)
```

### 3. En descripciones de procesos automáticos

```markdown
When a request is received, it is validated against the schema.
The session is created automatically after login.
Failed jobs are retried up to three times.
```

### 4. Para mantener un tono impersonal

```markdown
This feature was introduced in v2.1.
The bug was reported on GitHub issue #342.
```

---

## Tabla de conversión: Pasiva → Activa

| Voz Pasiva | Voz Activa |
|-----------|------------|
| The array is sorted by the function | The function sorts the array |
| The event is triggered by the listener | The listener triggers the event |
| The error is caught by the try block | The try block catches the error |
| The module is imported at the top | Import the module at the top |
| The variable should be declared first | Declare the variable first |
| The test was written by the QA team | The QA team wrote the test |
| The API is consumed by the frontend | The frontend consumes the API |
| The cache is cleared every hour | The system clears the cache every hour |
| The form data is validated on submit | The app validates form data on submit |
| The branch was merged yesterday | We merged the branch yesterday |

---

## Voz activa en diferentes tipos de documentación

### En README files

```markdown
# Pasivo (evitar)
This library was created to simplify HTTP requests.
Configuration can be done through a .env file.

# Activo (preferir)
This library simplifies HTTP requests.
Configure the app through a .env file.
```

### En docstrings y comentarios de código

```python
# Pasivo (evitar)
# The input is validated and an error is raised if invalid.

# Activo (preferir)
# Validates the input and raises an error if invalid.
```

```javascript
// Pasivo (evitar)
// The user data is fetched from the API and stored in state.

// Activo (preferir)
// Fetches user data from the API and stores it in state.
```

### En mensajes de error

```
# Pasivo (evitar)
The file could not be found by the system.

# Activo (preferir)
The system cannot find the file.
Cannot find the file "config.yaml".
```

---

## Resumen de reglas

| Situación | Usar |
|-----------|------|
| Instrucciones y guías | Activa |
| Descripciones de funciones | Activa |
| Mensajes de error | Activa |
| README y tutoriales | Activa |
| Procesos automáticos (agente irrelevante) | Pasiva |
| Foco en el objeto | Pasiva |
| Descripciones históricas impersonales | Pasiva |

> **Regla general:** Si puedes escribirlo en voz activa sin perder claridad, hazlo.
> Usa voz pasiva solo cuando agrega valor al mensaje.

---

## Práctica rápida

Convierte estas oraciones pasivas a voz activa:

1. "The database is queried by the repository layer."
2. "The configuration file is loaded at startup."
3. "The tests should be run before merging."
4. "The error was caused by a null pointer."
5. "The package is maintained by the open-source community."

### Respuestas

1. "The repository layer queries the database."
2. "The app loads the configuration file at startup."
3. "Run the tests before merging."
4. "A null pointer caused the error."
5. "The open-source community maintains the package."
