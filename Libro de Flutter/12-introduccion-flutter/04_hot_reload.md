# Hot Reload y Hot Restart en Flutter

## ¿Qué es el Hot Reload?

El **Hot Reload** es una de las carácterísticas más poderosas de Flutter para el desarrollo. Permite inyectar los cambios de código directamente en la Dart VM en ejecución **sin reiniciar la app ni perder el estado actual**.

Cuando presionas `r` en la terminal (o guardas el archivo si usas VS Code/Android Studio con el plugin Flutter), Flutter:

1. Recompila solo los archivos Dart modificados
2. Envía el nuevo bytecode a la Dart VM
3. Reconstruye el árbol de widgets desde cero
4. **Preserva el estado actual** de la app

El proceso tarda típicamente **menos de 1 segundo**.

---

## ¿Qué es el Hot Restart?

El **Hot Restart** (`R` mayúscula en la terminal) es más profundo:

1. Recompila toda la app desde cero
2. Reinicia la Dart VM
3. **Pierde el estado actual** (la app vuelve a la pantalla inicial)
4. Tarda entre 2 y 5 segundos

---

## Comparativa

| Característica | Hot Reload (`r`) | Hot Restart (`R`) |
|---|---|---|
| Velocidad | < 1 segundo | 2–5 segundos |
| Preserva estado | ✅ Sí | ❌ No |
| Reinicia `main()` | ❌ No | ✅ Sí |
| Ejecuta `initState()` | ❌ No | ✅ Sí |
| Ideal para | Cambios de UI | Cambios de estado inicial |

---

## Cómo funciona el Hot Reload internamente

Flutter usa la **Dart VM en modo JIT** (Just-In-Time) durante el desarrollo:

```
Tu código modificado
        ↓
Compilador Dart (solo archivos cambiados)
        ↓
Nuevo bytecode enviado a la VM en ejecución
        ↓
Flutter reconstruye el Widget Tree
        ↓
El estado (StatefulWidget) se preserva porque
los objetos State<T> ya existen en memoria
```

El truco está en que Flutter separa la **descripción de la UI** (Widget, inmutable) del **estado** (State, mutable). Como el estado vive en los objetos `State<T>` y no en los widgets, puede sobrevivir a una reconstrucción del árbol de widgets.

---

## Limitaciones del Hot Reload

El Hot Reload **no funciona** o requiere Hot Restart en estos casos:

### 1. Cambios en `initState()`
```dart
// Si cambias lo que hace initState(), necesitas Hot Restart
// porque initState() solo se ejecuta una vez al crear el widget.
@override
void initState() {
  super.initState();
  _titulo = 'Nuevo título'; // Este cambio NO se refleja con Hot Reload
}
```

### 2. Cambios en `main()`
```dart
// main() no se vuelve a ejecutar con Hot Reload.
void main() {
  // Cambios aquí requieren Hot Restart
  runApp(const MiApp());
}
```

### 3. Cambios en variables estáticas o globales
```dart
// Las variables estáticas ya están inicializadas en memoria.
// Hot Reload no las reinicializa.
static int contador = 0; // Cambiar el valor inicial requiere Hot Restart
```

### 4. Agregar/eliminar campos en una clase `State`
```dart
// Si agregas un nuevo campo a un State<T>, el objeto en memoria
// no tiene ese campo todavía. Necesitas Hot Restart.
class _MiState extends State<MiWidget> {
  int nuevocampo = 42; // Agregar esto requiere Hot Restart
}
```

### 5. Cambios en `enum` o cambios de tipo
Si cambias el tipo de una variable o el nombre de un valor de `enum`, la VM puede entrar en un estado inconsistente.

### 6. Cambios en código nativo (Android/iOS)
Cualquier cambio en archivos `.kt`, `.swift`, `.gradle` o `Info.plist` requiere una compilación completa con `flutter run`.

---

## Hot Reload en VS Code y Android Studio

| IDE | Hot Reload | Hot Restart |
|---|---|---|
| VS Code | `Ctrl+S` (guarda) o botón ⚡ | Botón 🔄 |
| Android Studio | `Ctrl+\` o botón ⚡ | `Ctrl+Shift+\` |
| Terminal | `r` | `R` |

---

## Por qué el Hot Reload es la mayor ventaja de Flutter

Antes del Hot Reload, el ciclo de desarrollo móvil era:

```
Cambiar código → Compilar (30–120 seg) → Instalar → Navegar hasta la pantalla → Ver el cambio
```

Con Flutter Hot Reload:

```
Cambiar código → Guardar (< 1 segundo) → Ver el cambio (con el estado intacto)
```

Esto transforma el desarrollo de UI: puedes ajustar el padding de un botón, cambiar un color, modificar un layout y ver el resultado **instantáneamente**, sin perder el contexto visual en el que estás trabajando.

Es especialmente valioso cuando estás en una pantalla a la que se llega después de varios pasos (como el formulario de checkout de una tienda): con Hot Reload no tienes que repetir esos pasos cada vez que cambias algo visual.

---

## Consejo profesional

Activa **"Format on Save"** en tu IDE para que el código se formatee automáticamente al guardar. Esto, combinado con el Hot Reload automático al guardar, crea un flujo de trabajo extremadamente fluido:

**VS Code** → `settings.json`:
```json
{
  "[dart]": {
    "editor.formatOnSave": true
  }
}
```
