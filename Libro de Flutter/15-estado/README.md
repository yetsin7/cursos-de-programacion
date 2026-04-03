# Módulo 15 — Estado en Flutter

## ¿Qué es el estado?

El **estado** es cualquier dato que puede cambiar en el tiempo y que, al cambiar, debe reflejarse en la interfaz de usuario.

Ejemplos de estado:
- El número actual en un contador
- Si un checkbox está marcado
- La lista de mensajes en un chat
- Si el usuario está autenticado
- El tema (claro/oscuro) de la app

---

## Tipos de estado

### Estado local (UI state)
Afecta solo a un widget y sus hijos. Ejemplos: si un acordeón está expandido, si se está mostrando una contraseña, el tab activo.

**Solución**: `StatefulWidget` + `setState()`.

### Estado global (app state)
Afecta a múltiples partes de la app no relacionadas. Ejemplos: usuario autenticado, carrito de compras, configuración de idioma.

**Soluciones**: `InheritedWidget`, `Provider`, `Riverpod`, `Bloc`, `GetX`.

---

## El ciclo de vida de un StatefulWidget

```
createState()          → Flutter crea el objeto State<T>
    ↓
initState()            → Se ejecuta UNA SOLA VEZ al montar el widget
    ↓
didChangeDependencies() → Al cambiar InheritedWidget del que depende
    ↓
build()                → Se ejecuta al montar y cada vez que setState() se llama
    ↓
didUpdateWidget()      → Al cambiar los parámetros del widget padre
    ↓
setState()             → Marca el widget como "sucio", schedula rebuild
    ↓
build() [again]        → Flutter reconstruye solo este widget y sus hijos
    ↓
deactivate()           → Al remover el widget del árbol (temporalmente)
    ↓
dispose()              → Se ejecuta UNA SOLA VEZ al destruir el widget
                         (liberar controladores, timers, streams aquí)
```

---

## Reglas de oro del estado en Flutter

1. **Coloca el estado tan cerca del widget que lo usa como sea posible**
2. **Si dos widgets necesitan el mismo estado, sube el estado al ancestro común más cercano**
3. **Nunca hagas lógica de negocio dentro de `setState()`** — solo actualiza variables
4. **Siempre llama `dispose()` para liberar recursos** (controladores, timers, streams)

---

## Archivos de este módulo

| Archivo | Tema |
|---|---|
| `01_stateless_widget.dart` | StatelessWidget, const, props, widgets reutilizables |
| `02_stateful_widget.dart` | StatefulWidget, State<T>, ciclo de vida |
| `03_setstate.dart` | setState en profundidad, antipatrones, Keys |
| `04_inherited_widget.dart` | InheritedWidget, paso de datos sin prop drilling |
| `05_ejercicios.dart` | Ejercicios de práctica |
