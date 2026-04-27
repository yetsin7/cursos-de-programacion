# Lesson 01: Reading Official Documentation

## Introducción

La documentación oficial es tu mejor amiga como programador. Aprender a navegar y leer documentación en ingles te ahorra horas de busqueda en Stack Overflow y te da información precisa y actualizada directamente de los creadores de la tecnología.

---

## secciones comúnes en la documentación oficial

Casi toda documentación técnica sigue una estructura similar. Conocerla te permite encontrar lo que necesitas rápidamente.

| Sección en ingles | Significado | Que encontraras |
|-------------------|-------------|-----------------|
| **Getting Started** | Primeros pasos | Instalacion, configuración básica, primer ejemplo |
| **Quick Start** | Inicio rápido | Versión condensada de Getting Started |
| **API Reference** | Referencia de API | Lista completa de funciones, clases, métodos |
| **Guides** | Guías | Tutoriales tematicos para tareas especificas |
| **Tutorials** | Tutoriales | Proyectos paso a paso para aprender |
| **Migration Guide** | Guía de migración | Como actualizar de una versión a otra |
| **Changelog** | Registro de cambios | Lista de cambios entre versiones |
| **FAQ** | Preguntas frecuentes | Respuestas a dudas comúnes |
| **Troubleshooting** | Solución de problemas | Errores comúnes y como resolverlos |
| **Examples** | Ejemplos | Código de ejemplo funcional |
| **Cookbook** | Recetario | soluciones a problemas especificos |
| **Concepts** | Conceptos | explicaciones teoricas de la arquitectura |

---

## Navegando la API Reference

La referencia de API es donde pasaras mas tiempo. Aprende a leer sus patrones comúnes.

### Tabla de parametros (Parameters Table)

```
Parameters:
| Name     | Type     | Required | Default | Description                    |
|----------|----------|----------|---------|--------------------------------|
| url      | string   | Yes      | -       | The URL to fetch               |
| method   | string   | No       | 'GET'   | The HTTP method to use         |
| headers  | object   | No       | {}      | Custom headers for the request |
| body     | any      | No       | null    | The request body               |
| timeout  | number   | No       | 5000    | Timeout in milliseconds        |
```

**Vocabulario clave en tablas de parametros:**

| Término | Significado |
|---------|-------------|
| **Required** | Obligatorio |
| **Optional** | Opcional |
| **Default** | Valor por defecto |
| **Type** | Tipo de dato |
| **Description** | Descripción |
| **Deprecated** | Obsoleto, no usar en código nuevo |
| **Since** | Desde que versión esta disponible |
| **Returns** | Que devuelve |
| **Throws** | Que errores puede lanzar |

### Valores de retorno (Return Values)

```
Returns: Promise<Response>

The response object contains:
- status (number): The HTTP status code
- data (object): The parsed response body
- headers (Headers): The response headers

Throws:
- TimeoutError: If the request exceeds the timeout
- NetworkError: If the network is unreachable
```

---

## Patrones comúnes en la documentación

### 1. Nota de advertencia (Warning/Caution)

```
> **Warning:** This method mutates the original array.

> **Note:** This feature requires Node.js 18 or later.

> **Tip:** You can also use the shorthand syntax.

> **Caution:** This is a breaking change in v3.0.
```

| Etiqueta | Significado | Nivel de importancia |
|----------|-------------|---------------------|
| **Note** | Nota informativa | Bajo |
| **Tip** | Consejo útil | Bajo |
| **Important** | Información importante | Medio |
| **Warning** | Advertencia | Alto |
| **Caution** | Precaución | Alto |
| **Danger** | Peligro | Muy alto |
| **Deprecated** | Obsoleto | Alto |

### 2. "See also" (Ver también)

```
See also:
- Array.prototype.map()
- Array.prototype.filter()
- Working with Arrays guide
```

Esta sección te dirige a contenido relacionado. Es muy útil para descubrir métodos o funciones que no conocias.

### 3. Bloques de código con contexto

```
// Basic usage
const result = await fetch('/api/users');

// With options
const result = await fetch('/api/users', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ name: 'John' })
});
```

Los comentarios `// Basic usage` y `// With options` son patrones comunes que indican nivel de complejidad.

---

## Técnicas de lectura rápida para documentación

### Estrategia 1: Escaneo por estructura (Scanning)

No leas toda la documentación de principio a fin. En su lugar:

