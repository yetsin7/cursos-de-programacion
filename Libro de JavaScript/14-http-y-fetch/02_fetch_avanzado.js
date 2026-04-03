// =============================================================================
// ARCHIVO: 02_fetch_avanzado.js
// TEMA: fetch avanzado — POST/PUT/DELETE, headers, AbortController, retry
// =============================================================================
// CÓMO EJECUTAR: node 02_fetch_avanzado.js
// REQUISITO: Node.js 18+ (fetch nativo)
// =============================================================================

const BASE_URL = 'https://jsonplaceholder.typicode.com';

// =============================================================================
// SECCIÓN 1: POST — enviar datos al servidor
// Requiere body serializado con JSON.stringify y header Content-Type
// =============================================================================

async function crearRecurso() {
  console.log('=== 1. POST — crear recurso ===\n');

  const nuevoPost = {
    title:  'Mi primer post con fetch',
    body:   'Aprendiendo a hacer peticiones HTTP con JavaScript moderno.',
    userId: 1,
  };

  const response = await fetch(`${BASE_URL}/posts`, {
    method:  'POST',
    headers: {
      // Indicar al servidor que el body es JSON
      'Content-Type': 'application/json',
      // Indicar qué formatos acepta la respuesta
      'Accept': 'application/json',
    },
    // El cuerpo SIEMPRE debe ser string — usar JSON.stringify()
    body: JSON.stringify(nuevoPost),
  });

  if (!response.ok) {
    throw new Error(`Error al crear: HTTP ${response.status}`);
  }

  const creado = await response.json();
  console.log('Recurso creado:');
  console.log('  ID:     ', creado.id);
  console.log('  Título: ', creado.title);
  console.log('  Status: ', response.status); // 201 Created
}

// =============================================================================
// SECCIÓN 2: PUT — reemplazar un recurso completo
// =============================================================================

async function reemplazarRecurso() {
  console.log('\n=== 2. PUT — reemplazar recurso ===\n');

  const postActualizado = {
    id:     1,
    title:  'Post completamente actualizado',
    body:   'El contenido fue reemplazado en su totalidad.',
    userId: 1,
  };

  const response = await fetch(`${BASE_URL}/posts/1`, {
    method:  'PUT',
    headers: { 'Content-Type': 'application/json' },
    body:    JSON.stringify(postActualizado),
  });

  const resultado = await response.json();
  console.log('POST actualizado (PUT):');
  console.log('  Título:', resultado.title);
  console.log('  Status:', response.status); // 200 OK
}

// =============================================================================
// SECCIÓN 3: PATCH — actualizar campos específicos
// A diferencia de PUT, solo envías los campos que cambian
// =============================================================================

async function actualizarParcialmente() {
  console.log('\n=== 3. PATCH — actualización parcial ===\n');

  const cambios = {
    title: 'Solo el título fue cambiado',
    // El body y userId no se tocan
  };

  const response = await fetch(`${BASE_URL}/posts/1`, {
    method:  'PATCH',
    headers: { 'Content-Type': 'application/json' },
    body:    JSON.stringify(cambios),
  });

  const resultado = await response.json();
  console.log('Resultado del PATCH:');
  console.log('  Título:', resultado.title);
  console.log('  Body:  ', resultado.body?.slice(0, 50));
}

// =============================================================================
// SECCIÓN 4: DELETE — eliminar un recurso
// =============================================================================

async function eliminarRecurso() {
  console.log('\n=== 4. DELETE — eliminar recurso ===\n');

  const response = await fetch(`${BASE_URL}/posts/1`, {
    method: 'DELETE',
  });

  // DELETE exitoso devuelve 200 o 204 (No Content)
  console.log('Status:', response.status);
  console.log('Eliminado correctamente:', response.ok);
}

// =============================================================================
// SECCIÓN 5: Headers personalizados — Authorization, API keys
// =============================================================================

