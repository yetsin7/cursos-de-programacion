# Common Error Types

## Tipos de Errores Comunes en Programacion

Cada lenguaje de programacion tiene su propio conjunto de errores, pero muchos
comparten nombres y conceptos. Aprenderemos los tipos mas comunes, que significan
y como describirlos en ingles.

---

## Errores de Sintaxis

### SyntaxError

**Pronunciacion**: /ˈsɪntæks ˈɛrər/ "SIN-taks E-ror"

**Que significa**: El codigo tiene un error gramatical que impide su ejecucion.

```javascript
// JavaScript
if (x > 5 {  // SyntaxError: Unexpected token '{'
  console.log("hello");
}
```

**Como describirlo**:
- "There's a **syntax error** on line 5 — a missing parenthesis."
- "The parser found an **unexpected token**."
- "I have a **syntax error** because I forgot to close the bracket."

---

## Errores de Tipo

### TypeError

**Pronunciacion**: /taɪp ˈɛrər/ "taip E-ror"

**Que significa**: Intentaste hacer una operacion con un tipo de dato incorrecto.

```javascript
// JavaScript
const name = null;
console.log(name.length); // TypeError: Cannot read property 'length' of null
```

**Como describirlo**:
- "I'm getting a **TypeError** because I'm calling a method on null."
- "The function expects a string but received a number — **type mismatch**."

---

### ReferenceError

**Pronunciacion**: /ˈrɛfərəns ˈɛrər/ "RE-fe-rens E-ror"

**Que significa**: Usaste una variable que no existe en el scope actual.

```javascript
console.log(myVar); // ReferenceError: myVar is not defined
```

**Como describirlo**:
- "There's a **ReferenceError** — the variable is not defined in this scope."

---

### RangeError

**Pronunciacion**: /reɪndʒ ˈɛrər/ "reinch E-ror"

**Que significa**: Un valor esta fuera del rango permitido.

```javascript
const arr = new Array(-1); // RangeError: Invalid array length
```

**Como describirlo**:
- "The value is **out of range** — you can't create an array with negative length."

---

## Errores de Null / Puntero

### NullPointerException

**Pronunciacion**: /nʌl ˈpɔɪntər ɪkˈsɛpʃən/ "nal POIN-ter ek-SEP-shon"

**Que significa**: Intentaste usar un objeto que es `null`.

```java
// Java
String name = null;
int length = name.length(); // NullPointerException
```

**Como describirlo**:
- "I'm getting a **NullPointerException** because the object is null."
- "The variable was **not initialized** before use."
- "We need to add a **null check** before accessing the property."

---

## Errores de Entrada/Salida

### IOException

**Pronunciacion**: /aɪ-oʊ ɪkˈsɛpʃən/ "ai-ou ek-SEP-shon"

**Que significa**: Fallo una operacion de entrada/salida (leer/escribir archivos, red).

**Como describirlo**:
- "An **IO exception** occurred while reading the file."
- "The **input/output operation** failed."

---

### FileNotFoundException

**Pronunciacion**: "fail not faund ek-SEP-shon"

**Que significa**: El archivo que buscas no existe.

```java
// Java
File file = new File("config.txt"); // FileNotFoundException
```

**Como describirlo**:
- "The system can't find the file — **file not found**."
- "The path is incorrect or the file **doesn't exist**."

---

## Errores de Permisos y Red

### PermissionDenied

**Pronunciacion**: /pərˈmɪʃən dɪˈnaɪd/ "per-MI-shon di-NAID"

**Que significa**: No tienes permiso para realizar la operacion.

**Como describirlo**:
- "**Permission denied** — the user doesn't have access to this resource."
- "The app needs **elevated permissions** to write to this directory."

---

### TimeoutError

**Pronunciacion**: /ˈtaɪmaʊt ˈɛrər/ "TAIM-aut E-ror"

**Que significa**: La operacion tardo demasiado y se cancelo.

**Como describirlo**:
- "The request **timed out** after 30 seconds."
- "The server didn't respond within the **timeout period**."

---

### ConnectionRefused

**Pronunciacion**: /kəˈnɛkʃən rɪˈfjuːzd/ "co-NEK-shon ri-FIUSD"

**Que significa**: No se puede establecer conexion con el servidor.

**Como describirlo**:
- "**Connection refused** — the server might be down."
- "I can't connect to the database — **connection refused** on port 5432."

---

## Errores de Memoria

### OutOfMemoryError

**Pronunciacion**: /aʊt ʌv ˈmɛməri/ "aut ov ME-mo-ri"

**Que significa**: El programa uso toda la memoria disponible.

**Como describirlo**:
- "The app crashed with an **out of memory** error."
- "We have a **memory leak** that's causing the app to run out of memory."

---

## Tabla Resumen de Todos los Errores

| Error | Causa | Frase para describirlo |
|-------|-------|----------------------|
| **SyntaxError** | Codigo mal escrito | "There's a syntax error on line X." |
| **TypeError** | Operacion con tipo incorrecto | "Type mismatch — expected string, got number." |
| **ReferenceError** | Variable no definida | "The variable is not defined in this scope." |
| **RangeError** | Valor fuera de rango | "The value is out of range." |
| **NullPointerException** | Usar un objeto null | "Null pointer — the object is null." |
| **IOException** | Fallo de lectura/escritura | "IO error while reading the file." |
| **FileNotFoundException** | Archivo no existe | "File not found at the given path." |
| **PermissionDenied** | Sin permisos | "Permission denied for this operation." |
| **TimeoutError** | Operacion tardo mucho | "The request timed out." |
| **ConnectionRefused** | Servidor no disponible | "Connection refused — server may be down." |
| **OutOfMemoryError** | Memoria agotada | "The app ran out of memory." |

---

## Verbos Comunes para Hablar de Errores

| Verbo | Significado | Ejemplo |
|-------|-------------|---------|
| **to throw** | Lanzar un error | "The function throws a TypeError." |
| **to catch** | Atrapar un error | "Catch the exception in a try-catch block." |
| **to raise** | Levantar/lanzar (Python) | "Raise a ValueError if the input is invalid." |
| **to handle** | Manejar un error | "Handle the error gracefully." |
| **to trigger** | Disparar/causar | "This input triggers a RangeError." |
| **to crash** | Fallar completamente | "The app crashes on startup." |
| **to fail** | Fallar | "The test fails with a timeout error." |
| **to log** | Registrar | "Log the error message for debugging." |

---

## Resumen

Los errores se clasifican en:

- **Sintaxis**: SyntaxError (codigo mal escrito)
- **Tipo**: TypeError, ReferenceError, RangeError
- **Null**: NullPointerException
- **I/O**: IOException, FileNotFoundException
- **Permisos/Red**: PermissionDenied, TimeoutError, ConnectionRefused
- **Memoria**: OutOfMemoryError

Conocer estos nombres y como describirlos te permitira comunicar problemas
tecnicos de forma clara y profesional.
