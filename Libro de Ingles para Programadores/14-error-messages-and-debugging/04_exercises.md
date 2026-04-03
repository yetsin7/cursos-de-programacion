# Chapter 14: Exercises

## Ejercicios de Mensajes de Error y Debugging

---

## Ejercicio 1: Identifica el Tipo de Error

Indica que tipo de error es cada uno.

1. El codigo tiene un parentesis faltante.
2. Intentaste acceder a `.name` en un objeto que es `null`.
3. Usaste una variable que nunca fue declarada.
4. El programa uso toda la memoria disponible.
5. La conexion al servidor tardo mas de 30 segundos.
6. Intentaste acceder al indice 10 de un array de 5 elementos.

<details>
<summary>Respuestas</summary>

1. SyntaxError
2. NullPointerException (o TypeError en JS)
3. ReferenceError
4. OutOfMemoryError
5. TimeoutError
6. RangeError / IndexOutOfBoundsException
</details>

---

## Ejercicio 2: Describe el Error en Ingles

Lee cada mensaje de error y escribelo como lo explicarias a un companiero en ingles.

**1.**
```
TypeError: Cannot read property 'email' of undefined
```

**2.**
```
ConnectionRefused: ECONNREFUSED 127.0.0.1:3000
```

**3.**
```
PermissionDenied: /var/log/app.log
```

<details>
<summary>Respuestas Sugeridas</summary>

1. "I'm getting a TypeError — I'm trying to access the email property on an undefined object. The user variable is probably not set."
2. "The connection to localhost on port 3000 was refused. The server is probably not running."
3. "Permission denied when trying to access the log file. The app doesn't have write permissions to that directory."
</details>

---

## Ejercicio 3: Vocabulario de Debugging

Completa las oraciones con el termino correcto.

1. "Set a _______ on line 25 to pause execution there."
2. "Click _______ to execute the current line without entering the function."
3. "There's a _______ — the app's memory usage keeps growing without stopping."
4. "The two threads are in a _______ — each one is waiting for the other."
5. "It's an _______ error — the loop runs one extra time."
6. "We need to deploy a _______ to production immediately."
7. "I found a _______ for now, but we need a proper fix."
8. "The _______ of the bug was a missing validation in the API."

<details>
<summary>Respuestas</summary>

1. breakpoint
2. step over
3. memory leak
4. deadlock
5. off-by-one
6. hotfix
7. workaround
8. root cause
</details>

---

## Ejercicio 4: Escribe un Bug Report

Escribe un bug report completo en ingles para este escenario:

> En una app de e-commerce, cuando un usuario agrega un producto al carrito y luego
> cambia el idioma de la app, el carrito se vacia completamente.

Incluye: Title, Description, Steps to Reproduce, Expected Behavior, Actual Behavior,
y Environment.

<details>
<summary>Ejemplo de Respuesta</summary>

**Title**: Cart items lost when changing app language

**Description**: When a user changes the application language from the settings,
all items in the shopping cart are removed.

**Steps to Reproduce**:
1. Open the app and log in.
2. Add any product to the cart.
3. Go to Settings > Language.
4. Change the language from English to Spanish.
5. Navigate back to the cart.

**Expected Behavior**: The cart should retain all items after changing the language.

**Actual Behavior**: The cart is empty after the language change. All items are lost.

**Environment**:
- OS: Android 14
- App version: 3.2.1
- Device: Pixel 8
</details>

---

## Ejercicio 5: Clasifica la Severidad

Asigna el nivel de severidad correcto: **Critical**, **Major**, **Minor**, o **Cosmetic**.

1. Los usuarios no pueden completar el proceso de pago.
2. El icono de notificaciones esta 2 pixeles desalineado.
3. La busqueda no encuentra resultados que contengan acentos.
4. La app se cierra al abrir la camara en Android 14.
5. El texto del footer tiene un color ligeramente diferente al del diseno.

<details>
<summary>Respuestas</summary>

1. Critical — impide la funcionalidad principal
2. Cosmetic — solo visual, no afecta funcionalidad
3. Major — funcionalidad importante no funciona correctamente
4. Critical — crash que afecta una funcion importante
5. Cosmetic — diferencia visual menor
</details>

---

## Ejercicio 6: Traduce las Frases de Debugging

Traduce al ingles:

1. "Encontre un bug en el flujo de autenticacion."
2. "El error solo ocurre a veces, no siempre."
3. "Necesitamos desplegar un parche urgente."
4. "Voy a poner un breakpoint para investigar."
5. "La causa raiz fue una race condition en el servicio de pagos."
6. "Tengo una solucion temporal por ahora."

<details>
<summary>Respuestas</summary>

1. "I found a bug in the authentication flow."
2. "The error only occurs sometimes — it's intermittent."
3. "We need to deploy a hotfix."
4. "I'll set a breakpoint to investigate."
5. "The root cause was a race condition in the payment service."
6. "I have a workaround for now."
</details>

---

## Ejercicio 7: Interpreta y Responde

Un companiero te envia este mensaje en Slack. Escribe tu respuesta en ingles.

> "Hey, I'm getting a NullPointerException in the UserService when I try to
> fetch the user profile. It only happens for new users who haven't set up
> their profile yet. Any ideas?"

<details>
<summary>Respuesta Sugerida</summary>

"It sounds like the `fetchProfile` method doesn't handle the case where the
profile is null for new users. We should add a null check before accessing
profile properties. Something like: `if (user.profile == null) return defaultProfile;`.
Can you check if the profile object is being initialized during user creation?"
</details>

---

## Ejercicio 8: Matching

Conecta cada termino con su definicion.

| Termino | Definicion |
|---------|-----------|
| 1. Race condition | a. Bug that reappears after being fixed |
| 2. Edge case | b. Result depends on execution order |
| 3. Regression | c. Extreme or boundary input scenario |
| 4. Deadlock | d. Test that sometimes passes, sometimes fails |
| 5. Flaky test | e. Two processes blocking each other |

<details>
<summary>Respuestas</summary>

1-b, 2-c, 3-a, 4-e, 5-d
</details>
