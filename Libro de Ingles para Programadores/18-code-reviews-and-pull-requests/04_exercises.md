# Ejercicios: Code Reviews y Pull Requests

---

## Ejercicio 1: Mejora el tono del feedback

Reescribe cada comentario de code review con un tono más profesional:

1. "This is wrong. Use async/await."
2. "Why would you do it this way?"
3. "This doesn't make any sense."
4. "Just use a Map."
5. "You forgot to handle errors."
6. "This is bad code."

### Respuestas sugeridas

1. "Have you considered using async/await here? It would make the flow easier to follow."
2. "What's the reasoning behind this approach? I'm curious about the tradeoffs."
3. "I'm not sure I follow this part. Could you add a comment explaining the logic?"
4. "What do you think about using a Map here? It would give us O(1) lookups."
5. "This could use some error handling. If the API call fails, it will crash silently."
6. "I'd suggest refactoring this section. We could improve readability by extracting the validation into a separate function."

---

## Ejercicio 2: Responde al feedback

Escribe una respuesta apropiada para cada comentario del reviewer:

1. Reviewer: "Nit: extra whitespace on line 23."
2. Reviewer: "This query runs inside a loop. It will cause N+1 queries."
3. Reviewer: "I'd suggest using TypeScript generics here."
4. Reviewer: "Why not use the built-in Array.flat() method?"
5. Reviewer: "This function is doing too many things. Consider splitting it."

### Respuestas sugeridas

1. "Fixed, thanks!"
2. "Great catch! I refactored to use a single query with a JOIN instead. See the latest commit."
3. "Good idea! I've updated the function signature to use generics. Much more flexible now."
4. "I chose a manual implementation because we need to support IE11 (no flat() support). I've added a comment explaining this."
5. "I agree, let me refactor this. I'll extract the validation and formatting into separate utility functions."

---

## Ejercicio 3: Clasifica el nivel de feedback

Asigna el prefijo correcto (Blocker, Major, Minor, Nit, Question) a cada comentario:

1. "The SQL query is vulnerable to injection attacks."
2. "Missing period at the end of the comment."
3. "This function doesn't validate the input before processing."
4. "Why did you choose this library over the more popular alternative?"
5. "Consider adding a loading state while the data fetches."
6. "The app crashes when the user submits an empty form."

### Respuestas

1. **Blocker:** Security vulnerability (SQL injection)
2. **Nit:** Formatting detail
3. **Major:** Missing input validation
4. **Question:** Understanding design decision
5. **Minor:** UX improvement suggestion
6. **Blocker:** App crash on user action

---

## Ejercicio 4: Escribe un título de PR

Escribe un título profesional para cada escenario:

1. Arreglaste un bug donde los usuarios no podían cambiar su contraseña.
2. Añadiste paginación al endpoint de productos.
3. Refactorizaste el servicio de autenticación en archivos más pequeños.
4. Actualizaste todas las dependencias del proyecto.
5. Añadiste tests unitarios para el módulo de pagos.
6. Mejoraste el tiempo de respuesta de la búsqueda.

### Respuestas

1. "fix: Resolve password change failing for existing users"
2. "feat: Add pagination to GET /api/products endpoint"
3. "refactor: Split AuthService into smaller focused modules"
4. "chore: Update project dependencies to latest versions"
5. "test: Add unit tests for payment processing module"
6. "perf: Optimize search query with database indexing"

---

## Ejercicio 5: Escribe una PR description completa

Escenario: Añadiste un sistema de notificaciones push a la app.
Los cambios incluyen: nuevo endpoint, nuevo servicio, tabla en la BD,
integración con Firebase, y tests. Cierra el issue #567.

### Respuesta sugerida

```markdown
## Summary

This PR adds push notification support to the application.
Users can now receive real-time notifications for order
updates, promotions, and account activity. The implementation
uses Firebase Cloud Messaging (FCM) for delivery.

## Changes

- Add `POST /api/notifications/send` endpoint
- Add `GET /api/notifications` endpoint with pagination
- Create `notifications` table with migration
- Create `NotificationService` with send, schedule, and
  mark-as-read methods
- Integrate Firebase Cloud Messaging SDK
- Add device token registration on user login
- Add unit and integration tests for notification service

## Testing

- [x] Unit tests pass for NotificationService
- [x] Integration tests with Firebase (staging environment)
- [x] Manual testing: send notification and verify delivery
- [x] Tested with both Android and iOS devices
- [x] Tested mark-as-read functionality
- [x] Tested pagination on notification list

## Related Issues

Closes #567 — Add push notifications

## Notes for Reviewers

- **Migration needed:** Run `npm run migrate` to create
  the `notifications` table.
- **Environment variables needed:** Add `FIREBASE_PROJECT_ID`,
  `FIREBASE_PRIVATE_KEY`, and `FIREBASE_CLIENT_EMAIL`.
- Please review the retry logic in the notification service
  carefully — I'm using exponential backoff with max 3 retries.
```

---

## Ejercicio 6: Escribe entradas de changelog

Escribe entradas de changelog para estos cambios:

1. Se añadió dark mode a la aplicación.
2. Se corrigió un bug donde el carrito mostraba precio incorrecto.
3. Se deprecó el endpoint `/api/v1/users` en favor de `/api/v2/users`.
4. Se mejoró el tiempo de carga de la página principal.
5. Se eliminó soporte para Node.js 14.
6. Se parcheó una vulnerabilidad XSS en los comentarios.

### Respuesta

```markdown
## [2.1.0] - 2024-06-15

### Added
- Dark mode support across all pages (#412)

### Fixed
- Cart displaying incorrect price for discounted items (#398)

### Deprecated
- `/api/v1/users` endpoint — use `/api/v2/users` instead

### Changed
- Optimized homepage load time by 40% with lazy loading (#405)

### Removed
- Node.js 14 support (minimum version is now 18)

### Security
- Patched XSS vulnerability in comment rendering (#420)
```

---

## Ejercicio 7: Maneja un desacuerdo

El reviewer dice: "You should use MongoDB instead of PostgreSQL for this feature because it's faster for document storage."

Tu sabes que PostgreSQL es mejor para este caso porque necesitas transacciones ACID y relaciones. Escribe una respuesta profesional.

### Respuesta sugerida

```
I see your point about MongoDB being a good fit for
document storage. However, I'd like to keep PostgreSQL
for this feature for a few reasons:

1. We need ACID transactions for payment processing —
   data consistency is critical here.
2. The data has strong relationships (users → orders →
   items) that benefit from foreign keys and joins.
3. PostgreSQL's JSONB column type gives us document-like
   flexibility when we need it, without losing relational
   capabilities.
4. Keeping a single database simplifies our infrastructure
   and deployment.

That said, if we encounter performance issues with
document-heavy queries in the future, I'm open to
evaluating MongoDB for specific use cases. What do
you think?
```
