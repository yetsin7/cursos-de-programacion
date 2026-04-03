# Chapter 12: Exercises

## Ejercicios de Lectura de Codigo en Ingles

---

## Ejercicio 1: Identifica la Convencion

Indica que convencion de nomenclatura usa cada nombre.

| Nombre | Convencion |
|--------|------------|
| 1. `getUserProfile` | ___ |
| 2. `MAX_CONNECTIONS` | ___ |
| 3. `user_profile` | ___ |
| 4. `UserProfile` | ___ |
| 5. `my-component` | ___ |

<details>
<summary>Respuestas</summary>

1. camelCase
2. SCREAMING_SNAKE_CASE
3. snake_case
4. PascalCase
5. kebab-case
</details>

---

## Ejercicio 2: Lee los Nombres en Voz Alta

Escribe como leerias cada nombre en ingles.

1. `isUserAuthenticated` → ___
2. `MAX_RETRY_COUNT` → ___
3. `handleFormSubmission` → ___
4. `get_items_by_category` → ___
5. `DatabaseConnectionManager` → ___
6. `shouldFetchNewData` → ___
7. `onClick` → ___
8. `API_BASE_URL` → ___

<details>
<summary>Respuestas</summary>

1. "is user authenticated"
2. "max retry count"
3. "handle form submission"
4. "get items by category"
5. "Database Connection Manager"
6. "should fetch new data"
7. "on click"
8. "API base URL"
</details>

---

## Ejercicio 3: Lee el Codigo en Voz Alta

Escribe como leerias cada linea de codigo en ingles.

**1.**
```javascript
if (count >= 10) { return; }
```

**2.**
```javascript
const name = user?.name ?? 'Guest';
```

**3.**
```python
for i in range(0, len(items)):
```

**4.**
```javascript
items.filter(x => x.price > 100).map(x => x.name);
```

**5.**
```dart
final List<String> names = [];
```

<details>
<summary>Respuestas Sugeridas</summary>

1. "If count is greater than or equal to ten, return."
2. "Const name equals user optional-chain name, null-coalescing Guest."
3. "For i in range zero to length of items."
4. "Items dot filter where x arrow x dot price is greater than one hundred, dot map where x arrow x dot name."
5. "Final list of string, names, equals empty list."
</details>

---

## Ejercicio 4: Nombra el Simbolo

Escribe el nombre en ingles de cada simbolo.

| # | Simbolo | Nombre |
|---|---------|--------|
| 1 | `{ }` | ___ |
| 2 | `[ ]` | ___ |
| 3 | `=>` | ___ |
| 4 | `&&` | ___ |
| 5 | `\|\|` | ___ |
| 6 | `!=` | ___ |
| 7 | `++` | ___ |
| 8 | `??` | ___ |
| 9 | `@` | ___ |
| 10 | `_` | ___ |

<details>
<summary>Respuestas</summary>

1. curly braces
2. square brackets
3. fat arrow / arrow
4. double ampersand / and
5. double pipe / or
6. not equal to
7. plus plus / increment
8. null coalescing
9. at sign
10. underscore
</details>

---

## Ejercicio 5: Interpreta el Error

Lee cada mensaje de error y explica en espaniol que significa.

**1.**
```
TypeError: Cannot read property 'length' of null
```

**2.**
```
404 Not Found: GET /api/users/999
```

**3.**
```
RangeError: Maximum call stack size exceeded
```

**4.**
```
CORS policy: No 'Access-Control-Allow-Origin' header is present
```

**5.**
```
SyntaxError: Unexpected token ';' at line 15
```

<details>
<summary>Respuestas</summary>

1. Intentaste acceder a `.length` en algo que es `null`. Probablemente una variable no tiene valor.
2. La ruta `/api/users/999` no existe. El usuario con ID 999 no se encontro.
3. La pila de llamadas se agoto. Hay una recursion infinita en el codigo.
4. El servidor no permite peticiones desde tu dominio. Falta configurar CORS en el backend.
5. Hay un punto y coma inesperado en la linea 15. Error de sintaxis.
</details>

---

## Ejercicio 6: Traduce la Descripcion del Error

Traduce estas descripciones de errores al ingles.

1. "Estoy obteniendo un error 401 cuando intento hacer login."
2. "La app se cae cuando la lista esta vacia."
3. "El error aparece solo en produccion, no localmente."
4. "Hay un NullPointerException en la linea 42."
5. "El stack trace muestra que el error viene del servicio de autenticacion."

<details>
<summary>Respuestas Sugeridas</summary>

1. "I'm getting a 401 error when I try to log in."
2. "The app crashes when the list is empty."
3. "The error only appears in production, not locally."
4. "There's a NullPointerException on line 42."
5. "The stack trace shows the error comes from the authentication service."
</details>

---

## Ejercicio 7: Lectura Completa

Lee el siguiente bloque de codigo en voz alta, linea por linea.

```javascript
async function fetchUserData(userId) {
  try {
    const response = await fetch(`/api/users/${userId}`);
    if (!response.ok) {
      throw new Error(`HTTP error: ${response.status}`);
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Failed to fetch user:', error.message);
    return null;
  }
}
```

<details>
<summary>Lectura Sugerida</summary>

- "Async function fetch-user-data takes user-ID."
- "Try:"
- "Const response equals await fetch, slash API slash users slash user-ID."
- "If not response dot OK:"
- "Throw new Error, HTTP error, response dot status."
- "Const data equals await response dot JSON."
- "Return data."
- "Catch error:"
- "Console dot error, Failed to fetch user, error dot message."
- "Return null."
</details>

---

## Ejercicio 8: Practica Diaria

Durante la proxima semana, practica lo siguiente:

1. **Dia 1-2**: Lee 5 nombres de variables de tu proyecto en voz alta
2. **Dia 3-4**: Lee 3 funciones completas en voz alta
3. **Dia 5-6**: Lee los mensajes de error que encuentres y explicalos en ingles
4. **Dia 7**: Haz pair programming (real o simulado) leyendo codigo en ingles
