# Módulo 16 — Navegación en Flutter

## Cómo moverse entre pantallas

En Flutter, la navegación entre pantallas se maneja a través de un **Navigator**. Un Navigator mantiene una **pila (stack)** de rutas. Las operaciones básicas son:

- `push`: agrega una nueva pantalla encima de la pila (navegar adelante)
- `pop`: elimina la pantalla actual de la pila (volver atrás)
- `pushReplacement`: reemplaza la pantalla actual (sin volver atrás)
- `pushAndRemoveUntil`: limpia la pila y deja solo la nueva pantalla

---

## La pila de navegación

```
[PantallaA]              → Estado inicial
[PantallaA, PantallaB]   → Después de push(PantallaB)
[PantallaA]              → Después de pop()
[PantallaC]              → Después de pushReplacement(PantallaC) desde A
```

---

## Tres formas de navegar en Flutter

### 1. Navigator.push / pop (imperativo clásico)
Código directo, sin rutas nombradas. Ideal para apps pequeñas.

### 2. Named Routes (`routes` en MaterialApp)
Define rutas como strings. Más organizado pero con limitaciones para pasar argumentos.

### 3. go_router (recomendado en 2024+)
Paquete oficial de la comunidad Flutter. Soporta deep linking, web URLs, rutas anidadas y es declarativo.

---

## ¿Qué elegir?

| Criterio | push/pop | Named Routes | go_router |
|---|---|---|---|
| Apps pequeñas | ✅ | ✅ | ✅ |
| Web (URLs legibles) | ❌ | ⚠️ | ✅ |
| Deep linking | ❌ | ⚠️ | ✅ |
| Parámetros de ruta | Manual | Limitado | ✅ |
| Rutas anidadas | Manual | Difícil | ✅ |
| Recomendación Flutter team | Básico | Básico | ✅ |

---

## Archivos de este módulo

| Archivo | Tema |
|---|---|
| `01_navigator_push.dart` | push/pop, pasar y recibir datos |
| `02_named_routes.dart` | Named routes en MaterialApp |
| `03_go_router.dart` | go_router: navegación moderna |
| `04_bottom_navigation.dart` | BottomNavigationBar, NavigationBar, TabBar |
| `05_ejercicios.dart` | Ejercicios de práctica |
