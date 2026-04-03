// =============================================================================
// ARCHIVO: 01_jsx.jsx
// TEMA: JSX — JavaScript + XML syntax en React
// NOTA: Requiere proyecto Vite → npm create vite@latest mi-app -- --template react
// =============================================================================

// JSX no es HTML. Es una extensión de sintaxis de JavaScript que React transforma
// en llamadas a React.createElement(). Vite/Babel hacen esa transformación.

// ─── 1. Diferencias JSX vs HTML ──────────────────────────────────────────────

/**
 * Componente que ilustra las diferencias principales entre JSX y HTML.
 * - className en lugar de class (class es palabra reservada en JS)
 * - htmlFor en lugar de for (for también es reservada)
 * - Atributos en camelCase: onClick, onChange, tabIndex
 * - style como objeto JS: style={{ color: 'red' }} (doble llaves)
 */
function DemoJSX() {
  return (
    <div className="contenedor">  {/* className, no class */}
      <label htmlFor="campo">     {/* htmlFor, no for */}
        Nombre:
      </label>
      <input
        id="campo"
        type="text"
        tabIndex={0}               /* tabIndex en camelCase */
        placeholder="Escribe aquí"
        style={{ border: '1px solid #ccc', padding: '4px' }}  /* style como objeto */
      />
    </div>
  );
}

// ─── 2. Expresiones JavaScript dentro de JSX ─────────────────────────────────

/**
 * En JSX, las llaves {} permiten insertar CUALQUIER expresión JavaScript válida.
 * - Variables, operaciones matemáticas, llamadas a funciones
 * - NO se pueden usar statements (if, for) — solo expresiones
 */
function ExpresionesJSX() {
  const nombre = 'María';
  const edad = 25;
  const items = ['Manzana', 'Pera', 'Uva'];

  return (
    <div>
      {/* Variables */}
      <p>Hola, {nombre}. Tienes {edad} años.</p>

      {/* Operaciones */}
      <p>En 10 años tendrás {edad + 10} años.</p>

      {/* Llamada a función */}
      <p>Nombre en mayúsculas: {nombre.toUpperCase()}</p>

      {/* Array: join para mostrar como texto */}
      <p>Frutas: {items.join(', ')}</p>

      {/* Expresión condicional con ternario */}
      <p>{edad >= 18 ? 'Mayor de edad' : 'Menor de edad'}</p>
    </div>
  );
}

// ─── 3. Fragments: retornar múltiples elementos ───────────────────────────────

/**
 * React exige que un componente retorne UN SOLO elemento raíz.
 * Si no quieres agregar un div innecesario, usa Fragment: <> ... </>
 * Fragment no genera nodo HTML — es "invisible" en el DOM.
 */
function DobleParrafo() {
  return (
    <>   {/* Fragment: envuelve sin agregar nodo al DOM */}
      <p>Primer párrafo</p>
      <p>Segundo párrafo</p>
    </>
  );
  // Sin Fragment habría que escribir:
  // return <div><p>...</p><p>...</p></div>
  // Lo que agrega un div innecesario al HTML
}

// ─── 4. Atributos booleanos ───────────────────────────────────────────────────

/**
 * En JSX, los atributos booleanos se pasan como expresiones JS.
 * disabled={true} o simplemente disabled (sin valor = true implícito)
 * disabled={false} elimina el atributo del DOM
 */
function AtributosBooleanos() {
  const formularioEnviando = false;

  return (
    <div>
      {/* disabled={true} → el botón está deshabilitado */}
      <button disabled>No puedo hacer clic</button>

      {/* disabled como expresión: solo se deshabilita si la condición es true */}
      <button disabled={formularioEnviando}>
        {formularioEnviando ? 'Enviando...' : 'Enviar'}
      </button>

      {/* readOnly, required, checked: mismo patrón */}
      <input type="checkbox" checked={true} readOnly />
    </div>
  );
}

// ─── 5. Comentarios en JSX ───────────────────────────────────────────────────

/**
 * Dentro de JSX, los comentarios van dentro de llaves con sintaxis de bloque.
 * Los comentarios // no funcionan dentro del markup JSX.
 */
function ComentariosJSX() {
  return (
    <div>
      {/* Esto es un comentario válido en JSX */}
      <p>Texto visible</p>
      {/*
        Los comentarios multilínea
        también funcionan así
      */}
    </div>
  );
}

// ─── Componente principal que muestra todos los demos ────────────────────────

/**
 * Componente raíz que agrupa todos los demos de JSX.
 * Este es el componente que se exporta para usar en App.jsx.
 */
export default function ModuloJSX() {
  return (
    <div style={{ fontFamily: 'sans-serif', padding: '20px' }}>
      <h1>Módulo 20 — JSX</h1>

      <section>
        <h2>1. Diferencias con HTML</h2>
        <DemoJSX />
      </section>

      <section>
        <h2>2. Expresiones JavaScript</h2>
        <ExpresionesJSX />
      </section>

      <section>
        <h2>3. Fragments</h2>
        <DobleParrafo />
      </section>

      <section>
        <h2>4. Atributos booleanos</h2>
        <AtributosBooleanos />
      </section>

      <section>
        <h2>5. Comentarios en JSX</h2>
        <ComentariosJSX />
        <p>Ver el código fuente — los comentarios no aparecen en el render</p>
      </section>
    </div>
  );
}
