# Plantillas y Descripciones de Pull Requests

## Introducción

Una buena descripción de Pull Request (PR) ahorra tiempo a los reviewers,
documenta el contexto de los cambios y facilita el mantenimiento futuro.
Aprender a escribir PRs en inglés es esencial para cualquier equipo.

---

## Estructura de una buena PR description

| Sección | Propósito |
|---------|-----------|
| **Title** | Resumen en una línea (qué cambió) |
| **Summary** | Qué se hizo y por qué |
| **Changes** | Lista de cambios específicos |
| **Testing** | Cómo se probaron los cambios |
| **Screenshots** | Capturas si hay cambios visuales |
| **Related issues** | Links a issues o tickets |
| **Notes** | Información adicional para el reviewer |

---

## Escribiendo el título del PR

El título debe ser **corto, específico y descriptivo**.

### Formato común: tipo + descripción

| Prefijo | Uso | Ejemplo |
|---------|-----|---------|
| feat: | Nueva funcionalidad | feat: Add user search endpoint |
| fix: | Corrección de bug | fix: Resolve login timeout issue |
| refactor: | Reestructuración sin cambiar comportamiento | refactor: Extract auth logic into service |
| docs: | Documentación | docs: Update API reference |
| test: | Tests | test: Add unit tests for payment module |
| chore: | Tareas de mantenimiento | chore: Update dependencies |
| style: | Formato, sin cambios lógicos | style: Fix indentation in auth module |
| perf: | Mejora de rendimiento | perf: Optimize database queries |

### Buenos vs malos títulos

| Malo | Bueno |
|------|-------|
| "Fix stuff" | "fix: Handle null response in user API" |
| "Update code" | "refactor: Split OrderService into smaller methods" |
| "Changes" | "feat: Add email verification on signup" |
| "Bug" | "fix: Prevent duplicate entries in cart" |
| "WIP" | "feat: Add pagination to products endpoint (WIP)" |

---

## Escribiendo el Summary

El summary explica **qué** se hizo y **por qué**.

### Frases para describir el tipo de cambio

| Frase | Uso |
|-------|-----|
| This PR adds... | Nueva funcionalidad |
| This PR fixes... | Corrección de bug |
| This PR removes... | Eliminación de código/feature |
| This PR refactors... | Reestructuración |
| This PR updates... | Actualización |
| This PR improves... | Mejora |
| This PR replaces... | Reemplazo |
| This PR introduces... | Introducción de algo nuevo |
| This PR migrates... | Migración |

### Frases para explicar el contexto

| Frase | Uso |
|-------|-----|
| The current behavior is... | Describir comportamiento actual |
| The problem was that... | Explicar el problema |
| This was needed because... | Justificar el cambio |
| Users were experiencing... | Describir impacto en usuarios |
| This is part of... | Indicar un esfuerzo mayor |
| As discussed in #123... | Referencia a discusión previa |

### Ejemplo completo

```markdown
## Summary

This PR adds email verification to the signup flow.

Previously, users could register with any email without
verification, which led to fake accounts and spam.

Now, after registration, the system sends a verification
email with a 6-digit code. Users must enter this code
within 15 minutes to activate their account.
```

---

## Listando los cambios

Usa bullet points específicos. Cada punto debe ser una acción concreta.

```markdown
## Changes

- Add `POST /api/auth/verify-email` endpoint
- Add `verification_codes` table with migration
- Create `EmailVerificationService` with send and verify methods
- Update `UserService.register()` to trigger verification email
- Add rate limiting (3 attempts per code) to prevent brute force
- Update signup page to show verification form after registration
- Add unit tests for verification service
```

---

## Sección de Testing

Explica cómo se verificaron los cambios.

```markdown
## Testing

- [x] Unit tests pass (`npm test`)
- [x] Manual testing: full signup flow with email verification
- [x] Tested expired code scenario (returns 400)
- [x] Tested rate limiting (blocks after 3 failed attempts)
- [x] Tested resend code functionality
- [x] Verified email delivery in development (Mailtrap)
```

---

## Referencias a Issues y tickets

| Frase | Efecto en GitHub |
|-------|-----------------|
| Related to #123 | Link al issue (no lo cierra) |
| Closes #456 | Cierra el issue al hacer merge |
| Fixes #789 | Cierra el issue al hacer merge |
| Resolves #101 | Cierra el issue al hacer merge |
| Part of #200 | Indica que es parte de un issue mayor |
| Blocked by #300 | Indica dependencia |
| See also #400 | Referencia relacionada |

```markdown
## Related Issues

Closes #234 — Users can register with fake emails
Related to #200 — Improve account security (epic)
```

---

## Notas importantes para el reviewer

| Frase | Uso |
|-------|-----|
| Breaking change: | Cambio que rompe compatibilidad |
| Migration needed: | Requiere ejecutar migraciones |
| Environment variable needed: | Requiere nueva variable de entorno |
| Deploy note: | Instrucciones especiales para deploy |
| This is behind a feature flag. | Controlado por feature flag |
| This is a draft / WIP. | No está listo para merge |
| Please review X carefully. | Pide atención especial en algo |
| I'm not sure about X. | Pide opinión sobre algo específico |

```markdown
## Notes for Reviewers

- **Migration needed:** Run `npm run migrate` to create
  the `verification_codes` table.
- **Environment variable needed:** Add `SMTP_HOST`,
  `SMTP_PORT`, `SMTP_USER`, and `SMTP_PASS` to `.env`.
- I'm not sure about the expiration time (15 min).
  Open to suggestions.
- Please review the rate limiting logic carefully.
```

---

## Plantilla completa de PR

```markdown
## Summary

[Qué se hizo y por qué, 2-3 oraciones]

## Changes

- [Cambio 1]
- [Cambio 2]
- [Cambio 3]

## Testing

- [ ] Unit tests pass
- [ ] Manual testing completed
- [ ] Edge cases verified

## Screenshots (if applicable)

[Capturas de pantalla si hay cambios de UI]

## Related Issues

[Closes #XX / Related to #XX]

## Notes for Reviewers

[Información adicional, breaking changes, deploy notes]
```

---

## Changelogs

Muchos proyectos mantienen un archivo CHANGELOG.md. Las entradas
siguen un formato estándar.

```markdown
## [1.3.0] - 2024-03-15

### Added
- Email verification on signup (#234)
- Rate limiting on verification endpoint

### Changed
- Updated signup flow to include verification step

### Fixed
- Duplicate entries in cart when clicking fast (#289)

### Deprecated
- `sendWelcomeEmail()` — use `NotificationService.send()` instead

### Removed
- Legacy password reset endpoint (`/api/v1/reset`)

### Security
- Patched XSS vulnerability in comment rendering (#301)
```

### Categorías estándar del changelog

| Categoría | Uso |
|-----------|-----|
| **Added** | Nuevas funcionalidades |
| **Changed** | Cambios en funcionalidades existentes |
| **Fixed** | Correcciones de bugs |
| **Deprecated** | Funcionalidades marcadas para eliminación futura |
| **Removed** | Funcionalidades eliminadas |
| **Security** | Correcciones de seguridad |

> **Consejo:** Escribe la PR description como si la persona que la lee
> no tiene contexto del problema. Un buen PR se explica por sí solo.
