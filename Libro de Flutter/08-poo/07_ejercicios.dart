// =============================================================================
// ARCHIVO: 07_ejercicios.dart
// TEMA: Ejercicios de Programación Orientada a Objetos
// =============================================================================
//
// Cinco ejercicios que integran clases, herencia, mixins, interfaces y
// genéricos. Cada ejercicio incluye enunciado, solución comentada y
// casos de prueba para verificar el comportamiento.
//
// CÓMO EJECUTAR:
//   dart run 07_ejercicios.dart
//
// =============================================================================

/// Imprime el encabezado de un ejercicio numerado.
void ejercicio(int n, String titulo) {
  print('\n${'═' * 55}');
  print('EJERCICIO $n: $titulo');
  print('═' * 55);
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Jerarquía de vehículos
// Crear una jerarquía: Vehiculo (abstracta) → Auto, Moto, Camion.
// Cada uno implementa: descripcion(), combustibleNecesario(km).
// ────────────────────────────────────────────────────────────────────────────

/// Clase base abstracta para todos los vehículos.
abstract class Vehiculo {
  final String marca, modelo;
  final int anio;
  const Vehiculo(this.marca, this.modelo, this.anio);
  String descripcion();
  double combustibleNecesario(double km);
  @override
  String toString() => '${descripcion()} — ${combustibleNecesario(100).toStringAsFixed(1)}L/100km';
}

/// Automóvil — consume 8L/100km.
class Auto extends Vehiculo {
  final int puertas;
  const Auto(String m, String mo, int a, this.puertas) : super(m, mo, a);
  @override
  String descripcion() => 'Auto $marca $modelo $anio ($puertas puertas)';
  @override
  double combustibleNecesario(double km) => km * 8 / 100;
}

/// Motocicleta — consume 4L/100km.
class Moto extends Vehiculo {
  final int cilindrada;
  const Moto(String m, String mo, int a, this.cilindrada) : super(m, mo, a);
  @override
  String descripcion() => 'Moto $marca $modelo $anio (${cilindrada}cc)';
  @override
  double combustibleNecesario(double km) => km * 4 / 100;
}

/// Camión — consume 15L + 3L por tonelada de carga / 100km.
class Camion extends Vehiculo {
  final double toneladas;
  const Camion(String m, String mo, int a, this.toneladas) : super(m, mo, a);
  @override
  String descripcion() => 'Camión $marca $modelo $anio (${toneladas}t)';
  @override
  double combustibleNecesario(double km) => km * (15 + toneladas * 3) / 100;
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Mixin Descuentable
// Añadir funcionalidad de descuentos a clases de productos sin herencia.
// ────────────────────────────────────────────────────────────────────────────

/// Mixin que añade lógica de descuentos a cualquier clase con precio.
///
/// La clase que lo usa debe implementar el getter [precioBase].
mixin Descuentable {
  /// Precio base sin descuento — la clase debe proveerlo.
  double get precioBase;

  // Porcentaje de descuento activo (0 = sin descuento, 50 = 50% off)
  double _descuento = 0;

  /// Aplica un [porcentaje] de descuento (0-100).
  void aplicarDescuento(double porcentaje) {
    if (porcentaje < 0 || porcentaje > 100) {
      print('Descuento inválido: debe estar entre 0 y 100.');
      return;
    }
    _descuento = porcentaje;
  }

  /// Precio final después de aplicar el descuento.
  double get precioFinal => precioBase * (1 - _descuento / 100);

  /// Ahorro total por el descuento.
  double get ahorro => precioBase - precioFinal;
}

/// Producto electrónico con soporte de descuentos.
class Electronico with Descuentable {
  // Nombre del producto
  final String nombre;

  @override
  final double precioBase;

  /// Crea un producto electrónico con nombre y precio.
  const Electronico(this.nombre, this.precioBase);

  @override
  String toString() =>
      '$nombre: \$${precioFinal.toStringAsFixed(2)} '
      '(base: \$${precioBase.toStringAsFixed(2)}, '
      'ahorro: \$${ahorro.toStringAsFixed(2)})';
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3: Pila genérica (Stack<T>)
// Implementar una estructura de datos pila con genéricos.
// ────────────────────────────────────────────────────────────────────────────

/// Pila LIFO (Last In, First Out) genérica.
///
/// Demuestra el uso práctico de genéricos en estructuras de datos.
class Pila<T> {
  // Almacenamiento interno de la pila
  final List<T> _elementos = [];

  /// Agrega [elemento] a la cima de la pila.
  void push(T elemento) => _elementos.add(elemento);

  /// Extrae y devuelve el elemento en la cima. Lanza si está vacía.
  T pop() {
    if (estaVacia) throw StateError('No se puede hacer pop de una pila vacía.');
    return _elementos.removeLast();
  }

  /// Devuelve el elemento en la cima sin extraerlo.
  T peek() {
    if (estaVacia) throw StateError('La pila está vacía.');
    return _elementos.last;
  }

  /// Número de elementos en la pila.
  int get tamanio => _elementos.length;

  /// Verifica si la pila está vacía.
  bool get estaVacia => _elementos.isEmpty;

  @override
  String toString() => 'Pila$_elementos (tope → ${estaVacia ? "vacía" : _elementos.last})';
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4: Repositorio en memoria
// Implementar la interfaz Repositorio<T> con almacenamiento en Map.
// ────────────────────────────────────────────────────────────────────────────

/// Modelo simple de usuario con id y nombre.
class UsuarioSimple {
  final String id, nombre;
  const UsuarioSimple(this.id, this.nombre);
  @override
  String toString() => 'Usuario($id: $nombre)';
}

/// Repositorio CRUD en memoria para UsuarioSimple.
class RepositorioUsuarios {
  final Map<String, UsuarioSimple> _almacen = {};
  int _contadorId = 0;

  /// Crea y guarda un nuevo usuario con el [nombre] dado.
  UsuarioSimple crear(String nombre) {
    String id = 'USR-${++_contadorId}';
    UsuarioSimple u = UsuarioSimple(id, nombre);
    _almacen[id] = u;
    return u;
  }

  UsuarioSimple? obtenerPorId(String id) => _almacen[id];
  List<UsuarioSimple> obtenerTodos() => _almacen.values.toList();
  bool eliminar(String id) => _almacen.remove(id) != null;
  int get total => _almacen.length;
}

// ────────────────────────────────────────────────────────────────────────────
// MAIN: Ejecutar todos los ejercicios
// ────────────────────────────────────────────────────────────────────────────

void main() {
  // --- Ejercicio 1: Vehículos ---
  ejercicio(1, 'Jerarquía de vehículos');
  List<Vehiculo> vehiculos = [
    Auto('Toyota', 'Corolla', 2023, 4),
    Moto('Honda', 'CBR', 2022, 600),
    Camion('Volvo', 'FH16', 2021, 20.0),
  ];
  for (Vehiculo v in vehiculos) {
    print(v);
    print('  Para 500km: ${v.combustibleNecesario(500).toStringAsFixed(1)}L');
  }

  // --- Ejercicio 2: Descuentos ---
  ejercicio(2, 'Mixin Descuentable');
  Electronico laptop = Electronico('Laptop Pro', 1200.0);
  print(laptop);
  laptop.aplicarDescuento(20);
  print(laptop);
  laptop.aplicarDescuento(0);
  print(laptop);

  // --- Ejercicio 3: Pila genérica ---
  ejercicio(3, 'Pila genérica Stack<T>');
  Pila<int> pilaInt = Pila<int>();
  pilaInt.push(10);
  pilaInt.push(20);
  pilaInt.push(30);
  print(pilaInt);
  print('Pop: ${pilaInt.pop()}');   // 30
  print('Peek: ${pilaInt.peek()}'); // 20
  print('Tamaño: ${pilaInt.tamanio}');

  Pila<String> pilaStr = Pila<String>();
  pilaStr.push('a');
  pilaStr.push('b');
  pilaStr.push('c');
  print(pilaStr);

  // --- Ejercicio 4: Repositorio en memoria ---
  ejercicio(4, 'Repositorio en memoria');
  RepositorioUsuarios repo = RepositorioUsuarios();
  UsuarioSimple u1 = repo.crear('Ana');
  UsuarioSimple u2 = repo.crear('Bob');
  UsuarioSimple u3 = repo.crear('Carlos');
  print('Creados: ${repo.obtenerTodos()}');
  print('Buscar USR-2: ${repo.obtenerPorId('USR-2')}');
  repo.eliminar(u2.id);
  print('Tras eliminar Bob: ${repo.obtenerTodos()}');
  print('Total: ${repo.total}');

  print('\n¡Todos los ejercicios completados!');
}

// EXPERIMENTA:
//   - Agrega un método buscarPorMarca() al ejercicio 1 que filtre la lista
//   - Crea un mixin Historial que registre todos los precios anteriores de un producto
//   - Implementa Pila<T> con un método toList() que devuelva los elementos en orden LIFO
//   - Extiende el repositorio para buscar usuarios por nombre (búsqueda parcial)
