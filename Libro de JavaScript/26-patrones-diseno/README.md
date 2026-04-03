# Módulo 26 — Patrones de Diseño en JavaScript

Los patrones de diseño son soluciones probadas a problemas recurrentes en el desarrollo de software. No son código copiado: son **plantillas conceptuales** adaptadas a cada situación.

---

## ¿Por qué aprender patrones?

- Vocabulario común entre desarrolladores ("usemos un Observer aquí")
- Evitar reinventar la rueda en situaciones conocidas
- Código más mantenible, extensible y legible
- Entender frameworks modernos (Vue usa Proxy, React usa Observer/State, Redux usa Flux)

---

## Categorías de patrones (GoF)

| Categoría      | ¿Qué resuelve?                                      | Ejemplos en este módulo         |
|----------------|-----------------------------------------------------|---------------------------------|
| **Creacionales** | Cómo crear objetos de forma flexible y controlada  | Singleton, Factory, Builder     |
| **Estructurales** | Cómo componer clases y objetos                   | Module, Decorator, Proxy, Adapter |
| **Comportamiento** | Cómo los objetos se comunican y distribuyen responsabilidades | Observer, Strategy, Command, Iterator |
| **Reactivos**  | Patrones para UI y estado en aplicaciones modernas  | Pub/Sub, State Machine, Redux   |

---

## Patrones más usados en JavaScript moderno

```
Aplicaciones React/Vue/Angular:
  └── Observer (eventos del DOM)
  └── Flux/Redux (estado global)
  └── State Machine (XState, formularios complejos)

Node.js / APIs:
  └── Singleton (conexión BD, config)
  └── Factory (crear instancias según tipo)
  └── Strategy (algoritmos intercambiables)
  └── Adapter (integrar librerías de terceros)

Arquitectura general:
  └── Command (acciones deshacer/rehacer)
  └── Proxy (validación, caché, logging)
  └── Builder (SDKs, query builders)
```

---

## Archivos del módulo

| Archivo                  | Patrones                                         |
|--------------------------|--------------------------------------------------|
| `01_creacionales.js`     | Singleton, Factory, Builder                      |
| `02_estructurales.js`    | Module, Decorator, Proxy, Adapter                |
| `03_comportamiento.js`   | Observer, Strategy, Command, Iterator            |
| `04_patrones_reactivos.js`| Pub/Sub, State Machine, Flux/Redux              |

---

## Advertencia

> No fuerces un patrón en código que no lo necesita. El peor código es el que aplica patrones innecesariamente.
> Un patrón es una **respuesta a un problema real**, no un adorno arquitectónico.
