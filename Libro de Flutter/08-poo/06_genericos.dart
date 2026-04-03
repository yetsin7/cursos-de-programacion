// =============================================================================
// ARCHIVO: 06_genericos.dart
// TEMA: Tipos genéricos en Dart
// =============================================================================
//
// Los genéricos permiten escribir código que funciona con cualquier tipo
// manteniendo la seguridad de tipos en tiempo de compilación. Son la base
// de colecciones como List<T>, Map<K,V> y del Result pattern en Clean Arch.
//
// CÓMO EJECUTAR:
//   dart run 06_genericos.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. CLASE GENÉRICA: class Caja<T>
// ────────────────────────────────────────────────────────────────────────────

/// Contenedor genérico que puede guardar cualquier tipo de valor.
///
/// T es el parámetro de tipo. Al crear la instancia se especifica el tipo real.
/// Esto es más seguro que usar 'dynamic' porque el compilador verifica los tipos.
class Caja<T> {
  // Valor almacenado — puede ser de cualquier tipo T
  T? _valor;

  /// Guarda un [valor] en la caja.
  void guardar(T valor) => _valor = valor;

  /// Obtiene el valor guardado. Devuelve null si la caja está vacía.
  T? obtener() => _valor;

  /// Verifica si la caja tiene contenido.
  bool get tieneContenido => _valor != null;

  /// Transforma el contenido con la función [transformar], si existe.
  /// Retorna una nueva Caja con el resultado transformado.
  Caja<R> transformar<R>(R Function(T) transformar) {
    Caja<R> nueva = Caja<R>();
    if (_valor != null) {
      nueva.guardar(transformar(_valor as T));
    }
    return nueva;
  }

  @override
  String toString() => 'Caja<$T>(${_valor ?? "vacía"})';
}

// ────────────────────────────────────────────────────────────────────────────
// 2. MÉTODOS GENÉRICOS
// ────────────────────────────────────────────────────────────────────────────

/// Obtiene el elemento en [indice] de [lista], o [porDefecto] si está fuera de rango.
///
/// T se infiere del tipo de la lista y del valor por defecto.
T obtenerSeguro<T>(List<T> lista, int indice, T porDefecto) {
  if (indice < 0 || indice >= lista.length) return porDefecto;
  return lista[indice];
}

/// Intercambia los elementos en las posiciones [i] y [j] de [lista].
/// Modifica la lista in-place.
void intercambiar<T>(List<T> lista, int i, int j) {
  if (i < 0 || j < 0 || i >= lista.length || j >= lista.length) return;
  T temp = lista[i];
  lista[i] = lista[j];
  lista[j] = temp;
}

/// Agrupa los elementos de [lista] según la clave devuelta por [agruparPor].
///
/// K es el tipo de la clave de agrupación, T el tipo de los elementos.
Map<K, List<T>> agrupar<K, T>(List<T> lista, K Function(T) agruparPor) {
  Map<K, List<T>> resultado = {};
  for (T elemento in lista) {
    K clave = agruparPor(elemento);
    resultado.putIfAbsent(clave, () => []).add(elemento);
  }
  return resultado;
}

// ────────────────────────────────────────────────────────────────────────────
// 3. BOUNDED GENERICS: <T extends Tipo>
// ────────────────────────────────────────────────────────────────────────────

/// Calcula el máximo de una lista de comparables.
///
/// <T extends Comparable<T>> garantiza que T tiene el método compareTo().
/// Esto es más seguro que aceptar cualquier tipo.
T maximo<T extends Comparable<T>>(List<T> lista) {
  if (lista.isEmpty) throw ArgumentError('La lista no puede estar vacía.');
  T max = lista[0];
  for (T elemento in lista) {
    if (elemento.compareTo(max) > 0) max = elemento;
  }
  return max;
}

/// Estadísticas básicas para listas de números.
///
/// <T extends num> acepta int y double pero no String u otros tipos.
class Estadisticas<T extends num> {
  // Lista de valores numéricos
  final List<T> valores;

  /// Crea estadísticas para la lista de [valores].
  const Estadisticas(this.valores);

  /// Suma de todos los valores.
  double get suma => valores.fold(0.0, (acc, v) => acc + v);

  /// Promedio de los valores.
  double get promedio => valores.isEmpty ? 0 : suma / valores.length;

  /// Valor mínimo de la lista.
  T get minimo => valores.reduce((a, b) => a < b ? a : b);

  /// Valor máximo de la lista.
  T get maximo => valores.reduce((a, b) => a > b ? a : b);

  @override
  String toString() =>
      'Stats: suma=${suma.toStringAsFixed(2)}, '
      'prom=${promedio.toStringAsFixed(2)}, '
      'min=$minimo, max=$maximo';
}

