# Chapter 13: Exercises

## Ejercicios de Escritura de Comentarios y Documentacion

---

## Ejercicio 1: Mejora los Comentarios

Reescribe estos malos comentarios para que sean utiles.

**1. Comentario redundante:**
```javascript
// Set name to "John"
const name = "John";
```

**2. Comentario vago:**
```python
# Do the thing
process_data(items)
```

**3. Comentario desactualizado:**
```javascript
// Returns the user's email
function getUserName(id) {
  return database.findUser(id).name;
}
```

<details>
<summary>Respuestas Sugeridas</summary>

1. Eliminar el comentario (el codigo es autoexplicativo) o agregar contexto:
   `// Default name used when the user hasn't set a display name`

2. `# Process raw items into normalized format for the analytics pipeline`

3. Actualizar: `// Returns the user's display name from the database`
</details>

---

## Ejercicio 2: Escribe Mensajes de Commit

Escribe un mensaje de commit en formato Conventional Commits para cada situacion.

1. Agregaste un boton de modo oscuro en la pagina de configuracion.
2. Corregiste un bug donde el carrito mostraba precios negativos.
3. Actualizaste el README con instrucciones de instalacion.
4. Reorganizaste el codigo del servicio de autenticacion sin cambiar funcionalidad.
5. Agregaste tests para el flujo de registro de usuarios.

<details>
<summary>Respuestas Sugeridas</summary>

1. `feat(settings): add dark mode toggle button`
2. `fix(cart): prevent negative prices in cart total`
3. `docs(readme): add installation instructions`
4. `refactor(auth): reorganize authentication service structure`
5. `test(auth): add unit tests for user registration flow`
</details>

---

## Ejercicio 3: Escribe JSDoc

Escribe la documentacion JSDoc completa para esta funcion.

```javascript
function filterActiveUsers(users, minAge) {
  return users.filter(u => u.isActive && u.age >= minAge);
}
```

<details>
<summary>Respuesta Sugerida</summary>

```javascript
/**
 * Filter users that are active and meet the minimum age requirement.
 *
 * @param {Array<User>} users - The list of users to filter.
 * @param {number} minAge - The minimum age threshold.
 * @returns {Array<User>} Active users who are at least minAge years old.
 *
 * @example
 * const adults = filterActiveUsers(allUsers, 18);
 */
```
</details>

---

## Ejercicio 4: Escribe una Seccion de README

Escribe la seccion "Getting Started" para un proyecto ficticio llamado
**QuickNotes** (una app de notas que usa Flutter y Supabase).

Incluye: Prerequisites, Installation (al menos 4 pasos), y un ejemplo de uso.

<details>
<summary>Estructura Sugerida</summary>

```markdown
## Getting Started

### Prerequisites
- Flutter SDK (3.19 or higher)
- Dart SDK (3.3 or higher)
- A Supabase account

### Installation

1. Clone the repository:
   git clone https://github.com/user/quicknotes.git

2. Navigate to the project:
   cd quicknotes

3. Install dependencies:
   flutter pub get

4. Configure Supabase credentials:
   cp .env.example .env
   # Add your Supabase URL and anon key

5. Run the app:
   flutter run

### Usage
Open the app and tap the "+" button to create your first note.
```
</details>

---

## Ejercicio 5: Identifica el Tipo de Documentacion

Indica si cada ejemplo es un **Tutorial**, **How-to Guide**, **Reference**, o **Explanation**.

1. "Step 1: Create a new Flutter project. Step 2: Add the dependencies..."
2. "GET /api/products — Returns a list of products. Parameters: page, limit..."
3. "We chose SQLite over PostgreSQL because the app runs offline..."
4. "How to deploy your app to Google Play Store"
5. "Build your first REST API from scratch in 30 minutes"

<details>
<summary>Respuestas</summary>

1. Tutorial
2. Reference
3. Explanation
4. How-to Guide
5. Tutorial
</details>

---

## Ejercicio 6: Corrige los Mensajes de Commit

Reescribe estos mensajes de commit incorrectos.

1. `"fixed bug"` →
2. `"Updated stuff"` →
3. `"Added new feature for users to login with Google and also fixed the bug where the cart was showing wrong prices and updated the README"` →
4. `"WIP"` →
5. `"changes"` →

<details>
<summary>Respuestas Sugeridas</summary>

1. `fix(auth): resolve login failure on expired session`
2. `update(config): adjust database connection timeout`
3. Dividir en 3 commits:
   - `feat(auth): add Google OAuth login`
   - `fix(cart): correct price calculation`
   - `docs(readme): update setup instructions`
4. No hacer commit de trabajo incompleto. Si es necesario: `feat(search): add initial search bar component (WIP)`
5. `refactor(api): simplify error handling in user controller`
</details>

---

## Ejercicio 7: Escribe Anotaciones

Escribe el comentario apropiado usando TODO, FIXME, HACK, o NOTE para cada situacion.

1. Una funcion que todavia no valida el email del usuario.
2. Un setTimeout que se usa como solucion temporal para un problema de timing.
3. Un endpoint que requiere autenticacion y es facil olvidarlo.
4. Un calculo que da resultados incorrectos con numeros negativos.

<details>
<summary>Respuestas Sugeridas</summary>

1. `// TODO: Add email format validation before saving`
2. `// HACK: Using setTimeout to wait for DOM update — replace with proper event listener`
3. `// NOTE: This endpoint requires a valid JWT token in the Authorization header`
4. `// FIXME: Returns incorrect results when input values are negative`
</details>

---

## Ejercicio 8: Redaccion Tecnica

Reescribe estas oraciones siguiendo las reglas de buena documentacion tecnica
(voz activa, segunda persona, presente simple).

1. "The configuration file will be created by the system." →
2. "We can see that the function is returning an error." →
3. "It is recommended that the user should restart the server." →
4. "The data was processed by the pipeline and results were stored." →

<details>
<summary>Respuestas</summary>

1. "The system creates the configuration file." o "Create the configuration file."
2. "The function returns an error."
3. "Restart the server."
4. "The pipeline processes the data and stores the results."
</details>
