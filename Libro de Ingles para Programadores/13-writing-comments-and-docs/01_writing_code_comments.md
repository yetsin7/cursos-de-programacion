# Writing Code Comments

## Como Escribir Comentarios de Codigo en Ingles

Los comentarios de codigo son la forma mas directa de comunicarte con otros
desarrolladores (incluido tu yo del futuro). Escribirlos bien en ingles es
fundamental para proyectos profesionales e internacionales.

---

## Tipos de Comentarios

### Comentarios de una linea (Single-line comments)

```javascript
// Calculate the total price including tax
const total = subtotal * (1 + taxRate);
```

```python
# Check if the user has permission to access this resource
if user.has_permission('admin'):
```

### Comentarios de bloque (Block comments)

```javascript
/*
 * This function processes the payment and returns
 * a receipt object with the transaction details.
 */
function processPayment(amount, method) { ... }
```

```python
"""
Process the payment and return a receipt object
with the transaction details.
"""
def process_payment(amount, method):
```

---

## Convenciones de Anotaciones

Estas etiquetas son universalmente reconocidas en la industria:

| Etiqueta | Significado | Cuando usarla |
|----------|-------------|---------------|
| `TODO` | "To do" - Pendiente | Algo que falta implementar |
| `FIXME` | "Fix me" - Arreglar | Un bug conocido que necesita correccion |
| `HACK` | "Hack" - Solucion temporal | Codigo que funciona pero no es ideal |
| `NOTE` | "Note" - Nota | Informacion importante para el lector |
| `WARNING` | "Warning" - Advertencia | Algo peligroso o delicado |
| `DEPRECATED` | "Deprecated" - Obsoleto | Codigo que ya no se deberia usar |
| `OPTIMIZE` | "Optimize" - Optimizar | Codigo que se puede mejorar en rendimiento |
| `REVIEW` | "Review" - Revisar | Codigo que necesita revision |

### Ejemplos

```javascript
// TODO: Add input validation for email format
// FIXME: This crashes when the list is empty
// HACK: Using setTimeout as a workaround for the race condition
// NOTE: This endpoint requires authentication
// WARNING: Do not change this order — it affects the payment flow
// DEPRECATED: Use fetchUserV2() instead
```

---

## Buenos vs Malos Comentarios

### Malos Comentarios (evitar)

```javascript
// Bad: States the obvious
i++; // Increment i by one

// Bad: Redundant with the code
const name = user.name; // Get the user's name

// Bad: Outdated / misleading
// Returns the user's email   <-- actually returns the name now
function getUserName() { ... }

// Bad: Too vague
// Do the thing
processData();
```

### Buenos Comentarios (usar)

```javascript
// Good: Explains WHY, not WHAT
// We sort by date first because the API doesn't guarantee order
items.sort((a, b) => a.date - b.date);

// Good: Explains a non-obvious decision
// Using a Map instead of an object for O(1) lookup performance
const cache = new Map();

// Good: Documents a business rule
// Users under 18 require parental consent per legal requirements
if (user.age < 18) { requireConsent(); }

// Good: Warns about a gotcha
// WARNING: This endpoint has a rate limit of 100 requests/minute
```

---

## JSDoc (JavaScript / TypeScript)

JSDoc es el estandar para documentar codigo JavaScript y TypeScript.

```javascript
/**
 * Calculate the total price including tax and discounts.
 *
 * @param {number} subtotal - The price before tax.
 * @param {number} taxRate - The tax rate as a decimal (e.g., 0.15).
 * @param {number} [discount=0] - Optional discount amount.
 * @returns {number} The final price after tax and discount.
 * @throws {Error} If subtotal or taxRate is negative.
 *
 * @example
 * calculateTotal(100, 0.15, 10); // Returns 105
 */
function calculateTotal(subtotal, taxRate, discount = 0) {
  if (subtotal < 0 || taxRate < 0) {
    throw new Error('Values cannot be negative');
  }
  return (subtotal - discount) * (1 + taxRate);
}
```

### Etiquetas JSDoc Comunes

| Etiqueta | Significado | Ejemplo |
|----------|-------------|---------|
| `@param` | Parametro de la funcion | `@param {string} name - The user's name.` |
| `@returns` | Valor de retorno | `@returns {boolean} True if valid.` |
| `@throws` | Error que puede lanzar | `@throws {Error} If the ID is invalid.` |
| `@example` | Ejemplo de uso | `@example getName('123')` |
| `@deprecated` | Metodo obsoleto | `@deprecated Use v2 instead.` |
| `@see` | Referencia relacionada | `@see UserService` |
| `@since` | Version en que se agrego | `@since 2.0.0` |

---

## Dartdoc (Dart / Flutter)

```dart
/// Fetches the user profile from the remote API.
///
/// Throws a [NetworkException] if the request fails.
/// Returns `null` if the user is not found.
///
/// Example:
/// ```dart
/// final profile = await fetchProfile('user-123');
/// print(profile?.name);
/// ```
Future<UserProfile?> fetchProfile(String userId) async {
  // ...
}
```

### Reglas de Dartdoc

- Usa `///` para documentacion (no `//` ni `/* */`)
- La primera oracion es el resumen — debe ser clara y concisa
- Usa `[ClassName]` para crear enlaces a otras clases
- Incluye ejemplos con bloques de codigo

---

## Python Docstrings

```python
def fetch_user(user_id: str) -> dict:
    """Fetch a user from the database by their ID.

    Queries the users table and returns the matching record.
    Returns None if no user is found.

    Args:
        user_id: The unique identifier of the user.

    Returns:
        A dictionary with user data, or None if not found.

    Raises:
        DatabaseError: If the connection fails.

    Example:
        >>> user = fetch_user('abc-123')
        >>> print(user['name'])
        'Alice'
    """
```

---

## Frases Utiles para Comentarios

| Ingles | Uso |
|--------|-----|
| "Returns the..." | Para describir el valor de retorno |
| "Throws an error if..." | Para advertir sobre excepciones |
| "This is a workaround for..." | Para explicar soluciones temporales |
| "Called when..." | Para describir cuando se ejecuta algo |
| "Defaults to..." | Para valores por defecto |
| "Must not be null." | Para restricciones |
| "See also: [OtherClass]" | Para referencias |
| "For internal use only." | Para metodos privados |

---

## Resumen

1. Comenta el **por que**, no el **que**
2. Usa **TODO/FIXME/HACK/NOTE** consistentemente
3. Sigue el formato de documentacion de tu lenguaje (JSDoc, Dartdoc, docstrings)
4. Manten los comentarios **actualizados** con el codigo
5. Elimina comentarios **obsoletos o redundantes**
