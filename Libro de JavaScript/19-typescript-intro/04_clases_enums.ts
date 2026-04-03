// =============================================================================
// ARCHIVO: 04_clases_enums.ts
// TEMA: Clases con tipos, modificadores de acceso y enums en TypeScript
// =============================================================================

// ─── 1. Clases con propiedades tipadas ───────────────────────────────────────

// En TypeScript, las propiedades de la clase se declaran con su tipo
// y los parámetros del constructor también se anotan
class Rectangulo {
  // Propiedades tipadas de la instancia
  ancho: number;
  alto: number;

  constructor(ancho: number, alto: number) {
    this.ancho = ancho;
    this.alto = alto;
  }

  // Método tipado: retorna number
  area(): number {
    return this.ancho * this.alto;
  }

  perimetro(): number {
    return 2 * (this.ancho + this.alto);
  }
}

const rect = new Rectangulo(10, 5);
console.log('=== CLASE BÁSICA ===');
console.log(`Área: ${rect.area()} | Perímetro: ${rect.perimetro()}`);

// ─── 2. Modificadores de acceso ───────────────────────────────────────────────

// public   → accesible desde cualquier lugar (es el valor por defecto)
// private  → solo accesible dentro de la clase
// protected → accesible dentro de la clase y sus subclases
class CuentaBancaria {
  public titular: string;         // accesible desde fuera
  private saldo: number;          // solo esta clase puede leerlo/modificarlo
  protected numeroCuenta: string; // subclases también pueden accederlo

  constructor(titular: string, saldoInicial: number) {
    this.titular = titular;
    this.saldo = saldoInicial;
    this.numeroCuenta = `CTA-${Date.now()}`;
  }

  // Método público: interfaz hacia el exterior
  depositar(monto: number): void {
    if (monto <= 0) throw new Error('El monto debe ser positivo');
    this.saldo += monto;
  }

  retirar(monto: number): void {
    if (monto > this.saldo) throw new Error('Saldo insuficiente');
    this.saldo -= monto;
  }

  // Getter: permite leer el saldo sin exponerlo directamente
  get saldoActual(): number {
    return this.saldo;
  }
}

const cuenta = new CuentaBancaria('Ana García', 1000);
cuenta.depositar(500);
cuenta.retirar(200);
// cuenta.saldo = 9999; // Error: saldo es private

console.log('\n=== MODIFICADORES DE ACCESO ===');
console.log(`${cuenta.titular}: $${cuenta.saldoActual}`);

// ─── 3. Herencia y protected ─────────────────────────────────────────────────

// Las subclases pueden acceder a propiedades protected de la clase padre
class CuentaPremium extends CuentaBancaria {
  private limiteCredito: number;

  constructor(titular: string, saldo: number, limiteCredito: number) {
    super(titular, saldo); // llamar al constructor del padre
    this.limiteCredito = limiteCredito;
  }

  resumen(): string {
    // numeroCuenta es protected: accesible aquí pero no desde fuera
    return `${this.titular} (${this.numeroCuenta}) - Límite: $${this.limiteCredito}`;
  }
}

const premium = new CuentaPremium('Carlos López', 5000, 2000);
console.log('\n=== HERENCIA ===');
console.log(premium.resumen());

// ─── 4. Enums ─────────────────────────────────────────────────────────────────

// enum: conjunto de constantes con nombre
// Por defecto los valores son 0, 1, 2... (numéricos)
enum Direccion {
  Norte,   // 0
  Sur,     // 1
  Este,    // 2
  Oeste,   // 3
}

function mover(direccion: Direccion): string {
  // Se puede comparar directamente con el enum
  if (direccion === Direccion.Norte) return 'Moviéndose al norte';
  if (direccion === Direccion.Sur)   return 'Moviéndose al sur';
  return `Dirección: ${Direccion[direccion]}`; // Acceso inverso: número → nombre
}

console.log('\n=== ENUM NUMÉRICO ===');
console.log(mover(Direccion.Norte));
console.log(mover(Direccion.Oeste));
console.log('Valor numérico de Este:', Direccion.Este);

// Enum de cadenas: más claro al depurar, sin conversión inversa automática
enum EstadoPedido {
  Pendiente = 'PENDIENTE',
  Procesando = 'PROCESANDO',
  Enviado = 'ENVIADO',
  Entregado = 'ENTREGADO',
  Cancelado = 'CANCELADO',
}

function describir(estado: EstadoPedido): string {
  const descripciones: Record<EstadoPedido, string> = {
    [EstadoPedido.Pendiente]:   'Esperando confirmación',
    [EstadoPedido.Procesando]:  'En preparación',
    [EstadoPedido.Enviado]:     'En camino',
    [EstadoPedido.Entregado]:   'Entregado con éxito',
    [EstadoPedido.Cancelado]:   'Pedido cancelado',
  };
  return descripciones[estado];
}

console.log('\n=== ENUM DE CADENAS ===');
console.log(describir(EstadoPedido.Enviado));
console.log(describir(EstadoPedido.Entregado));

// ─── 5. Const enums: más eficientes ──────────────────────────────────────────

// const enum se reemplaza en tiempo de compilación por sus valores literales
// No genera código JS adicional — mejor rendimiento
const enum Permiso {
  Leer = 1,
  Escribir = 2,
  Administrar = 4,
}

const permisoUsuario: Permiso = Permiso.Leer;
console.log('\n=== CONST ENUM ===');
console.log('Permiso asignado:', permisoUsuario);

// ─── 6. Decoradores (mención) ────────────────────────────────────────────────

// Los decoradores son una característica experimental de TypeScript
// usada ampliamente en Angular y NestJS para añadir metadata a clases
// Se activan en tsconfig.json con: "experimentalDecorators": true

// Ejemplo conceptual (no ejecutable sin configuración):
// @Injectable()
// class ServicioUsuarios { ... }

// @Controller('/usuarios')
// class UsuariosController { ... }

console.log('\n=== DECORADORES ===');
console.log('Usados en Angular (@Component, @Injectable) y NestJS (@Controller)');
console.log('Requieren "experimentalDecorators": true en tsconfig.json');
