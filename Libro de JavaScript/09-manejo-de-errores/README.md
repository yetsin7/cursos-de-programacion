# 09 - Manejo de Errores

Los errores son inevitables en cualquier programa. La clave no es evitarlos, sino **manejarlos correctamente** para que el programa falle de forma controlada, informativa y recuperable.

## ¿Por qué importa el manejo de errores?

Un error no manejado puede:
- Detener toda la aplicación inesperadamente
- Dejar recursos abiertos (archivos, conexiones)
- Mostrar mensajes técnicos confusos al usuario
- Ocultar la causa real del problema

## Herramientas disponibles

### try / catch / finally
```js
try {
  // código que puede fallar
} catch (e) {
  // manejo del error: e.message, e.name, e.stack
} finally {
  // siempre se ejecuta: cerrar recursos, limpiar estado
}
```

### Tipos de errores built-in
| Error | Cuándo ocurre |
|---|---|
| `TypeError` | Operación en tipo incorrecto (`null.propiedad`) |
| `RangeError` | Valor fuera de rango (`new Array(-1)`) |
| `ReferenceError` | Variable no declarada |
| `SyntaxError` | Código inválido (en `eval()` o JSON.parse()) |
| `URIError` | URI malformada |

### Errores personalizados
```js
class AppError extends Error {
  constructor(mensaje, codigo) {
    super(mensaje);
    this.name = 'AppError';
    this.codigo = codigo;
  }
}
```

## Estructura del módulo

| Archivo | Contenido |
|---|---|
| `01_try_catch.js` | try/catch/finally, tipos de error, throw |
| `02_errores_personalizados.js` | Extender Error, jerarquía, Result pattern |
| `03_ejercicios.js` | 3 ejercicios con soluciones |

## Cómo ejecutar

```bash
node 01_try_catch.js
node 02_errores_personalizados.js
```
