// ============================================================
// ARCHIVO: 02_zustand.jsx
// TEMA: Zustand — estado global simple, sin boilerplate
// CÓMO EJECUTAR: Pegar como src/App.jsx en un proyecto Vite+React
// DEPENDENCIA: npm install zustand
// ============================================================

// Zustand es una librería de estado global minimalista.
// A diferencia de Redux, NO requiere providers, reducers ni actions.
// Solo se define el store y se consume donde se necesite.

import { create } from 'zustand';
import { persist } from 'zustand/middleware';

// ─── STORE 1: CONTADOR ────────────────────────────────────────

/**
 * Store básico de contador.
 * create() recibe una función que devuelve el estado inicial + las acciones.
 * set() actualiza el estado — Zustand hace el merge automáticamente.
 */
const useContadorStore = create((set) => ({
  // Estado inicial
  valor: 0,
  paso: 1,

  // Acciones — funciones que actualizan el estado con set()
  incrementar: () => set((state) => ({ valor: state.valor + state.paso })),
  decrementar: () => set((state) => ({ valor: state.valor - state.paso })),
  resetear: () => set({ valor: 0 }),
  cambiarPaso: (nuevoPaso) => set({ paso: nuevoPaso }),
}));

/** Demo del store de contador */
function DemoContador() {
  // Suscripción selectiva: solo este componente se re-renderiza si `valor` cambia
  // Más eficiente que suscribirse a todo el store
  const valor = useContadorStore((state) => state.valor);
  const paso = useContadorStore((state) => state.paso);
  const { incrementar, decrementar, resetear, cambiarPaso } = useContadorStore();

  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>1. Store básico (contador)</h2>
      <p style={s.valor}>{valor}</p>
      <div style={s.fila}>
        <button style={s.btn} onClick={decrementar}>−{paso}</button>
        <button style={s.btn} onClick={incrementar}>+{paso}</button>
        <button style={{ ...s.btn, background: '#f38ba8', color: '#1e1e2e' }} onClick={resetear}>Reset</button>
      </div>
      <div style={{ ...s.fila, marginTop: '10px' }}>
        <span style={{ color: '#a6adc8', fontSize: '13px' }}>Paso:</span>
        {[1, 5, 10].map((p) => (
          <button key={p} style={{ ...s.btn, background: paso === p ? '#cba6f7' : '#45475a', color: paso === p ? '#1e1e2e' : '#cdd6f4', padding: '4px 10px' }}
            onClick={() => cambiarPaso(p)}>{p}</button>
        ))}
      </div>
    </section>
  );
}

// ─── STORE 2: CARRITO CON persist ────────────────────────────

const PRODUCTOS = [
  { id: 1, nombre: 'Teclado mecánico', precio: 89.99 },
  { id: 2, nombre: 'Mouse gaming', precio: 45.50 },
  { id: 3, nombre: 'Monitor 27"', precio: 349.99 },
  { id: 4, nombre: 'Auriculares USB', precio: 65.00 },
];

/**
 * Store del carrito de compras con persistencia en localStorage.
 * persist() es un middleware de Zustand que guarda el estado automáticamente.
 */
const useCarritoStore = create(
  // persist envuelve la función del store y guarda/restaura el estado en localStorage
  persist(
    (set, get) => ({
      items: [], // Array de { id, nombre, precio, cantidad }

      /**
       * Agrega un producto al carrito.
       * Si ya existe, incrementa la cantidad en lugar de duplicarlo.
       * @param {{ id: number, nombre: string, precio: number }} producto
       */
      agregar: (producto) => set((state) => {
        const existe = state.items.find((i) => i.id === producto.id);
        if (existe) {
          return { items: state.items.map((i) => i.id === producto.id ? { ...i, cantidad: i.cantidad + 1 } : i) };
        }
        return { items: [...state.items, { ...producto, cantidad: 1 }] };
      }),

      /**
       * Elimina un producto del carrito por su ID.
       * @param {number} id
       */
      eliminar: (id) => set((state) => ({
        items: state.items.filter((i) => i.id !== id),
      })),

      /** Vacía completamente el carrito */
      vaciar: () => set({ items: [] }),

      /** @returns {number} Total calculado del carrito */
      get total() {
        return get().items.reduce((sum, i) => sum + i.precio * i.cantidad, 0);
      },
    }),
    {
      name: 'carrito-zustand', // Clave de localStorage donde se guarda
      // partialize: (state) => ({ items: state.items }) // Solo persistir items (opcional)
    }
  )
);

