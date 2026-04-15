# Capítulo 10 — Transacciones

## ¿Qué es una transacción?

Una transacción es un conjunto de operaciones que se ejecutan **todas o ninguna**.
Si algo falla a la mitad, todo vuelve al estado anterior.

Ejemplo real: transferencia bancaria.
Si debitas a Juan pero el sistema falla antes de acreditar a María,
la transacción se revierte y nadie pierde dinero.

---

## Propiedades ACID

| Propiedad | Descripción |
|-----------|-------------|
| **A**tomicity (Atomicidad) | Todo o nada — si algo falla, todo se revierte |
| **C**onsistency (Consistencia) | La BD siempre queda en estado válido |
| **I**solation (Aislamiento) | Las transacciones no se interfieren entre sí |
| **D**urability (Durabilidad) | Una vez confirmada, los datos persisten aunque el sistema falle |

---

## Comandos de transacción

```sql
BEGIN;           -- Iniciar la transacción
-- ... operaciones SQL ...
COMMIT;          -- Confirmar y guardar todos los cambios
-- o
ROLLBACK;        -- Revertir todos los cambios (volver al estado anterior)
```

---

## Ejemplo: Insertar datos con seguridad

```sql
BEGIN;

INSERT INTO books (book_number, short_name, long_name) VALUES (800, 'X1', 'Prueba');
INSERT INTO verses (book_number, chapter, verse, text) VALUES (800, 1, 1, 'Texto...');

-- Si todo salió bien:
COMMIT;

-- Si algo salió mal:
-- ROLLBACK;
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_transacciones.sql` | BEGIN, COMMIT, ROLLBACK con ejemplos prácticos |
