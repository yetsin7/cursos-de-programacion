# Ejercicios: Stack Overflow y Foros Técnicos

---

## Ejercicio 1: Mejora estos títulos de preguntas

Reescribe cada título para que sea específico y buscable:

1. "Help with error"
2. "React problem"
3. "Code not working"
4. "Database question"
5. "Need help ASAP!!!"
6. "Why doesn't this work?"

### Respuestas sugeridas

1. "TypeError: Cannot read property 'length' of undefined in Express middleware"
2. "React useState not updating immediately after setState call"
3. "Python script exits with code 1 when reading CSV with special characters"
4. "PostgreSQL LEFT JOIN returns NULL for existing related records"
5. "Flutter Navigator.pushNamed throws RouteNotFoundException for registered route"
6. "JavaScript fetch POST returns 403 despite valid CORS headers"

---

## Ejercicio 2: ¿Qué significa cada abreviación?

Traduce al español:

1. TL;DR
2. FWIW
3. YMMV
4. AFAIK
5. LGTM
6. IIRC
7. YAGNI
8. ELI5
9. WONTFIX
10. PTAL

### Respuestas

1. **TL;DR** — Muy largo; resumen: (Too Long; Didn't Read)
2. **FWIW** — Por si sirve de algo (For What It's Worth)
3. **YMMV** — Tu experiencia puede variar (Your Mileage May Vary)
4. **AFAIK** — Hasta donde yo sé (As Far As I Know)
5. **LGTM** — Se ve bien para mí (Looks Good To Me)
6. **IIRC** — Si recuerdo correctamente (If I Remember Correctly)
7. **YAGNI** — No lo vas a necesitar (You Aren't Gonna Need It)
8. **ELI5** — Explícame como si tuviera 5 años (Explain Like I'm 5)
9. **WONTFIX** — No se va a arreglar (Will Not Fix)
10. **PTAL** — Por favor revisa de nuevo (Please Take Another Look)

---

## Ejercicio 3: Escribe una pregunta para Stack Overflow

Escenario: Tu app Flutter muestra un error `RangeError (index)` cuando
intentas acceder a un elemento de una lista que obtuviste de una API.
El error ocurre solo cuando la API retorna una lista vacía.

Escribe la pregunta completa (título, contexto, código, error, entorno).

### Respuesta sugerida

```markdown
# Flutter RangeError (index) when accessing API response list that is empty

I'm building a Flutter app that fetches product data from
a REST API. When the API returns an empty list, the app
crashes with a `RangeError (index)`.

## What I've tried

- Adding a null check before accessing the list
- Using `list.isNotEmpty` before the ListView builder
- Checking the API response in Postman (it returns `[]`)

## Code

```dart
Future<void> fetchProducts() async {
  final response = await http.get(Uri.parse('$baseUrl/products'));
  final List<dynamic> data = json.decode(response.body);
  setState(() {
    // Crashes here when data is empty
    firstProduct = data[0];
  });
}
```

## Error

```
RangeError (index): Invalid value: Valid value range is
empty: 0
```

## Expected behavior

The app should show an empty state message when there
are no products, instead of crashing.

## Environment

- Flutter 3.16.0
- Dart 3.2.0
- Android 14 (emulator)
- http package 1.1.0
```

---

## Ejercicio 4: Escribe una respuesta útil

Alguien pregunta: "Why does my JavaScript `forEach` loop not wait
for async operations?"

Escribe una respuesta que diagnostique el problema, ofrezca solución
y explique por qué funciona.

### Respuesta sugerida

```markdown
The issue is that `forEach` doesn't await async callbacks.
It fires all iterations simultaneously and doesn't wait
for any of them to complete.

## Solution

Use `for...of` instead:

```javascript
// This WON'T work (forEach ignores async)
urls.forEach(async (url) => {
  const data = await fetch(url);
  console.log(data);
});
console.log('Done'); // Runs BEFORE fetches complete

// This WILL work (for...of respects await)
for (const url of urls) {
  const data = await fetch(url);
  console.log(data);
}
console.log('Done'); // Runs AFTER all fetches complete
```

## Why?

`forEach` calls your callback function for each element
but does NOT await the returned Promise. It's equivalent
to calling multiple async functions without `await`.

`for...of` is a regular loop, so `await` inside it pauses
execution as expected.

## If you want parallel execution:

```javascript
// Fetch all URLs in parallel
const results = await Promise.all(
  urls.map(url => fetch(url))
);
```

This is faster because all requests run simultaneously.

For more details, see the [MDN docs on forEach](link).
```

---

## Ejercicio 5: Responde a estos comentarios de foro

Escribe una respuesta apropiada para cada situación:

### A) Alguien resolvió tu problema

Comentario: "Try adding `overflow: hidden` to the parent container."

Tu respuesta: ___

### B) Necesitas más información del que preguntó

Pregunta: "My app is slow."

Tu comentario: ___

### C) La pregunta es un duplicado

Pregunta: "How do I center a div in CSS?"

Tu comentario: ___

### D) Una respuesta de hace 3 años está desactualizada

Respuesta antigua: "Use componentWillMount in React..."

Tu comentario: ___

### Respuestas sugeridas

**A)** "That fixed it! Thanks so much. I had no idea the parent container's overflow was causing the issue. Marking as accepted."

**B)** "Can you provide more context? What does 'slow' mean exactly — slow initial load, slow navigation, slow API responses? Also, what framework and version are you using? A screenshot of the browser's Network tab would help narrow it down."

**C)** "Possible duplicate of [How to center a div](link). The accepted answer there covers all modern approaches including Flexbox and Grid."

**D)** "Note: This answer is outdated. `componentWillMount` has been deprecated since React 16.3 and removed in React 18. Use `useEffect` instead for side effects, or just initialize state directly in the component/constructor."

---

## Ejercicio 6: Usa las abreviaciones correctamente

Completa cada oración con la abreviación apropiada:

1. "___, the issue might be related to CORS." (hasta donde yo sé)
2. "___: use `useCallback` for function refs, `useMemo` for values." (resumen)
3. "___, this workaround fixed my build error." (por si sirve de algo)
4. "___, this only works on Chrome. ___." (si recuerdo bien / tu experiencia puede variar)
5. "We don't need caching right now. ___." (no lo vas a necesitar)

### Respuestas

1. "**AFAIK**, the issue might be related to CORS."
2. "**TL;DR**: use `useCallback` for function refs, `useMemo` for values."
3. "**FWIW**, this workaround fixed my build error."
4. "**IIRC**, this only works on Chrome. **YMMV**."
5. "We don't need caching right now. **YAGNI**."

---

## Ejercicio 7: Identifica los problemas en esta pregunta

Lee esta pregunta y lista al menos 5 problemas:

```
HELP!!! MY CODE DOESNT WORK!!!

i have a problem with my website. it was working yesterday
but now its broken. can someone fix it? i dont know what
happened. please help me its urgent i need it for tomorrow.

thanks
```

### Respuestas

1. **Título no descriptivo** — "HELP!!!" no dice nada del problema
2. **Sin código** — no incluye código ni ejemplo reproducible
3. **Sin error** — no muestra el mensaje de error
4. **Sin entorno** — no menciona tecnologías ni versiones
5. **Sin lo que intentó** — no dice qué ha probado
6. **Sin resultado esperado vs actual** — no describe el comportamiento
7. **Urgencia irrelevante** — "urgent" no cambia la prioridad
8. **Pide que le resuelvan** — "can someone fix it" no es una pregunta técnica
9. **Todo en minúsculas** — difícil de leer
10. **No buscable** — nadie encontrará esto al buscar su mismo problema