/** Lista de productos disponibles */
function ListaProductos() {
  const agregar = useCarritoStore((state) => state.agregar);
  const items = useCarritoStore((state) => state.items);

  return (
    <div>
      <h3 style={{ color: '#a6adc8', fontSize: '13px', margin: '0 0 8px' }}>Productos</h3>
      {PRODUCTOS.map((p) => {
        const enCarrito = items.find((i) => i.id === p.id);
        return (
          <div key={p.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '8px 12px', background: '#1e1e2e', borderRadius: '6px', marginBottom: '6px' }}>
            <div>
              <p style={{ margin: 0, color: '#cdd6f4', fontSize: '13px' }}>{p.nombre}</p>
              <p style={{ margin: '2px 0 0', color: '#89b4fa', fontSize: '12px' }}>${p.precio}</p>
            </div>
            <button style={{ ...s.btn, padding: '4px 10px', fontSize: '12px', background: enCarrito ? '#a6e3a1' : '#89b4fa' }}
              onClick={() => agregar(p)}>
              {enCarrito ? `+1 (${enCarrito.cantidad})` : 'Agregar'}
            </button>
          </div>
        );
      })}
    </div>
  );
}

/** Vista del carrito de compras */
function Carrito() {
  const items = useCarritoStore((state) => state.items);
  const eliminar = useCarritoStore((state) => state.eliminar);
  const vaciar = useCarritoStore((state) => state.vaciar);
  const total = useCarritoStore((state) => state.total);

  return (
    <div style={{ marginTop: '14px' }}>
      <h3 style={{ color: '#a6adc8', fontSize: '13px', margin: '0 0 8px' }}>
        Carrito ({items.reduce((s, i) => s + i.cantidad, 0)} items)
      </h3>
      {items.length === 0 ? (
        <p style={{ color: '#6c7086', fontSize: '13px' }}>Vacío — agrega productos arriba</p>
      ) : (
        <>
          {items.map((item) => (
            <div key={item.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '6px 10px', background: '#1e1e2e', borderRadius: '6px', marginBottom: '4px' }}>
              <span style={{ color: '#cdd6f4', fontSize: '12px' }}>{item.nombre} × {item.cantidad}</span>
              <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
                <span style={{ color: '#a6e3a1', fontSize: '12px' }}>${(item.precio * item.cantidad).toFixed(2)}</span>
                <button style={{ ...s.btn, padding: '2px 8px', background: '#f38ba8', color: '#1e1e2e', fontSize: '11px' }} onClick={() => eliminar(item.id)}>✕</button>
              </div>
            </div>
          ))}
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '10px', padding: '8px 10px', background: '#313244', borderRadius: '6px' }}>
            <span style={{ color: '#cdd6f4', fontWeight: 'bold' }}>Total: ${total.toFixed(2)}</span>
            <button style={{ ...s.btn, background: '#f38ba8', color: '#1e1e2e' }} onClick={vaciar}>Vaciar</button>
          </div>
          <p style={{ color: '#6c7086', fontSize: '11px', marginTop: '6px' }}>
            El carrito se guarda en localStorage (recarga la página para verificar)
          </p>
        </>
      )}
    </div>
  );
}

/** Demo del store del carrito con persist */
function DemoCarrito() {
  return (
    <section style={s.seccion}>
      <h2 style={s.titulo}>2. Store con persist (carrito)</h2>
      <ListaProductos />
      <Carrito />
    </section>
  );
}

// ─── ESTILOS ──────────────────────────────────────────────────
const s = {
  seccion: { background: '#313244', borderRadius: '10px', padding: '20px', marginBottom: '16px' },
  titulo: { color: '#cba6f7', marginTop: 0, marginBottom: '12px', fontSize: '16px' },
  valor: { fontSize: '48px', textAlign: 'center', color: '#cdd6f4', margin: '8px 0' },
  fila: { display: 'flex', gap: '8px', alignItems: 'center' },
  btn: { padding: '6px 14px', background: '#89b4fa', color: '#1e1e2e', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' },
};

export default function App() {
  return (
    <div style={{ background: '#181825', minHeight: '100vh', padding: '24px', fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ color: '#cba6f7', textAlign: 'center', marginBottom: '4px' }}>Zustand</h1>
      <p style={{ color: '#6c7086', textAlign: 'center', fontSize: '13px', marginBottom: '24px' }}>Estado global sin Provider ni boilerplate</p>
      <div style={{ maxWidth: '500px', margin: '0 auto' }}>
        <DemoContador />
        <DemoCarrito />
      </div>
    </div>
  );
}
