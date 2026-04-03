# Frases Técnicas Comunes en Documentación

## Introducción

Existen frases estándar que aparecen constantemente en documentación técnica,
README files, changelogs, y guías de programación. Aprenderlas te permitirá
leer y escribir documentación con naturalidad.

---

## Frases para notas y advertencias

| Frase en inglés | Significado en español | Uso |
|-----------------|----------------------|-----|
| Note that... | Ten en cuenta que... | Información importante |
| Keep in mind that... | Ten presente que... | Recordatorio relevante |
| Be aware that... | Ten cuidado con... | Posible problema |
| Important: | Importante: | Información crítica |
| Warning: | Advertencia: | Riesgo potencial |
| Caution: | Precaución: | Acción peligrosa |
| Tip: | Consejo: | Sugerencia útil |

### Ejemplos en contexto

```markdown
> **Note that** this method mutates the original array.

> **Keep in mind that** environment variables are case-sensitive on Linux.

> **Be aware that** this operation cannot be undone.

> **Warning:** Running this command will delete all data in the database.

> **Tip:** Use `--dry-run` to preview changes before applying them.
```

---

## Frases para instrucciones

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| Make sure to... | Asegúrate de... |
| Make sure that... | Asegúrate de que... |
| Make sure you have... | Asegúrate de tener... |
| Before you begin... | Antes de empezar... |
| First, you need to... | Primero, necesitas... |
| Optionally, you can... | Opcionalmente, puedes... |
| If needed, you can... | Si es necesario, puedes... |
| You may also want to... | También podrías querer... |
| To do this, run... | Para hacer esto, ejecuta... |
| For example: | Por ejemplo: |

### Ejemplos en contexto

```markdown
**Make sure to** install Node.js 18+ before proceeding.

**Make sure that** your database is running.

**Before you begin**, create a GitHub account.

**Optionally, you can** configure a custom port in `.env`.

**If needed, you can** override the default timeout:
```bash
export TIMEOUT=5000
```
```

---

## Frases para referencias y versiones

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| For more information, see... | Para más información, consulta... |
| Refer to... | Consulta... / Revisa... |
| See also: | Ver también: |
| As of version X... | A partir de la versión X... |
| Starting from v2.0... | A partir de v2.0... |
| Available since v1.5 | Disponible desde v1.5 |
| Introduced in v3.0 | Introducido en v3.0 |
| Supported in v2+ | Soportado en v2+ |

### Ejemplos en contexto

```markdown
**For more information, see** the [API Reference](/docs/api).

**As of version 3.0**, the `legacy` option has been removed.

**Starting from v2.0**, TypeScript is supported out of the box.

This feature was **introduced in v1.8**. **See also:** Migration Guide.
```

---

## Frases para deprecaciones y cambios

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| This is deprecated in favor of... | Esto está deprecado en favor de... |
| This has been replaced by... | Esto ha sido reemplazado por... |
| This will be removed in... | Esto será eliminado en... |
| Use X instead of Y | Usa X en lugar de Y |
| No longer supported | Ya no es soportado |
| Breaking change: | Cambio incompatible: |
| Migration needed: | Migración necesaria: |

### Ejemplos en contexto

```markdown
> `findAll()` **is deprecated in favor of** `getAll()`.
> It **will be removed in** version 4.0.

> **Breaking change:** The `callback` parameter **has been replaced by**
> a Promise-based API. **Use** `async/await` **instead of** callbacks.

> The `mysql` driver is **no longer supported**. **Migration needed:**
> switch to `mysql2`.
```

---

## Frases para describir comportamiento por defecto

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| By default... | Por defecto... |
| The default value is... | El valor por defecto es... |
| Unless otherwise specified... | A menos que se especifique lo contrario... |
| If not provided... | Si no se proporciona... |
| When omitted... | Cuando se omite... |
| Out of the box... | De serie / Sin configuración... |
| Works out of the box | Funciona sin configuración adicional |

### Ejemplos en contexto

```markdown
**By default**, the server runs on port 3000.

**The default value is** `true`. **If not provided**, the app
uses `localhost`.

**Unless otherwise specified**, all timestamps are in UTC.

The framework includes routing, middleware, and logging
**out of the box**.
```

---

## Frases para describir el funcionamiento interno

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| Under the hood... | Internamente... / Por debajo... |
| Behind the scenes... | Detrás de escena... |
| Internally, it... | Internamente, esto... |
| This works by... | Esto funciona mediante... |
| What happens is... | Lo que sucede es... |

### Ejemplos en contexto

```markdown
**Under the hood**, React uses a virtual DOM to minimize
actual DOM updates.

**Behind the scenes**, the ORM converts your method calls
into SQL queries.

**This works by** comparing the current state with the
previous snapshot and applying only the differences.
```

---

## Frases para condiciones y requisitos

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| Prerequisites: | Requisitos previos: |
| Requirements: | Requisitos: |
| This requires... | Esto requiere... |
| You must have... | Debes tener... |
| This assumes that... | Esto asume que... |
| Provided that... | Siempre y cuando... |
| As long as... | Mientras que... / Siempre que... |

### Ejemplos en contexto

```markdown
**Prerequisites:**
- Node.js 18+
- Docker installed and running

**This assumes that** you have already cloned the repository.

**This requires** a valid API key. **You must have** admin
privileges to access this endpoint.
```

---

## Frases para resultados y consecuencias

| Frase en inglés | Significado en español |
|-----------------|----------------------|
| This will result in... | Esto resultará en... |
| This causes... | Esto causa... |
| This may lead to... | Esto puede llevar a... |
| This ensures that... | Esto asegura que... |
| This prevents... | Esto previene... |
| Otherwise... | De lo contrario... |
| If so... | Si es así... |

### Ejemplos en contexto

```markdown
Not handling this error **may lead to** unexpected crashes.

Adding an index **ensures that** queries run efficiently.

Validate input **to prevent** SQL injection attacks.
**Otherwise**, your database could be compromised.
```

---

## Resumen visual

```
Notas:        Note that... / Keep in mind... / Be aware...
Instrucciones: Make sure to... / Optionally... / Before you begin...
Referencias:  For more information, see... / As of version X...
Deprecación:  Deprecated in favor of... / Replaced by... / No longer supported
Por defecto:  By default... / Out of the box... / Unless otherwise specified...
Interno:      Under the hood... / Behind the scenes...
Requisitos:   Prerequisites... / This requires... / This assumes...
Resultados:   This ensures... / This prevents... / This may lead to...
```

> **Consejo:** Lee documentación de proyectos populares (React, Next.js, Django)
> para ver estas frases en contexto real. Las encontrarás en cada página.