async function headersPersonalizados() {
  console.log('\n=== 5. Headers personalizados ===\n');

  // Ejemplo de cómo enviar un token de autorización (patrón Bearer)
  // En apps reales, el token viene de process.env.API_TOKEN
  const TOKEN_EJEMPLO = 'mi-token-secreto-aqui';

  const response = await fetch(`${BASE_URL}/posts/1`, {
    headers: {
      'Authorization': `Bearer ${TOKEN_EJEMPLO}`,
      'X-Custom-Header': 'valor-personalizado',
      'Accept-Language': 'es-ES,es;q=0.9',
    },
  });

  // JSONPlaceholder ignora el token pero responde igual — en una API real
  // devolvería 401 Unauthorized si el token fuera inválido
  console.log('Status con header Authorization:', response.status);
  console.log('(JSONPlaceholder ignora el token — solo es un ejemplo)');
}

// =============================================================================
// SECCIÓN 6: AbortController — cancelar peticiones
// Útil para cancelar cuando el usuario navega a otra página o hay timeout
// =============================================================================

async function abortar() {
  console.log('\n=== 6. AbortController — cancelar petición ===\n');

  // --- Ejemplo 1: cancelar manualmente ---
  const controller1 = new AbortController();

  // Cancelar después de 1ms (muy rápido para demostrar el abort)
  setTimeout(() => controller1.abort(), 1);

  try {
    await fetch(`${BASE_URL}/posts`, { signal: controller1.signal });
    console.log('Petición completada (fue más rápida que el abort)');
  } catch (err) {
    // err.name === 'AbortError' cuando se cancela con AbortController
    if (err.name === 'AbortError') {
      console.log('Petición cancelada intencionalmente — AbortError capturado');
    } else {
      throw err;
    }
  }

  // --- Ejemplo 2: timeout automático con AbortSignal.timeout() (Node 18+) ---
  console.log('\nEjemplo con AbortSignal.timeout():');
  try {
    // Cancelar automáticamente si no responde en 5000ms
    const res = await fetch(`${BASE_URL}/posts/1`, {
      signal: AbortSignal.timeout(5000),
    });
    const data = await res.json();
    console.log('Respuesta dentro del timeout:', data.title.slice(0, 40));
  } catch (err) {
    if (err.name === 'TimeoutError') {
      console.log('La petición tardó demasiado — TimeoutError');
    }
  }
}

// =============================================================================
// SECCIÓN 7: Retry con backoff exponencial
// Reintentar peticiones fallidas con esperas crecientes entre intentos
// =============================================================================

/**
 * Ejecuta un fetch con reintentos automáticos ante errores de red o 5xx.
 * Usa backoff exponencial: 1s, 2s, 4s entre reintentos.
 * @param {string} url - URL a la que hacer la petición
 * @param {object} opciones - Opciones del fetch
 * @param {number} maxIntentos - Número máximo de intentos (default: 3)
 * @returns {Promise<Response>} Response cuando la petición es exitosa
 */
async function fetchConRetry(url, opciones = {}, maxIntentos = 3) {
  let ultimoError;

  for (let intento = 1; intento <= maxIntentos; intento++) {
    try {
      const response = await fetch(url, opciones);

      // Reintentar solo en errores de servidor (5xx), no en 4xx
      if (response.status >= 500) {
        throw new Error(`Error servidor: ${response.status}`);
      }

      return response; // éxito — retornar inmediatamente
    } catch (err) {
      ultimoError = err;

      if (intento < maxIntentos) {
        // Espera exponencial: 1000ms, 2000ms, 4000ms...
        const espera = 1000 * 2 ** (intento - 1);
        console.log(`  Intento ${intento} fallido. Reintentando en ${espera}ms...`);
        await new Promise((resolve) => setTimeout(resolve, espera));
      }
    }
  }

  throw new Error(`Fallaron ${maxIntentos} intentos. Último error: ${ultimoError.message}`);
}

async function demoRetry() {
  console.log('\n=== 7. Retry con backoff exponencial ===\n');

  // Usar una URL válida para demostrar que el retry funciona cuando SÍ hay respuesta
  const response = await fetchConRetry(`${BASE_URL}/posts/2`);
  const data = await response.json();
  console.log('Recurso obtenido con retry exitoso:', data.title.slice(0, 50));
}

// Ejecutar todas las secciones
(async () => {
  try {
    await crearRecurso();
    await reemplazarRecurso();
    await actualizarParcialmente();
    await eliminarRecurso();
    await headersPersonalizados();
    await abortar();
    await demoRetry();
    console.log('\n✅ Módulo 14 — fetch avanzado completado');
  } catch (err) {
    console.error('Error:', err.message);
  }
})();
