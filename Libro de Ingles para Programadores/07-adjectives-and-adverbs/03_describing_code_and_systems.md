# Describing Code and Systems

## Cómo describir código, calidad y rendimiento en inglés

Esta lección combina adjetivos y adverbios para que puedas describir código, sistemas y rendimiento de forma precisa y profesional en code reviews, documentación, reuniones y reportes.

---

## 1. Describir calidad de código

### Código bueno

```text
The code is clean and well-organized.
This function is easy to understand.
The naming conventions are consistent throughout the project.
The error handling is robust and comprehensive.
The architecture is modular and scalable.
```

### Código problemático

```text
The code is messy and hard to follow.
This function is poorly documented.
The variable names are unclear and inconsistent.
The logic is overly complex and tightly coupled.
There's too much duplicated code in this module.
```

---

## 2. Adjetivos compuestos (Compound Adjectives)

Los adjetivos compuestos se forman uniendo dos palabras con un guión. Son muy comunes en inglés técnico.

### Estructura: well/poorly + participio pasado

| Compuesto | Significado | Ejemplo |
|-----------|-------------|---------|
| well-documented | bien documentado | This API is well-documented. |
| well-tested | bien testeado | The module is well-tested. |
| well-structured | bien estructurado | The codebase is well-structured. |
| well-designed | bien diseñado | A well-designed interface. |
| well-maintained | bien mantenido | A well-maintained library. |
| poorly-documented | mal documentado | This function is poorly documented. |
| poorly-designed | mal diseñado | A poorly-designed database schema. |
| poorly-written | mal escrito | Poorly-written error messages. |

### Estructura: sustantivo/adjetivo + sustantivo/adjetivo

| Compuesto | Significado | Ejemplo |
|-----------|-------------|---------|
| high-performance | alto rendimiento | A high-performance database. |
| high-quality | alta calidad | We deliver high-quality code. |
| low-latency | baja latencia | A low-latency connection. |
| real-time | tiempo real | Real-time notifications. |
| open-source | código abierto | An open-source framework. |
| cross-platform | multiplataforma | A cross-platform application. |
| user-friendly | fácil de usar | A user-friendly interface. |
| backward-compatible | retrocompatible | The update is backward-compatible. |
| production-ready | listo para producción | The feature is production-ready. |
| battle-tested | probado en batalla | A battle-tested library. |
| type-safe | seguro en tipos | TypeScript is type-safe. |
| third-party | de terceros | A third-party integration. |

> **Regla del guión:** El guión se usa cuando el adjetivo compuesto va **antes** del sustantivo.
> "A well-documented API" pero "The API is well documented" (sin guión después del verbo).

---

## 3. Describir rendimiento

### Rendimiento positivo

```text
The API responds quickly under heavy load.
The query executes in under 50 milliseconds.
The app handles concurrent requests efficiently.
The system scales horizontally without issues.
The cache significantly improves response times.
```

### Rendimiento negativo

```text
The page loads extremely slowly on mobile devices.
The database query is unnecessarily complex and slow.
The app consumes too much memory.
The server struggles under high traffic.
The response time is unacceptably high.
```

### Vocabulario de rendimiento

| Término | Significado | Ejemplo |
|---------|-------------|---------|
| performant | con buen rendimiento | The app is highly performant. |
| sluggish | lento, perezoso | The UI feels sluggish. |
| snappy | rápido, ágil | The interface feels snappy. |
| bottleneck | cuello de botella | The database is the bottleneck. |
| overhead | sobrecarga | The framework adds too much overhead. |
| throughput | rendimiento / capacidad | The throughput dropped by 30%. |

---

## 4. Describir comportamiento del sistema

```text
The server runs reliably in production.
The application gracefully recovers from errors.
The system intermittently drops connections.
The feature works inconsistently across browsers.
The API consistently returns the correct response.
The process runs silently in the background.
```

### Patrones útiles: Sujeto + verbo + adverbio

| Patrón | Ejemplo |
|--------|---------|
| works + correctly/properly | The function works correctly now. |
| runs + smoothly/reliably | The server runs smoothly. |
| fails + silently/intermittently | The job fails silently. |
| handles + gracefully/poorly | The app handles errors gracefully. |
| scales + horizontally/vertically | The service scales horizontally. |
| loads + quickly/slowly | The page loads quickly. |
| responds + immediately/slowly | The API responds immediately. |

---

## 5. Describir código en code reviews

### Frases de aprobación

```text
This is a clean and elegant solution.
The code is well-structured and easy to follow.
Great use of design patterns here.
The test coverage is comprehensive.
This refactoring significantly improves readability.
```

### Frases de sugerencia

```text
This function is too complex — consider splitting it.
The naming could be more descriptive.
This logic would be clearer with early returns.
The error messages aren't specific enough.
This approach might not be scalable in the long run.
```

### Frases de problema

```text
This introduces a tightly-coupled dependency.
The function has too many responsibilities.
This is a fragile implementation that will break easily.
The code is unnecessarily verbose.
There's no input validation on this endpoint.
```

---

## 6. Orden de adjetivos múltiples

Cuando usamos varios adjetivos, siguen un orden natural en inglés:

```
opinión -> tamaño -> edad -> forma -> color -> origen -> material -> propósito
```

En tech, el orden más común es:

```
opinión -> tamaño/cantidad -> estado/edad -> tipo técnico -> propósito
```

### Ejemplos

```text
A robust, scalable backend architecture.
   (opinión, tipo técnico, propósito)

A simple, lightweight JavaScript library.
   (opinión, tamaño, origen/tipo)

An outdated, poorly-maintained legacy system.
   (estado, opinión, edad)
```

> **Consejo:** En la práctica, no uses más de 2-3 adjetivos seguidos. Si necesitas más, usa oraciones separadas.

---

## 7. Patrones para documentación técnica

### Describir una función

```text
This utility function efficiently converts JSON data
into a typed object. It handles null values gracefully
and throws a descriptive error for invalid input.
```

### Describir un sistema

```text
The notification system is a lightweight, event-driven
microservice that asynchronously processes messages.
It is horizontally scalable and currently handles
approximately 10,000 messages per second.
```

### Describir un bug

```text
The login form intermittently fails on Safari.
When the user submits invalid credentials, the error
message is incorrectly displayed as a success notification.
The issue is consistently reproducible on iOS devices.
```

---

## 8. Frases que deberías memorizar

| Inglés | Español |
|--------|---------|
| The code runs efficiently. | El código se ejecuta eficientemente. |
| This function is poorly documented. | Esta función está mal documentada. |
| The API responds quickly. | La API responde rápidamente. |
| The system is highly scalable. | El sistema es altamente escalable. |
| The implementation is straightforward. | La implementación es directa/sencilla. |
| The solution is overly complex. | La solución es excesivamente compleja. |
| The tests are flaky and unreliable. | Los tests son inestables y poco confiables. |
| The codebase is well-maintained. | El codebase está bien mantenido. |
| The feature is production-ready. | La funcionalidad está lista para producción. |
| The migration was seamless. | La migración fue sin problemas. |

---

## Resumen

| Qué describir | Adjetivos clave | Adverbios clave |
|---------------|----------------|-----------------|
| Calidad | clean, messy, readable, maintainable | well, poorly, clearly |
| Rendimiento | fast, slow, performant, sluggish | quickly, efficiently, slowly |
| Estado | stable, broken, deprecated, outdated | currently, intermittently |
| Comportamiento | reliable, consistent, fragile, flaky | gracefully, silently, reliably |
| Compuestos | well-documented, high-performance, user-friendly | — |
