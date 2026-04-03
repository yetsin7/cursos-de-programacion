# Chapter 15: Exercises

## Ejercicios de Git y Control de Versiones

---

## Ejercicio 1: Vocabulario de Comandos

Escribe el comando de Git que corresponde a cada descripcion.

1. Copiar un repositorio remoto a tu maquina local: `git ___`
2. Ver que archivos han cambiado: `git ___`
3. Guardar cambios temporalmente sin hacer commit: `git ___`
4. Enviar tus commits al repositorio remoto: `git ___`
5. Crear un commit que deshace otro commit: `git ___`
6. Copiar un commit especifico a otra rama: `git ___`
7. Traer cambios del remoto sin fusionar: `git ___`
8. Marcar un commit como una version: `git ___`

<details>
<summary>Respuestas</summary>

1. git clone
2. git status
3. git stash
4. git push
5. git revert
6. git cherry-pick
7. git fetch
8. git tag
</details>

---

## Ejercicio 2: Pronunciacion

Escribe como pronunciarias estos terminos de Git.

1. repository → ___
2. merge → ___
3. rebase → ___
4. cherry-pick → ___
5. stash → ___
6. origin → ___
7. upstream → ___
8. checkout → ___

<details>
<summary>Respuestas</summary>

1. ri-PO-si-to-ri
2. merch
3. ri-BEIS
4. CHE-ri pik
5. stash
6. O-ri-yin
7. AP-striim
8. CHEK-aut
</details>

---

## Ejercicio 3: Completa la Oracion

Elige el termino correcto: **merge**, **rebase**, **cherry-pick**, **stash**, **fetch**.

1. "I'll _______ my branch onto main before creating the PR."
2. "Let me _______ my changes before switching branches."
3. "_______ the hotfix commit into the release branch."
4. "_______ the latest changes to see if anyone pushed new code."
5. "_______ the feature branch into develop when it's ready."

<details>
<summary>Respuestas</summary>

1. rebase
2. stash
3. Cherry-pick
4. Fetch
5. Merge
</details>

---

## Ejercicio 4: Nombra la Rama

Escribe un nombre de rama apropiado para cada situacion, usando las convenciones.

1. Agregar autenticacion con Google.
2. Corregir un bug donde el carrito muestra precios negativos.
3. Correccion urgente porque los pagos no funcionan en produccion.
4. Actualizar las dependencias del proyecto.
5. Preparar la version 3.0.0.

<details>
<summary>Respuestas Sugeridas</summary>

1. `feature/google-authentication`
2. `fix/cart-negative-prices`
3. `hotfix/payment-processing-failure`
4. `chore/update-dependencies`
5. `release/v3.0.0`
</details>

---

## Ejercicio 5: Escribe un Titulo de PR

Escribe un titulo de PR profesional para cada situacion.

1. Creaste una pagina de perfil de usuario con subida de avatar.
2. Corregiste un bug donde la sesion expiraba inmediatamente.
3. Reorganizaste el codigo del servicio de pagos.
4. Agregaste tests para el flujo de registro.
5. Actualizaste la documentacion de la API.

<details>
<summary>Respuestas Sugeridas</summary>

1. "feat: add user profile page with avatar upload"
2. "fix: resolve premature session expiration"
3. "refactor: reorganize payment service architecture"
4. "test: add coverage for user registration flow"
5. "docs: update API reference documentation"
</details>

---

## Ejercicio 6: Code Review Phrases

Que dirias en ingles en cada situacion de code review?

1. El codigo se ve bien y quieres aprobarlo.
2. Hay un problema menor de estilo que no bloquea la aprobacion.
3. Encontraste un posible memory leak.
4. Quieres sugerir usar una constante en vez de un numero magico.
5. Quieres elogiar un refactor bien hecho.

<details>
<summary>Respuestas Sugeridas</summary>

1. "LGTM! Approved."
2. "Nit: consider using camelCase for this variable name."
3. "There's a potential memory leak here — the listener is never disposed."
4. "I'd suggest extracting this value into a named constant for readability."
5. "Nice refactor — much cleaner now!"
</details>

---

## Ejercicio 7: Resuelve el Conflicto

Mira este conflicto de merge y decide como resolverlo. Explica tu decision en ingles.

```
<<<<<<< HEAD
const API_URL = 'https://api.example.com/v2';
=======
const API_URL = 'https://api.example.com/v3';
>>>>>>> feature/upgrade-api
```

<details>
<summary>Respuesta Sugerida</summary>

"I'll accept the incoming changes from the feature branch since we're upgrading
to API v3. The final code should be:

`const API_URL = 'https://api.example.com/v3';`

The v2 URL in HEAD is the old version we're replacing."
</details>

---

## Ejercicio 8: Escribe una Descripcion de PR

Escribe la descripcion completa de un PR para este escenario:

> Implementaste un sistema de notificaciones push para la app movil.
> Creaste un `NotificationService`, un `NotificationProvider`, y modificaste
> el `HomeScreen` para mostrar un badge con el conteo de notificaciones.
> Esto cierra el issue #89.

Incluye: Summary, Changes, How to Test, y Related Issues.

<details>
<summary>Respuesta Sugerida</summary>

```markdown
## Summary

Implement push notification system for the mobile app, including
a notification service, state management, and UI badge indicator.

## Changes

- Created `NotificationService` for handling push notification registration and delivery
- Added `NotificationProvider` for managing notification state
- Updated `HomeScreen` to display a notification count badge
- Added notification permission request on first launch

## How to Test

1. Check out this branch and run the app.
2. Allow notification permissions when prompted.
3. Send a test notification using the Firebase console.
4. Verify the badge count updates on the home screen.
5. Tap the bell icon to see the notifications list.

## Related Issues

Closes #89
```
</details>

---

## Ejercicio 9: Traduce al Ingles

1. "Crea una rama de feature desde develop."
2. "Hay un conflicto de merge en el archivo de configuracion."
3. "Rebasa tu rama sobre main antes de crear el PR."
4. "El PR fue aprobado con sugerencias menores."
5. "Necesitamos hacer cherry-pick de ese fix en la rama de release."

<details>
<summary>Respuestas</summary>

1. "Create a feature branch from develop."
2. "There's a merge conflict in the configuration file."
3. "Rebase your branch onto main before creating the PR."
4. "The PR was approved with minor suggestions."
5. "We need to cherry-pick that fix into the release branch."
</details>
