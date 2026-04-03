# Writing Documentation

## Como Escribir Documentacion Tecnica en Ingles

La documentacion tecnica bien escrita es lo que diferencia un proyecto profesional
de uno amateur. Existen cuatro tipos principales de documentacion, cada uno con
un proposito y estilo diferente.

---

## Los 4 Tipos de Documentacion

| Tipo | Proposito | Orientacion |
|------|----------|-------------|
| **Tutorial** | Ensenar paso a paso | Aprendizaje guiado |
| **How-to Guide** | Resolver un problema especifico | Orientado a tareas |
| **Reference** | Describir la API o sistema | Informacion tecnica |
| **Explanation** | Explicar conceptos y decisiones | Comprension profunda |

---

## 1. Tutorials (Tutoriales)

Los tutoriales guian al lector paso a paso para completar un proyecto o tarea.

### Estructura

```markdown
# Build Your First REST API with Express

## What You'll Learn
- How to set up an Express server
- How to create CRUD endpoints
- How to connect to a database

## Prerequisites
- Node.js v18 or higher
- Basic JavaScript knowledge

## Step 1: Set Up the Project
First, create a new directory and initialize the project:
```

### Frases clave para tutoriales

| Ingles | Uso |
|--------|-----|
| "In this tutorial, you will learn how to..." | Introduccion |
| "By the end of this tutorial, you will be able to..." | Objetivos |
| "First, let's..." | Iniciar un paso |
| "Next, we need to..." | Siguiente paso |
| "You should see..." | Verificacion |
| "If everything went well, you should now have..." | Confirmacion |
| "Let's move on to..." | Transicion |
| "Congratulations! You've successfully..." | Cierre |

### Tono y estilo

- Usa **segunda persona**: "you" (tu), no "we" (nosotros)
- Se **amigable** pero profesional
- Incluye **resultados esperados** en cada paso
- **No asumas conocimiento previo** a menos que lo declares en prerequisites

---

## 2. How-to Guides (Guias Practicas)

Las guias practicas resuelven un problema especifico. Son mas directas que los tutoriales.

### Estructura

```markdown
# How to Add Authentication to Your API

## Overview
This guide shows you how to implement JWT-based authentication.

## Steps

### 1. Install Dependencies
```bash
npm install jsonwebtoken bcrypt
```

### 2. Create the Auth Middleware
Create a new file `middleware/auth.js`:
```

### Frases clave para guias

| Ingles | Uso |
|--------|-----|
| "This guide shows you how to..." | Introduccion |
| "To accomplish this, you need to..." | Requisitos |
| "Run the following command:" | Instruccion de terminal |
| "Create a new file called..." | Crear archivo |
| "Add the following code to..." | Agregar codigo |
| "Make sure to replace `X` with your own value." | Personalizacion |
| "If you encounter [error], try..." | Troubleshooting |

---

## 3. Reference Documentation (Documentacion de Referencia)

La referencia describe la API o sistema de forma tecnica y precisa.
No ensenia, solo informa.

### Estructura para una API

```markdown
# User API Reference

## Endpoints

### GET /api/users

Retrieve a list of all users.

**Parameters:**

| Name     | Type   | Required | Description           |
|----------|--------|----------|-----------------------|
| `page`   | number | No       | Page number (default: 1) |
| `limit`  | number | No       | Results per page (default: 20) |

**Response:**

```json
{
  "data": [
    { "id": 1, "name": "Alice", "email": "alice@example.com" }
  ],
  "total": 42,
  "page": 1
}
```

**Status Codes:**

| Code | Description |
|------|-------------|
| 200  | Success     |
| 401  | Unauthorized |
| 500  | Internal Server Error |
```

### Frases clave para referencia

| Ingles | Uso |
|--------|-----|
| "Returns..." | Valor de retorno |
| "Accepts..." | Parametros que recibe |
| "Required." / "Optional." | Si es obligatorio |
| "Defaults to..." | Valor por defecto |
| "Throws [Error] if..." | Errores posibles |
| "Available since version..." | Version |
| "See also: [related]" | Referencias cruzadas |
| "Type: `string`" | Tipo del parametro |

---

## 4. Explanations (Explicaciones)

Las explicaciones profundizan en el por que de las decisiones tecnicas.

### Estructura

```markdown
# Understanding Our Authentication Architecture

## Why JWT?
We chose JWT tokens over session-based authentication for
several reasons:

1. **Stateless**: No need to store sessions on the server.
2. **Scalable**: Works across multiple server instances.
3. **Mobile-friendly**: Easy to use in mobile apps.

## How It Works
When a user logs in, the server generates a token...

## Trade-offs
The main trade-off with JWT is that tokens cannot be
invalidated before they expire...
```

### Frases clave para explicaciones

| Ingles | Uso |
|--------|-----|
| "The reason we chose X over Y is..." | Justificar decisiones |
| "This approach has the advantage of..." | Ventajas |
| "The trade-off is..." | Compromisos |
| "Under the hood, this works by..." | Mecanismo interno |
| "It's important to understand that..." | Punto clave |
| "This is different from X because..." | Diferencias |

---

## Estilo y Tono General

### Reglas de estilo

1. **Voz activa**: "The function returns a list" (no "A list is returned")
2. **Segunda persona**: "You can configure..." (no "One can configure...")
3. **Presente simple**: "This method creates..." (no "This method will create...")
4. **Oraciones cortas**: Maximo 20-25 palabras por oracion
5. **Un parrafo = una idea**: No mezcles temas

### Palabras a evitar

| Evitar | Usar en su lugar |
|--------|-----------------|
| "simply" / "just" | (omitir - minimiza la dificultad) |
| "obviously" | (omitir - si fuera obvio, no necesitaria documentacion) |
| "easy" / "straightforward" | (omitir - es subjetivo) |
| "etc." | Lista los elementos especificos |
| "stuff" / "things" | Nombra los elementos concretos |

---

## Resumen

1. **Tutoriales**: guian paso a paso, tono amigable, segunda persona
2. **How-to guides**: resuelven problemas especificos, directos al punto
3. **Reference**: describe la API, tecnico y preciso, sin narrativa
4. **Explanations**: explican el por que, profundidad conceptual
5. Siempre usa **voz activa**, **presente simple** y **segunda persona**
