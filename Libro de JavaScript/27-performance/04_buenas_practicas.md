# Buenas Prácticas y Checklist de Performance en JavaScript

## Checklist de código — revisión antes de hacer commit

### Variables y declaraciones
- [ ] Usar `const` por defecto — solo `let` cuando el valor necesita reasignarse
- [ ] Nunca usar `var` — tiene scoping a función y hoisting confuso
- [ ] Nombres descriptivos: evitar `temp`, `data`, `x`, `item` sin contexto
- [ ] Desestructuración para acceso limpio: `const { nombre, edad } = usuario`

### Mutaciones y efectos secundarios
- [ ] Evitar mutar objetos y arrays recibidos como argumentos
- [ ] Usar spread `[...arr]` o `arr.slice()` para copiar antes de modificar
- [ ] funciones puras cuando sea posible: misma entrada → misma salida
- [ ] Separar lógica de negocio de efectos secundarios (I/O, fetch, DOM)

### Estructuras de datos correctas
- [ ] **Array** — lista ordenada de items, acceso por índice
- [ ] **Set** — colección de valores únicos, `.has()` en O(1)
- [ ] **Map** — pares clave-valor con clave de cualquier tipo, `.get()` en O(1)
- [ ] Construir índice `Map` cuando se hagan búsquedas frecuentes en arrays grandes

### Código asíncrono
- [ ] `Promise.all([...])` cuando las operaciones son independientes entre sí
- [ ] `Promise.allSettled([...])` cuando se necesitan todos los resultados aunque fallen
- [ ] `await` en serie solo cuando cada paso depende del resultado del anterior
- [ ] Siempre manejar errores en promesas: `try/catch` o `.catch()`
- [ ] Cancelar fetch con `AbortController` al desmontar componentes React

---

## Memory Leaks — causas más comúnes

Los memory leaks ocurren cuando el garbage collector no puede liberar memoria porque hay referencias activas a objetos que ya no se necesitan.

| Causa | Solución |
|---|---|
| Event listeners sin remover | `element.removeEventListener(...)` al desmontar |
| `setInterval` / `setTimeout` sin cancelar | Guardar el ID y llamar `clearInterval(id)` en cleanup |
| IntersectionObserver / ResizeObserver | Llamar `.disconnect()` al desmontar |
| Variables globales acumulando datos | Limitar el scope, usar WeakMap/WeakSet cuando corresponda |
| Closures que retienen referencias grandes | Liberar la referencia asignando `null` cuando ya no se necesite |

### Patrón correcto en React
```js
useEffect(() => {
  const controller = new AbortController();
  const id = setInterval(fn, 1000);
  window.addEventListener('resize', handler);

  // Cleanup: SIEMPRE limpiar lo que se crea en el efecto
  return () => {
    controller.abort();
    clearInterval(id);
    window.removeEventListener('resize', handler);
  };
}, []);
```

---

## Código a evitar

### eval() y new Function()
```js
// MAL — eval ejecuta strings como código: lento y peligroso (XSS)
eval('console.log("hola")');
const fn = new Function('x', 'return x * 2');

// BIEN — usar funciones reales
const fn = (x) => x * 2;
```

### with statement
```js
// MAL — with contamina el scope y confunde al engine
with (objeto) { console.log(propiedad); }

// BIEN — ser explícito
console.log(objeto.propiedad);
```

### comparaciones sin tipo
```js
// MAL — == hace coerción de tipos: '5' == 5 → true
if (valor == null) { }

// BIEN — === compara valor Y tipo
if (valor === null || valor === undefined) { }
// O más conciso:
if (valor == null) { } // Solo aceptable para null/undefined juntos
```

---

## Strict Mode

Activar `'use strict'` al inicio de cada archivo (o módulo ES6) hace que JavaScript:
- Prohíba variables no declaradas
- Prohíba `this` global en funciones
- Lance errores en operaciones silenciosamente inválidas
- Reserve palabras para futuras versiones del lenguaje

```js
'use strict';
// En módulos ES6 (import/export), strict mode está activado automáticamente
```

---

## Profiling — medir antes de optimizar

> "Premature optimization is the root of all evil." — Donald Knuth
>
> Mide primero. Optimiza donde el profiler indique, no donde intuyas.

### Node.js
```bash
# Generar perfil de CPU
node --prof mi-script.js

# Procesar el log generado
node --prof-process isolate-*.log > perfil.txt

# Ver memory usage en tiempo real
node --inspect mi-script.js
# Abrir chrome://inspect en Chrome
```

### Navegador — DevTools
1. **F12 → Performance** → Record → realizar la acción → Stop
   - Ver flame chart de llamadas de funciones
   - Identificar funciones lentas o renders costosos

2. **F12 → Memory** → Heap Snapshot
   - Detectar memory leaks
   - Ver qué objetos están ocupando memoria

3. **F12 → Coverage** (⌘+Shift+P → "Coverage")
   - Ver qué porcentaje del JS cargado realmente se ejecuta
   - Identificar código muerto para eliminar o hacer code splitting

### Lighthouse
```bash
# Auditar rendimiento de una app web
npx lighthouse https://mi-app.com --view

# O desde DevTools: F12 → Lighthouse → Analyze page load
```

Métricas clave de Lighthouse:
- **FCP** (First Contentful Paint): primer contenido visible
- **LCP** (Largest Contentful Paint): contenido principal visible — meta < 2.5s
- **CLS** (Cumulative Layout Shift): estabilidad visual — meta < 0.1
- **TTI** (Time to Interactive): cuándo la página responde — meta < 3.8s
- **TBT** (Total Blocking Time): tiempo que el hilo principal está bloqueado
