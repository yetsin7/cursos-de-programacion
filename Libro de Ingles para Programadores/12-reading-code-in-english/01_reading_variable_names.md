# Reading Variable Names

## Como Leer Nombres de Variables en Ingles

Los nombres de variables, funciones y clases siguen convenciones de nomenclatura
especificas. Saber leerlos en voz alta correctamente es esencial para comunicarte
con otros programadores.

---

## Convenciones de Nomenclatura

| Convencion | Formato | Uso tipico |
|-----------|---------|------------|
| **camelCase** | `getUserById` | Variables y funciones (Java, JS, Dart) |
| **snake_case** | `get_user_by_id` | Variables y funciones (Python, Ruby) |
| **PascalCase** | `UserProfile` | Clases y tipos (casi todos los lenguajes) |
| **SCREAMING_SNAKE_CASE** | `MAX_RETRY_COUNT` | Constantes |
| **kebab-case** | `user-profile` | Archivos, URLs, CSS |

---

## Como Leer camelCase

En camelCase, cada palabra nueva empieza con mayuscula. Lee cada palabra por separado.

| Variable | Como se lee en ingles |
|----------|----------------------|
| `getUserById` | "get user by ID" |
| `isAuthenticated` | "is authenticated" |
| `firstName` | "first name" |
| `totalItemCount` | "total item count" |
| `hasPermission` | "has permission" |
| `onButtonPressed` | "on button pressed" |
| `fetchUserData` | "fetch user data" |
| `calculateTotalPrice` | "calculate total price" |
| `shouldRetryRequest` | "should retry request" |
| `handleFormSubmit` | "handle form submit" |

### Prefijos Comunes en camelCase

| Prefijo | Significado | Ejemplo | Lectura |
|---------|-------------|---------|---------|
| `get` | Obtener | `getName` | "get name" |
| `set` | Establecer | `setName` | "set name" |
| `is` | Es (booleano) | `isValid` | "is valid" |
| `has` | Tiene (booleano) | `hasChildren` | "has children" |
| `can` | Puede (booleano) | `canEdit` | "can edit" |
| `should` | Deberia (booleano) | `shouldUpdate` | "should update" |
| `on` | Cuando / evento | `onClick` | "on click" |
| `handle` | Manejar | `handleError` | "handle error" |
| `fetch` | Obtener (de red) | `fetchData` | "fetch data" |
| `create` | Crear | `createUser` | "create user" |
| `update` | Actualizar | `updateProfile` | "update profile" |
| `delete` | Eliminar | `deleteItem` | "delete item" |

---

## Como Leer snake_case

En snake_case, las palabras se separan con guion bajo. Lee cada palabra por separado,
ignorando los guiones bajos.

| Variable | Como se lee |
|----------|-------------|
| `get_user_by_id` | "get user by ID" |
| `is_authenticated` | "is authenticated" |
| `max_retry_count` | "max retry count" |
| `total_item_count` | "total item count" |
| `database_connection` | "database connection" |
| `file_not_found` | "file not found" |

---

## Como Leer PascalCase

PascalCase es igual que camelCase pero la primera letra tambien es mayuscula.
Se usa para nombres de clases y tipos.

| Clase | Como se lee |
|-------|-------------|
| `UserProfile` | "User Profile" |
| `HttpRequest` | "HTTP Request" |
| `DatabaseManager` | "Database Manager" |
| `ShoppingCartItem` | "Shopping Cart Item" |
| `AuthenticationService` | "Authentication Service" |
| `FileNotFoundException` | "File Not Found Exception" |

---

## Como Leer SCREAMING_SNAKE_CASE

Se usa para constantes. Lee cada palabra, ignorando los guiones bajos.

| Constante | Como se lee |
|-----------|-------------|
| `MAX_RETRY_COUNT` | "max retry count" |
| `API_BASE_URL` | "API base URL" |
| `DEFAULT_TIMEOUT` | "default timeout" |
| `HTTP_STATUS_OK` | "HTTP status OK" |
| `DATABASE_HOST` | "database host" |
| `MIN_PASSWORD_LENGTH` | "min password length" |

---

## Como Leer kebab-case

Se usa en archivos, URLs y clases CSS. Lee cada palabra, ignorando los guiones.

| Nombre | Como se lee |
|--------|-------------|
| `user-profile` | "user profile" |
| `my-component` | "my component" |
| `dark-mode-toggle` | "dark mode toggle" |
| `api-response-handler` | "API response handler" |

---

## Abreviaciones Comunes en Nombres

| Abreviacion | Significado | Lectura |
|-------------|-------------|---------|
| `id` | Identifier | "ID" (ai-di) |
| `db` | Database | "database" o "D-B" |
| `btn` | Button | "button" |
| `msg` | Message | "message" |
| `err` | Error | "error" |
| `req` | Request | "request" |
| `res` | Response | "response" |
| `auth` | Authentication | "auth" o "authentication" |
| `config` | Configuration | "config" |
| `temp` | Temporary | "temp" |
| `num` | Number | "number" |
| `str` | String | "string" |
| `val` | Value | "value" |
| `idx` | Index | "index" |
| `len` | Length | "length" |
| `fn` | Function | "function" |
| `cb` | Callback | "callback" |
| `ctx` | Context | "context" |
| `env` | Environment | "environment" |
| `impl` | Implementation | "implementation" |

---

## Patrones de Nombres Comunes

### Funciones de conversion
- `toString` → "to string" (convertir a cadena)
- `toJson` → "to JSON" (convertir a JSON)
- `fromMap` → "from map" (crear desde un mapa)
- `parseFloat` → "parse float" (analizar como decimal)

### Variables de estado
- `isLoading` → "is loading" (esta cargando)
- `hasError` → "has error" (tiene error)
- `canSubmit` → "can submit" (puede enviar)
- `wasDeleted` → "was deleted" (fue eliminado)

### Handlers de eventos
- `onTap` → "on tap" (al tocar)
- `onChanged` → "on changed" (al cambiar)
- `handleSubmit` → "handle submit" (manejar envio)
- `didUpdateWidget` → "did update widget" (el widget se actualizo)

---

## Consejos Practicos

1. **Separa las palabras mentalmente** antes de leer en voz alta
2. **Las abreviaciones** se pueden leer como la palabra completa o como siglas
3. **No leas los guiones** ni guiones bajos, solo las palabras
4. **Practica** leyendo el codigo de proyectos open source en voz alta
5. **Los acronimos** como HTTP, API, URL se leen como siglas (letra por letra o como palabra)
