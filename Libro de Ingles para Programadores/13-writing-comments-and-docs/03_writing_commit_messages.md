# Writing Commit Messages

## Como Escribir Mensajes de Commit en Ingles

Los mensajes de commit son el historial de tu proyecto. Un buen mensaje de commit
comunica que se cambio y por que, facilitando la revision de codigo, el debugging
y la colaboracion.

---

## Estructura de un Mensaje de Commit

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Ejemplo completo

```
feat(auth): add two-factor authentication support

Implement TOTP-based 2FA using the otplib library.
Users can enable 2FA from their security settings.

Closes #234
```

---

## Conventional Commits

Los "Conventional Commits" son el estandar mas usado en la industria.

| Tipo | Significado | Cuando usarlo |
|------|-------------|---------------|
| **feat** | Feature (caracteristica) | Agregas funcionalidad nueva |
| **fix** | Fix (correccion) | Corriges un bug |
| **docs** | Documentation | Cambias documentacion |
| **style** | Style (estilo) | Formateo, punto y coma, espacios (no CSS) |
| **refactor** | Refactoring | Cambias codigo sin alterar funcionalidad |
| **test** | Test (pruebas) | Agregas o corriges tests |
| **chore** | Chore (tarea) | Mantenimiento, dependencias, config |
| **perf** | Performance | Mejoras de rendimiento |
| **ci** | CI/CD | Cambios en configuracion de CI/CD |
| **build** | Build | Cambios en el sistema de build |
| **revert** | Revert | Reviertes un commit anterior |

---

## Ejemplos por Tipo

### feat (nueva funcionalidad)

```
feat: add dark mode toggle to settings page
feat(cart): implement quantity selector for products
feat(auth): add Google OAuth login support
feat(i18n): add Spanish translations for checkout flow
```

### fix (correccion de bug)

```
fix: resolve null pointer in user authentication
fix(payment): correct tax calculation for international orders
fix(ui): prevent layout overflow on small screens
fix(api): handle empty response from user endpoint
```

### docs (documentacion)

```
docs: update API reference with new endpoints
docs(readme): add installation instructions for Windows
docs: fix typo in contributing guidelines
```

### refactor (reestructuracion)

```
refactor: extract validation logic into separate service
refactor(auth): simplify token refresh mechanism
refactor: rename UserManager to UserService for clarity
```

### test (pruebas)

```
test: add unit tests for payment service
test(auth): cover edge case for expired tokens
test: increase coverage for user registration flow
```

### chore (mantenimiento)

```
chore: update dependencies to latest versions
chore: configure ESLint rules for TypeScript
chore(deps): bump flutter_bloc from 8.0 to 8.1
```

---

## El Modo Imperativo

Los mensajes de commit deben usar el **modo imperativo** en ingles.
Imagina que completas la frase: "If applied, this commit will..."

| Correcto (imperativo) | Incorrecto |
|----------------------|------------|
| **Add** user validation | ~~Added~~ user validation |
| **Fix** login bug | ~~Fixed~~ login bug |
| **Update** README | ~~Updated~~ README |
| **Remove** unused imports | ~~Removed~~ unused imports |
| **Refactor** auth service | ~~Refactoring~~ auth service |
| **Implement** dark mode | ~~Implemented~~ dark mode |

---

## Verbos Comunes para Commits

| Verbo | Significado | Ejemplo |
|-------|-------------|---------|
| **add** | Agregar algo nuevo | "add email validation" |
| **fix** | Corregir un error | "fix crash on empty list" |
| **update** | Actualizar algo existente | "update user model" |
| **remove** | Eliminar algo | "remove deprecated API" |
| **rename** | Renombrar | "rename config file" |
| **move** | Mover archivo/codigo | "move utils to shared folder" |
| **refactor** | Reestructurar | "refactor database layer" |
| **implement** | Implementar | "implement search feature" |
| **improve** | Mejorar | "improve error handling" |
| **replace** | Reemplazar | "replace axios with fetch" |
| **simplify** | Simplificar | "simplify routing logic" |
| **extract** | Extraer | "extract helper function" |
| **merge** | Fusionar | "merge feature branch" |
| **revert** | Revertir | "revert login changes" |
| **bump** | Actualizar version | "bump version to 2.1.0" |

---

## Scope (Alcance)

El scope es opcional y describe que parte del proyecto se afecto.

```
feat(auth): add login with biometrics
fix(cart): correct item count badge
refactor(api): simplify error handling middleware
test(user): add tests for profile update
chore(deps): update Flutter to 3.22
```

**Scopes comunes**: auth, api, ui, db, config, deps, i18n, nav, cart, user, payment

---

## El Body (Cuerpo)

Para cambios complejos, agrega un cuerpo que explique:
- **Que** se cambio y **por que**
- **No** repitas lo que ya dice el titulo

```
fix(auth): prevent token refresh loop

The refresh token was being called on every 401 response,
including the refresh endpoint itself, causing an infinite loop.

Added a flag to skip token refresh for auth-related requests.
```

---

## El Footer (Pie)

Se usa para referencias y notas especiales.

```
feat(payment): add Stripe integration

Implement Stripe checkout for premium subscriptions.

Closes #156
Co-authored-by: Alice <alice@example.com>
BREAKING CHANGE: payment API now requires a currency parameter
```

| Footer | Significado |
|--------|-------------|
| `Closes #123` | Cierra el issue numero 123 |
| `Fixes #456` | Corrige el issue numero 456 |
| `Refs #789` | Referencia el issue 789 |
| `BREAKING CHANGE:` | Cambio que rompe compatibilidad |
| `Co-authored-by:` | Co-autor del commit |

---

## Errores Comunes

| Mal | Bien |
|-----|------|
| "fixed stuff" | "fix(auth): resolve session timeout on mobile" |
| "update" | "refactor(api): simplify error response format" |
| "WIP" | No hagas commit de trabajo incompleto |
| "asdfgh" | Nunca hagas commits sin mensaje real |
| "fix fix fix" | Un commit por cada cambio logico |

---

## Resumen

1. Usa **Conventional Commits**: `type(scope): description`
2. Escribe en **modo imperativo**: "add", no "added"
3. Se **especifico** pero conciso en la descripcion
4. Agrega un **body** para cambios complejos
5. Usa **footers** para referencias a issues
6. Un commit = un cambio logico
