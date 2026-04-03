# Reading Error Messages

## Como Leer y Entender Mensajes de Error en Ingles

Los mensajes de error estan siempre en ingles. Saber leerlos y entenderlos
rapidamente te hara un programador mucho mas eficiente. En esta leccion
aprenderemos a desglosar los errores mas comunes.

---

## Estructura de un Mensaje de Error

La mayoria de errores siguen este patron:

```
ErrorType: Description of the problem
    at file.js:line:column
    at functionName (file.js:line:column)
```

- **ErrorType**: Tipo de error (que salio mal)
- **Description**: Descripcion detallada del problema
- **Stack trace**: Donde ocurrio (archivo, linea, columna)

---

## Errores de JavaScript / TypeScript

### TypeError

```
TypeError: Cannot read property 'name' of undefined
```
> "Type Error: Cannot read property name of undefined."

**Significado**: Intentaste acceder a `.name` en algo que es `undefined`.
Es decir, la variable no existe o no tiene valor.

**Como describirlo**: "I'm getting a TypeError because I'm trying to access
a property on an undefined value."

---

### ReferenceError

```
ReferenceError: myVariable is not defined
```
> "Reference Error: my-variable is not defined."

**Significado**: Usaste una variable que no ha sido declarada.

**Como describirlo**: "There's a ReferenceError — the variable hasn't been
declared in this scope."

---

### SyntaxError

```
SyntaxError: Unexpected token '}'
```
> "Syntax Error: Unexpected token, closing curly brace."

**Significado**: El codigo tiene un error de sintaxis; hay un `}` donde no deberia.

---

## Errores de Java / Kotlin

### NullPointerException

```
java.lang.NullPointerException: Cannot invoke method on null object
```
> "Null Pointer Exception: Cannot invoke method on null object."

**Significado**: Intentaste llamar un metodo en un objeto que es `null`.

**Como describirlo**: "I'm getting a NullPointerException because the object
is null when I try to call a method on it."

---

### ClassNotFoundException

```
java.lang.ClassNotFoundException: com.example.MyClass
```
> "Class Not Found Exception: com dot example dot MyClass."

**Significado**: El programa no puede encontrar la clase especificada.

---

## Errores HTTP

| Codigo | Nombre | Significado |
|--------|--------|-------------|
| **400** | Bad Request | "Bad request" - La peticion tiene errores |
| **401** | Unauthorized | "Unauthorized" - No estas autenticado |
| **403** | Forbidden | "Forbidden" - No tienes permiso |
| **404** | Not Found | "Not found" - El recurso no existe |
| **405** | Method Not Allowed | "Method not allowed" - Metodo HTTP incorrecto |
| **408** | Request Timeout | "Request timeout" - La peticion tardo demasiado |
| **429** | Too Many Requests | "Too many requests" - Excediste el limite |
| **500** | Internal Server Error | "Internal server error" - Error del servidor |
| **502** | Bad Gateway | "Bad gateway" - El servidor intermedio fallo |
| **503** | Service Unavailable | "Service unavailable" - Servicio no disponible |

### Como hablar de errores HTTP

- "The API is **returning a 404**." (La API esta devolviendo un 404.)
- "I'm getting a **401 Unauthorized** error." (Estoy recibiendo un error 401 no autorizado.)
- "The server is throwing a **500 Internal Server Error**." (El servidor esta lanzando un error 500.)

---

## Errores de Red y Seguridad

### CORS Policy

```
Access to fetch at 'https://api.example.com' from origin 'http://localhost:3000'
has been blocked by CORS policy
```
> "Access to fetch at API dot example dot com from origin localhost three thousand
> has been blocked by CORS policy."

**Significado**: El navegador bloquea la peticion porque el servidor no permite
peticiones desde tu dominio.

**Como describirlo**: "I'm hitting a CORS issue — the server doesn't allow
requests from my domain."

---

### Connection Refused

```
Error: connect ECONNREFUSED 127.0.0.1:5432
```
> "Error: connect, connection refused, one-twenty-seven dot zero dot zero dot one,
> port fifty-four thirty-two."

**Significado**: No se puede conectar al servidor en ese puerto (probablemente esta apagado).

---

## Errores de Memoria y Rendimiento

### Stack Overflow

```
RangeError: Maximum call stack size exceeded
```
> "Range Error: Maximum call stack size exceeded."

**Significado**: Hay una recursion infinita que agoto la pila de llamadas.

**Como describirlo**: "I have a stack overflow — there's probably infinite
recursion somewhere."

---

### Out of Memory

```
FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed - JavaScript heap out of memory
```
> "Fatal error: Allocation failed, JavaScript heap out of memory."

**Significado**: El programa uso demasiada memoria.

---

### Segmentation Fault

```
Segmentation fault (core dumped)
```
> "Segmentation fault, core dumped."

**Significado**: El programa intento acceder a memoria que no le pertenece.
Comun en C/C++.

---

## Errores de Indices y Colecciones

### Index Out of Bounds

```
RangeError: index out of range: index 5, length 3
```
> "Range Error: index out of range, index five, length three."

**Significado**: Intentaste acceder al indice 5 de una coleccion que solo tiene 3 elementos.

**Como describirlo**: "I'm getting an index out of bounds error — I'm accessing
index 5 but the array only has 3 elements."

---

## Vocabulario Clave para Errores

| Termino | Significado |
|---------|-------------|
| **thrown** | Lanzado (un error fue lanzado) |
| **caught** | Atrapado (un error fue atrapado por try-catch) |
| **unhandled** | No manejado (nadie atrapo el error) |
| **stack trace** | Rastro de la pila de llamadas |
| **root cause** | Causa raiz del problema |
| **triggered** | Disparado (que lo causo) |
| **deprecated** | Obsoleto (ya no se recomienda usar) |
| **breaking change** | Cambio que rompe compatibilidad |

---

## Frases para Describir Errores

| Ingles | Espaniol |
|--------|----------|
| "I'm getting an error on line 42." | "Estoy obteniendo un error en la linea 42." |
| "The app crashes when I click submit." | "La app se cae cuando hago clic en enviar." |
| "It throws a TypeError at runtime." | "Lanza un TypeError en tiempo de ejecucion." |
| "The error is reproducible." | "El error es reproducible." |
| "It works locally but fails in production." | "Funciona localmente pero falla en produccion." |
| "I can't reproduce the bug." | "No puedo reproducir el bug." |
| "The stack trace points to line 15." | "El stack trace apunta a la linea 15." |

---

## Consejos para Leer Errores

1. **Lee el tipo de error primero** — te dice la categoria del problema
2. **Lee la descripcion** — te dice exactamente que salio mal
3. **Mira el stack trace** — te dice donde ocurrio
4. **Busca el archivo y linea** — ahorra tiempo
5. **Copia el mensaje exacto** al buscar en Google o Stack Overflow
