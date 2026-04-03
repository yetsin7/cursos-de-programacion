/**
 * vite.config.js
 * Configuración de Vite para el frontend de la Biblia RV60.
 * Incluye el plugin de React y un proxy para redirigir
 * las peticiones /api al servidor Express en el puerto 3001.
 */

import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],

  server: {
    port: 5173,
    proxy: {
      // Redirige /api/* → http://localhost:3001/api/*
      '/api': {
        target: 'http://localhost:3001',
        changeOrigin: true,
      },
    },
  },
});
