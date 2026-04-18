export {};

/*
 * Capitulo 08 — tsconfig y Tooling
 * Archivo: 01_tsconfig_explained.ts
 *
 * Este archivo no existe para hacer logica compleja. Existe para demostrar como
 * una configuracion estricta obliga a escribir codigo mas claro.
 */

interface EnvironmentConfig {
  apiUrl: string;
  retries: number;
  timeoutMs?: number;
}

function buildEnvironmentSummary(config: EnvironmentConfig): string {
  const timeoutText = config.timeoutMs ?? 3000;
  return `API: ${config.apiUrl} | reintentos: ${config.retries} | timeout: ${timeoutText}ms`;
}

const localConfig: EnvironmentConfig = {
  apiUrl: "http://localhost:3000",
  retries: 2
};

console.log(buildEnvironmentSummary(localConfig));
