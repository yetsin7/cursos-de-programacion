/**
 * main.jsx
 * Punto de entrada de la aplicación React.
 * Monta el componente raíz App dentro del elemento #root del HTML,
 * envuelto en BrowserRouter para habilitar la navegación por rutas.
 */

import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import App from './App.jsx';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </StrictMode>
);
