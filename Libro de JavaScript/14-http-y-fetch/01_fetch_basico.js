// =============================================================================
// ARCHIVO: 01_fetch_basico.js
// TEMA: fetch básico — GET requests, response, manejo de errores
// =============================================================================
// CÓMO EJECUTAR: node 01_fetch_basico.js
// REQUISITO: Node.js 18+ (fetch nativo) o npm install node-fetch
// =============================================================================

// API pública gratuita para practicar: JSONPlaceholder
const BASE_URL = 'https://jsonplaceholder.typicode.com';

// =============================================================================
// SECCIÓN 1: fetch básico — GET simple
// fetch retorna una Promise con el objeto Response
// =============================================================================

async function fetchBasico() {
  console.log('=== 1. fetch básico ===\n');

  // fetch retorna una Promise<Response> — no los datos directamente
  const response = await fetch(`${BASE_URL}/posts/1`);

  // Propiedades importantes del objeto Response
  console.log('Status:     ', response.status);      // 200, 404, 500...
  console.log('Status text:', response.statusText);  // 'OK', 'Not Found'...
  console.log('OK:         ', response.ok);           // true si status 200-299
  console.log('URL:        ', response.url);

  // Leer el cuerpo — solo se puede leer UNA vez por response
  // response.json()   → parsea como JSON y retorna Promise<object>
  // response.text()   → retorna como string crudo
  // response.blob()   → retorna como Blob (archivos binarios)
  // response.arrayBuffer() → para datos binarios
  const post = await response.json();

  console.log('\nPost obtenido:');
  console.log('  ID:     ', post.id);
  console.log('  Título: ', post.title);
  console.log('  Body:   ', post.body.slice(0, 60) + '...');
}

// =============================================================================
// SECCIÓN 2: Error de red vs error HTTP
// fetch SOLO rechaza la Promise ante errores de red, no errores HTTP
// =============================================================================

async function manejoDeErrores() {
  console.log('\n=== 2. Manejo de errores ===\n');

  // --- CASO A: URL que no existe (error de red) ---
  // La Promise se RECHAZA → entra al catch
  try {
    await fetch('https://dominio-que-no-existe-9x8z.com/api');
  } catch (err) {
    console.log('[Error de red capturado]', err.message.slice(0, 60));
  }

  // --- CASO B: Recurso que no existe (error HTTP 404) ---
  // La Promise RESUELVE — hay que verificar response.ok manualmente
  const response404 = await fetch(`${BASE_URL}/posts/99999`);
  console.log('\n[Error HTTP 404]:');
  console.log('  response.ok:    ', response404.ok);      // false
  console.log('  response.status:', response404.status);  // 404
  // Nunca llamar a response.json() sin verificar response.ok primero

  // --- PATRÓN CORRECTO: siempre verificar response.ok ---
  async function fetchConValidacion(url) {
    const res = await fetch(url);

    if (!res.ok) {
      // Lanzar error con información útil para el catch del llamador
      throw new Error(`Error HTTP ${res.status}: ${res.statusText} — ${url}`);
    }

    return res.json();
  }

  try {
    await fetchConValidacion(`${BASE_URL}/posts/99999`);
  } catch (err) {
    console.log('\n[Validación correcta]:', err.message);
  }
}

// =============================================================================
// SECCIÓN 3: Fetch con parámetros de query string
// Construir URLs con parámetros dinámicos
// =============================================================================

async function fetchConParams() {
  console.log('\n=== 3. Query parameters ===\n');

  // Construir URL con URLSearchParams (evita errores de codificación manual)
  const params = new URLSearchParams({
    _limit: '3',
    _page:  '1',
    userId: '1',
  });

  const url      = `${BASE_URL}/posts?${params}`;
  const response = await fetch(url);
  const posts    = await response.json();

  console.log(`URL: ${url}`);
  console.log(`Posts obtenidos: ${posts.length}`);
  posts.forEach((p) => {
    console.log(`  [${p.id}] ${p.title.slice(0, 45)}...`);
  });
}

// =============================================================================
// SECCIÓN 4: Fetch de múltiples recursos en paralelo con Promise.all
// Más eficiente que hacer los fetch uno por uno
// =============================================================================

async function fetchParalelo() {
  console.log('\n=== 4. Fetch en paralelo con Promise.all ===\n');

  const inicio = Date.now();

  // Lanzar los 3 fetch al mismo tiempo — NO secuencialmente
  const [usuario, posts, comentarios] = await Promise.all([
    fetch(`${BASE_URL}/users/1`).then((r) => r.json()),
    fetch(`${BASE_URL}/posts?userId=1&_limit=3`).then((r) => r.json()),
    fetch(`${BASE_URL}/comments?postId=1&_limit=3`).then((r) => r.json()),
  ]);

  const tiempo = Date.now() - inicio;

  console.log(`Tiempo total (paralelo): ${tiempo}ms`);
  console.log('\nUsuario:', usuario.name, '—', usuario.email);
  console.log('Posts:');
  posts.forEach((p) => console.log('  -', p.title.slice(0, 50)));
  console.log('Comentarios:');
  comentarios.forEach((c) => console.log('  -', c.name.slice(0, 50)));
}

// =============================================================================
// SECCIÓN 5: Inspeccionar headers de la respuesta
// =============================================================================

async function inspectarHeaders() {
  console.log('\n=== 5. Inspeccionar headers ===\n');

  const response = await fetch(`${BASE_URL}/posts/1`);

  console.log('Headers de la respuesta:');
  // response.headers es un objeto Headers iterable
  for (const [clave, valor] of response.headers) {
    console.log(`  ${clave}: ${valor}`);
  }

  // Acceder a un header específico
  const contentType = response.headers.get('content-type');
  console.log('\nContent-Type:', contentType);
}

// Ejecutar todas las secciones
(async () => {
  try {
    await fetchBasico();
    await manejoDeErrores();
    await fetchConParams();
    await fetchParalelo();
    await inspectarHeaders();
    console.log('\n✅ Módulo 14 — fetch básico completado');
  } catch (err) {
    console.error('Error inesperado:', err.message);
  }
})();
