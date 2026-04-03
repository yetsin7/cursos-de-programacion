// ============================================================
// ARCHIVO: cliente_test.js
// TEMA: Script de prueba de la API con fetch nativo (Node 18+)
// CÓMO EJECUTAR: node cliente_test.js
// NOTA: Ejecuta primero el servidor → node servidor.js
// ============================================================

'use strict';

const BASE_URL = 'http://localhost:3000/api/notas';

// ─── UTILIDADES ───────────────────────────────────────────────

/**
 * Ejecuta una prueba y muestra el resultado formateado.
 * @param {string} descripcion - Nombre descriptivo de la prueba
 * @param {Function} fn - Función async que realiza la prueba
 */
async function probar(descripcion, fn) {
  process.stdout.write(`\n  📋 ${descripcion}... `);
  try {
    const resultado = await fn();
    console.log('\x1b[32m✅ OK\x1b[0m');
    if (resultado !== undefined) {
      const texto = JSON.stringify(resultado, null, 2)
        .split('\n').map((l) => '     ' + l).join('\n');
      console.log(texto);
    }
    return resultado;
  } catch (e) {
    console.log('\x1b[31m❌ FALLÓ\x1b[0m');
    console.error('     Error:', e.message);
  }
}

/**
 * Realiza una petición HTTP a la API y retorna el JSON de respuesta.
 * @param {string} ruta - Ruta relativa (ej: '/1')
 * @param {{ method?: string, body?: object }} opciones
 * @returns {Promise<object>} Respuesta JSON
 */
async function api(ruta = '', opciones = {}) {
  const { method = 'GET', body } = opciones;
  const res = await fetch(`${BASE_URL}${ruta}`, {
    method,
    headers: body ? { 'Content-Type': 'application/json' } : {},
    body: body ? JSON.stringify(body) : undefined,
  });

  const json = await res.json();

  // Lanzar error si el servidor respondió con un código de error
  if (!res.ok) {
    throw new Error(`HTTP ${res.status}: ${json.error || JSON.stringify(json)}`);
  }

  return json;
}

// ─── SUITE DE PRUEBAS ─────────────────────────────────────────

async function ejecutarPruebas() {
  console.log('\x1b[36m');
  console.log('════════════════════════════════════════');
  console.log('  PRUEBAS DE LA API DE NOTAS');
  console.log('  Servidor: ' + BASE_URL);
  console.log('════════════════════════════════════════');
  console.log('\x1b[0m');

  // 1. Estado inicial
  const estadoInicial = await probar(
    'GET /api/notas — listar todas (estado inicial)',
    () => api()
  );
  console.log(`     (${estadoInicial?.total ?? 0} notas en la BD antes de las pruebas)`);

  // 2. Crear notas
  let nota1, nota2, nota3;

  nota1 = await probar('POST — crear nota con todos los campos', () =>
    api('', {
      method: 'POST',
      body: { titulo: 'Apuntes de Express', contenido: 'Express es un framework minimalista para Node.js', etiqueta: 'backend' },
    })
  );

  nota2 = await probar('POST — crear nota solo con título', () =>
    api('', {
      method: 'POST',
      body: { titulo: 'Nota rápida sin contenido' },
    })
  );

  nota3 = await probar('POST — crear tercera nota', () =>
    api('', {
      method: 'POST',
      body: { titulo: 'Hooks de React', contenido: 'useState, useEffect, useCallback', etiqueta: 'frontend' },
    })
  );

  // 3. Obtener una nota
  if (nota1?.id) {
    await probar(`GET /api/notas/${nota1.id} — obtener por ID`, () =>
      api(`/${nota1.id}`)
    );
  }

  // 4. Listar todas
  await probar('GET /api/notas — listar todas las notas creadas', () => api());

  // 5. Búsqueda
  await probar('GET /api/notas?q=express — buscar por texto', () =>
    api('?q=express')
  );

  await probar('GET /api/notas?q=react — buscar por texto', () =>
    api('?q=react')
  );

  // 6. Actualizar
  if (nota1?.id) {
    await probar(`PUT /api/notas/${nota1.id} — actualizar nota`, () =>
      api(`/${nota1.id}`, {
        method: 'PUT',
        body: { titulo: 'Apuntes de Express (actualizado)', etiqueta: 'nodejs' },
      })
    );
  }

  // 7. Eliminar
  if (nota2?.id) {
    await probar(`DELETE /api/notas/${nota2.id} — eliminar nota`, () =>
      api(`/${nota2.id}`, { method: 'DELETE' })
    );
  }

  // 8. Verificar lista final
  const estadoFinal = await probar('GET /api/notas — estado final', () => api());
  console.log(`     (${estadoFinal?.total ?? 0} notas tras las pruebas)`);

  // 9. Casos de error
  console.log('\n\x1b[33m  — Pruebas de errores esperados —\x1b[0m');

  await probar('POST sin título → 400 Bad Request', async () => {
    const res = await fetch(BASE_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ contenido: 'Sin título' }),
    });
    const json = await res.json();
    if (res.status !== 400) throw new Error(`Esperaba 400, recibió ${res.status}`);
    return { status: res.status, error: json.error };
  });

  await probar('GET /api/notas/99999 → 404 Not Found', async () => {
    const res = await fetch(`${BASE_URL}/99999`);
    const json = await res.json();
    if (res.status !== 404) throw new Error(`Esperaba 404, recibió ${res.status}`);
    return { status: res.status, error: json.error };
  });

  // Resumen
  console.log('\n\x1b[32m════════════════════════════════════════');
  console.log('  ✅ Pruebas completadas');
  console.log('════════════════════════════════════════\x1b[0m\n');
}

// Verificar que el servidor esté corriendo antes de empezar
fetch('http://localhost:3000/')
  .then(() => ejecutarPruebas())
  .catch(() => {
    console.error('\n\x1b[31m❌ No se pudo conectar al servidor.\x1b[0m');
    console.error('   Ejecuta primero: node servidor.js\n');
    process.exit(1);
  });
