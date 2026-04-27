# Módulo 08 — Programación Orientada a Objetos (POO)

POO en JavaScript moderno con `class`. herencia, encapsulación, propiedades
privadas, getters/setters, mixins y composición.

## Archivos

| Archivo | Tema |
|---|---|
| `01_clases.js` | class, constructor, métodos, this, instancias, toString |
| `02_herencia.js` | extends, super, override, instanceof, prototype chain |
| `03_static_y_privado.js` | static, propiedades privadas #, getters/setters |
| `04_mixins_y_composicion.js` | Mixins, composición, Symbol, iteradores |
| `05_ejercicios.js` | Ejercicios prácticos con jerarquía de clases |

## Cómo ejecutar

```bash
node 01_clases.js
node 02_herencia.js
node 03_static_y_privado.js
node 04_mixins_y_composicion.js
node 05_ejercicios.js
```

## Conceptos clave

- Las **clases en JS son azúcar sintáctico** sobre el sistema de prototipos
- Las **propiedades privadas** (`#campo`) son una carácterística nativa de ES2022
- Preferir **composición sobre herencia** cuando sea posible
- `static` pertenece a la clase, no a las instancias