// ────────────────────────────────────────────────────────────────────────────
// 4. RESULTADO GENÉRICO: patrón Result<T, E>
// ────────────────────────────────────────────────────────────────────────────

/// Representa el resultado de una operación que puede éxito o fallar.
///
/// Alternativa más segura y expresiva a lanzar excepciones.
/// T: tipo del valor en caso de éxito. E: tipo del error en caso de falla.
class Result<T, E> {
  // Valor en caso de éxito (null si hay error)
  final T? _valor;
  // Error en caso de falla (null si hay éxito)
  final E? _error;
  // Indica si el resultado es exitoso
  final bool _esExito;

  // Constructor privado para forzar el uso de los factory constructors
  Result._({T? valor, E? error, required bool esExito})
      : _valor = valor,
        _error = error,
        _esExito = esExito;

  /// Crea un resultado exitoso con el [valor] dado.
  factory Result.exito(T valor) => Result._(valor: valor, esExito: true);

  /// Crea un resultado de error con el [error] dado.
  factory Result.error(E error) => Result._(error: error, esExito: false);

  /// Verifica si el resultado es exitoso.
  bool get esExito => _esExito;

  /// Obtiene el valor, lanzando si es un error.
  T get valor {
    if (!_esExito) throw StateError('El resultado es un error: $_error');
    return _valor as T;
  }

  /// Obtiene el error, lanzando si es un éxito.
  E get error {
    if (_esExito) throw StateError('El resultado es un éxito');
    return _error as E;
  }

  /// Ejecuta [onExito] o [onError] según el estado del resultado.
  R cuando<R>({
    required R Function(T) onExito,
    required R Function(E) onError,
  }) {
    if (_esExito) return onExito(_valor as T);
    return onError(_error as E);
  }

  @override
  String toString() => _esExito ? 'Exito($_valor)' : 'Error($_error)';
}

/// Simula dividir dos números, devolviendo Result en lugar de lanzar excepción.
Result<double, String> dividir(double a, double b) {
  if (b == 0) return Result.error('División por cero no permitida.');
  return Result.exito(a / b);
}

void main() {
  // ── Caja genérica ──
  print('── Caja<T> genérica ──');
  Caja<String> cajaString = Caja<String>();
  cajaString.guardar('Hola, genéricos!');
  print(cajaString);
  print('¿Tiene contenido? ${cajaString.tieneContenido}');

  // Transformar: String → int (la longitud)
  Caja<int> cajaInt = cajaString.transformar((s) => s.length);
  print(cajaInt);

  Caja<double> cajaDouble = Caja<double>();
  cajaDouble.guardar(3.14);
  print(cajaDouble);

  // ── Métodos genéricos ──
  print('\n── Métodos genéricos ──');
  List<String> frutas = ['manzana', 'naranja', 'pera'];
  print(obtenerSeguro(frutas, 1, 'desconocida'));  // naranja
  print(obtenerSeguro(frutas, 10, 'desconocida')); // desconocida

  List<int> nums = [1, 2, 3, 4, 5];
  intercambiar(nums, 0, 4);
  print(nums); // [5, 2, 3, 4, 1]

  // Agrupación genérica
  List<String> palabras = ['Ana', 'Bob', 'Carlos', 'Diana', 'Eva'];
  Map<int, List<String>> porLongitud = agrupar(palabras, (p) => p.length);
  print('Por longitud: $porLongitud');

  // ── Bounded generics ──
  print('\n── Bounded generics ──');
  print('Máximo: ${maximo([3, 1, 4, 1, 5, 9, 2, 6])}');    // 9
  print('Máximo: ${maximo(['pera', 'uva', 'manzana'])}');   // uva

  Estadisticas<int> statsInt = Estadisticas([10, 20, 30, 40, 50]);
  print('Enteros: $statsInt');

  Estadisticas<double> statsDouble = Estadisticas([1.5, 2.3, 0.8, 4.1]);
  print('Decimales: $statsDouble');

  // ── Result pattern ──
  print('\n── Result<T, E> pattern ──');
  Result<double, String> r1 = dividir(10, 3);
  Result<double, String> r2 = dividir(10, 0);

  for (Result<double, String> r in [r1, r2]) {
    String msg = r.cuando(
      onExito: (v) => 'Resultado: ${v.toStringAsFixed(4)}',
      onError: (e) => 'Error: $e',
    );
    print(msg);
  }
}

// EXPERIMENTA:
//   - Implementa una pila genérica (Stack<T>) con push, pop y peek
//   - Crea Result.mapExito<R>(R Function(T)) para transformar el valor del éxito
//   - Añade <T extends Comparable<T>> a la clase Estadisticas para obtener mediana
//   - Implementa un Pair<A, B> genérico con sus dos valores de tipos diferentes
