# Reading Code Aloud

## Como Leer Codigo en Voz Alta en Ingles

Cuando participas en pair programming, code reviews o entrevistas, necesitas poder
leer codigo en voz alta de manera clara y comprensible. Esta leccion te ensenara
como pronunciar cada estructura, operador y simbolo.

---

## Estructuras de Control

### if / else

```javascript
if (x > 5) {
  return true;
}
```
> "If x is greater than five, return true."

```javascript
if (user != null && user.isActive) {
  doSomething();
} else {
  handleError();
}
```
> "If user is not null and user dot is-active, do something. Else, handle error."

### Operador ternario

```javascript
const status = isActive ? "on" : "off";
```
> "Const status equals is-active question mark on colon off."
> O mas natural: "Set status to on if is-active, otherwise off."

---

### for loops

```java
for (int i = 0; i < n; i++) {
  process(items[i]);
}
```
> "For int i equals zero, i less than n, i plus-plus: process items at index i."

```python
for item in items:
    print(item)
```
> "For item in items: print item."

```javascript
items.forEach(item => console.log(item));
```
> "Items dot for-each, item arrow console dot log item."

---

### while loops

```javascript
while (count > 0) {
  count--;
}
```
> "While count is greater than zero, count minus-minus."

---

### switch / case

```dart
switch (status) {
  case 'active':
    return true;
  default:
    return false;
}
```
> "Switch on status: case active, return true. Default, return false."

---

## Funciones y Metodos

```javascript
function calculateTotal(items, tax) {
  return items.reduce((sum, item) => sum + item.price, 0) * (1 + tax);
}
```
> "Function calculate-total takes items and tax. Return items dot reduce,
> sum comma item arrow sum plus item dot price, starting at zero,
> times one plus tax."

```dart
Future<List<User>> fetchUsers() async {
  final response = await http.get(url);
  return parseUsers(response.body);
}
```
> "Future of list of User, fetch-users, async. Final response equals await
> HTTP dot get URL. Return parse-users of response dot body."

---

## Operadores: Como Leerlos

### Operadores de Comparacion

| Operador | Como se lee en ingles |
|----------|----------------------|
| `==` | "equals" o "is equal to" |
| `!=` | "is not equal to" o "not equals" |
| `>` | "is greater than" |
| `<` | "is less than" |
| `>=` | "is greater than or equal to" |
| `<=` | "is less than or equal to" |
| `===` | "is strictly equal to" (triple equals) |
| `!==` | "is strictly not equal to" |

### Operadores Logicos

| Operador | Como se lee |
|----------|-------------|
| `&&` | "and" (double ampersand) |
| `\|\|` | "or" (double pipe) |
| `!` | "not" (bang / exclamation) |
| `??` | "null coalescing" o "if null" |
| `?.` | "null-safe" o "optional chaining" |

### Operadores Aritmeticos y de Asignacion

| Operador | Como se lee |
|----------|-------------|
| `++` | "plus plus" o "increment" |
| `--` | "minus minus" o "decrement" |
| `+=` | "plus equals" |
| `-=` | "minus equals" |
| `*=` | "times equals" |
| `/=` | "divided-by equals" |
| `%` | "modulo" o "mod" |

### Operadores Especiales

| Operador | Como se lee |
|----------|-------------|
| `=>` | "arrow" o "fat arrow" |
| `->` | "arrow" o "thin arrow" |
| `::` | "double colon" o "scope resolution" |
| `...` | "spread" o "three dots" |
| `?.` | "optional chaining" o "null-safe access" |
| `!.` | "bang dot" o "force unwrap" |
| `??=` | "null-aware assignment" |

---

## Simbolos: Como Leerlos

| Simbolo | Nombre en ingles | Pronunciacion |
|---------|-----------------|---------------|
| `{ }` | curly braces / curly brackets | "ker-li BREI-ses" |
| `[ ]` | square brackets / brackets | "skuer BRA-kets" |
| `( )` | parentheses / parens | "pa-REN-zi-sis" |
| `< >` | angle brackets / chevrons | "AN-gol BRA-kets" |
| `;` | semicolon | "se-mi-CO-lon" |
| `:` | colon | "CO-lon" |
| `.` | dot / period | "dot" |
| `,` | comma | "CO-ma" |
| `#` | hash / pound / hashtag | "jash" |
| `@` | at sign / at | "at" |
| `_` | underscore | "AN-der-scor" |
| `*` | asterisk / star | "AS-te-risk" |
| `&` | ampersand | "AM-per-sand" |
| `\|` | pipe / vertical bar | "paip" |
| `~` | tilde | "TIL-da" |
| `^` | caret | "KA-ret" |
| `` ` `` | backtick / grave accent | "BAK-tik" |
| `/` | forward slash / slash | "slash" |
| `\` | backslash | "BAK-slash" |
| `"` | double quote | "da-bol KUOUT" |
| `'` | single quote / apostrophe | "SIN-gol KUOUT" |

---

## Ejemplos Completos de Lectura

### Ejemplo 1: Arrow Function

```javascript
const isAdult = (age) => age >= 18;
```
> "Const is-adult equals a function that takes age, arrow, age is greater than
> or equal to eighteen."

### Ejemplo 2: Method Chain

```javascript
return items.filter(x => x.isActive).map(x => x.name).join(', ');
```
> "Return items dot filter where x arrow x dot is-active, dot map where x arrow
> x dot name, dot join with comma space."

### Ejemplo 3: Null Safety

```dart
final name = user?.profile?.displayName ?? 'Anonymous';
```
> "Final name equals user optional-chain profile optional-chain display-name,
> null-coalescing Anonymous."

### Ejemplo 4: Destructuring

```javascript
const { name, age, ...rest } = user;
```
> "Const, destructure name, age, and spread rest, from user."

### Ejemplo 5: Generic Type

```dart
Future<Either<Failure, List<User>>> getUsers();
```
> "Future of Either of Failure or List of User, get-users."

---

## Consejos para Leer Codigo en Voz Alta

1. **Lee la intencion, no la sintaxis literal** cuando sea posible
2. **Simplifica**: `x => x.isActive` puede ser "where x is active"
3. **Usa "dot" para el punto** de acceso a propiedades/metodos
4. **Di "of"** para generics: `List<String>` = "list of string"
5. **Practica** con codigo real todos los dias
