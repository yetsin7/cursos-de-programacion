# Exercises: Reading Documentation, RFCs, and Changelogs

## Ejercicio 1: Navegando documentacion oficial

Lee el siguiente fragmento de documentacion y responde las preguntas:

```
### fetch(url, options?)

Fetches a resource from the network.

Parameters:
| Name    | Type    | Required | Default | Description                  |
|---------|---------|----------|---------|------------------------------|
| url     | string  | Yes      | -       | The URL to fetch             |
| options | object  | No       | {}      | Configuration options        |

Options:
| Name    | Type    | Default | Description                      |
|---------|---------|---------|----------------------------------|
| method  | string  | 'GET'   | HTTP method                      |
| headers | object  | {}      | Request headers                  |
| body    | any     | null    | Request body                     |
| timeout | number  | 30000   | Timeout in ms                    |
| retry   | number  | 0       | Number of retry attempts         |

Returns: Promise<Response>

Throws:
- TimeoutError: If the request exceeds the timeout
- NetworkError: If no network connection is available

> **Warning:** The `retry` option is experimental and MAY be
> removed in future versions.

> **Deprecated:** Using a number as the first argument is
> deprecated. Use a string URL instead.

See also: Request, Response, Headers
```

**Preguntas:**

1. Cuales son los parametros obligatorios?
2. Cual es el timeout por defecto?
3. Que significa la advertencia sobre `retry`?
4. Que esta marcado como deprecated?
5. Que errores puede lanzar esta funcion?

---

## Ejercicio 2: Palabras clave de RFC 2119

Clasifica las siguientes oraciones segun su nivel de obligacion:

1. "The server MUST return a 200 status code on success."
2. "Clients SHOULD include a User-Agent header."
3. "The implementation MAY support gzip compression."
4. "Servers MUST NOT modify the request body."
5. "It is RECOMMENDED that connections use TLS."
6. "The timeout value is OPTIONAL."
7. "Implementations SHALL support UTF-8 encoding."
8. "Clients SHOULD NOT send credentials in query parameters."

Escribe tu respuesta en esta tabla:

| # | Nivel de obligacion | Justificacion |
|---|---------------------|---------------|
| 1 | ___ | ___ |
| 2 | ___ | ___ |
| 3 | ___ | ___ |
| 4 | ___ | ___ |
| 5 | ___ | ___ |
| 6 | ___ | ___ |
| 7 | ___ | ___ |
| 8 | ___ | ___ |

---

## Ejercicio 3: Interpretando un changelog

Lee el siguiente changelog y responde:

```markdown
## [3.0.0] - 2025-06-01

### Breaking Changes
- Dropped support for Node.js 16
- `createClient()` now requires a configuration object instead
  of positional arguments
- Removed deprecated `v1` API endpoints

### Added
- New streaming API for real-time data
- TypeScript type definitions included by default
- Dark mode support in the admin panel

### Changed
- Default timeout increased from 5000ms to 10000ms
- Error messages now include request IDs

### Deprecated
- `legacyMode` option will be removed in v4.0

### Fixed
- Memory leak when handling large file uploads
- Race condition in concurrent database queries

### Security
- Patched CVE-2025-5678 in XML parser
```

**Preguntas:**

1. Es seguro actualizar directamente desde v2.x? Por que?
2. Que debes cambiar en tu codigo si usas `createClient()`?
3. Hay alguna actualizacion de seguridad urgente?
4. Que funcionalidad deberias dejar de usar ahora?
5. Cual es la version minima de Node.js requerida?

---

## Ejercicio 4: Semantic Versioning

Determina que tipo de bump (MAJOR, MINOR o PATCH) corresponde a cada cambio:

| Cambio | Tipo de bump |
|--------|-------------|
| Corregir un typo en un mensaje de error | ___ |
| Agregar un nuevo endpoint a la API | ___ |
| Cambiar el tipo de retorno de una funcion publica | ___ |
| Mejorar el rendimiento de una consulta SQL | ___ |
| Eliminar un parametro de una funcion | ___ |
| Agregar soporte para un nuevo formato de archivo | ___ |
| Cambiar el nombre de un metodo publico | ___ |
| Corregir un calculo incorrecto | ___ |
| Subir la version minima de Node.js | ___ |
| Agregar un parametro opcional a una funcion | ___ |

---

## Ejercicio 5: Traduccion de secciones de documentacion