1. **Lee los titulos** (headings) para entender la estructura
2. **Busca la sección relevante** a tu problema
3. **Lee los ejemplos de código** primero, luego el texto explicativo
4. **Revisa la tabla de parametros** para entender las opciones

### Estrategia 2: Busqueda por palabras clave (Keyword Search)

Usa `Ctrl+F` (o `Cmd+F`) con estas palabras clave:

| Si necesitas... | Busca... |
|-----------------|----------|
| Como instalar | `install`, `setup`, `getting started` |
| Un método especifico | El nombre del método |
| Configuracion | `config`, `configuration`, `options` |
| Errores | `error`, `troubleshooting`, `common issues` |
| Ejemplos | `example`, `usage`, `sample` |
| Migracion | `migration`, `upgrade`, `breaking` |
| Rendimiento | `performance`, `optimization`, `best practices` |

### Estrategia 3: Leer el código de ejemplo primero

Los programadores experimentados leen los ejemplos de código **antes** del texto explicativo. El código es a menudo mas claro que la explicación en prosa.

```python
# Ejemplo de la documentacion de requests
import requests

# En lugar de leer 3 parrafos, este ejemplo te muestra todo:
response = requests.get('https://api.example.com/users', 
                        params={'page': 1, 'limit': 10},
                        headers={'Authorization': 'Bearer token123'},
                        timeout=30)
print(response.json())
```

### Estrategia 4: Versión comparison (Comparar versiones)

Cuando actualizas una libreria, busca estas secciones:

- **"What's New"** - Lo nuevo en esta versión
- **"Breaking Changes"** - Cambios que rompen compatibilidad
- **"Migration Guide"** - Guía paso a paso para actualizar
- **"Deprecated"** - Funcionalidades que seran eliminadas

---

## Frases comúnes en documentación

| Frase en ingles | Significado práctico |
|-----------------|---------------------|
| "This method is **idempotent**" | Puedes llamarlo multiples veces sin efectos secundarios |
| "**Under the hood**" | Internamente, lo que pasa detras de escena |
| "This is a **convenience method**" | Es un atajo para algo mas complejo |
| "**Out of the box**" | Funciona sin configuración adicional |
| "This is **opinionated**" | Tiene decisiones de diseno fuertes |
| "**Side effects** may include..." | Efectos secundarios que debes considerar |
| "This will be **removed** in the next major versión" | Deja de usar esto pronto |
| "**Opt-in** feature" | Debes activarlo manualmente |
| "**Opt-out**" | Viene activado, puedes desactivarlo |
| "**Batteries included**" | Viene con todo lo necesario |
| "Use at your **own risk**" | No hay garantias, puede fallar |
| "This is an **experimental** feature" | Puede cambiar o ser eliminada |

---

## Tipos de documentación por framework

| Framework/Libreria | Estilo de docs | Donde empezar |
|---------------------|---------------|---------------|
| React | Tutoriales interactivos | "Learn React" section |
| Vue | Guías progresivas | "Guide" -> "Essentials" |
| Django | Documentación muy completa | "First steps" tutorial |
| Flutter | Cookbooks + API reference | "Get started" -> "Codelabs" |
| Node.js | API reference técnica | Directamente en la API ref |
| Python | PEPs + stdlib docs | "Tutorial" section |

---

## Vocabulario esencial

| Palabra | Pronunciacion aproximada | Significado |
|---------|--------------------------|-------------|
| **Documentation** | doc-yu-men-TEI-shon | Documentación |
| **Reference** | RE-fer-ens | Referencia |
| **Specification** | spe-si-fi-KEI-shon | Especificacion |
| **Implementation** | im-ple-men-TEI-shon | Implementación |
| **Deprecated** | DE-pre-kei-ted | Obsoleto |
| **Comprehensive** | com-pri-JEN-siv | Completo, exhaustivo |
| **Straightforward** | streit-FOR-ward | Directo, sencillo |
| **Boilerplate** | BOI-ler-pleit | Código repetitivo necesario |
| **Scaffold** | SKA-fold | Estructura base de un proyecto |
| **Verbose** | ver-BOUS | Detallado, con mucho texto |

---

## Resumen

- La documentación oficial sigue patrones predecibles que puedes aprender a reconocer
- Lee los ejemplos de código primero, luego el texto explicativo
- Usa busqueda por palabras clave para encontrar lo que necesitas rápidamente
- Conoce las secciones clave: Getting Started, API Reference, Guides, Migration Guide
- Presta atencion a las notas de Warning, Deprecated y Breaking Changes