Traduce las siguientes secciones al espanol manteniendo el significado tecnico:

1. "This method is idempotent and can be called multiple times without side effects."

2. "Out of the box, the framework provides server-side rendering with zero configuration."

3. "This feature has been deprecated since v2.3 and will be removed in the next major release."

4. "The library ships with TypeScript definitions and works with any bundler that supports ESM."

5. "Under the hood, the ORM uses connection pooling to optimize database performance."

---

## Ejercicio 6: Lectura rapida de documentacion

Tienes los siguientes problemas. Que seccion de la documentacion consultarias primero?

| Problema | Seccion a consultar |
|----------|-------------------|
| Quieres usar la libreria por primera vez | ___ |
| Tu codigo dejo de funcionar despues de actualizar | ___ |
| Necesitas saber los parametros de un metodo | ___ |
| Quieres saber si hay una funcion para algo especifico | ___ |
| Tienes un error que no entiendes | ___ |
| Quieres ver un ejemplo completo de un feature | ___ |
| Necesitas actualizar de v2 a v3 | ___ |
| Quieres saber que cambio en la ultima version | ___ |

---

## Ejercicio 7: Escritura de changelog

Escribe entradas de changelog en ingles para estos cambios:

1. Agregaste autenticacion con Google OAuth
2. Corregiste un bug donde los usuarios no podian cambiar su email
3. Eliminaste el soporte para Internet Explorer
4. Mejoraste la velocidad de carga de imagenes en un 50%
5. Marcaste el endpoint `/api/v1/users` como obsoleto

Usa el formato Keep a Changelog:

```markdown
### Added
- ___

### Fixed
- ___

### Removed
- ___

### Changed
- ___

### Deprecated
- ___
```

---

## Ejercicio 8: Leyendo un fragmento de RFC

Lee el siguiente fragmento del RFC 6455 (WebSocket) y responde:

```
The client MUST include the |Host| header field in the opening
handshake.  If the client is connecting to an HTTP proxy, the host
SHOULD be the host of the resource being requested.

The client MAY include additional headers such as |Origin|.

The server MUST close the connection if the |Sec-WebSocket-Key|
header is missing.  The server SHOULD NOT accept connections from
origins that are not explicitly allowed.
```

1. Es obligatorio incluir el header `Host`?
2. Es obligatorio incluir el header `Origin`?
3. Que debe hacer el servidor si falta `Sec-WebSocket-Key`?
4. Puede el servidor aceptar conexiones de cualquier origen?

---

## Respuestas

<details>
<summary>Click para ver las respuestas</summary>

**Ejercicio 1:**
1. Solo `url` (Required: Yes)
2. 30000 ms (30 segundos)
3. Es experimental y podria ser eliminado en versiones futuras
4. Usar un numero como primer argumento (debe ser string URL)
5. TimeoutError y NetworkError

**Ejercicio 2:**
1. 100% requerido (MUST)
2. Fuertemente recomendado (SHOULD)
3. Opcional (MAY)
4. 100% prohibido (MUST NOT)
5. Fuertemente recomendado (RECOMMENDED = SHOULD)
6. Opcional (OPTIONAL = MAY)
7. 100% requerido (SHALL = MUST)
8. Fuertemente desaconsejado (SHOULD NOT)

**Ejercicio 3:**
1. No es seguro directamente. Hay breaking changes (Node.js 16 dropped, createClient API changed, v1 endpoints removed). Debes seguir la guia de migracion.
2. Cambiar de argumentos posicionales a un objeto de configuracion.
3. Si, CVE-2025-5678 en el parser XML.
4. `legacyMode` option (sera removido en v4.0).
5. Node.js 18 (16 fue eliminado).

**Ejercicio 4:**
1. PATCH, 2. MINOR, 3. MAJOR, 4. PATCH, 5. MAJOR, 6. MINOR, 7. MAJOR, 8. PATCH, 9. MAJOR, 10. MINOR

**Ejercicio 6:**
1. Getting Started, 2. Migration Guide / Changelog, 3. API Reference, 4. API Reference, 5. Troubleshooting / FAQ, 6. Examples / Cookbook, 7. Migration Guide, 8. Changelog / What's New

**Ejercicio 8:**
1. Si, MUST = obligatorio
2. No, MAY = opcional
3. MUST close the connection (obligatorio cerrar)
4. Tecnicamente si, pero SHOULD NOT = fuertemente desaconsejado

</details>
